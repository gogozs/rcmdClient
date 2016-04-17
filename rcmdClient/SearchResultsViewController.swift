//
//  SearchResultsViewController.swift
//  rcmdClient
//
//  Created by Song Zhou on 3/21/16.
//  Copyright © 2016 Song Zhou. All rights reserved.
//

import UIKit

private let cellIdentifier = "search cell"

class SearchResultsViewController: UITableViewController {
    var movies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let movies = movies {
            return movies.count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let movie = movies![indexPath.row]
        let id = movie.id
        
        let vc = MovieDetailViewController.init(style: .Grouped, movieID: id)
        self.presentingViewController?.navigationController?.pushViewController(vc, animated: true)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
        
        if let movies = movies {
            let movie = movies[indexPath.row]
            cell.textLabel?.text = movie.name
        }
        
        return cell
    }

}

extension SearchResultsViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let keyword = searchController.searchBar.text where keyword != "" {
            DataManager.sharedInstance.searchMoviesWithKeyword(keyword, completion: { [unowned self]jsonObject, reponse, error in
                if let moviesResponse = jsonObject as? [[String: AnyObject]] {
                    var movies = [Movie]()
                    for movieResponse in moviesResponse {
                        let movie = Movie.init(id: movieResponse[movieIDKey] as! Int)
                        movie.name = movieResponse[movieNameKey] as! String
                        movie.genre = movieResponse[movieGenreKey] as? Int
                        movie.release_data = movieResponse[movieReleaseDateKey] as? String
                        
                        movies.append(movie)
                    }
                    
                    self.movies = movies;
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                    })
                }
                
            })
        }
    }
 

}