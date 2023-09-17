//
//  Photo.swift
//  PhotoNamer
//
//  Created by Eugene on 14/09/2023.
//

import Foundation
import SwiftUI

struct Photo: Identifiable, Codable {

    enum CodingKeys: CodingKey {
        case id, photoName, inputImage
    }
    
    var id = UUID()
    var inputImage: UIImage?
    var photoName = ""
    
    init(from decoder: Decoder) throws {
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

class Photos: ObservableObject, Identifiable {
    let savePath = FileManager.documentsDirectory.appendingPathComponent("PhotoNamerData.json")

    @Published var photos: [Photo]
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            photos = try JSONDecoder().decode([Photo].self, from: data)
        } catch {
            photos = []
        }
    }
}
