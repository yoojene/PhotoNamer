//
//  PhotoListView.swift
//  PhotoNamer
//
//  Created by Eugene on 14/09/2023.
//

//import SwiftUI

// TODO need to consume NamedPhoto class, only has static images for testing
//struct PhotoListView: View {
//
//    @ObservedObject var photo = Photo()
//    @ObservedObject var photos: [Photo]
//
//    var body: some View {
//        List {
//            ForEach(photos) {
//                Image(uiImage: $0.inputImage ?? UIImage())
//
////                HStack {
//                    NavigationLink {
//                        Text("Detail view")
//
//                    } label: {
//                        HStack {
//                            Image(uiImage: $0.inputImage ?? UIImage())
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 50, height: 50)
//                                .clipShape(Circle())
//
//                            Text(photo.photoName)
//                                .padding(.leading)
//
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct PhotoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoListView()
//    }
//}
