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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratedLabel.layer.cornerRadius = 2
        ratedLabel.layer.borderWidth = 1.0
        ratedLabel.layer.borderColor = UIColor.darkGray.cgColor
        
        //var lblInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        //ratedLabel.alignmentRectInsets = lblInset
        //ratedLabel.l
        
        Movie.downloadMovieDetails(movie: movie) { movie in
            self.movie = movie
            self.titleLabel.text = movie.title
            self.ratedLabel.text = movie.rated
            self.durationLabel.text = movie.duration
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
