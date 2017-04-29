//
//  TableViewCell.swift
//  MovieApp
//
//  Created by Simon Zhen on 4/28/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(_ movie: Movie) {
        self.movieTitle.text = "\(movie.title) (\(movie.year))"
        self.moviePoster.image = movie.poster.image
    }
}
