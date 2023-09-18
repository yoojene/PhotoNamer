//
//  PhotoDetailView.swift
//  PhotoNamer
//
//  Created by Eugene on 16/09/2023.
//

import SwiftUI
import MapKit

struct PhotoDetailView: View {

    let photo: Photo
    
    let locationFetcher = LocationFetcher()
    
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0),span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))

    @State private var locations = [UserLocation]()
    
    var body: some View {
        VStack {
            Image(uiImage: photo.inputImage ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Text(photo.photoName)
            
            ZStack {
                Map(coordinateRegion: $mapRegion, annotationItems: photo.photoLocation ) { loc in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude))
                }
            }
        }
    }
}

struct PhotoDetail_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: Photo(id: UUID()))
    }
}
