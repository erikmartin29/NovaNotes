import Foundation
import SpriteKit

public class GameScene: SKScene, SKPhysicsContactDelegate {
    //nodes:
    private var ship: SKSpriteNode!
    private var noteSpawner: SKSpriteNode!
    
    private var life1: SKSpriteNode!
    private var life2: SKSpriteNode!
    private var life3: SKSpriteNode!

    private var lives : Int!
    
    private var currentSound: String!

    public override func sceneDidLoad() {
        size = CGSize(width: 700, height: 1000)
    }

    public override func didMove(to view: SKView) {
        //setup & start playing the song
        setupSong()
        playSong()

        lives = 3
        
        //setup nodes
        ship = self.scene?.childNode(withName: "ship") as? SKSpriteNode
        noteSpawner = self.scene?.childNode(withName: "noteSpawner") as? SKSpriteNode

        life1 = self.scene?.childNode(withName: "life1") as? SKSpriteNode
        life2 = self.scene?.childNode(withName: "life2") as? SKSpriteNode
        life3 = self.scene?.childNode(withName: "life3") as? SKSpriteNode
        
        ship.physicsBody = SKPhysicsBody(rectangleOf: ship.frame.size)
        ship.physicsBody!.collisionBitMask = 0
        ship.physicsBody!.affectedByGravity = false
        
        let starsPath = Bundle.main.path(forResource: "stars", ofType: "sks")!
        let stars = NSKeyedUnarchiver.unarchiveObject(withFile: starsPath) as! SKEmitterNode

        stars.position.y = 500
        stars.targetNode = self
        
        self.scene?.addChild(stars)
        
        let asteroidsPath = Bundle.main.path(forResource: "asteroid", ofType: "sks")!
        let asteroids = NSKeyedUnarchiver.unarchiveObject(withFile: asteroidsPath) as! SKEmitterNode
        
        asteroids.position.y = 500
        asteroids.targetNode = self
        
        self.scene?.addChild(asteroids)
        
        physicsWorld.contactDelegate = self
    }

