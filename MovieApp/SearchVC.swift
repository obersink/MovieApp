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
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var inSearchMode: Bool!
    var filteredMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToMovieDetailVC" {
            if let movieDetailVC = segue.destination as? MovieDetailVC {
                if let movie = sender as? Movie {
                    movieDetailVC.movie = movie
                }
            }
            
        }
    }
}

//MARK: SearchBar
extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text == nil || searchBar.text == "" {
//            Movie.clearMovieList()
//            movieTableView.reloadData()
//        }
        
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            dataTasks.forEach{ $0.cancel() }
            uploadTasks.forEach{ $0.cancel() }
            downloadTasks.forEach{ $0.cancel() }
        }
        
        
            Movie.downloadMovieList(searchKey: searchBar.text!) {
                self.movieTableView.reloadData()
                
                if searchBar.text == nil || searchBar.text == "" {
                    Movie.clearMovieList()
                    self.movieTableView.reloadData()
                }

            }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        Movie.downloadMovieList(searchKey: searchBar.text!) {
//            self.movieTableView.reloadData()
//        }
    }
}


//MARK: TableView
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    //rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movie.movieList.count
    }
    //cell for row
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SegueToMovieDetailVC", sender: Movie.movieList[indexPath.row])
    }
    
}
