//
//  ContentView.swift
//  Photo Gallery iOS
//
//  Created by Farial Mahmod on 10/3/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    // displayingPhotos() contains the photos fetched by the API call
    @ObservedObject var displayingPhotos = GalleryPhoto()
    // scale is to modify the range limit of zoom-in or out
    @GestureState private var scale: CGFloat = 1.0
    // to count the last scale value
    @State var lastScaleValue: CGFloat = 1.0
    
    var body: some View {
        // this view will be navigated to Fullscreenview() with image as clicked by the user
        NavigationView {

            ScrollView {
                // title of the app
                Text("Collection Gallery iOS")
                    .font(.title).foregroundStyle(
                        LinearGradient(
                            // the title is a gradient color text
                            colors: [.red, .blue, .green, .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                // to load only on the visible screen
                LazyVStack(alignment: .center){
                    // to load only on the visible screen
                    // this is a custom Grid view
                    LazyVGrid(columns: [GridItem(.adaptive(minimum:210))]) {
                        
                        ForEach(displayingPhotos.photos, id: \.id) { photo in
                            // this view will be navigated to Fullscreenview() with image as clicked by the user
                            NavigationLink(destination: FullscreenView(link: photo.urls.regularUrl.absoluteString)){
                                
                                // AsyncImage uses URLCache
                                // the image is customized to fit the screen and never to cross the screen-size
                                AsyncImage(url: URL(string: photo.urls.regularUrl.absoluteString))
                                    .frame(width: 275, height: 275)
                                    .cornerRadius(35).scaledToFit()
                                    .gesture(MagnificationGesture().onChanged { val in
                                        // the calculation is to manage the amount to zoom
                                        let delta = val / self.lastScaleValue
                                        self.lastScaleValue = val
                                        let newScale = self.scale * delta
                                        
                                        // clamping the newScale
                                    }.onEnded { val in
                                        // to avoid the next gesture be broken
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

// preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
