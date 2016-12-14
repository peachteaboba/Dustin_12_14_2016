//
//  PersonCell.swift
//  Star Wars Encyclopedia
//
//  Created by Dustin Lee on 12/14/16.
//  Copyright © 2016 Dustin Lee. All rights reserved.
//

import Foundation

import UIKit

class PersonCell: UITableViewCell {
    @IBOutlet weak var detailsButton: UIButton!
    
    weak var delegate: showButtonDelegate?
    
    
    
    private var _model: Person?
    
    
    
    
    // Write getter and setter for this _model
    var model:Person {
        set{
            _model = newValue
        

        }
        get {
            return _model!
        }
    }

    
    
    
    
    
    
    
    @IBAction func showButtonPressed(sender: AnyObject) {
        print("Running Delegate Method")
        delegate?.showCharacterDescription(self, selectedCharacter: self._model!)
        
    }
}
