//
//  FullscreenView.swift
//  Photo Gallery iOS
//
//  Created by Farial Mahmod on 10/4/23.
//

import SwiftUI

// fulllscreen view of the image
struct FullscreenView: View {
    // link is the url passed from the home screen
    var link: String
    // scale helps to magnify the zoom in/out features
    @State var scale = 1.0
    @State private var lastScale = 1.0
    private let minScale = 1.0
    private let maxScale = 5.0
    
    // magnification to magnify the zoom-in feature on the image
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged { state in
                adjustScale(from: state)
            }
            .onEnded { state in
                withAnimation {
                    validateScaleLimits()
                }
                lastScale = 1.0
            }
    }
    // the image view
    var body: some View {

            VStack {
                
                Spacer()
                Spacer()
                // AsyncImage uses URLCache
                // the image is customized to fit the screen and never to cross the screen-size
                AsyncImage(url: URL(string: link)) { image in
                    image.resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(scale)
                        .gesture(magnification)
                } placeholder: {
                    // to show a round progressview when it is loading
                    ProgressView()
                }
                
                Spacer()
                Spacer()
                
                HStack {
                    Spacer()
                    // to share the image link
                    ShareLink(item: link, preview: SharePreview(
                        // custom message and icon
                        "Sent to you by EWN BD",
                        image: Image("logo")
                    )){
                        HStack{
                            Text("Share")
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                    Spacer()
                }.background(.white).padding(.top, 7)
            }
            
        }
        // to adjust the range of magnification
        func adjustScale(from state: MagnificationGesture.Value) {
            let delta = state / lastScale
            scale *= delta
            lastScale = state
        }
        // the allowed minimum
        func getMinimumScaleAllowed() -> CGFloat {
            return max(scale, minScale)
        }
        // th alloewd minimum
        func getMaximumScaleAllowed() -> CGFloat {
            return min(scale, maxScale)
        }
        // to validate the scale range limit
        func validateScaleLimits() {
            scale = getMinimumScaleAllowed()
            scale = getMaximumScaleAllowed()
        }
    }

