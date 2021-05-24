//
//  SuperHero.swift
//  Marvelgram
//
//  Created by Нариман on 02.05.2021.
//

import Foundation

struct ThumbnailImage: Codable {
    var path: String = ""
    var `extension`: String = ""

    func fullPath() -> String {
        return "\(self.path).\(self.extension)"
    }
}

struct SuperHero: Codable {
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var thumbnail: ThumbnailImage = ThumbnailImage()
    var active = true
    private enum CodingKeys: String, CodingKey {
        case id, name, description, thumbnail
    }
}

