//
//  AboutScene.swift
//  Detective Emoji
//
//  Created by Daniel Salinas on 18.03.19.
//  Copyright © 2019 danielsalinas. All rights reserved.
//

import SpriteKit


public class AboutScene: SKScene {
    
    public override func didMove(to view: SKView) {
        
        // set background image
        let background = SKSpriteNode(imageNamed: "gradBackground.jpg")
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        let question = SKLabelNode(text: "Hello!\nMy name is Daniel Salinas and i dream on being a great iOS Developer!")
        question.zPosition = 1
        question.position = CGPoint(x: frame.midX, y: frame.maxY*0.9)
        addChild(question)
        
    }
    
}

// MARK: - Drawings
extension AboutScene {
    
    
}
