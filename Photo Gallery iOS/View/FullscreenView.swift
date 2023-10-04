//
//  FullscreenView.swift
//  Photo Gallery iOS
//
//  Created by Farial Mahmod on 10/4/23.
//

import SwiftUI

struct FullscreenView: View {
    var link: String
    @State var scale = 1.0
    @State private var lastScale = 1.0
    private let minScale = 1.0
    private let maxScale = 5.0
    
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
    var body: some View {

            VStack {
                
                Spacer()
                Spacer()
                
                AsyncImage(url: URL(string: link)) { image in
                    image.resizable().scaledToFit().aspectRatio(contentMode: .fit).scaleEffect(scale)
                        .gesture(magnification)
                } placeholder: {
                    ProgressView()
                }
                
                Spacer()
                Spacer()
                
                HStack {
                    Spacer()
                    ShareLink(item: link, preview: SharePreview(
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
        
        func adjustScale(from state: MagnificationGesture.Value) {
            let delta = state / lastScale
            scale *= delta
            lastScale = state
        }
        
        func getMinimumScaleAllowed() -> CGFloat {
            return max(scale, minScale)
        }
        
        func getMaximumScaleAllowed() -> CGFloat {
            return min(scale, maxScale)
        }
        
        func validateScaleLimits() {
            scale = getMinimumScaleAllowed()
            scale = getMaximumScaleAllowed()
        }
    }

