//
//  PhotoSaver.swift
//  PhotoNamer
//
//  Created by Eugene on 14/09/2023.
//

import Foundation

import UIKit

class PhotoSaver: NSObject {
    
    var successHander: (() -> Void)?
    var errorHander: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            errorHander?(error)
        } else {
            successHander?()
        }
        
    }
    
}
