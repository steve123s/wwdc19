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
    
    let emojis: [String] = ["🐶","🐱","🐻","🐼","🐴","🦄","🦁","🐯",
                            "🐦","🐤","🐣","🐥","🙉","🙈","🐠","🐟",
                            "🐪","🐫","🦖","🦎","🐑","🐐","🐁","🐀",
                             "🦊","🐰","🐭","🐹", "🐛","🦋"]
    
    private var label : SKLabelNode!
    
    public override func didMove(to view: SKView) {
        
        backgroundColor = UIColor.white
        if let particles = SKEmitterNode(fileNamed: "Starfield.sks") {
            particles.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            addChild(particles)
        }
        
        let gradBackground = SKSpriteNode(imageNamed: "gradBackground.jpg")
        gradBackground.zPosition = 0
        gradBackground.setScale(0.8)
        gradBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(gradBackground)
        
        let background = SKSpriteNode(imageNamed: "homeBackground.png")
        background.name = "background"
        background.zPosition = 1
        background.setScale(0.8)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        let title = SKSpriteNode(imageNamed: "title.png")
        title.zPosition = 2
        title.setScale(0.8)
        title.position = CGPoint(x: frame.midX, y: 400)
        title.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: title.frame.width * 1.25 , height: title.frame.height * 1.25))
        title.physicsBody?.isDynamic = false
        addChild(title)
        
        let buttonNodeName = "button"
        let button = PlayButton()
        button.name = buttonNodeName
        button.position = CGPoint(x: self.frame.midX, y: 50)
        button.zPosition = 2
        button.delegate = self
        
        button.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: button.frame.width * 1.25 , height: button.frame.height * 1.25))
        button.physicsBody?.isDynamic = false
        button.alpha = 0
        let fadeInOut = SKAction.sequence([.fadeIn(withDuration: 0.4),
                                           .fadeOut(withDuration: 2.0)])
        button.run(.repeatForever(fadeInOut))
        addChild(button)
        
        let wait = SKAction.wait(forDuration: 0.1)
        let dropAction = SKAction.run {
            self.dropRandomEmoji()
        }
        let pinAction = SKAction.run {
            for child in self.children {
                child.physicsBody?.isDynamic = false
            }
        }
        let stopAction = SKAction.run {
            if self.children.count > 40 {
                self.removeAllActions()
            }
        }
        run(SKAction.repeatForever(SKAction.sequence([dropAction, wait, pinAction, stopAction])))
    }
    
    func dropRandomEmoji() {
        //let action = SKAction.playSoundFileNamed("begin.mp3", waitForCompletion: false)
        //self.run(action)
        let randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: emojis.count)
        let emojiLabel = SKLabelNode(text: emojis[randomIndex])
        emojiLabel.fontSize = CGFloat(40)
        let xSpawn = CGFloat.random(in: 0.0...frame.maxX)
        let ySpawn = CGFloat.random(in: 0.0...frame.maxY)
        emojiLabel.position = CGPoint(x: xSpawn, y: ySpawn)
        emojiLabel.physicsBody = SKPhysicsBody(circleOfRadius: emojiLabel.fontSize * 1.25)
        
        let xRange = SKRange(lowerLimit: -20,
                             upperLimit: frame.size.width + 20 )
        let yRange = SKRange(lowerLimit: 0,
                             upperLimit: frame.size.height)
        emojiLabel.constraints = [SKConstraint.positionX(xRange,y:yRange)]
        
        addChild(emojiLabel)
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
