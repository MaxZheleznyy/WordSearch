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

enum CustomReturnEror: Error {
    case wrongURL
    case noDataInResponse
    case cantDecodeResponse
}

class WordSearchViewModel {
    
    private let baseStringedURL = "https://dictionary.skyeng.ru/api/public/v1"
    private let imageStringedURLPrefix = "https:"
    private let networkQueue = DispatchQueue(label: "Word Search", qos: DispatchQoS.background)
    
    //MARK: - Network
    func searchWord(_ word: String, completion: @escaping (SearchResult?, Error?) -> Void) {
        let stringedEndpointURL = baseStringedURL + "/words/search?search=\(word)".encodeUrl
        
        networkQueue.async {
            guard let url = URL(string: stringedEndpointURL) else {
                completion(nil, CustomReturnEror.wrongURL)
                return
            }

            let urlRequest = URLRequest(url: url)
        
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard let data = data else {
                    completion(nil, CustomReturnEror.noDataInResponse)
                    return
                }
                
                do {
                    let searchResult = try JSONDecoder().decode(Array<SearchResult>.self, from: data)
                    if let firstResult = searchResult.first {
                        completion(firstResult, nil)
                    }
                } catch {
                    completion(nil, CustomReturnEror.cantDecodeResponse)
                }
            }.resume()
        }
    }
}
