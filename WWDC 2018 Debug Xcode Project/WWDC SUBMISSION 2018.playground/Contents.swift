import PlaygroundSupport
import SpriteKit
//import UIKit
import Cocoa

let scene = GameScene(fileNamed: "GameScene")

let frame = CGRect(x:0, y:0, width:1920, height:1080)
let view = SKView(frame:frame)

//scene.backgroundColor = .white
//scene.scaleMode = .aspectFit

let options = [NSTrackingArea.Options.mouseMoved, NSTrackingArea.Options.activeInKeyWindow, NSTrackingArea.Options.activeAlways, NSTrackingArea.Options.inVisibleRect, ] as NSTrackingArea.Options
let tracker = NSTrackingArea(rect:frame, options: options, owner:view, userInfo: nil)
view.addTrackingArea(tracker)

PlaygroundPage.current.needsIndefiniteExecution = true
view.presentScene(scene)

PlaygroundPage.current.liveView = view
