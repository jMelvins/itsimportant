//
//  SearchResults.swift
//  itsImportant
//
//  Created by Vladislav Shilov on 19.04.17.
//  Copyright © 2017 Vladislav Shilov. All rights reserved.
//

import Foundation

class SearchResult {
    var indexOfNumber : Int
    var number : String
    
    init(indexOfNumber: Int, number: String) {
        self.indexOfNumber = indexOfNumber
        self.number = number
    }
}
