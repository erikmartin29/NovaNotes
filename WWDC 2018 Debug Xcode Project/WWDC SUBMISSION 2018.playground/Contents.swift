import PlaygroundSupport
import SpriteKit
import Cocoa
/*:
# *Game Name*
  You are on a mission to save the galaxy, but there's only one problem...
 **your ship got off course and you're headed full speed for disaster!**
 
 ## How to Play
 There will be enemies coming towards you. Shoot them to hear a note. If done correctly, you'll hear a catchy tune. But be careful! If you let one pass by or get hit by one, you'll lose a life.
 
 The goal of the game is to survive all 4 levels. Complete them all to win!
 
 Move your mouse left/right to drive the ship, and click to shoot.
 
 **Have Fun!** 👍
 */
let scene = GameScene(fileNamed: "GameScene")

let frame = CGRect(x: 0, y: 0, width: 700, height: 1000)
let view = SKView(frame: frame)

//add tracker to detect mouse location
let tracker = NSTrackingArea(rect: frame, options: options, owner: view, userInfo: nil)
view.addTrackingArea(tracker)

PlaygroundPage.current.needsIndefiniteExecution = true
view.presentScene(scene)

PlaygroundPage.current.liveView = view
