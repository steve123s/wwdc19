//
//  GameEvents.swift
//  Detective Emoji
//
//  Created by Daniel Salinas on 18.03.19.
//  Copyright © 2019 danielsalinas. All rights reserved.
//


import Foundation

protocol GameEvents {
    
    var level: Int { get set }
    var timer: Int {get set}
    
    func userDidRightChoice(index: Int)
    func userDidWrongChoice()
    
    func gameOver(description: String)
    func moveToNextLevel()
    
}
