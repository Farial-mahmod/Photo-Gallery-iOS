//
//  Photo.swift
//  Photo Gallery iOS
//
//  Created by Farial Mahmod on 10/3/23.
//

import Foundation

// Each photo will have these two properties
struct Photo: Codable, Identifiable {
    let id: String
    let urls: Urls
}

struct Urls: Codable {
    let regular: String
    var regularUrl: URL {
        return URL(string: regular)!
    }
}

