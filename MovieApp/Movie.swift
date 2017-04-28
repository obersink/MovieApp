//
//  Movie.swift
//  MovieApp
//
//  Created by Simon Zhen on 4/28/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import Foundation
import Alamofire

class Movie {
    private var _title: String
    private var _year: String
    
    static var _movieList = [[String:String]]()
    
    var title: String { return _title }
    var year: String { return _year }
    
    init(title: String, year: String) {
        self._title = title
        self._year = year
    }
    
    class func downloadMovieList(completed: @escaping () -> ()) {
        DispatchQueue.global().async {
            Alamofire.request("http://www.omdbapi.com/?s=wick").responseJSON { response in
                if let result = response.result.value as? [String:Any] {
                    if let list = result["Search"] as? [[String:String]] {
                        Movie._movieList = list
                    }
                }
                DispatchQueue.main.async {
                    completed()
                }
            }
        }
    }
}
