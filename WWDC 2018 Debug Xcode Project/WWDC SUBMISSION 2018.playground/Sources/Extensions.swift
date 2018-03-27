import Foundation
import SpriteKit

//HOW TO ADD SONG ARRAY VALUES (this is an example and should be deleted later)
//song.addNote(note: "A", octave: 1, length: 100)
//song.addDelay(length: 1)
//etc...

//Delays Animations
public func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

public func addNoteWithOptions(height: CGFloat, xPosition: CGFloat, in scene: SKScene) {
    
    var newNote = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 43.75, height: height))
    
    newNote.fillColor = .white
    //center y is set to length so that the end of the collision works properly
    newNote.physicsBody = SKPhysicsBody(rectangleOf: newNote.frame.size)
    
    newNote.physicsBody!.isDynamic = false
    newNote.physicsBody!.affectedByGravity = false
    newNote.physicsBody!.usesPreciseCollisionDetection = true
    
    newNote.physicsBody!.categoryBitMask = 0x1 << 2
    newNote.physicsBody!.collisionBitMask = 0
    newNote.physicsBody!.contactTestBitMask = 0x0
    
    //change to CGPoint later; easier to read this way for now
    newNote.position.x = CGFloat(xPosition)
    newNote.position.y = 500
    
    scene.addChild(newNote)
    
    //start moving down the screen
    let move = SKAction.moveBy(x: 0, y: -1500, duration: 15)
    newNote.run(move)
    
    //to maintain performance, delete note nodes after they leave the screen.
    DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
        newNote.removeFromParent()
    }
}

/*
public extension SKScene {
    /*
    public func addShapeNodeWithPhysicsBody(ofRect rect: CGRect, gravityEnabled: Bool, collisionBitMask: UInt32, categoryBitMask: UInt32, contactTestBitMask: UInt32, dynamic: Bool) {
        
        var node = SKShapeNode(rect: rect)
        
        node.fillColor = .white
        
        node.physicsBody = SKPhysicsBody(rectangleOf: node.frame.size)
        node.physicsBody!.isDynamic = dynamic
        node.physicsBody!.affectedByGravity = gravityEnabled
        
        node.physicsBody!.categoryBitMask = categoryBitMask
        node.physicsBody!.collisionBitMask = collisionBitMask
        node.physicsBody!.contactTestBitMask = contactTestBitMask
        
        self.addChild(node)
    } */
    
    public func addNoteWithOptions(height: CGFloat, xPosition: CGFloat, in scene: SKScene) {
        
        var newNote = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 43.75, height: height))
        
        newNote.fillColor = .white
        //center y is set to length so that the end of the collision works properly
        newNote.physicsBody = SKPhysicsBody(rectangleOf: newNote.frame.size)
        
        newNote.physicsBody!.isDynamic = false
        newNote.physicsBody!.affectedByGravity = false
        newNote.physicsBody!.usesPreciseCollisionDetection = true
        
        newNote.physicsBody!.categoryBitMask = NoteCategory
        newNote.physicsBody!.collisionBitMask = 0
        newNote.physicsBody!.contactTestBitMask = 0x0
        
        self.scene.addChild(newNote)
        
        //start moving down the screen
        let move = SKAction.moveBy(x: 0, y: -1500, duration: 15)
        newNote.run(move)
        
        //to maintain performance, delete note nodes after they leave the screen.
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            newNote.removeFromParent()
        }
    }
} */

