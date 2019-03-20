//
//  GameActions.swift
//  Detective Emoji
//
//  Created by Daniel Salinas on 18.03.19.
//  Copyright © 2019 danielsalinas. All rights reserved.
//

import Foundation

protocol GameActions {
    
    var emojiPairIndex: Int? { get }
    
    func userHasChosen(_ answer: Bool)
    
    func setupLogic(delegate: GameEvents, emojiPairIndex: Int)
    
}

