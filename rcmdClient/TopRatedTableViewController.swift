//
//  TopRatedTableViewController.swift
//  rcmdClient
//
//  Created by Song Zhou on 3/21/16.
//  Copyright © 2016 Song Zhou. All rights reserved.
//

import UIKit

class TopRatedTableViewController: UITableViewController {
    var topMovies: [String: AnyObject]?
    var sortedMovies:[String]?
    var movieDetails = [Int: [String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topListStr = NSLocalizedString("top_rated", comment: "")
        self.title = topListStr
        
        DataManager.sharedInstance.getTopMovies(20) { responseObject, response, error in
            if let _ = error {
                
            } else {
                self.topMovies = responseObject as? [String: AnyObject]
                
                if let topMovies = self.topMovies {
                    self.sortedMovies = topMovies.keys.sort {
                        topMovies[$0] as! Double > topMovies[$1] as! Double
                    }
                    self.tableView.reloadData()
                }
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
        if let topMovies = self.topMovies {
            return topMovies.keys.count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "top Movie"
        var cell = self.tableView.dequeueReusableCellWithIdentifier(identifier) as? MovieCell
        if cell == nil {
            cell = MovieCell(reuseIdentifier: identifier)
        }
        
        if let topMovies = self.topMovies, let sortedMovies = self.sortedMovies {
            if let movieID = Int(sortedMovies[indexPath.row]) {
                if movieDetails[movieID] == nil {
                    DataManager.sharedInstance.getMovieDetail(movieID, completion: {[unowned self] jsonObject, response, error in
                        if let movie = jsonObject as? [String: AnyObject] {
                            self.movieDetails[movieID] = movie
                            
                            // update UI
                            dispatch_async(dispatch_get_main_queue(), {
                                cell!.nameLabel.text = movie[movieNameKey] as? String
                            })
                        }
                    })
                } else {
                   cell!.nameLabel.text = movieDetails[movieID]?[movieNameKey] as? String
                }
                
            }
//            cell.textLabel?.text = movieID
            if let rating = topMovies[sortedMovies[indexPath.row]] as? Double {
                cell!.ratingLabel.text = String(format: "%.2f", rating)
            }
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let movieID = sortedMovies![indexPath.row]
        
        let vc = MovieDetailViewController.init(style: .Grouped, movieID: Int(movieID)!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class MovieCell: UITableViewCell {
    var nameLabel = UILabel()
    var ratingLabel = UILabel()
    
    convenience init(reuseIdentifier: String?) {
        self.init(style: .Default, reuseIdentifier: reuseIdentifier)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.textColor = UIColor.grayColor()
        
        self.addSubview(self.nameLabel)
        self.addSubview(self.ratingLabel)
        
        self.initNameLabel()
        self.initRatingLabel()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    func initNameLabel() {
        
        let leading = NSLayoutConstraint.init(item: self.nameLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 8)
        let centerY = NSLayoutConstraint.init(item: self.nameLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0)
        
        let trailing = NSLayoutConstraint.init(item: self.nameLabel, attribute: .Trailing, relatedBy: .LessThanOrEqual, toItem: self.ratingLabel, attribute: .Leading, multiplier: 1.0, constant: -8)
        
        trailing.priority = UILayoutPriorityDefaultHigh + 1
        self.nameLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh - 1, forAxis: .Horizontal)
        NSLayoutConstraint.activateConstraints([leading, centerY, trailing])
    }
    
    func initRatingLabel() {
        let trailing = NSLayoutConstraint.init(item: self, attribute: .Trailing, relatedBy: .Equal, toItem: self.ratingLabel, attribute: .Trailing, multiplier: 1.0, constant: 8)
        let centerY = NSLayoutConstraint.init(item: self.ratingLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activateConstraints([trailing, centerY])
    }
}
