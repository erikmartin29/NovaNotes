import Foundation
import SpriteKit

//handles the playing of sounds
struct Sound {
    private let action : SKAction
    var noteString: String = ""
    
    init(input: Double, length: Double) {
        //find out what note to play.
        //the x value of the note determines the note it should play
        switch input {
        case -350 ..< -300:
            noteString = "C1"
        case -300 ..< -250:
            noteString = "D1"
        case -250 ..< -200:
            noteString = "E1"
        case -200 ..< -150:
            noteString = "F1"
        case -150 ..< -100:
            noteString = "G1"
        case -100 ..< -50:
            noteString = "A1"
        case -50 ..< 0:
            noteString = "B1"
        case 0 ..< 50:
            noteString = "C2"
        case 51..<100:
            noteString = "D2"
        case 100..<150:
            noteString = "E2"
        case 150..<200:
            noteString = "F2"
        case 200..<250:
            noteString = "G2"
        case 250..<300:
            noteString = "A2"
        case 300...350:
            noteString = "B2"
        default:
            print("this shouldn't happen")
        }

        //weird bug makes length change from 30 to 20 sometimes. so just check both
        if(length == 20.0 || length == 30.0) {
            //quarter note
            action = .playSoundFileNamed("\(noteString)_quarter.mp3", waitForCompletion: false)
        } else if(length == 50.0) {
            //half note
            action = .playSoundFileNamed("\(noteString)_quarter.mp3", waitForCompletion: false)
        } else {
            //silence is used just as a placeholder for if the note doesn't meet any of the prior length requirements
            action = .playSoundFileNamed("silence.mp3", waitForCompletion: false)
        }
    }
    
    //play the sound
    func playSound(in scene : SKScene) {
        scene.run(action)
    }
}
