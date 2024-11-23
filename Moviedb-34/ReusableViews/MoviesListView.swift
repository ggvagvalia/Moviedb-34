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
    var releaseDate: String?
    var language: String?
    var codableModel: Movies?
    @EnvironmentObject var favouritesPageViewModel: FavouritesPageViewModel
    
    var body: some View {
        
        HStack {
            VStack() {
                ImageView(imageJPG: image)
                    .cornerRadius(10)
                    .aspectRatio(4/3, contentMode: .fit)
                    .foregroundStyle(Color(.label))
                
                
                HStack(alignment: .top) {
                    Text(title)
                        .bold()
                        .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 18 : 12))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(.label))
                        .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 10 : 0)
                    //                Spacer()
                }
                Spacer()

            }
            .background(Color(.systemBackground))
        }
    }
}

//#Preview {
//    MoviesListPage()
//        .environmentObject(MoviesListPageViewModel())
//}
