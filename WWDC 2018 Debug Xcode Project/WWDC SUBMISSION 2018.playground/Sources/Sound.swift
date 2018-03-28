import Foundation
import SpriteKit

struct Sound {
    private let action : SKAction
    var noteString: String
    
    init(input: Double, length: Double) {
        noteString = ""
 
        switch input {
        case -350 ... -300:
            noteString = "C1"
        case -299 ... -250:
            noteString = "D1"
        case -249 ... -200:
            noteString = "E1"
        case -199 ... -150:
            noteString = "F1"
        case -149 ... -100:
            noteString = "G1"
        case -99 ... -50:
            noteString = "A1"
        case -49 ... 0:
            noteString = "B1"
        case 1...50:
            noteString = "C2"
        case 51...100:
            noteString = "D2"
        case 101...150:
            noteString = "E2"
        case 151...200:
            noteString = "F2"
        case 201...250:
            noteString = "G2"
        case 251...300:
            noteString = "A2"
        case 301...350:
            noteString = "B2"
        default:
            print("this shouldn't happen")
        }

        //weird bug makes length change from 30 to 20 sometimes. so just check both
        if(length == 20 || length == 30) {
            //quarter note
            action = .playSoundFileNamed("\(noteString)_quarter.mp3", waitForCompletion: false)
        } else if(length == 50) {
            //half note
            action = .playSoundFileNamed("\(noteString)_quarter.mp3", waitForCompletion: false)
        } else {
            //silence is used just as a placeholder for if the note doesn't meet any of the prior length requirements, although this shouldn't happen often
            action = .playSoundFileNamed("silence.mp3", waitForCompletion: false)
        }
    }
    
    func playSound(in scene : SKScene) {
        scene.run(action)
    }
}
