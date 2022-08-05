//
//  Rss.swift
//  Just Grid Layout App
//
//  Created by Emir on 5.08.2022.
//

import Foundation

struct RSS: Decodable {
    var feed: Feed
}

struct Feed: Decodable {
    var results: [Result]
}

struct Result: Decodable, Hashable {
    var artistName, name, artworkUrl100, releaseDate: String
}
