import Foundation
import SpriteKit

///
public class IntroView: SKScene {
    
    public override func sceneDidLoad() {
        size = CGSize(width: 700, height: 1000)
    }
    
    public override func didMove(to view: SKView) {
       
    }
    /*override public func mouseMoved(with event: NSEvent) {
        let location = event.location(in:self)
        // move ship to mouse (only x values)
        ship.position.x = location.x
        //move the boosters along with the ship (keeping thier relative posistions)
        booster1.position.x = ship.position.x + 50
        booster1.position.y = ship.position.y
        booster2.position.x = ship.position.x - 50
        booster2.position.y = ship.position.y
        booster3.position.x = ship.position.x
        booster3.position.y = ship.position.y
    }*/
    
    public override func mouseDown(with event: NSEvent) {
        //shoots on click
        print("click")
        self.backgroundColor = .clear
    }
    
    // called when user touches anywhere on the view and dismisses it via animation.
   
}


