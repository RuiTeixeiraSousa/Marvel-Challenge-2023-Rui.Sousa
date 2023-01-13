//
//  CharacterService.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//

import Foundation
import CryptoKit

typealias CharacterDataResult = ((Result<CharacterData, NSError>) -> Void)

class CharacterService {
    
    private let limit = 100
    private let baseURL: URL
    private let privateKey: String
    private let apiKey: String
    
    private static var sharedSession: URLSession = {
        return URLSession.shared
    }()
    
    private static var commonQueryItems: [URLQueryItem] = {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let privateKey = "092ac9946b25add4a7d468068e8541f6f9b0be0e"
        let apiKey = "f43d07f9042745026ecbd8d03073dda8"
        let hash = privateKey.MD5(string: "\(timestamp)\(privateKey)\(apiKey)")
        
        return [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "hash", value: hash)
          
        ]
    }()
    
    init(baseURL: URL, privateKey: String, apiKey: String) {
        self.baseURL = baseURL
        self.privateKey = privateKey
        self.apiKey = apiKey
    }
    
    func character(_ name: String?, page: Int, limit:Int, completion: @escaping CharacterDataResult){
        
        var components = URLComponents(url: baseURL.appendingPathComponent("v1/public/characters"), resolvingAgainstBaseURL: true)
        var customQueryItems = [URLQueryItem]()
        
        if let name = name {
            customQueryItems.append(URLQueryItem(name: "name", value: name))
        }
        
        if page > 0 {
            customQueryItems.append(URLQueryItem(name: "offset", value: "\(page * limit)"))
        }
        
        components?.queryItems = CharacterService.commonQueryItems + customQueryItems
        
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "", code: 409, userInfo: ["message": "Can't build url"])))
            return
        }
        
        let task = CharacterService.sharedSession.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(NSError(domain: "", code: 409, userInfo: ["message": error.localizedDescription])))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 409, userInfo: ["message": "Can't get data"])))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: 409, userInfo: ["message": "Invalid response"])))
                return
            }
            
            switch httpResponse.statusCode {
            case 409:
                if let missingParameter = httpResponse.allHeaderFields["Missing-Parameter"] as? String {
                    completion(.failure(NSError(domain: "", code: 409, userInfo: ["message": "Missing \(missingParameter)"])))
                } else {
                    completion(.failure(NSError(domain: "", code: 409, userInfo: ["message": "Missing API Key, Hash or Timestamp"])))
                }
            case 401:
                if let invalidParameter = httpResponse.allHeaderFields["Invalid-Parameter"] as? String {
                    completion(.failure(NSError(domain: "", code: 401, userInfo: ["message": "Invalid \(invalidParameter)"])))
                } else {
                    completion(.failure(NSError(domain: "", code: 401, userInfo: ["message": "Invalid Referer or Hash"])))
                }
            case 405:
                completion(.failure(NSError(domain: "", code: 405, userInfo: ["message": "Method Not Allowed"])))
            case 403:
                completion(.failure(NSError(domain: "", code: 403, userInfo: ["message": "Forbidden"])))
            default:
                guard let characterData = try? JSONDecoder().decode(CharacterData.self, from: data) else {
                    completion(.failure(NSError(domain: "", code: 409, userInfo: ["message": "Can't parse json"])))
                    return
                }
                
                completion(.success(characterData))
            }
        }
        
        task.resume()
    }
}

extension String {
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
