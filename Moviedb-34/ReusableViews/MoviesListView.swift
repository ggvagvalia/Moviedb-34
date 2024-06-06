//
//  MoviesListView.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI

struct MoviesListView: View {
    @Environment(\.colorScheme) var mode
    var image: URL
    var title: String
    var releaseDate: String
    var language: String
    var rating: String
    
    let color = LinearGradient(
        colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)).opacity(0.3), Color(#colorLiteral(red: 0.9973154664, green: 0.8012097478, blue: 0.004905504175, alpha: 1)).opacity(0.4)],
        startPoint: .leading,
        endPoint: .trailing)
    
    var body: some View {
        let backgroundColor: Color = mode == .light ? Color.secondary.opacity(0.1) : Color.cellBackgroundColor1.opacity(0.55)
        
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
        .background(backgroundColor)
        .overlay (
            RoundedRectangle(cornerRadius: 10)
                .stroke(color, lineWidth: 3)
                .padding(1.5)
        )
    }
}


#Preview {
    MoviesListPage()
        .environmentObject(MoviesListPageViewModel())
}
