import Foundation
import SpriteKit

struct Sound {
    private let action : SKAction
    init(input: Double, length: Double) {
        var noteString: String = "test"
        
        print(input)
        print(length)
        
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
        
        if(length == 20 || length == 30) {
            //quarter note
            action = .playSoundFileNamed("\(noteString)_quarter.mp3", waitForCompletion: false)
            print("playing")
        } else if(length == 50) {
            //half note
            action = .playSoundFileNamed("\(noteString)_quarter.mp3", waitForCompletion: false)
            print("playing")
        } else {
            noteString = "C2_half.mp3"
            action = .playSoundFileNamed(noteString, waitForCompletion: false)
            //print("this is not a quarter or half note...")
        }
    }
    
    func playSound(in scene : SKScene) {
        scene.run(action)
    }
   
    /*func findAndPlayNote(input: Double, length: Double, in scene : SKScene) {
        
        var noteString: String
        
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
        
        if(length == 30) {
            //quarter note
            noteString = "\(noteString)_quarter.mp3"
            action = .playSoundFileNamed(noteString, waitForCompletion: false)
            print("playing")
        } else if(length == 50) {
            //half note
            noteString = "\(noteString)_half.mp3"
            action = .playSoundFileNamed(noteString, waitForCompletion: false)
            print("playing")
        } else {
            noteString = "C2_half.mp3"
            action = .playSoundFileNamed(noteString, waitForCompletion: false)
            //print("this is not a quarter or half note...")
        }
        //scene.run(action)
    }
 */

    /*
    public func checkNote(length: Double, noteToPlay: String) {
        if(length == 30) {
            //quarter note
            playSound(sound: "\(noteToPlay)_quarter.mp3")
            print("playing")
        } else if(length == 50) {
            //half note
            playSound(sound: "\(noteToPlay)_half.mp3")
            print("playing")
        } else {
            //print("this is not a quarter or half note...")
        }
        //checkCorrect(noteToCheck: noteToPlay)
    }*/
    
}

/*

public class Sound: SKSpriteNode {
    
    // Variable that is overridden by subclass to set the name of the sound file.
    var soundFileName: String {
        fatalError("Must be overridden by subclasses.")
    }
    
    
    /// Plays a sound and runs a sequence to change node's image when in a collision.
    public func playSoundForX(value: Double, length: Double) {
        // Retreive first part of sound file from soundFileName and finish the second part with SoundModifier enum.

        print("func called")
        
        switch value {
        case -350 ... -300:
            checkNote(length: length, noteToPlay: "C1")
        case -299 ... -250:
            checkNote(length: length, noteToPlay: "D1")
        case -249 ... -200:
            checkNote(length: length, noteToPlay: "E1")
        case -199 ... -150:
            checkNote(length: length, noteToPlay: "F1")
        case -149 ... -100:
            checkNote(length: length, noteToPlay: "G1")
        case -99 ... -50:
            checkNote(length: length, noteToPlay: "A1")
        case -49 ... 0:
            checkNote(length: length, noteToPlay: "B1")
        case 1...50:
            checkNote(length: length, noteToPlay: "C2")
        case 51...100:
            checkNote(length: length, noteToPlay: "D2")
        case 101...150:
            checkNote(length: length, noteToPlay: "E2")
        case 151...200:
            checkNote(length: length, noteToPlay: "F2")
        case 201...250:
            checkNote(length: length, noteToPlay: "G2")
        case 251...300:
            checkNote(length: length, noteToPlay: "A2")
        case 301...350:
            checkNote(length: length, noteToPlay: "B2")
        default:
            print("this shouldn't happen")
        }
    }
    
    public func checkNote(length: Double, noteToPlay: String) {
        if(length == 30) {
            //quarter note
            playSound(sound: "\(noteToPlay)_quarter.mp3")
            print("playing")
        } else if(length == 50) {
            //half note
            playSound(sound: "\(noteToPlay)_half.mp3")
            print("playing")
        } else {
            //print("this is not a quarter or half note...")
        }
        //checkCorrect(noteToCheck: noteToPlay)
    }
    
    public func playSound(sound: String) {
        run(SKAction.playSoundFileNamed(sound, waitForCompletion: false))
        print("should have played")
    }
    
}
 
 */

