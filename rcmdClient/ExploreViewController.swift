//
//  ExploreViewController.swift
//  rcmdClient
//
//  Created by Song Zhou on 3/21/16.
//  Copyright © 2016 Song Zhou. All rights reserved.
//

import UIKit

class ExploreViewController: UITableViewController {
    var searchController: MovieSearchController!
    var movies: [[String: AnyObject]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exploreStr = NSLocalizedString("explore", comment: "")
        self.title = exploreStr
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(ExploreViewController.searchButtonClicked(_:)))
        
        let headerView = UILabel.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 200))
        headerView.textAlignment = .Center
        headerView.text = "基于用户的协同过滤推荐结果, 用户 ID: 250"
        
        self.tableView.tableHeaderView = headerView
            
        DataManager.sharedInstance.getUserUserCF(250) { [unowned self] jsonObject, response, error in
            self.movies = jsonObject as? [[String: AnyObject]]
            
            if self.movies != nil {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let count = movies?.count {
            return count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MovieCell(reuseIdentifier: "explore cell")
        let movie = movies![indexPath.row]
        
        cell.nameLabel.text = movie["name"] as? String
        cell.ratingLabel.text = String(format: "%.2f",  movie["prediction"] as! Double)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let movie = movies![indexPath.row]
        
        let vc = MovieDetailViewController.init(style: .Grouped, movieID: movie["id"] as! Int)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Button Actions
    func searchButtonClicked(sender: UIBarButtonItem) {
        let searchResultsViewController = SearchResultsViewController()
        
        self.searchController = MovieSearchController(searchResultsController: searchResultsViewController)
        
        self.searchController.searchResultsUpdater = searchResultsViewController
        self.presentViewController(searchController, animated: true, completion: nil)
    }
}
