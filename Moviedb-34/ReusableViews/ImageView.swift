//
//  ImageView.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI

struct ImageView: View {
    let imageJPG: String
    
    var body: some View {
        if let imageURL = URL(string: imageJPG) {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
            }
        } else {
            Text("no image in URL")
        }
    }
}

//#Preview {
//    ImageView()
//}
