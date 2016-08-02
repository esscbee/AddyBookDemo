//
//  GameScene.swift
//  AddyBookDemo
//
//  Created by Stephen Brennan on 8/1/16.
//  Copyright (c) 2016 Stephen Brennan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var addy : AddressBook?
    var names = ["Not Authorized or No Conacts"]
    
    
    func setAddy(addy : AddressBook) {
        self.addy = addy
    }
    override func didMoveToView(view: SKView) {
        
        if let addy = self.addy {
            if let n = addy.getFullNames() {
                self.names = n
            }
        }
        
        let dy : CGFloat = 20
        let hello = SKLabelNode(text: "Tap to add names")
        hello.position = CGPointMake(frame.midX, frame.midY + dy)
        addChild(hello)
        let hello2 = SKLabelNode(text: "Shake to clear")
        hello2.position = CGPointMake(frame.midX, frame.midY - dy)
        addChild(hello2)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            var nodesRemoved = 0
            for n in nodesAtPoint(location) {
                if n == self {
                    continue
                }
                n.removeFromParent()
                nodesRemoved += 1
            }
            
            if nodesRemoved == 0 {
                let idx = random() % names.count
                let name = names[idx]
                let label = SKLabelNode(text: name)
                label.position = location
                label.horizontalAlignmentMode = location.x > frame.midX ? .Right : .Left
                label.verticalAlignmentMode = location.y > frame.midY ? .Top : .Bottom
                addChild(label)
            }
            
            
        }
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
