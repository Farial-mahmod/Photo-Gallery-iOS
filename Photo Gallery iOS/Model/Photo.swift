//
//  Photo.swift
//  Photo Gallery iOS
//
//  Created by Farial Mahmod on 10/3/23.
//

import Foundation

struct Photo: Identifiable, Codable {
    var id: Int
    var url: [String: String]
}
