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
    @GestureState private var scale: CGFloat = 1.0
    @State var lastScaleValue: CGFloat = 1.0
    
    var body: some View {

        NavigationView {

            ScrollView {
                
                Text("Collection Gallery iOS")
                    .font(.title).foregroundStyle(
                        LinearGradient(
                            colors: [.red, .blue, .green, .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                LazyVStack(alignment: .center){
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum:200))]) {
                        
                        ForEach(displayingPhotos.photos, id: \.id) { photo in
                            NavigationLink(destination: FullscreenView(link: photo.urls.regularUrl.absoluteString)){
                                
                                AsyncImage(url: URL(string: photo.urls.regularUrl.absoluteString))                        .frame(width: 275, height: 275)
                                    .cornerRadius(35).scaledToFit().padding()
                                    .gesture(MagnificationGesture().onChanged { val in
                                        let delta = val / self.lastScaleValue
                                        self.lastScaleValue = val
                                        let newScale = self.scale * delta
                                        
                                        //... anything else e.g. clamping the newScale
                                    }.onEnded { val in
                                        // without this the next gesture will be broken
                                        self.lastScaleValue = 1.0
                                    })
                            }
                        }
                    } 
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
