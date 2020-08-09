//
//  SearchResult.swift
//  WordSearch
//
//  Created by Maxim Zheleznyy on 8/8/20.
//  Copyright © 2020 Maxim Zheleznyy. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let id: Int?
    let text: String?
    let meanings: [Meaning]?
}
