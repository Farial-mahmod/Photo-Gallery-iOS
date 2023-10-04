//
//  ContentView.swift
//  Photo Gallery iOS
//
//  Created by Farial Mahmod on 10/3/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @ObservedObject var displayingPhotos = GalleryPhoto()
    
    var body: some View {
        ScrollView {
        LazyVStack(alignment: .leading){
          
                ForEach(displayingPhotos.photos, id: \.id) { photo in
                    
                    AsyncImage(url: URL(string: "\(photo.urls.regularUrl.absoluteString)"))
                }}
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
