//
//  FilmViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Dustin Lee on 12/13/16.
//  Copyright © 2016 Dustin Lee. All rights reserved.
//

import UIKit
import Dispatch


class FilmViewController: UITableViewController {

    
    var episode = [Film]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        swAPI()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper functions ---------------------------------
    
    func swAPI() {
        let url = NSURL(string: "http://swapi.co/api/films/")
        // Create an NSURLSession to handle the request tasks
        let session = NSURLSession.sharedSession()
        // Create a "data task" which will request some data from a URL and then run a completion handler after it is done
        let task = session.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            print("in here")
            //            print(data)
            
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                    print(jsonResult)
                    
                    // This is where we play with the JSON DATA ..
                    
                    
                    if let results = jsonResult["results"] {
                        let resultsArray = results as! NSArray
                        
                        print(resultsArray.count)
                        print(resultsArray.firstObject)
                        //                        self.people = resultsArray
                        //                        dispatch_async(dispatch_get_main_queue()) {
                        //                            // dont use this line --> people = resultsArray.map(){Person(name:$0)}
                        //                            self.tableView.reloadData()
                        
                        for x in resultsArray {
                            let thisFilm = x as! NSDictionary
                            
                            // Trying to print luke skywalker
                            //                            let thisPerson = resultsArray.firstObject as! NSDictionary
                            
                            //defaults
                            var titleSave = "no title"
//                            var episode_idSave = "n/a"
                    
                            
                            if let title = thisFilm["title"] {
                                titleSave = title as! String
                            }
//                            if let episode_id = thisFilm["episode_id"] {
//                                episode_idSave = episode_id as! Int
//                            }
                            
                            self.episode.append(Film(title: titleSave))
                        }
                        dispatch_async(dispatch_get_main_queue()) {
                            self.tableView.reloadData()
                        }
                    }
                }
            }catch {
                print("Something went wrong")
            }
        })
        task.resume()
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people
        return episode.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Create a generic cell
        //        let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCellWithIdentifier("FilmCell")!
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = self.episode[indexPath.row].title
        // return the cell so that it can be rendered
        return cell
    }
    
}
