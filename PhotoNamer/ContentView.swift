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
    @State private var showList = false
    @StateObject private var photos = Photos()
    @State private var locations = [UserLocation]()
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("PhotoNamerData.json")
   
    let locationFetcher = LocationFetcher()

    var body: some View {
        NavigationView {
            Group {
                if showList {
                    PhotoListView()

                } else {
                    PhotoSelectView(photo: $photo, locations: locations)
                        .onAppear {
                            self.locationFetcher.start()
                            photo.inputImage = nil
                        }
                }
  
            }
            .navigationTitle("PhotoNamer")
            .toolbar {
                Button(showList ? "Select Photo" : "List") {
                    showList.toggle()
                    locations = []
                }
                if !showList {
                    Button("Save", action: {
                   
                        if let location = self.locationFetcher.lastKnownLocation {
                            print("Your location is \(location)")
                            locations.append(UserLocation(id: UUID(), latitude: location.latitude, longitude: location.longitude))
                            
                        }
                        var newPhoto = photo
                        newPhoto.id = UUID()
                        newPhoto.inputImage = photo.inputImage
                        newPhoto.photoName = photo.photoName
                        newPhoto.photoLocation = locations
                        
                        photos.photos.append(newPhoto)
                        
                        save()
//                        showList = true
                        
                    })
                    .disabled(photo.inputImage == nil)
                    
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
        
    static var previews: some View {
        ContentView(photo: Photo(id: UUID()))
    }
}
