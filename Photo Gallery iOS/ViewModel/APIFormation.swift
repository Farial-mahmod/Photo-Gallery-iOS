//
//  APIFormation.swift
//  Photo Gallery iOS
//
//  Created by Farial Mahmod on 10/3/23.

import Foundation

@MainActor class GalleryPhoto : ObservableObject {
    // an array to store the fetched URLs
    @Published var photos: [Photo] = []

init(){
    loadPhotos()
}

// loadPhotos() initiates the API request to the Unsplash server
func loadPhotos(){
    
    let key = "-2kFD_PDKY_EFCfQuv5Fb4xfiz6lK9qOxFPf_QI_ueM"
    // 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
    // URL provided by Unplash doc
    guard let url = URL(string: "https://api.unsplash.com/photos/random/?count=719&client_id=\(key)") else {return }

    // API Call
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        
            // to return an error object if data is unavailable
            guard let data = data else {
                let tempError = error!.localizedDescription
              print(tempError)
                return
            }
        
        // JSON decoding
        let photosResponse = try! JSONDecoder().decode([Photo].self, from: data)
            print(photosResponse)
              DispatchQueue.main.async {
              self.photos.append(contentsOf: photosResponse)
              }
          
        }.resume()
}
}
