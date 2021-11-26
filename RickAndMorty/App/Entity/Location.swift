//
//  Location.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 01.11.2021.
//

import Foundation

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: URL
    let created: String
}

struct LocationrList: Codable {
    let results: [Location]
    let info: Info
}

