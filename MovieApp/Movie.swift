//
//  Movie.swift
//  MovieApp
//
//  Created by Simon Zhen on 4/28/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import Foundation
import Alamofire

var request: Alamofire.Request?

class Movie {
    
    private var _imdbID: String
    private var _title: String
    private var _year: String
    private var _poster: String?
    
    private var _plot: String?
    private var _directors: String?
    private var _writers: String?
    
//MARK: Getters
    var imdbID: String { return _imdbID }
    var title: String { return _title }
    var year: String { return _year }
    var poster: String? { return _poster == "N/A" ? nil : _poster }
    
//MARK: Movies array and functions
    private static var _movieList = [Movie]()
    static var movieList: [Movie] { return _movieList }
    class func clearMovieList() { _movieList.removeAll() }
    
//MARK: Constructor
    init(imdbID: String, title: String, year: String, poster: String?) {
        _imdbID = imdbID
        _title = title
        _year = year
        _poster = poster
    }
    
    //currently unused
//    func downloadMovieDetails(imdbID: String, completed: @escaping () -> ()) {
//        Alamofire.request("http://www.omdbapi.com/?i=\(imdbID)").responseJSON { response in
//            if let result = response.result.value as? [String: Any] {
//        
//                //let title = result["Title"] as! String
//                //let year = result["Year"] as! String
//                //let poster = result["Poster"] as! String
//                //let movie = Movie(title: title, year: year)
//            }
//            DispatchQueue.main.async {
//                completed()
//            }
//        }
//    }
    
    class func downloadMovieList(searchKey: String, completed: @escaping () -> ()) {
        
        var movies = [Movie]()
        
        request?.cancel()
        
        request = Alamofire.request("http://www.omdbapi.com/?s=\(searchKey.replacingOccurrences(of: " ", with: "%20"))").responseJSON { response in
            
            DispatchQueue.global().async {
                if let result = response.result.value as? [String: Any] {
                    if let list = result["Search"] as? [[String: String]] {
                        for obj in list {
                            guard let imdbID = obj["imdbID"] else { return }
                            guard let title = obj["Title"] else { return }
                            guard let year = obj["Year"] else { return }
                            guard let poster = obj["Poster"] else { return }
                            
                            movies.append(Movie(imdbID: imdbID, title: title, year: year, poster: poster))
                            self._movieList = movies
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
