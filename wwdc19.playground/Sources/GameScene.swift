//
//  GameScene.swift
//  Detective Emoji
//
//  Created by Daniel Salinas on 18.03.19.
//  Copyright © 2019 danielsalinas. All rights reserved.
//

import SpriteKit


public class GameScene: SKScene {
    
    private let possiblePairs: [[String]] = [["⏰","⏱"],
                                             ["🐶","🐱"],
                                             ["🐻","🐼"],
                                             ["🐴","🦄"],
                                             ["🦁","🐯"],
                                             ["🐦","🐤"],
                                             ["🐣","🐥"],
                                             ["🙉","🙈"],
                                             ["🐠","🐟"],
                                             ["🐪","🐫"],
                                             ["🦖","🦎"],
                                             ["🐑","🐐"],
                                             ["🐁","🐀"],
                                             ["🦊","🐰"],
                                             ["🐭","🐹"],
                                             ["🐛","🦋"],
                                             ["🐏","🐑"],
                                             ["🦝","🦡"],
                                             ["🐕","🐈"]]
    
    var level: Int = 1
    var timer: Double = 8.0
    var logic: GameActions?
    
    var question: SKSpriteNode?
    var levelLabelNode: SKLabelNode?
    var timerLabelNode: SKLabelNode?
    
    var deckNodes: [SKLabelNode] = []
    
    public override func didMove(to view: SKView) {
        
        // set background image
        let background = SKSpriteNode(imageNamed: "background.png")
        background.name = "gameBackground"
        background.setScale(1.3)
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        question = SKSpriteNode(imageNamed: "question.png")
        question?.zPosition = 1
        question?.position = CGPoint(x: frame.midX, y: 220)
        addChild(question!)
        
        // connect nodes with scene
        self.levelLabelNode = childNode(withName: "level") as? SKLabelNode
        self.timerLabelNode = childNode(withName: "timer") as? SKLabelNode
        
        // configure the labels text
        self.levelLabelNode?.text = "Score : \(level*10 - 10)"
        self.timerLabelNode?.text = "⏰: \(timer)"
        
        setupGrid()
        enumerateChildNodes(withName: "//*") {
            node, stop in
            if node.name == "figure" {
                self.deckNodes.append(node as! SKLabelNode)
            }
        }

        // configure logic
        self.logic = GameplayLogic()
        logic?.setupLogic(delegate: self, emojiPairIndex: Int.random(in: 0..<possiblePairs.count))
        
        // Draw sprites
        setupTimer()
        drawBoard()

    }
    
}

// MARK: - Drawings
extension GameScene {
    
    func drawGrid(rows: Int, cols: Int) {
        for row in 0..<rows {
            for col in 0..<cols {
                let labelNode = SKLabelNode(text: "Emoji")
                labelNode.fontSize = CGFloat(36 + 144/(rows+cols))
                let xOffset = labelNode.frame.maxX*(CGFloat(row))*2
                let yOffset = labelNode.frame.maxY*(CGFloat(col))*2
                labelNode.position = CGPoint(x: frame.midX-labelNode.frame.maxX*(CGFloat(rows)) + xOffset+60,
                                             y: frame.midY-labelNode.frame.maxY*(CGFloat(cols)) + yOffset-100)
                labelNode.name = "figure"
                addChild(labelNode)
            }
        }
        
    }
    
    func setupGrid() {
        switch level {
        case 1...3:
            drawGrid(rows: 2, cols: 2)
        case 4...6:
            drawGrid(rows: 3, cols: 2)
        case 7...9:
            drawGrid(rows: 4, cols: 3)
        case 10...12:
            drawGrid(rows: 5, cols: 4)
        case 13...15:
            drawGrid(rows: 5, cols: 5)
        case 16...18:
            drawGrid(rows: 6, cols: 5)
        case 19...21:
            drawGrid(rows: 7, cols: 5)
        case 19...21:
            drawGrid(rows: 8, cols: 6)
        default:
            drawGrid(rows: 9, cols: 7)
        }
        
    }
    
    func drawBoard() {
        let random = Int.random(in: 0...1)
        for (_, node) in deckNodes.enumerated() {
            
            node.text = possiblePairs[logic?.emojiPairIndex ?? 1][random]
            node.xScale = 1.5
            node.yScale = 1.5
        }
        let wrongNode = deckNodes[Int.random(in: 0...deckNodes.count-1)]
        wrongNode.text = possiblePairs[logic?.emojiPairIndex ?? 0][1-random]
        wrongNode.name = "differentEmoji"
    }
    
    //set timer for each level
    func setupTimer() {
        
        self.timerLabelNode?.horizontalAlignmentMode = .left
        let waitTimer = SKAction.wait(forDuration: 0.01)
        let actionTimer = SKAction.run {
            self.timerLabelNode?.text = "⏰: " + String(format: "%.2f", self.timer)
            if self.timer <= 0.0 {
                self.timerLabelNode?.text = "⏰: " + String(format: "%.2f", "0.00")
                self.gameOver(description: "⌚️ You ran out of time! ⌚️")
            }
            self.timer = self.timer - 0.01
        }
        run(SKAction.repeatForever(SKAction.sequence([actionTimer, waitTimer])))
    }
}

// MARK: - Event Delegation
extension GameScene: GameEvents {
    
