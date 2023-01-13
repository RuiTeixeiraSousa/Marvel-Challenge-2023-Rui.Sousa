//
//  MarvelAPI.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//

import Foundation

class MarvelAPI {
    
    static let shared = MarvelAPI(
        baseURL: URL(string: "https://gateway.marvel.com:443")!,
        privateKey: "092ac9946b25add4a7d468068e8541f6f9b0be0e",
        apiKey: "f43d07f9042745026ecbd8d03073dda8"
        
    )

    var characterService: CharacterService {
        return CharacterService(baseURL: baseURL, privateKey: privateKey, apiKey: apiKey)
    }
    
    private let baseURL: URL
    private let privateKey: String
    private let apiKey: String
    
    init(baseURL: URL, privateKey: String, apiKey: String) {
        self.baseURL = baseURL
        self.privateKey = privateKey
        self.apiKey = apiKey
    }
    
}
