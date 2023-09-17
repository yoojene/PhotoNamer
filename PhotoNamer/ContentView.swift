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
   
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("PhotoNamerData.json")
   

    var body: some View {
        NavigationView {
            Group {
                if showList {
                    PhotoListView()
                } else {
                    PhotoSelectView(photo: $photo)
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
