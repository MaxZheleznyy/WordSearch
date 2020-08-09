//
//  StringExtension.swift
//  WordSearch
//
//  Created by Maxim Zheleznyy on 8/8/20.
//  Copyright © 2020 Maxim Zheleznyy. All rights reserved.
//

import Foundation

extension String{
    var encodeUrl: String {
        if let nonEmptyUpdatedString = self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            return nonEmptyUpdatedString
        } else {
            return self
        }
    }
    
    var decodeUrl: String {
        if let nonEmptyUpdatedString = self.removingPercentEncoding {
            return nonEmptyUpdatedString
        } else {
            return self
        }
    }
}
