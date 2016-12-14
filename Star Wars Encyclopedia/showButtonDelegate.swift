//
//  showButtonDelegate.swift
//  Star Wars Encyclopedia
//
//  Created by Dustin Lee on 12/14/16.
//  Copyright © 2016 Dustin Lee. All rights reserved.
//

import Foundation

protocol showButtonDelegate: class {
    func showCharacterDescription(controller: PersonCell, selectedCharacter people: Person)
}
