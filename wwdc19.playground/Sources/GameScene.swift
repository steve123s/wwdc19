//
//  GameScene.swift
//  Detective Emoji
//
//  Created by Daniel Salinas on 18.03.19.
//  Copyright © 2019 danielsalinas. All rights reserved.
//

import SpriteKit


public class GameScene: SKScene {
    
    private let possiblePairs: [[String]] = [["🐶","🐱"],
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
                                             ["🐛","🦋"]]
    
    var level: Int = 1
    var timer: Int = 0
    var logic: GameActions?
    
    var titleLabelNode: SKLabelNode?
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
        
        // connect nodes with scene
        self.levelLabelNode = childNode(withName: "level") as? SKLabelNode
        self.timerLabelNode = childNode(withName: "timer") as? SKLabelNode
        self.titleLabelNode = childNode(withName: "title") as? SKLabelNode
        
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
        case 1...5:
            drawGrid(rows: 2, cols: 2)
        case 6...10:
            drawGrid(rows: 3, cols: 2)
        case 11...15:
            drawGrid(rows: 4, cols: 3)
        case 16...20:
            drawGrid(rows: 5, cols: 4)
        case 21...25:
            drawGrid(rows: 5, cols: 5)
        case 26...30:
            drawGrid(rows: 6, cols: 5)
        case 31...35:
            drawGrid(rows: 7, cols: 5)
        default:
            drawGrid(rows: 8, cols: 6)
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
        var timer = 0
        if (level >= 1 && level <=  5) {
            timer = 8
        } else if (level >= 6 && level <=  10) {
            timer = 7
        } else if (level >= 11 && level <=  15) {
            timer = 6
        } else if (level >= 16 && level <=  20) {
            timer = 5
        } else if (level >= 21 && level <=  25) {
            timer = 4
        } else if (level >= 26 && level <=  30) {
            timer = 3
        } else if (level >= 31) {
            timer = 2
        }
        
        let runTimer = timer
        let waitTimer = SKAction.wait(forDuration: 1)
        let actionTimer = SKAction.run {
            self.timerLabelNode?.text = "⏰: \(timer)"
            if timer == 0 {
                self.gameOver(description: "⌚️ You ran out of time! ⌚️")
            }
            timer = timer - 1
        }
        run(SKAction.repeat(SKAction.sequence([actionTimer, waitTimer]) , count: runTimer+1 ))
    }
}

// MARK: - Event Delegation
extension GameScene: GameEvents {
    
    func userDidRightChoice(index: Int) {
        /*let action = SKAction.playSoundFileNamed("rightFig.mp3", waitForCompletion: false)
        self.run(action)*/
    }
    
    func userDidWrongChoice() {
        /*var action = SKAction.playSoundFileNamed("wrongFig.mp3", waitForCompletion: false)
        self.run(action)*/
    }
    
}


extension GameScene {
    
    func gameOver(description: String) {
        removeAllActions()
        isUserInteractionEnabled = false
        titleLabelNode?.isHidden = true
        /*let action = SKAction.playSoundFileNamed("lose.mp3", waitForCompletion: true)
        self.run(action)*/
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
    
    func moveToNextLevel() {
        let action =  SKAction.run {
            let transition = SKTransition.crossFade(withDuration: 0)
            let nextLevelScene = GameScene(fileNamed:"GameScene")
            nextLevelScene!.level = self.level + 1
            nextLevelScene!.scaleMode = SKSceneScaleMode.aspectFill
            self.scene!.view?.presentScene(nextLevelScene!, transition: transition)
        }
        self.run(SKAction.sequence([SKAction.wait(forDuration : 0.35), action ]))
        
        
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
                let rotationAction = SKAction.sequence([.rotate(byAngle: 0.1*CGFloat.pi, duration: 0.15),
                                                        .rotate(byAngle: -0.1*CGFloat.pi, duration: 0.15)])
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
        /*let action = SKAction.playSoundFileNamed("popSound.mp3", waitForCompletion: false)
        self.run(action)*/
        let transition = SKTransition.crossFade(withDuration: 0)
        let scene1 = GameScene(fileNamed:"GameScene")
        scene1!.level = 1
        scene1!.scaleMode = SKSceneScaleMode.aspectFill
        self.scene!.view?.presentScene(scene1!, transition: transition)
    }
    
}

