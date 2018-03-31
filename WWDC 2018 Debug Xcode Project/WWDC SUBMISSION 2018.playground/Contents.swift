import PlaygroundSupport
import SpriteKit
import Cocoa

let scene = GameScene(fileNamed: "GameScene")

let frame = CGRect(x: 0, y: 0, width: 700, height: 1000)
let view = SKView(frame: frame)

//add tracker to detect mouse location
let options = [NSTrackingArea.Options.mouseMoved, NSTrackingArea.Options.activeInKeyWindow, NSTrackingArea.Options.activeAlways, NSTrackingArea.Options.inVisibleRect,] as NSTrackingArea.Options
let tracker = NSTrackingArea(rect: frame, options: options, owner: view, userInfo: nil)
view.addTrackingArea(tracker)

PlaygroundPage.current.needsIndefiniteExecution = true
view.presentScene(scene)
  
PlaygroundPage.current.liveView = view 
