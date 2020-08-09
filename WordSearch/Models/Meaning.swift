//
//  Meaning.swift
//  WordSearch
//
//  Created by Maxim Zheleznyy on 8/8/20.
//  Copyright © 2020 Maxim Zheleznyy. All rights reserved.
//

import Foundation

struct Meaning: Decodable {
    let id: Int?
    let difficultyLevel: Int?
    let translation: Translation?
    let previewUrl: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, difficultyLevel, translation, previewUrl, imageUrl
    }
}
