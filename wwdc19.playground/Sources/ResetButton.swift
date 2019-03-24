//
//  ResetButton.swift
//  Detective Emoji
//
//  Created by Daniel Salinas on 18.03.19.
//  Copyright © 2019 danielsalinas. All rights reserved.
//

import SpriteKit

//------------------------------------
// MARK: - Protocol
//------------------------------------

protocol ResetButtonDelegate: class {
    func didTapReset(sender: ResetButton)
}

public class ResetButton: SKSpriteNode {
    
    //------------------------------------
    // MARK: - Properties
    //------------------------------------
    
    weak var delegate: ResetButtonDelegate?
    
    //------------------------------------
    // MARK: - Initializers
    //------------------------------------
    
    init() {
        let texture = SKTexture(imageNamed: "restartButton.png")
        let color = SKColor.red
        let size = CGSize(width:  264 , height: 80)
        super.init(texture: texture, color: color, size: size)
        
        isUserInteractionEnabled = true
        zPosition = 4
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //------------------------------------
    // MARK: - Touches
    //------------------------------------
    
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
    
    //------------------------------------
    // MARK: - Private Methods
    //------------------------------------
    
    private func performButtonAppearanceResetAnimation() {
        let alphaAction = SKAction.fadeAlpha(to: 1.0, duration: 0.10)
        alphaAction.timingMode = .easeInEaseOut
        run(alphaAction)
    }
    
}
