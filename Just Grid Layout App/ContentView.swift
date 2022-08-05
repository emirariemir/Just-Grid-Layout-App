//
//  ContentView.swift
//  Just Grid Layout App
//
//  Created by Emir on 5.08.2022.
//

import SwiftUI
import Kingfisher

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
