//
//  PhotoDetailView.swift
//  PhotoNamer
//
//  Created by Eugene on 16/09/2023.
//

import SwiftUI

struct PhotoDetailView: View {

    let photo: Photo

    var body: some View {
        VStack {
            Image(uiImage: photo.inputImage ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Text(photo.photoName)
        }
    }
}

struct PhotoDetail_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: Photo(id: UUID()))
    }
}
