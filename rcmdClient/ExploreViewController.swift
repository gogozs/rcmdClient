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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exploreStr = NSLocalizedString("explore", comment: "")
        self.title = exploreStr
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(ExploreViewController.searchButtonClicked(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    // MARK: - Button Actions
    func searchButtonClicked(sender: UIBarButtonItem) {
        let searchResultsViewController = SearchResultsViewController()
        
        self.searchController = MovieSearchController(searchResultsController: searchResultsViewController)
        
        self.searchController.searchResultsUpdater = searchResultsViewController
        self.presentViewController(searchController, animated: true, completion: nil)
    }
}
