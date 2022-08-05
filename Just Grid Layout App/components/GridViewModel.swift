//
//  GridViewModel.swift
//  Just Grid Layout App
//
//  Created by Emir on 5.08.2022.
//

import Foundation

class GridViewModel: ObservableObject {
    @Published var items = 0..<10
    
    @Published var results = [Result]()
    
    init() {
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/music/most-played/25/albums.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode(RSS.self, from: data)
                self.results = rss.feed.results
            } catch {
                print("Failed while decoding: \(error)")
            }
        }.resume()
    }
}
