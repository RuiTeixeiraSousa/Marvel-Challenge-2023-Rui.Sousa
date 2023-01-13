//
//  CharacterData.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//

import Foundation

struct CharacterData: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: CharacterDataContainer?
    let etag: String?
    var description: String {
        return "CharacterDataWrapper: {\n  code: \(String(describing: code)),\n  status: \(String(describing: status)),\n  copyright: \(String(describing: copyright)),\n  attributionText: \(String(describing: attributionText)),\n  attributionHTML: \(String(describing: attributionHTML)),\n  etag: \(String(describing: etag)),\n  data: \(String(describing: data))\n}"
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case copyright
        case attributionText
        case attributionHTML
        case data
        case etag
    }
}

struct CharacterDataContainer: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]?
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}

struct Character: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: Image?
    let comics: ComicList?
    let series: SeriesList?
    let stories: StoryList?
    let events: EventList?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
        case comics
        case series
        case stories
        case events
    }
}

struct ComicList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [ComicSummary]?
    
    enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
}

struct ComicSummary: Codable {
    let resourceURI: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
    }
}

struct SeriesList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [SeriesSummary]?
    
    enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
}

struct SeriesSummary: Codable {
    let resourceURI: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
    }
}

struct StoryList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [StorySummary]?
    
    enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
}

struct StorySummary: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
        case type
    }
}

struct EventList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [EventSummary]?
    
    enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
}

struct EventSummary: Codable {
    let resourceURI: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
    }
}

struct Image {
    let path: String?
    let ext: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

extension Image {
    
    var url: URL? {
        if let path = path, let ext = ext {
            return URL(string: "\(path).\(ext)")
        } else {
            return nil
        }
    }
}

extension Image: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decodeIfPresent(String.self, forKey: .path)
        self.ext = try container.decodeIfPresent(String.self, forKey: .ext)
    }
}

extension Image: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(ext, forKey: .ext)
    }
}