    func shootBeam() {
        let beam = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 2, height: 2))

        beam.fillColor = .red

        beam.physicsBody = SKPhysicsBody(rectangleOf: beam.frame.size)
        beam.physicsBody!.isDynamic = true
        beam.physicsBody!.affectedByGravity = false

        beam.physicsBody!.categoryBitMask = 3
        beam.physicsBody!.collisionBitMask = 0
        beam.physicsBody!.contactTestBitMask = 2

        //change to CGPoint later; easier to read this wy for now
        beam.position.y = ship.position.y + 50
        beam.position.x = ship.position.x

        self.scene?.addChild(beam)

        let beamShoot = SKAction.moveBy(x: 0.0, y: 1000, duration: 2.0)
        beam.run(beamShoot)

        //to maintain performance, delete beam nodes after they leave the screen.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            beam.removeFromParent()
        }
    }

    public func spawnNote(note: String, octave: Int, length: Double) {

        let noteWidth = 43.75
        var noteHeight : Double

        var x: Double = 0

        //always start off assuming we have a note and not a delay
        var isNote = true
        
        switch note {
            case "C":
                x = noteWidth * -8
            case "D":
                x = noteWidth * -7
            case "E":
                x = noteWidth * -6
            case "F":
                x = noteWidth * -5
            case "G":
                x = noteWidth * -4
            case "A":
                x = noteWidth * -3
            case "B":
                x = noteWidth * -2
            case "C2":
                x = noteWidth * -1
            case "D2":
                x = noteWidth
            case "E2":
                x = noteWidth * 2
            case "F2":
                x = noteWidth * 3
            case "G2":
                x = noteWidth * 4
            case "A2":
                x = noteWidth * 5
            case "B2":
                x = noteWidth * 6
            case "N/A":
                x = 0
            default:
                isNote = false
                print("this shouldn't happen, but it could just be a delay")
        }

        //is note checks if the note being created is not a rest
        if(isNote) {
            //convert length (in beats) into both height of note (1 beat is 100px in length)
            noteHeight = length * Double(100)
            
            //change length
            let newNote = SKShapeNode(rect: CGRect(x: 0, y: 0, width: Double(noteWidth), height: noteHeight))

            newNote.fillColor = .white

            //center y is set to length so that the end of the collision works properly
            newNote.physicsBody = SKPhysicsBody(rectangleOf: newNote.frame.size, center: CGPoint(x: 0, y: noteHeight))

            newNote.physicsBody!.isDynamic = false
            newNote.physicsBody!.affectedByGravity = false

            newNote.physicsBody!.categoryBitMask = 2
            newNote.physicsBody!.collisionBitMask = 0
            newNote.physicsBody!.contactTestBitMask = 3

            //change to CGPoint later; easier to read this way for now
            newNote.position.x = CGFloat(x)
            newNote.position.y = 500

            self.scene?.addChild(newNote)

            //start moving down the screen
            let move = SKAction.moveBy(x: 0, y: -1500, duration: 15)
            newNote.run(move)

            //to maintain performance, delete note nodes after they leave the screen.
            DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                newNote.removeFromParent()
            }
       }
    }

    /////////////////////////////
    //MARK:Physics and Contacts//
    /////////////////////////////

    public func setupPhysics() {
        //do I even need this?
    }

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
    }

    public func didBegin(_ contact: SKPhysicsContact) {

        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if firstBody.categoryBitMask == 1 && secondBody.categoryBitMask == 2 {
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

        if firstBody.categoryBitMask == 2 && secondBody.categoryBitMask == 3 {
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
                
                contact.bodyA.node!.removeFromParent()
                contact.bodyB.node!.removeFromParent()
            }
        }
    }
    
    public func checkNote(length: Double, noteToPlay: String) {
        if(length == 30) {
            //quarter note
            playSound(sound: "\(noteToPlay)_quarter.mp3")
        } else if(length == 50) {
            //half note
            playSound(sound: "\(noteToPlay)_half.mp3")
        } else {
            //print("this is not a quarter or half note...")
        }
        
        checkCorrect(noteToCheck: noteToPlay)
    }
    
    ////////////////
    //MARK:Scoring//
    ////////////////
    
    var notesPlayed = 0
    var nextNote : String!
    var targetNote : String!
    
    public func checkCorrect(noteToCheck note: String) {
        //not working b/c multiple nodes are hitting the same note
        if(note == (song.noteArray[notesPlayed]).0) {
            print("correct")
        } else {
            print("wrong")
        }
         notesPlayed += 1
    }
    
    //////////////
    //MARK:Sound//
    //////////////

    func playSound(sound: String) {
         run(SKAction.playSoundFileNamed(sound, waitForCompletion: false))
    }
    
    //////////////////////////////
    //MARK: Mouse Event Handlers//
    //////////////////////////////
 
    override public func mouseMoved(with event: NSEvent) {
        let location = event.location(in:self)
        // move ship to mouse (only x values)
        ship.position.x = location.x
    }
    
    public override func mouseDown(with event: NSEvent) {
        shootBeam()
        print("clicked")
    }
 
    ////////////////////
    //MARK: Song Stuff//
    ////////////////////

    let song = Song()
    //var songBPM = 120

    public func setupSong() {
        //change later, add some basic song presets to choose from.
        //get rid of this for loop later. right not it's just a test
        
        // .quarter = .25, half = .5, and so on; fix later
        for _ in 0...5 {
        song.addNote(note: "A", octave: 1, length: 0.25)
        song.addDelay(length: 1)
        song.addNote(note: "C", octave: 1, length: 0.5)
        song.addDelay(length: 1)
        song.addNote(note: "D", octave: 1, length: 0.25)
        song.addDelay(length: 1)
        song.addNote(note: "E", octave: 1, length: 0.25)
        song.addDelay(length: 1)
        song.addNote(note: "F", octave: 1, length: 0.25)
        song.addDelay(length: 1)
        song.addNote(note: "A2", octave: 1, length: 0.25)
        song.addDelay(length: 1)
        song.addNote(note: "C2", octave: 1, length: 0.5)
        song.addDelay(length: 1)
        song.addNote(note: "D2", octave: 1, length: 0.25)
        song.addDelay(length: 1)
        song.addNote(note: "E2", octave: 1, length: 0.25)
        song.addDelay(length: 1)
        song.addNote(note: "F2", octave: 1, length: 0.25)
        song.addDelay(length: 1)
        }
    }
    
    var i = -1
    
    public func playSong() {
        //because of the functionailty of my delay function, a for loop would not work properly
        i = i + 1
        if i < (song.songArray.count - 1) {
            if ((song.songArray[i]).0) == "N/A" {
                //delay here
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int((song.songArray[i]).2))) {
                    self.playSong()
                }
            } else {
                //spawn note
                spawnNote(note: ((song.songArray[i]).0), octave: ((song.songArray[i]).1), length: ((song.songArray[i]).2))
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int((song.songArray[i]).2))) {
                    self.playSong()
                }
            }
        }
    }
    
    ///////////////////////
    //MARK: Update Frames//
    ///////////////////////

    public override func update(_ currentTime: TimeInterval) {
   
    }
}
