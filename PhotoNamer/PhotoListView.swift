//
//  PhotoListView.swift
//  PhotoNamer
//
//  Created by Eugene on 14/09/2023.
//

import SwiftUI

struct PhotoListView: View {

    @StateObject private var photos = Photos()

    var body: some View {
        List(photos.photos, id: \.id) { photo in
                NavigationLink {
                    PhotoDetailView(photo: photo)
                } label: {
                    HStack {
                        Image(uiImage: photo.inputImage ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text(photo.photoName)
                            .padding(.leading)

                    }
                }
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}