    func userDidRightChoice() {
        let action = SKAction.playSoundFileNamed("right.wav", waitForCompletion: false)
        self.run(action)
    }
    
    func userDidWrongChoice() {
        let action = SKAction.playSoundFileNamed("wrong.wav", waitForCompletion: false)
        self.run(action)
    }
    
}


extension GameScene {
    
    func gameOver(description: String) {
        removeAllActions()
        userDidWrongChoice()
        isUserInteractionEnabled = false
        question?.isHidden = true
        let overMsg = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        overMsg.text = description
        overMsg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: overMsg.frame.width * 1.25 , height: overMsg.frame.height * 2.5))
        overMsg.physicsBody?.isDynamic = false
        overMsg.fontSize = 50
        overMsg.fontColor = SKColor.black
        overMsg.position = CGPoint(x: frame.midX, y: frame.midY+150)
        addChild(overMsg)
        overMsg.alpha = 1
        overMsg.zPosition = 4
        var fadeOutAction = SKAction.fadeIn(withDuration: 1) 
        fadeOutAction.timingMode = .easeInEaseOut
        overMsg.run(fadeOutAction, completion: {
            overMsg.alpha = 1
        })
        
        // show correct answer
        let fadeOutEmojiAction = SKAction.group([.fadeOut(withDuration: 0.5),
                                            .scale(by: 0.1, duration: 0.5)])
        enumerateChildNodes(withName: "//*") {
            node, stop in
            if node.name == "figure" {
                node.run(fadeOutEmojiAction)
            } else if node.name == "differentEmoji" {
                if let particles = SKEmitterNode(fileNamed: "bright.sks") {
                    particles.position = node.position
                    self.addChild(particles)
                }
            }
        }
        
        let button = ResetButton()
        button.position = CGPoint(x: frame.midX, y: frame.midY + 100 - (overMsg.frame.height + 10))
        button.delegate = self
        button.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: button.frame.width * 1.25 , height: button.frame.height * 2.5))
        button.physicsBody?.isDynamic = false
        addChild(button)
        button.alpha = 1
        fadeOutAction = SKAction.fadeIn(withDuration: 1.5)
        fadeOutAction.timingMode = .easeInEaseOut
        button.run(fadeOutAction, completion: {
            button.alpha = 1
        })
    }
    
    func showPoints(pointsNumber: Int, position: CGPoint) -> SKLabelNode? {
        var points: SKLabelNode!
        //Show label
        points = SKLabelNode(fontNamed: "Chalkduster")
        points.text = "+" + String(pointsNumber)
        points.horizontalAlignmentMode = .left
        points.fontSize = 60
        points.position = CGPoint(x: position.x + 240.0, y: position.y + 40.0)
        
        //Remove label
        let scaleOut = SKAction.scale(to: 0.01, duration:1.0)
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
        let group = SKAction.group([scaleOut, fadeOut])
        let seq = SKAction.sequence([group, SKAction.removeFromParent()])
        points.run(seq)
        
        return points
    }
    
    func moveToNextLevel() {
        var extraTime = 1
        for node in children {
                if let emoji = node as? SKLabelNode {
                    if (emoji.text?.contains("⏱"))! {
                        extraTime = 3
                        continue
                }
            }
        }
        addChild(showPoints(pointsNumber: extraTime, position: timerLabelNode?.position ?? CGPoint.zero)!)
        let action =  SKAction.run {
            let transition = SKTransition.crossFade(withDuration: 0)
            let nextLevelScene = GameScene(fileNamed:"GameScene")
            nextLevelScene!.level = self.level + 1
            nextLevelScene!.timer = self.timer + Double(extraTime) + 0.2
            nextLevelScene!.scaleMode = SKSceneScaleMode.aspectFill
            self.scene!.view?.presentScene(nextLevelScene!, transition: transition)
        }
        self.run(SKAction.sequence([SKAction.wait(forDuration : 0.2), action]))
        
        
    }
}

// MARK: - Touches
extension GameScene {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let node = self.atPoint(position)
            
            if node.name == "figure" {
                self.logic?.userHasChosen(false)
                
            } else if node.name == "differentEmoji" {
                userDidRightChoice()
                let rotationAction = SKAction.sequence([.rotate(byAngle: 0.1*CGFloat.pi, duration: 0.1),
                                                        .rotate(byAngle: -0.1*CGFloat.pi, duration: 0.1)])
                let correctAction = SKAction.group([rotationAction,
                                                   .scale(by: 1.2, duration: 0.2),
                                                   .run {
                                                    if let particles = SKEmitterNode(fileNamed: "bright.sks") {
                                                        particles.position = node.position
                                                        self.addChild(particles)
                                                    }
                    }])
                node.run(correctAction)
                self.logic?.userHasChosen(true)
            }
            
        }
    }
    
}


extension GameScene: ResetButtonDelegate {
    
    func didTapReset(sender: ResetButton) {
        let action = SKAction.playSoundFileNamed("button.wav", waitForCompletion: false)
        self.run(action)
        let transition = SKTransition.crossFade(withDuration: 0)
        let scene1 = GameScene(fileNamed:"GameScene")
        scene1!.level = 1
        scene1!.scaleMode = SKSceneScaleMode.aspectFill
        self.scene!.view?.presentScene(scene1!, transition: transition)
    }
    
}

