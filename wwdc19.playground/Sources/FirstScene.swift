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

public class FirstScene: SKScene {
    
    private var label : SKLabelNode!
    
    public override func didMove(to view: SKView) {
        
        backgroundColor = UIColor.white
        if let particles = SKEmitterNode(fileNamed: "Starfield.sks") {
            particles.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            addChild(particles)
        }
        
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.name = "background"
        background.setScale(0.8)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        let gameName = "Let's Findmoji!"
        let welcome = SKLabelNode(fontNamed: "Helvetica Neue")
        welcome.text = gameName
        welcome.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: welcome.frame.width * 1.25 , height: welcome.frame.height * 2.5))
        welcome.physicsBody?.isDynamic = false
        welcome.fontSize = 50
        welcome.fontColor = SKColor.black
        welcome.position = CGPoint(x: self.frame.midX, y: 400)
        welcome.alpha = 1
        welcome.zPosition = 3
        addChild(welcome)
        
        let buttonNodeName = "button"
        let button = PlayButton()
        button.name = buttonNodeName
        button.position = CGPoint(x: self.frame.midX, y: 200)
        button.delegate = self
        button.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: button.frame.width * 1.25 , height: button.frame.height * 2.5))
        button.physicsBody?.isDynamic = false
        button.alpha = 0
        let fadeInOut = SKAction.sequence([.fadeIn(withDuration: 0.5),
                                           .fadeOut(withDuration: 2.0)])
        button.run(.repeatForever(fadeInOut))
        addChild(button)
    }
    
}


extension FirstScene: PlayButtonDelegate {
    
    func didTapPlay(sender: PlayButton) {
        /*
        let action = SKAction.playSoundFileNamed("popSound.mp3", waitForCompletion: false)
        self.run(action)*/
        let transition = SKTransition.crossFade(withDuration: 0)
        let scene1 = GameScene(fileNamed:"GameScene")
        print("scene created")
        scene1!.level = 1
        scene1!.scaleMode = SKSceneScaleMode.aspectFill
        print("transition")
        self.scene!.view?.presentScene(scene1!, transition: transition)
    }
    
}
