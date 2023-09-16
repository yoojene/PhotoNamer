//
//  Photo.swift
//  PhotoNamer
//
//  Created by Eugene on 16/09/2023.
//
import Foundation
import UIKit

class Photo: Identifiable, Codable, ObservableObject {
   


    enum CodingKeys: CodingKey {
        case id, photoName, inputImage
    }

    @Published var id: UUID
    @Published var inputImage: UIImage?
    @Published var photoName = ""
    

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.photoName = try container.decode(String.self, forKey: .photoName)
        let imageData = try container.decode(Data.self, forKey: .inputImage)
        let decodedImage = UIImage(data: imageData) ?? UIImage()
        self.inputImage = decodedImage
   }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.id, forKey: .id)
        try container.encode(self.photoName, forKey: .photoName)
        guard let inputImage = inputImage else { return }
        if let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
            try container.encode(jpegData, forKey: .inputImage)
        }
    }
    
   
    
    
    init(id: UUID) {
        self.id = id
    }

}

//class Photos: ObservableObject, Codable {
//    
//    enum CodingKeys: CodingKey {
//        case photos
//    }
//
//    @Published var photos = [Photo]()
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.photos = try container.decode([Photo].self, forKey: .photos)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.photos, forKey: .photos)
//    }
//    
//    init() { }
//
//}

