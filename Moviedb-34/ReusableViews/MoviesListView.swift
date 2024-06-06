//
//  MoviesListView.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI

struct MoviesListView: View {
    var image: URL
    var title: String
    var releaseDate: String
    var language: String
    var rating: String
    
    var body: some View {
        HStack {
            ImageView(imageJPG: image)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    
                Spacer()
                
                Text("language: \(language)")
                    .font(.caption)
                HStack {
                    Text(releaseDate)
                        .font(.caption2)
                    
                    Spacer()
                    
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("\(rating)")
                        .bold()
                        .lineLimit(10)
                }
            }
            .padding(5)
            .padding(.top, 5)
            .padding(.bottom, 5)
            .padding(.trailing, 5)
        }
        .background(Color.secondary.opacity(0.1))
        .overlay (
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.yellow, lineWidth: 2.5)
                .padding(1)
            )
        }
    }


#Preview {
    MoviesListPage()
        .environmentObject(MoviesListPageViewModel())
}
