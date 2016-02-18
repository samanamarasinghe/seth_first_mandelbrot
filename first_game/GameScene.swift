//
//  GameScene.swift
//  first_game
//
//  Created by saman on 2/17/16.
//  Copyright (c) 2016 saman. All rights reserved.
//

import SpriteKit

let scale = SKUniform(name:"scale", float:1.0) // THe scale factor of currently being scaled
let psca = SKUniform(name:"psca", float:1.0) // Previously set scale factor.
let xoff = SKUniform(name:"xoff", float:0) // moved in x direction
let yoff = SKUniform(name:"yoff", float:0) // moved in y direction

var scrollStart : CGPoint = CGPoint(x:0.0, y:0.0) // start point of scrolling
var frame_width : CGFloat = 0.0 // the width of the image
var frame_height : CGFloat = 0.0 // height of the image


class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
       
        frame_width = CGRectGetWidth(self.frame)
        frame_height = CGRectGetHeight(self.frame)

        //setup a space the size of the display
        let box = SKSpriteNode(color: UIColor(red:0.0, green:0.0, blue:0.0, alpha:1), size:CGSize(width: CGRectGetWidth(self.frame), height:CGRectGetHeight(self.frame)))
        let location = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        box.position = location
        
        // add a fragment shader
        let pattern = SKShader(fileNamed: "Frag.fsh")
        // next set the variables that is used in the fragment shader
        pattern.addUniform(xoff)
        pattern.addUniform(yoff)
        pattern.addUniform(psca)
        pattern.addUniform(scale)
        box.shader = pattern
        
        self.addChild(box)
    }
    

    
   // Screen touched to begin panning
   override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       psca.floatValue = psca.floatValue * scale.floatValue
       scale.floatValue = 1.0
        
        for touch in touches {
            let location = touch.locationInNode(self)
            scrollStart.x += location.x
            scrollStart.y += location.y
            print("Start", location)
        }
    }
    
    // in the process of moving the finger to pan
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            xoff.floatValue = Float((location.x - scrollStart.x)/frame_width)
            yoff.floatValue = Float((location.y - scrollStart.y)/frame_height)
            print("Moved", location, xoff.floatValue, yoff.floatValue)
        }
    }
    
    
    // done panning
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            scrollStart.x -= location.x
            scrollStart.y -= location.y
            print("Ended", location)
        }
    }

   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
