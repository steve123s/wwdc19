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
    var timer: Double {get set}
    
    func userDidRightChoice()
    func userDidWrongChoice()
    
    func gameOver(description: String)
    func moveToNextLevel()
    
}
