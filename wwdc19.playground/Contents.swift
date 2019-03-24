//: A SpriteKit based Playground
/*
 This playground is based on the idea that anyone can do
 a great app while maintaining simplicity.
 Here i take advantage of the iOS emojis to make a game of
 randomness and quick reflexes.
 I use to dedicte my free time to give swift basic courses
 to people in my contry and this is a way for me to inspire new developers.
 
 Insructions:
 Touch the different emoji to gain ponts. Don't let the timer reach cero :-)
 Difficulty gets higher as you find emojis.
 Good luck! :D
 */

import PlaygroundSupport
import SpriteKit
import Foundation

// Set scene
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
sceneView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
let scene = FirstScene(size: CGSize(width: 640, height: 480))
scene.scaleMode = .aspectFill

// Present the scene
sceneView.presentScene(scene)
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView


