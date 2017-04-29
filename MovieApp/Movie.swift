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
    
    private var _imdbID: String!
    private var _title: String
    private var _year: String
    private var _poster: UIImageView?
    
//MARK: Getters
    var title: String { return _title }
    var year: String { return _year }
    var poster: UIImageView { return _poster! }
    
//MARK: Movies array and functions
    private static var _movieList = [Movie]()
    static var movieList: [Movie] { return _movieList }
    class func clearMovieList() { _movieList.removeAll() }
    
//MARK: Constructor
    init(title: String, year: String) {
        self._title = title
        self._year = year
        //self._poster = poster
        //self._poster = UIImage(data: (imgData as? Data)!)!
    }
    
    //currently unused
    func downloadMovieDetails(imdbID: String, completed: @escaping () -> ()) {
        Alamofire.request("http://www.omdbapi.com/?i=\(imdbID)").responseJSON { response in
            if let result = response.result.value as? [String:Any] {
        
                //let title = result["Title"] as! String
                //let year = result["Year"] as! String
                //let poster = result["Poster"] as! String
                //let movie = Movie(title: title, year: year)
            }
            DispatchQueue.main.async {
                completed()
            }
        }
    }
    
    class func downloadMovieList(searchKey: String, completed: @escaping () -> ()) {
        
        DispatchQueue.global().async {
            var movies = [Movie]()
            print("request")
            Alamofire.request("http://www.omdbapi.com/?s=\(searchKey)").responseJSON { response in
                if let result = response.result.value as? [String:Any] {
                    if let list = result["Search"] as? [[String:String]] {
                        for obj in list {
                            let id = obj["imdbID"]
                            let title = obj["Title"]!
                            let year = obj["Year"]!
                            let posterURL = obj["Poster"]!
                            
                            let poster = UIImageView()
                            let imgURL = URL(string: posterURL)!
                            do {
                                let data = try Data.init(contentsOf: imgURL)
                                poster.image = UIImage(data: data)
                            }
                            catch{}
                            
                            let movie = Movie(title: title, year: year)
                            movie._imdbID = id
                            movie._poster = poster
                            
                            movies.append(movie)
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
