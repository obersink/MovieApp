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
    var poster: UIImageView { return _poster == nil ? UIImageView() : _poster! }
    
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
    
    func downloadMovieDetails(imdbID: String, completed: @escaping () -> ()) {
        Alamofire.request("http://www.omdbapi.com/?i=\(imdbID)").responseJSON { response in
            if let result = response.result.value as? [String:Any] {
        
                let title = result["Title"] as! String
                let year = result["Year"] as! String
                let poster = result["Poster"] as! String
                let movie = Movie(title: title, year: year)
    
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
                            
                            

                            let movie = Movie(title: title, year: year)
                            movie._imdbID = id
                            
                            
//                            let imgURL = URL(fileURLWithPath: posterURL)
//                            do{
//                                let imgData = try Data(contentsOf: imgURL)
//                                movie._poster = UIImage(data: imgData)
//                            }
//                            catch {}
                            let url = URL(string: posterURL)
                            
                            DispatchQueue.global().async {
                                let data = try? Data(contentsOf: url!)
                                DispatchQueue.main.async {
                                    movie._poster?.image = UIImage(data: data!)
                                }
                            }
                            
                            
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
