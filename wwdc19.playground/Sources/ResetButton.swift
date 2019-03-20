//
//  ResetButton.swift
//  Detective Emoji
//
//  Created by Daniel Salinas on 18.03.19.
//  Copyright © 2019 danielsalinas. All rights reserved.
//

import SpriteKit

public class ResetButton: SKSpriteNode {
    
    // MARK: Properties
    
    weak var delegate: ResetButtonDelegate?
    
    // MARK: Lifecycle
    
    init() {
        let texture = SKTexture(imageNamed: "restartButton.png")
        let color = SKColor.red
        let size = CGSize(width:  60 , height: 60)
        super.init(texture: texture, color: color, size: size)
        
        isUserInteractionEnabled = true
        zPosition = 4
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Touch Handling
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        alpha = 0.5
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let alphaAction = SKAction.fadeAlpha(to: 0.5, duration: 0.10)
        alphaAction.timingMode = .easeInEaseOut
        run(alphaAction)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        performButtonAppearanceResetAnimation()
        delegate?.didTapReset(sender: self)
        
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        performButtonAppearanceResetAnimation()
    }
    
    // MARK: Helper Functions
    
    func performButtonAppearanceResetAnimation() {
        let alphaAction = SKAction.fadeAlpha(to: 1.0, duration: 0.10)
        alphaAction.timingMode = .easeInEaseOut
        run(alphaAction)
    }
    
}

// MARK: CGPoint Extension for Hit Testing

extension CGPoint {
    
    func isInside(node: SKSpriteNode) -> Bool {
        if self.x > -node.size.width/2, self.x < node.size.width/2, self.y > -node.size.height/2, self.y < node.size.height/2 { return true }
        return false
    }
}

// MARK: ResetButtonDelegate

protocol ResetButtonDelegate: class {
    func didTapReset(sender: ResetButton)
}

