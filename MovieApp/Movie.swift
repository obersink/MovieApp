//
//  Movie.swift
//  MovieApp
//
//  Created by Simon Zhen on 4/28/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import Foundation

class Movie {
    private var _title: String
    private var _year: String
    
    var title: String { return _title }
    var year: String { return _year }
    
    init(title: String, year: String) {
        self._title = title
        self._year = year
    }
}
