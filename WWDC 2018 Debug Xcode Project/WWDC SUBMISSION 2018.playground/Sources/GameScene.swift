import Foundation
import SpriteKit

public class GameScene: SKScene, SKPhysicsContactDelegate {
    //Nodes
    private var ship: SKSpriteNode!
    private var noteSpawner: SKSpriteNode!
    private var life1: SKSpriteNode!
    private var life2: SKSpriteNode!
    private var life3: SKSpriteNode!

    //Scoring
    private var lives : Int!
 
    //Physics Global Vars
    let BulletCategory: UInt32 = 0x1 << 0
    let ShipCategory: UInt32 = 0x1 << 1
    let NoteCategory: UInt32 = 0x1 << 2
    
    //array of all contacts to be handled in the next frame
    var contactQueue = [SKPhysicsContact]()

    public override func sceneDidLoad() {
        size = CGSize(width: 700, height: 1000)
    }

    public override func didMove(to view: SKView) {
        //setup & start playing the song
        setupSong()
        playSong()

        //start w/ 3 lives
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
        
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
    }

    func shootBeam() {
        let beam = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 15, height: 15))

        beam.fillColor = .red

        beam.physicsBody = SKPhysicsBody(rectangleOf: beam.frame.size)
        beam.physicsBody!.isDynamic = true
        beam.physicsBody!.affectedByGravity = false

        beam.physicsBody!.categoryBitMask = BulletCategory
        beam.physicsBody!.collisionBitMask = 0
        beam.physicsBody!.contactTestBitMask = NoteCategory

        beam.physicsBody!.usesPreciseCollisionDetection = true
        
        //change to CGPoint later; easier to read this wy for now
        beam.position.y = ship.position.y + 50
        beam.position.x = ship.position.x

        self.scene?.addChild(beam)

        beam.physicsBody!.applyImpulse(CGVector(dx: 0.0, dy: 10.0))
    }

    public func spawnNote(note: String, octave: Int, length: Double) {
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
                print("this shouldn't happen")
        }

        //is note checks if the note being created is not a rest
        if(isNote) {
            //convert length (in beats) into both height of note (1 beat is 100px in length)
            noteHeight = length * Double(100)
            
            //add the note to the scene
            addNoteWithOptions(height: CGFloat(noteHeight), xPosition: CGFloat(x), in: self)
       }
    }

    /////////////////////////////
    //MARK:Physics and Contacts//
    /////////////////////////////

    public func setupPhysics() {
        //do I even need this?
    }

    public func handle(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil {
            return
        }
        
        let nodeBitmasks = [contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask]
    
        if nodeBitmasks.contains(NoteCategory) && nodeBitmasks.contains(BulletCategory) {
            //bullet hit note
        
            if let note = contact.bodyA.node {
                let length = (10 * round(Double(note.frame.size.height / 10.0)))
                Sound(input: Double(note.position.x), length: length).playSound(in: self)
            }
            contact.bodyA.node!.removeFromParent()
            contact.bodyB.node!.removeFromParent()
        }
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        contactQueue.append(contact)
    }
    
    ////////////////
    //MARK:Scoring//
    ////////////////
    
    //FIX THIS
    
    var notesPlayed = 0
    var nextNote : String!
    var targetNote : String!
    
    public func checkCorrect(noteToCheck note: String) {
        //not working b/c multiple nodes are hitting the same note
        if(note == (song.noteArray[notesPlayed]).0) {
            //print("correct")
        } else {
            //print("wrong")
        }
         notesPlayed += 1
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
    }
 
    ////////////////////
    //MARK: Song Stuff//
    ////////////////////

    let song = Song()
    var i = -1
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

    public func playSong() {
        //because of the functionailty of my delay function, a for loop would not work properly
        i = i + 1
        if i < (song.songArray.count - 1) {
            if ((song.songArray[i]).0) == "N/A" {
                //delay here
                delay(Double((song.songArray[i]).2)) {
                    self.playSong()
                }
            } else {
                //spawn note
                spawnNote(note: ((song.songArray[i]).0), octave: ((song.songArray[i]).1), length: ((song.songArray[i]).2))
                //delay
                delay(Double((song.songArray[i]).2)) {
                    self.playSong()
                }
            }
        }
    }
    
    ///////////////////////
    //MARK: Update Frames//
    ///////////////////////

    func processContacts(forUpdate currentTime: CFTimeInterval) {
        for contact in contactQueue {
            handle(contact)
            
            if let index = contactQueue.index(of: contact) {
                contactQueue.remove(at: index)
            }
        }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        processContacts(forUpdate: currentTime)
    }
}
