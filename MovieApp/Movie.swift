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
    private var _poster: String
    
    private static var _movieList = [Movie]()
    
    var title: String { return _title }
    var year: String { return _year }
    
    static var movieList: [Movie] { return _movieList }
    static func append(_ movie: Movie){ _movieList.append(movie) }
    
    init(title: String, year: String, img: String) {
        self._title = title
        self._year = year
        self._poster = img
        
        //let imgURL = NSURL(fileURLWithPath: img)
        //let imgData = NSData(contentsOf: imgURL as URL)
        //self._poster = UIImage(data: (imgData as? Data)!)!
    }
    
    class func downloadMovieList(completed: @escaping () -> ()) {
        DispatchQueue.global().async {
            Alamofire.request("http://www.omdbapi.com/?s=wick").responseJSON { response in
                if let result = response.result.value as? [String:Any] {
                    if let list = result["Search"] as? [[String:String]] {
                        for obj in list {
                            let title = obj["Title"]!
                            let year = obj["Year"]!
                            let poster = obj["Poster"]!
                            let movie = Movie(title: title, year: year, img: poster)
                            Movie.append(movie)
                        }
                    }
                }
                DispatchQueue.main.async {
                    completed()
                }
            }
        }
    }
}
