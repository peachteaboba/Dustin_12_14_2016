//
//  ViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Dustin Lee on 12/13/16.
//  Copyright © 2016 Dustin Lee. All rights reserved.
//

import UIKit
import Dispatch


class PeopleViewController: UITableViewController, showButtonDelegate {
    
//    var people = ["Luke Skywalker", "Leia Organa", "Han Solo", "C-3PO", "R2-D2"]
//    var Person = resultsArray.firstObject
    
//    var people = []
    
    var people = [Person]()
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
        let url = NSURL(string: "http://swapi.co/api/people/")
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
                            let thisPerson = x as! NSDictionary
                        
                        // Trying to print luke skywalker
//                            let thisPerson = resultsArray.firstObject as! NSDictionary
                       
                            //defaults
                            var nameSave = "no name"
                            var massSave = "n/a"
                            var heightSave = "n/a"
                            
                            if let name = thisPerson["name"] {
                                nameSave = name as! String
                            }
                            if let mass = thisPerson["mass"] {
                                massSave = mass as! String
                            }
                            if let height = thisPerson["height"] {
                                heightSave = height as! String
                            }
                            
                        self.people.append(Person(name: nameSave, mass: massSave, height: heightSave))
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
    
    
    
    // MARK: - Table View Delegate's Protocol Methods ------------------------------
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people
        return people.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("PersonCell")! as! PersonCell
        
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = self.people[indexPath.row].name
        
        // return the cell so that it can be rendered
        cell.delegate = self
        
        cell.model = self.people[indexPath.row]
        
        
       
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath.row)
        
        
        // Instantiate a storyboard VC and downcasting to the specific type
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DescriptionVC") as! CharacterDescriptionViewController
        
        // Setting some data
        vc.showDescrip = self.people[indexPath.row]
        
        // Presenting the vc that we instantiated
        self.presentViewController(vc, animated: true, completion: nil)

        
        
        
    }
    
    
    
    
    
    
    
    
    
    
//************************* MARK: show character ***********************
    func showCharacterDescription(controller: PersonCell, selectedCharacter people: Person) {
        
        print("We made it!!")
        
        // Instantiate a storyboard VC and downcasting to the specific type
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DescriptionVC") as! CharacterDescriptionViewController
        
        // Setting some data
        vc.showDescrip = people
        
        // Presenting the vc that we instantiated
        self.presentViewController(vc, animated: true, completion: nil)
        
        
        
    }
    
    
    
//************************* MARK: seqgue ******************************
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCharacterDescription" {
            let controller = segue.destinationViewController as! CharacterDescriptionViewController
            print("before description")
            controller.showDescrip = sender as? Person
            
            
        }
    }
}
