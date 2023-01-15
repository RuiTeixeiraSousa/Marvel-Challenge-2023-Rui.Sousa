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
        privateKey: "2821f23808b7f8751381b2acb3671890a90eddf0",
        apiKey: "197f354f1d837df1049fb5c06581c0b4"
        
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
