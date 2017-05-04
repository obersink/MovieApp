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
var request2: Alamofire.Request?

class Movie {
    
//MARK: Properties
    private var _imdbID: String
    private var _title: String
    private var _year: String
    private var _poster: String?
    
    private var _rated: String?
    private var _duration: String?
    private var _genre: String?
    private var _plot: String?
    private var _directors: String?
    private var _writers: String?
    
    private var _imdbRating: String?
    private var _metacriticRating: String?
    private var _rtRating: Int?
    
    var imdbID: String { return _imdbID }
    var title: String { return _title }
    var year: String { return _year }
    var poster: String? { return _poster == "N/A" ? nil : _poster }
    var rated: String? { return _rated == "N/A" ? "Unrated" : _rated }
    var duration: String? { return _duration == nil ? nil : _duration }
    var genre: String? { return _genre == nil ? nil : _genre }
    var plot: String? { return _plot == nil ? nil : _plot }
    
    var imdbRating: String? { return _imdbRating == "N/A" ? "N/A" : _imdbRating }
    var metacriticRating: String? { return _metacriticRating == "N/A" ? "N/A" : _imdbRating }
    var rtRating: Int? { return _rtRating == nil ? nil : _rtRating }
    
//MARK: Constructor
    init(imdbID: String, title: String, year: String, poster: String?) {
        _imdbID = imdbID
        _title = title
        _year = year
        _poster = poster
    }
    
//MARK: Methods
    class func downloadMovieList(searchText: String?, completed: @escaping (_ movies: [Movie]) -> ()) {
        request?.cancel()
        
        var movies = [Movie]()
        
        guard let searchText = searchText, searchText != "" else {
            completed(movies)
            return
        }
        
        request = Alamofire.request("http://www.omdbapi.com/?s=\(searchText.replacingOccurrences(of: " ", with: "%20"))").responseJSON { response in
            guard response.error == nil else {
                return
            }
            
            if let result = response.result.value as? [String: Any] {
                if let list = result["Search"] as? [[String: String]] {
                    DispatchQueue.global().async {
                        for obj in list {
                            guard let imdbID = obj["imdbID"] else { return }
                            guard let title = obj["Title"] else { return }
                            guard let year = obj["Year"] else { return }
                            guard let poster = obj["Poster"] else { return }
                            
                            movies.append(Movie(imdbID: imdbID, title: title, year: year, poster: poster))
                        }
                        DispatchQueue.main.async {
                            completed(movies)
                        }
                    }
                }
            }
        }
    }
    
    class func downloadMovieDetails(movie: Movie, completed: @escaping (_ movie: Movie) -> ()) {
        
        request2 = Alamofire.request("http://www.omdbapi.com/?i=\(movie.imdbID)").responseJSON { response in
            if let result = response.result.value as? [String: Any] {
                let rated = result["Rated"] as! String
                let duration = result["Runtime"] as! String
                let durInMin = Int(duration.components(separatedBy: " ")[0])!

                let hours = durInMin / 60
                let minutes = durInMin % 60
                let plot = result["Plot"] as! String
                let genre = result["Genre"] as! String
                
                movie._rated = rated
                movie._duration = "\(hours)h \(minutes)min"
                movie._genre = genre
                movie._plot = plot

                //Ratings from different sites
                var rtRating: String!
                if let ratings = result["Ratings"] as? [[String:String]] {
                    for rating in ratings {
                        if rating["Source"] == "Rotten Tomatoes" {
                            rtRating = rating["Value"]!
                            rtRating = rtRating.substring(to: rtRating.index(before: rtRating.endIndex))
                            movie._rtRating = Int(rtRating)
                        }
                    }
                }
                
                let imdbRating = result["imdbRating"] as! String
                let metascore = result["Metascore"] as! String
                
                movie._imdbRating = imdbRating
                movie._metacriticRating = metascore
                
            }
            DispatchQueue.main.async {
                completed(movie)
            }
        }
    }
}
