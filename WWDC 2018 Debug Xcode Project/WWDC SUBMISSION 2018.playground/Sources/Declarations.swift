import Foundation
import SpriteKit

//delays animations, this makes the code musch easier to read
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

//defines a word for each not length so it is easier to read
public var quarter = 0.25
public var half = 0.5