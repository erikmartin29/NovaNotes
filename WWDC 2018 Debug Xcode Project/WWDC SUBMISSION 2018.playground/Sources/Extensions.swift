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

