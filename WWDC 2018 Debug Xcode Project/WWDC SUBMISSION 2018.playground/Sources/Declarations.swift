import Foundation
import SpriteKit

//options for the mouse tracker
public let options = [NSTrackingArea.Options.mouseMoved, NSTrackingArea.Options.activeInKeyWindow, NSTrackingArea.Options.activeAlways, NSTrackingArea.Options.inVisibleRect,] as NSTrackingArea.Options

//delays animations, this makes the code musch easier to read
public func delay(_ delay: Double, closure: @escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

//array of all the song titles
var songTitles = ["Mary Had a Little Lamb", "London Bridge", "I'm A Little Teapot", "Itsy-Bitsy Spider"]

//bitmask declarations
struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let Bullet    : UInt32 = 0b1       // 1
    static let Ship      : UInt32 = 0b10      // 2
    static let Note      : UInt32 = 0b100     // 3
    static let Bottom    : UInt32 = 0b1000    // 4
}

//defines a word for each not length so it is easier to read
public var quarter = 0.25
public var half = 0.5
