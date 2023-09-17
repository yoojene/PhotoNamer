//
//  ContentView.swift
//  PhotoNamer
//
//  Created by Eugene on 14/09/2023.
//

import SwiftUI
import Foundation
struct ContentView: View {
    
    @State var photo: Photo
    @State private var showList = true
    @StateObject private var photos = Photos()
    @State private var image: Image?
    @State private var showPhotoPicker = false
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("PhotoNamerData.json")
   

    var body: some View {
        NavigationView {
            Group {
                if showList {
                    PhotoListView()
                } else {
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
                
            }
            .navigationTitle("PhotoNamer")
            .toolbar {
                Button(showList ? "Select Photo" : "List") { showList.toggle()}
                if !showList {
                    Button("Save", action: {
                        var newPhoto = photo
                        newPhoto.id = UUID()
                        newPhoto.inputImage = photo.inputImage
                        newPhoto.photoName = photo.photoName
                        
                        photos.photos.append(newPhoto)
                        
                        save()
                        showList = true
                        
                    })
                    
                }
            }

        }
    }
    
    func loadImage() {
        guard let inputImage = photo.inputImage else { return }
                
        image = Image(uiImage: inputImage)
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(photos.photos)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            
        } catch {
            print("Unable to save data!")
        }
    }
    
    
    func load() {
            
    }
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    
//    let photos = NamedPhoto(id: UUID())
    static var previews: some View {
        ContentView(photo: Photo(id: UUID()))
    }
}
