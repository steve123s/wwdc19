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
        
        let greeting = SKLabelNode(text: "Hello! :)")
        greeting.color = UIColor.black
        greeting.fontColor = UIColor.black
        greeting.fontSize = 25
        greeting.zPosition = 1
        greeting.position = CGPoint(x: frame.midX, y: frame.maxY*0.93)
        addChild(greeting)
        
        let name = SKLabelNode(text: "My name is Daniel Salinas, i live in Mexico. 🇲🇽")
        name.fontColor = UIColor.black
        name.fontSize = 19
        name.zPosition = 1
        name.position = CGPoint(x: frame.midX, y: frame.maxY*0.87)
        addChild(name)
        
        let desc = SKLabelNode(text: "I form part of the iOS Development Lab. FI, UNAM since it's beginning.")
        desc.fontColor = UIColor.black
        desc.fontSize = 19
        desc.zPosition = 1
        desc.position = CGPoint(x: frame.midX, y: frame.maxY*0.81)
        addChild(desc)
        
        let desc2 = SKLabelNode(text: "My favorite part about iOS development is creating new user experiences.")
        desc2.fontColor = UIColor.black
        desc2.fontSize = 19
        desc2.zPosition = 1
        desc2.position = CGPoint(x: frame.midX, y: frame.maxY*0.75)
        addChild(desc2)
        
        let desc3 = SKLabelNode(text: "This month a was also a mentor on the first iOS Lab. Hackathon in my country 😁")
        desc3.fontColor = UIColor.black
        desc3.fontSize = 19
        desc3.zPosition = 1
        desc3.position = CGPoint(x: frame.midX, y: frame.maxY*0.69)
        addChild(desc3)
        
        let desc4 = SKLabelNode(text: "And i just started working as an iOS Developer Jr at Urbvan to improve my skills.")
        desc4.fontColor = UIColor.black
        desc4.fontSize = 19
        desc4.zPosition = 1
        desc4.position = CGPoint(x: frame.midX, y: frame.maxY*0.63)
        addChild(desc4)
        
        let desc5 = SKLabelNode(text: "I love Swift and my dream is to be a great iOS Developer!")
        desc5.fontColor = UIColor.black
        desc5.fontSize = 19
        desc5.zPosition = 1
        desc5.position = CGPoint(x: frame.midX, y: frame.maxY*0.57)
        addChild(desc5)
        
        let hackathonImageNode = SKSpriteNode(texture: SKTexture(imageNamed: "hackathonImage.jpg"), size: CGSize(width: 1086/4, height: 724/4))
        hackathonImageNode.zPosition = 1
        hackathonImageNode.position = CGPoint(x: frame.midX, y: frame.maxY*0.35)
        addChild(hackathonImageNode)
        
        let backButton = AboutButton()
        backButton.texture = SKTexture(imageNamed: "backButton.png")
        backButton.name = "backButton"
        backButton.position = CGPoint(x: self.frame.midX, y: self.frame.maxY*0.1)
        backButton.zPosition = 2
        backButton.delegate = self
        addChild(backButton)
        
    }
    
}

// MARK: - Drawings
extension AboutScene {
    
    
}


extension AboutScene: AboutButtonDelegate {
    
    func didTapAbout(sender: AboutButton) {
        
        let transition = SKTransition.crossFade(withDuration: 0)
        let scene1 = FirstScene(size: CGSize(width: 640, height: 480))
        scene1.scaleMode = SKSceneScaleMode.aspectFill
        self.scene!.view?.presentScene(scene1, transition: transition)
    }
    
}
