//
//  AboutScene.swift
//  Detective Emoji
//
//  Created by Daniel Salinas on 18.03.19.
//  Copyright © 2019 danielsalinas. All rights reserved.
//

import SpriteKit
import UIKit
import GameplayKit


public class AboutScene: SKScene {
    
    //------------------------------------
    // MARK: - Properties
    //------------------------------------
    
    let emojis: [String] = ["🐶","🐱",
                            "🐻","🐼","🐴","🦄","🦁","🐯",
                            "🐦","🐤","🐣","🐥","🙉","🙈","🐠","🐟",
                            "🐪","🐫","🦖","🦎","🐑","🐐","🐁","🐀",
                            "🦊","🐰","🐭","🐹", "🐛","🦋"]
    
    //------------------------------------
    // MARK: - DidMove
    //------------------------------------
    
    public override func didMove(to view: SKView) {
        
        var fadeInAction = SKAction.fadeIn(withDuration: 1.0)
        
        
        // set background image
        let background = SKSpriteNode(imageNamed: "gradBackground.jpg")
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        let greeting = SKLabelNode(text: "Hello! :)")
        greeting.color = UIColor.black
        greeting.fontColor = UIColor.black
        greeting.fontSize = 25
        greeting.zPosition = 0
        greeting.alpha = 0
        greeting.position = CGPoint(x: frame.midX, y: frame.maxY*0.93)
        addChild(greeting)
        greeting.run(fadeInAction)
        
        let name = SKLabelNode(text: "My name is Daniel Salinas, i live in Mexico. 🇲🇽")
        name.fontColor = UIColor.black
        name.fontSize = 19
        name.zPosition = 1
        name.alpha = 0
        name.position = CGPoint(x: frame.midX, y: frame.maxY*0.87)
        addChild(name)
        fadeInAction = SKAction.fadeIn(withDuration: 1.5)
        name.run(fadeInAction)
        
        let desc = SKLabelNode(text: "I form part of the iOS Development Lab. FI, UNAM since it's beginning.")
        desc.fontColor = UIColor.black
        desc.fontSize = 19
        desc.zPosition = 1
        desc.alpha = 0
        desc.position = CGPoint(x: frame.midX, y: frame.maxY*0.81)
        addChild(desc)
        fadeInAction = SKAction.fadeIn(withDuration: 2.0)
        desc.run(fadeInAction)
        
        let desc2 = SKLabelNode(text: "My favorite part about iOS development is creating new user experiences.")
        desc2.fontColor = UIColor.black
        desc2.fontSize = 19
        desc2.zPosition = 1
        desc2.alpha = 0
        desc2.position = CGPoint(x: frame.midX, y: frame.maxY*0.75)
        addChild(desc2)
        fadeInAction = SKAction.fadeIn(withDuration: 2.5)
        desc2.run(fadeInAction)
        
        let desc3 = SKLabelNode(text: "Recently i was also a mentor on the first Swift Hackathon in my country. 😁")
        desc3.fontColor = UIColor.black
        desc3.fontSize = 19
        desc3.zPosition = 1
        desc3.alpha = 0
        desc3.position = CGPoint(x: frame.midX, y: frame.maxY*0.69)
        addChild(desc3)
        fadeInAction = SKAction.fadeIn(withDuration: 3.0)
        desc3.run(fadeInAction)
        
        let desc4 = SKLabelNode(text: "And i just started working as an iOS Developer Jr at Urbvan to improve my skills.")
        desc4.fontColor = UIColor.black
        desc4.fontSize = 19
        desc4.zPosition = 1
        desc4.alpha = 0
        desc4.position = CGPoint(x: frame.midX, y: frame.maxY*0.63)
        addChild(desc4)
        fadeInAction = SKAction.fadeIn(withDuration: 3.5)
        desc4.run(fadeInAction)
        
        let desc5 = SKLabelNode(text: "I love Swift and my dream is to be a great iOS Developer!")
        desc5.fontColor = UIColor.black
        desc5.fontSize = 19
        desc5.zPosition = 1
        desc5.alpha = 0
        desc5.position = CGPoint(x: frame.midX, y: frame.maxY*0.57)
        addChild(desc5)
        fadeInAction = SKAction.fadeIn(withDuration: 4.0)
        desc5.run(fadeInAction)
        
        let hackathonImageNode = SKSpriteNode(texture: SKTexture(imageNamed: "hackathonImage.jpg"), size: CGSize(width: 1086/4, height: 724/4))
        hackathonImageNode.zPosition = 1
        hackathonImageNode.alpha = 0
        hackathonImageNode.position = CGPoint(x: frame.midX, y: frame.maxY*0.35)
        addChild(hackathonImageNode)
        fadeInAction = SKAction.fadeIn(withDuration: 4.5)
        hackathonImageNode.run(fadeInAction)
        
        let backButton = AboutButton()
        backButton.texture = SKTexture(imageNamed: "backButton.png")
        backButton.name = "backButton"
        backButton.position = CGPoint(x: self.frame.midX, y: self.frame.maxY*0.1)
        backButton.zPosition = 2
        backButton.alpha = 0
        backButton.delegate = self
        addChild(backButton)
        fadeInAction = SKAction.fadeIn(withDuration: 5.0)
        backButton.run(fadeInAction)
        
        let wait = SKAction.wait(forDuration: 0.3)
        let dropAction = SKAction.run {
            self.dropRandomEmoji()
        }
        let pinAction = SKAction.run {
            for child in self.children {
                child.physicsBody?.isDynamic = false
            }
        }
        let stopAction = SKAction.run {
            if self.children.count > 15 {
                self.removeAllActions()
            }
        }
        run(SKAction.repeatForever(SKAction.sequence([dropAction, wait, pinAction, stopAction])))
        
    }
    
    //------------------------------------
    // MARK: - Private Methods
    //------------------------------------
    
    private func dropRandomEmoji() {
        let randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: emojis.count)
        let emojiLabel = SKLabelNode(text: emojis[randomIndex])
        emojiLabel.fontSize = CGFloat(40)
        let xSpawn = CGFloat.random(in: 0.0...frame.maxX)
        let ySpawn = CGFloat.random(in: 0.0...frame.midY-20)
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

//------------------------------------
// MARK: - Extensions
//------------------------------------

extension AboutScene: AboutButtonDelegate {
    
    func didTapAbout(sender: AboutButton) {
        
        let transition = SKTransition.crossFade(withDuration: 0)
        let scene1 = FirstScene(size: CGSize(width: 640, height: 480))
        scene1.scaleMode = SKSceneScaleMode.aspectFill
        self.scene!.view?.presentScene(scene1, transition: transition)
    }
    
}
