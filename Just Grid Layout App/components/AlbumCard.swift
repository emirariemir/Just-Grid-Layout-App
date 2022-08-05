//
//  AlbumCard.swift
//  Just Grid Layout App
//
//  Created by Emir on 5.08.2022.
//

import SwiftUI
import Kingfisher

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
