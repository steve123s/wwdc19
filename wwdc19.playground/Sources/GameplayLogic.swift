//
//  GameplayLogic.swift
//  Detective Emoji
//
//  Created by Daniel Salinas on 18.03.19.
//  Copyright © 2019 danielsalinas. All rights reserved.
//


import PlaygroundSupport
import SpriteKit
import Foundation
import GameKit

public class GameplayLogic {
    
    var delegate: GameEvents?
    
    //------------------------------------
    // MARK: - Properties
    //------------------------------------
    
    var emojiPairIndex: Int?
    var correctEmojiIndex: Int?
    
    //------------------------------------
    // MARK: - Methods
    //------------------------------------
    
    func setupLogic(delegate: GameEvents, emojiPairIndex: Int) {
        self.delegate = delegate
        self.emojiPairIndex = emojiPairIndex
        // pair of emojis to choose
        self.correctEmojiIndex = Int.random(in: 0...1)
        
    }
}

//------------------------------------
// MARK: - Extensions
//------------------------------------

extension GameplayLogic: GameActions {
    
    func userHasChosen(_ answer: Bool) {
        answer == true ? self.delegate?.moveToNextLevel() : self.delegate?.gameOver(description: "😣 You Lost 😣")
    }
    
}





