//Dump code that may or may not be used in this file
/*
 
 import Foundation
 
 public class Scoring {
 
 //var queuedNote = Song().noteArray[0]
 
 public func checkCorrect(noteString: String) {
 //var noteChecking = noteString
 
 // if(Song().noteArray[0] == queuedNote) {
 //     print("correct note")
 //  } else {
 print("note was wrong")
 
 // var note = song.noteArray.index(of:"\(noteString)")
 // queuedNote = song.noteArray[note!]
 
 //print("next note up is \(queuedNote)")
 //}
 }
 
 }

 
 /*
 public func didBegin(_ contact: SKPhysicsContact) {
 
 contactQueue.append(contact)
 
 var firstBody: SKPhysicsBody
 var secondBody: SKPhysicsBody
 
 if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
 firstBody = contact.bodyA
 secondBody = contact.bodyB
 } else {
 firstBody = contact.bodyB
 secondBody = contact.bodyA
 }
 
 if firstBody.categoryBitMask == 1 && secondBody.categoryBitMask == 2  ||  firstBody.categoryBitMask == 2 && secondBody.categoryBitMask == 1  {
 // print("note hit ship")
 // this is where the player would die
 lives = lives - 1
 
 if (lives == 2) {
 life3.removeFromParent()
 }
 if (lives == 1) {
 life2.removeFromParent()
 }
 if (lives == 0) {
 life1.removeFromParent()
 print("he ded")
 }
 }
 
 if firstBody.categoryBitMask == 2 && secondBody.categoryBitMask == 3  ||  firstBody.categoryBitMask == 3 && secondBody.categoryBitMask == 2 {
 
 
 //print("contact w/ noteandbeam")
 //the height coresponds to the note's length (see the spawnNote funciton)
 if let bodyANode = contact.bodyA.node {
 
 let length = (10 * round(Double(bodyANode.frame.size.height / 10.0)))
 
 //these don't need to be ranges anymore cuz we stopped using random values, fix later
 switch bodyANode.position.x {
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
 contact.bodyA.node!.removeFromParent()
 contact.bodyB.node!.removeFromParent()
 }
 }
 */
 
 
 
 /*
 public func didEnd(_ contact: SKPhysicsContact) {
 
 var firstBody: SKPhysicsBody
 var secondBody: SKPhysicsBody
 
 if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
 firstBody = contact.bodyA
 secondBody = contact.bodyB
 } else {
 firstBody = contact.bodyB
 secondBody = contact.bodyA
 }
 
 if firstBody.categoryBitMask == 2 && secondBody.categoryBitMask == 3 {
 contact.bodyA.node!.removeFromParent()
 contact.bodyB.node!.removeFromParent()
 }
 } */
 
 
 
 
 
 */
