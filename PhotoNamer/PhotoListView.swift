//
//  PhotoListView.swift
//  PhotoNamer
//
//  Created by Eugene on 14/09/2023.
//

import SwiftUI

// TODO need to consume NamedPhoto class, only has static images for testing
struct PhotoListView: View {
    var body: some View {
        List {
            HStack {
                NavigationLink {
                    Text("Detail view")
                        
                } label: {
                    HStack {
                        Image("Eugene")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                     
                        Text("Photo 1")
                            .padding(.leading)

                    }
                   
                }
                
            }
            
            Text("Photo 2")
            Text("Photo 3")
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}
