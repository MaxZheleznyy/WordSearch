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
    
    private let previewUrl: String?
    private let imageUrl: String?
    
    var fixedPreviewURL: String? {
        get {
            if let nonEmptyPreviewURL = previewUrl {
                var finalPreviewURL = nonEmptyPreviewURL
                if finalPreviewURL.prefix(5) != "https" {
                    finalPreviewURL = "https:" + finalPreviewURL
                }
                return finalPreviewURL
            } else {
                return nil
            }
        }
    }
    
    var fixedImageURL: String? {
        get {
            if let nonEmptyImageURL = imageUrl {
                var finalImageURL = nonEmptyImageURL
                if nonEmptyImageURL.prefix(5) != "https" {
                    finalImageURL = "https:" + finalImageURL
                }
                return finalImageURL
            } else {
                return nil
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, difficultyLevel, translation, previewUrl, imageUrl
    }
}
