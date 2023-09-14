//
//  ContentView.swift
//  PhotoNamer
//
//  Created by Eugene on 14/09/2023.
//

import SwiftUI

//TODO maybe refactor using ViewModel.  Needs shared state
struct ContentView: View {
    
    @State private var showList = true
    
    var body: some View {
        NavigationView {
            Group {
                if showList {
                    PhotoListView()
                        
                } else {
                    PhotoSelectView()
                }
                
            }
            .navigationTitle("PhotoNamer")
            .toolbar {
                Button(showList ? "Select Photo" : "List") { showList.toggle()}
                if !showList {
                    Button("Save", action: {
                        // TODO
                    })
                    
                }
            }

        }
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
