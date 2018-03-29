import Foundation
import SpriteKit

//delays animations
public func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

//bitmask declarations
struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let Bullet    : UInt32 = 0b1       // 1
    static let Ship      : UInt32 = 0b10      // 2
    static let Note      : UInt32 = 0b100     // 3
}

struct NoteLength  {
    static let quarter   : Double = 0.25
    static let half      : Double = 0.25
    //add more later?
}


