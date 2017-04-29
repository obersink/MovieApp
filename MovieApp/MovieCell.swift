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

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    var request: Alamofire.Request?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(_ movie: Movie) {
        self.movieTitle.text = "\(movie.title) (\(movie.year))"
        self.moviePoster.image = nil
        if let poster = movie.poster {
            request?.cancel()
            request = Alamofire.request(poster).responseImage { response in
                if let image = response.result.value {
                    self.moviePoster.image = image
                }
            }
        }
    }
}
