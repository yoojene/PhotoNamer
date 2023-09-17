//
//  PhotoSelectView.swift
//  PhotoNamer
//
//  Created by Eugene on 14/09/2023.
//

import SwiftUI

struct PhotoSelectView: View {
    
    @Binding var photo: Photo
    
    @State private var image: Image?
    @State private var showPhotoPicker = false

    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Gradient(colors: [.yellow, .red]))

                Text("Tap to select a picture")
                    .foregroundColor(.white)
                    .font(.headline)

                image?
                    .resizable()
                    .scaledToFit()

            }
            .onTapGesture {
                image = nil
                photo.photoName = ""
                showPhotoPicker = true
            }
            .sheet(isPresented: $showPhotoPicker) {
                PhotoPicker(image: $photo.inputImage)
            }
            .onChange(of: photo.inputImage) { _ in loadImage() }


            VStack (alignment: .leading, spacing: 0.2) {

                TextField("Enter a name", text: $photo.photoName)
                    .padding(.bottom)
                    .disabled(image == nil)
                Spacer()
            }
            .padding()
        }
        
    }
    
    func loadImage() {
        guard let inputImage = photo.inputImage else { return }
                
        image = Image(uiImage: inputImage)
    }
}

struct PhotoSelectView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSelectView(photo: .constant(Photo(id: UUID()   )))
    }
}
