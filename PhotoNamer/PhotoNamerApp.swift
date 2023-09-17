//
//  PhotoNamerApp.swift
//  PhotoNamer
//
//  Created by Eugene on 14/09/2023.
//

import SwiftUI

@main
struct PhotoNamerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(photo:Photo(id: UUID()))
        }
    }
}
