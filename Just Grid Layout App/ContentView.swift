//
//  ContentView.swift
//  Just Grid Layout App
//
//  Created by Emir on 5.08.2022.
//

import SwiftUI
import Kingfisher

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

struct RSS: Decodable {
    var feed: Feed
}

struct Feed: Decodable {
    var results: [Result]
}

struct Result: Decodable, Hashable {
    var artistName, name, artworkUrl100, releaseDate: String
}

struct ContentView: View {
    @ObservedObject var vm = GridViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                // NOTE THIS
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 16, alignment: .top)
                ], spacing: 12, content: {
                    ForEach(vm.results, id: \.self) { app in
                        AlbumCard(app: app)
                        //.padding(.horizontal)
                        //.background(Color.green)
                    }
                }).padding(.horizontal, 12).padding(.vertical, 6)
            }.navigationTitle("Music Layout")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AlbumCard: View {
    var app: Result
    
    var body: some View {
        VStack (alignment: .leading, spacing: 4) {
            KFImage(URL(string: app.artworkUrl100))
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
            Text(app.name)
                .font(.system(size: 20, weight: .semibold))
            //.padding(.top, 4)
            Text(app.artistName)
                .font(.system(size: 15, weight: .regular))
            Text(app.releaseDate)
                .font(.system(size: 11, weight: .regular))
        }
    }
}
