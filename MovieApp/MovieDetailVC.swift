//
//  MovieDetailVC.swift
//  MovieApp
//
//  Created by Simon Zhen on 4/28/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {

    var movie: Movie!
    
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var plotTextView: UITextView!
    
    @IBOutlet weak var imdbRating: UILabel!
    @IBOutlet weak var metacriticRating: UILabel!
    @IBOutlet weak var rtRating: UILabel!
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var rtIcon: UIImageView!
    
    @IBOutlet weak var imdbRatingView: UIStackView!
    @IBOutlet weak var metacriticRatingView: UIStackView!
    @IBOutlet weak var rtRatingView: UIStackView!
    @IBOutlet weak var noRatingsLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratedLabel.layer.cornerRadius = 2
        ratedLabel.layer.borderWidth = 1.0
        ratedLabel.layer.borderColor = UIColor.darkGray.cgColor
        
        self.view.layer.borderWidth = 1.0
        self.view.layer.borderColor = UIColor.darkGray.cgColor
        
        
        Movie.downloadMovieDetails(movie: movie) { movie in
            self.movie = movie
            self.titleLabel.text = movie.title
            self.ratedLabel.text = movie.rated
            self.durationLabel.text = movie.duration
            self.genreLabel.text = movie.genre
            self.plotTextView.text = movie.plot
            
            self.imdbRating.text = movie.imdbRating
            self.metacriticRating.text = movie.metacriticRating
            
            //check if ratings exist
            if let rtScore = movie.rtRating {
                self.rtRating.text = "\(rtScore)%"
                if rtScore >= 75 {
                    self.rtIcon.image = UIImage(named: "rtCertified")
                }
                else if rtScore <= 59 {
                    self.rtIcon.image = UIImage(named: "rtRotten")
                }
                else {
                    self.rtIcon.image = UIImage(named: "rtFresh")
                }
                self.rtRatingView.isHidden = false
            }
            
            if movie.imdbRating != "N/A" { self.imdbRatingView.isHidden = false }
            if movie.metacriticRating != "N/A" { self.metacriticRatingView.isHidden = false }
            
            if self.imdbRatingView.isHidden && self.metacriticRatingView.isHidden && self.rtRatingView.isHidden {
                self.noRatingsLabel.isHidden = false
            }
            
            if let poster = movie.poster, let url = URL(string: poster) {
                self.moviePoster.af_setImage(withURL: url, placeholderImage: nil, filter: nil, imageTransition: .noTransition)
            }
            
            
        }
        
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//class InsetLabel: UILabel {
//    override func drawText(in rect: CGRect) {
//        super.drawText(in: CGRect(x: 0, y: 10, width: 0, height: 10))
//    }
//}
