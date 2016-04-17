//
//  MovieDetailViewController.swift
//  rcmdClient
//
//  Created by Song Zhou on 3/21/16.
//  Copyright © 2016 Song Zhou. All rights reserved.
//

import UIKit

let movieDetailCellIdentifier = "similar movie cell identifier"

class MovieDetailViewController: UITableViewController {
    var movieID: Int
    var similarMovies: [[String: AnyObject]]?

    init(style: UITableViewStyle, movieID: Int) {
        self.movieID = movieID
        
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "基于项目的协同过滤推荐"
        
        /// @todo prematrue dealloc when viewDisappear but data load
        DataManager.sharedInstance.getItemItemCF(movieID, count: 5) { [unowned self] jsonObject, response, error in
            self.similarMovies = jsonObject as? [[String: AnyObject]]
            
            if self.similarMovies != nil {
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
        // #warning Incomplete implementation, return the number of sections
        if let _ = similarMovies?.count {
            return 2
        } else {
            return 1
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return similarMovies!.count
        default:
            break
        }
        
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MovieCell(reuseIdentifier: movieDetailCellIdentifier)
        
        switch indexPath.section {
        case 0:
            DataManager.sharedInstance.getMovieDetail(movieID, completion: { jsonObject, response, error in
                if let movie = jsonObject as? [String: AnyObject] {
                    // update UI
                    cell.nameLabel.text = movie[movieNameKey] as? String
                }
                })
            DataManager.sharedInstance.getRatingWithUserID(250, movieID: movieID, completion: { jsonObject, response, error in
                    if let result = jsonObject as? [String: AnyObject] {
                        if let score = result[ratingKey] {
                           cell.ratingLabel.text = "你的评分 " + String(score)
                        } else {
                           cell.ratingLabel.text = "还没有评分"
                        }
                    } else {
                    }
                })
            break
        case 1:
            let movie = similarMovies![indexPath.row]
            DataManager.sharedInstance.getMovieDetail(movie[movieIDKey] as! Int, completion: {jsonObject, response, error in
                if let movie = jsonObject as? [String: AnyObject] {
                    // update UI
                    cell.nameLabel.text = movie[movieNameKey] as? String
                }
                })
            cell.ratingLabel.text = String(format:"相似度 %.4f", movie["similarity"] as! Double)
            break
        default:
            break
        }

        return cell
    }
 
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            break
        case 1:
            return "相似的电影"
        default:
            break
        }
        
        return ""
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
