//
//  WordSearchViewModel.swift
//  WordSearch
//
//  Created by Maxim Zheleznyy on 8/8/20.
//  Copyright © 2020 Maxim Zheleznyy. All rights reserved.
//

import Foundation

enum SearchState: String {
    case showingResults
    case searching = "Validating word..."
    case noResult = "No results found."
    case empty = ""
}

class WordSearchViewModel {
    
    private let baseStringedURL = "https://dictionary.skyeng.ru/api/public/v1"
    private let imageStringedURLPrefix = "https:"
    
    
}
