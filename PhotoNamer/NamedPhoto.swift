//
//  Photo.swift
//  PhotoNamer
//
//  Created by Eugene on 14/09/2023.
//

import Foundation
import SwiftUI

class NamedPhoto: Identifiable, Codable {
    
    enum CodingKeys: CodingKey {
        case id, photoName, inputImage
    }
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("PhotoNamerData")
    var id: UUID
    var inputImage: UIImage
    var photoName: String
    
    init(id: UUID, inputImage: UIImage, photoName: String) {
        self.id = id
        self.inputImage = inputImage
        self.photoName = photoName
    }
    
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
        if let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
            
            try container.encode(jpegData, forKey: .inputImage)
        }
    }
    
    
//    static let example = NamedPhoto(id: UUID(), image: , photoName: "It's Eugene!")
    
    
    
}
