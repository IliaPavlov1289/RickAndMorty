//
//  Episode.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 01.11.2021.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: URL
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
        case created
    }
}

struct EpisodeList: Codable {
    let results: [Episode]
    let info: Info
}
