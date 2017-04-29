//
//  TableViewCell.swift
//  MovieApp
//
//  Created by Simon Zhen on 4/28/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    //MARK: Properties
    static var id: String {
        return String(describing: self)
    }
    
    //MARK: Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(_ movie: Movie) {
        movieTitle.text = "\(movie.title) (\(movie.year))"
        
        self.moviePoster.image = nil
        if let poster = movie.poster, let url = URL(string: poster) {
            moviePoster.af_setImage(withURL: url, placeholderImage: nil, filter: nil, imageTransition: .noTransition)
        }
    }
}
