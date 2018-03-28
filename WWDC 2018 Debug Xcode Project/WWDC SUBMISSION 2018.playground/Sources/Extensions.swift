import Foundation
import SpriteKit

//HOW TO ADD SONG ARRAY VALUES (this is an example and should be deleted later)
//song.addNote(note: "A", octave: 1, length: 100)
//song.addDelay(length: 1)
//etc...

//Delays animations
public func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

//Spawns new note to the scene
public func addNoteWithOptions(height: CGFloat, xPosition: CGFloat, in scene: SKScene) {
    
    let newNote = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 43.75, height: height))
    
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
    let move = SKAction.moveBy(x: 0, y: -1500, duration: 15/5)
    newNote.run(move)
    
    //to maintain performance, delete note nodes after they leave the screen.
    DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
        newNote.removeFromParent()
    }
}

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let Bullet    : UInt32 = 0b1       // 1
    static let Ship      : UInt32 = 0b10      // 2
    static let Note      : UInt32 = 0b100     // 3
}


