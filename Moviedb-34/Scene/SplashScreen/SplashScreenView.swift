//
//  SplashScreenView.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/8/24.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject var moviesListViewModel: MoviesListPageViewModel
    @EnvironmentObject var genresViewModel: GenresViewModel
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            MainPage()
        } else {
            VStack {
                VStack {
                    Image("splashScreenImage")
                        .resizable()
                        .frame(width: 215, height: 215)
                        .scaleEffect(size)
                        .opacity(opacity)
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.2)) {
                        self.size = 1.1
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isActive = true
                }
            }
        }
    }
}

//#Preview {
//    SplashScreenView()
//        .environmentObject(moviesListViewModel)
//        .environmentObject(genresViewModel)
//}
