//
//  ImageView.swift
//  Moviedb-34
//
//  Created by gvantsa gvagvalia on 6/5/24.
//

import SwiftUI

struct ImageView: View {
    let imageJPG: URL
    
    var body: some View {
        if let imageURL = URL(string: "\(imageJPG)") {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(7/9, contentMode: .fit)
                    .scaledToFill()
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
