//
//  MoviesListView.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI

struct MoviesListView: View {
    var title: String
    var image: String
    var body: some View {
        VStack {
            Text("\(title)")
        }
    }
}

//#Preview {
//    MoviesListView()
//}
