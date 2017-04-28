//
//  ViewController.swift
//  MovieApp
//
//  Created by Simon Zhen on 4/28/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Movie.downloadMovieList {
            self.movieTableView.reloadData()
        }
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movie.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            let movie = Movie.movieList[indexPath.row]
            cell.configureCell(movie)
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
}
