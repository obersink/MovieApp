//
//  ViewController.swift
//  MovieApp
//
//  Created by Simon Zhen on 4/28/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import UIKit
import Alamofire

class SearchVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Properties
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    var inSearchMode: Bool!
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToMovieDetailVC", let movieDetailVC = segue.destination as? MovieDetailVC, let movie = sender as? Movie {
            movieDetailVC.movie = movie
        }
        
    }
}

//MARK: SearchBar
extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Movie.downloadMovieList(searchText: searchText) { [weak self] (movies) in
            self?.movies = movies
            self?.movieTableView.reloadData()
        }
    }
}

//MARK: TableView
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.id, for: indexPath) as? MovieCell {
            cell.configureCell(movies[indexPath.row])
            return cell
        }
        return MovieCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SegueToMovieDetailVC", sender: movies[indexPath.row])
    }
}
