//
//  SplashScreen.swift
//  Photo Gallery iOS
//
//  Created by Farial Mahmod on 10/4/23.
//

import SwiftUI

struct SplashScreen: View {
    // to check which screen is active
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                // to display the contentView() when active
                ContentView()
            } else {
                // displaying the splash screen
                Rectangle()
                    .background(Color.black)
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 195).edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            // setting the duration
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.53) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
