//
//  PhotoSelectView.swift
//  PhotoNamer
//
//  Created by Eugene on 14/09/2023.
//

import SwiftUI
import MapKit

struct PhotoSelectView: View {
    
    @Binding var photo: Photo
    
    @State private var image: Image?
    @State private var showPhotoPicker = false
    
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0),span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    var locations: [UserLocation]

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
            }
            .padding()
            
            ZStack {
                Map(coordinateRegion: $mapRegion, annotationItems: locations ) { location in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                    
                }
                
            }
            
        }.onAppear {
            resetSelectView()
        }
        
    }
    
    func loadImage() {
        guard let inputImage = photo.inputImage else { return }
                
        image = Image(uiImage: inputImage)
    }
    
    func resetSelectView() {
        image = nil
        photo.photoName = ""
    }
}

struct PhotoSelectView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSelectView(photo: .constant(Photo(id: UUID())), locations: [UserLocation.example])
    }
}
