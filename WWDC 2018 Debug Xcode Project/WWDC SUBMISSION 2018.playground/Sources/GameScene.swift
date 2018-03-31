import Foundation
import SpriteKit

public class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //nodes
    private var ship: SKSpriteNode!

    private var life1: SKShapeNode!
    private var life2: SKShapeNode!
    private var life3: SKShapeNode!
    private var scoreLabel : SKLabelNode!
    
    private var stars : SKEmitterNode!
    private var asteroids : SKEmitterNode!
    
    private var booster1 : SKEmitterNode!
    private var booster2 : SKEmitterNode!
    private var booster3 : SKEmitterNode!
    
    private var levelLabel : SKLabelNode!
    private var songLabel : SKLabelNode!
    private var scoreTextLabel : SKLabelNode!
    
    //Scoring
    private var lives = 3
    private var score = 0
    
    private var currentLevel = 1
    
    private var running = false

    //array of all contacts to be handled in the next frame
    var contactQueue = [SKPhysicsContact]()
    
    ////////////////////
    //MARK:Scene Setup//
    ////////////////////
    
    public override func sceneDidLoad() {
        size = CGSize(width: 700, height: 1000)
    }

    public override func didMove(to view: SKView) {
        setupNodes()
        intro()
        
        delay(6){
        //setup & start generating the song
        self.song.setup(level: self.currentLevel)
        self.generateSong()
        }
        
        //start w/ 3 lives
        lives = 3
        
        //setup physics
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
    }
    
    //sets up all initial properties of the nodes
    func setupNodes() {
        //ship node
        ship = scene?.childNode(withName: "ship") as? SKSpriteNode
        ship.position.y = -570
        
        //ship node physics body
        ship.physicsBody = SKPhysicsBody(rectangleOf: ship.frame.size)
        ship.physicsBody!.collisionBitMask = PhysicsCategory.None
        ship.physicsBody!.categoryBitMask = PhysicsCategory.Ship
        ship.physicsBody!.contactTestBitMask = PhysicsCategory.Note
        ship.physicsBody!.affectedByGravity = false
        ship.zPosition = 100
        
        //hearts
        life1 = scene?.childNode(withName: "life1") as? SKShapeNode
        life2 = scene?.childNode(withName: "life2") as? SKShapeNode
        life3 = scene?.childNode(withName: "life3") as? SKShapeNode
        scoreLabel = scene?.childNode(withName: "score") as? SKLabelNode
        scoreTextLabel = scene?.childNode(withName: "scoreTextLabel") as? SKLabelNode
        
        life1.position.y = -550
        life2.position.y = -550
        life3.position.y = -550
        scoreLabel.position.y = -575
        scoreTextLabel.position.y = -575
        
        //stars emitter
        let starsPath = Bundle.main.path(forResource: "stars", ofType: "sks")!
        stars = NSKeyedUnarchiver.unarchiveObject(withFile: starsPath) as! SKEmitterNode
        
        stars.position.y = 500
        stars.targetNode = self
        
        //asteroid emiiter
        let asteroidsPath = Bundle.main.path(forResource: "asteroid", ofType: "sks")!
        asteroids = NSKeyedUnarchiver.unarchiveObject(withFile: asteroidsPath) as! SKEmitterNode
        
        asteroids.position.y = 500
        asteroids.targetNode = self
        
        //level labels
        levelLabel = scene?.childNode(withName: "levelLabel") as? SKLabelNode
        songLabel = scene?.childNode(withName: "songLabel") as? SKLabelNode
        
        levelLabel.position.y = -500
        songLabel.position.y = -540
        
        //ship booster effects
        let boosterPath = Bundle.main.path(forResource: "booster", ofType: "sks")!
        booster1 = NSKeyedUnarchiver.unarchiveObject(withFile: boosterPath) as! SKEmitterNode
        
        booster1.position.x = ship.position.x + 50
        booster1.position.y = ship.position.y
        booster1.particleScale = 0.1
        booster1.targetNode = self
        
        booster2 = NSKeyedUnarchiver.unarchiveObject(withFile: boosterPath) as! SKEmitterNode
        
        booster2.position.x = ship.position.x - 50
        booster2.position.y = ship.position.y
        booster2.particleScale = 0.1
        booster2.targetNode = self
        
        booster3 = NSKeyedUnarchiver.unarchiveObject(withFile: boosterPath) as! SKEmitterNode
        
        booster3.position.x = ship.position.x
        booster3.position.y = ship.position.y
        booster3.particleScale = 0.3
        booster3.targetNode = self
    }
    
    //intro sequence when game starts
    func intro() {
        
        //add the emitters to the view
        scene?.addChild(stars)
        scene?.addChild(asteroids)
        scene?.addChild(booster1)
        scene?.addChild(booster2)
        scene?.addChild(booster3)
        
        //play the level animation
        levelAnimation(level:"1", song:"Mary Had A Little Lamb")
        
        delay(2){
            //ship flys into screen
            let moveShip = SKAction.moveBy(x: 0, y: 230, duration: 2)
            self.ship.run(moveShip)
            self.booster1.run(moveShip)
            self.booster2.run(moveShip)
            self.booster3.run(moveShip)
            
            let moveLives = SKAction.moveBy(x: 0, y: 100, duration: 2)
            self.life1.run(moveLives)
            self.life2.run(moveLives)
            self.life3.run(moveLives)
            self.scoreLabel.run(moveLives)
            self.scoreTextLabel.run(moveLives)
           
            //after these animations complete, start the game
            delay(2){
                self.running = true
            }
        }
    }
    
    func levelAnimation(level: String, song: String) {
        //move the labels back to the bottom
        levelLabel.position.y = -500
        songLabel.position.y = -540
        
        //set the label text
        levelLabel.text = "Level \(level)"
        songLabel.text = song
        
        //move the label
        let move = SKAction.moveBy(x: 0, y: 1060, duration: 4)
        levelLabel.run(move)
        songLabel.run(move)
    }
    
    ///////////////////////
    //MARK:Spawning Nodes//
    ///////////////////////

    func shootBeam() {
        //beam is invisible, but is the node that tracks collisions
        let beam = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 30, height: 30))
        beam.fillColor = .clear
        beam.strokeColor = .clear
        
        //bulletPath is the emitter that makes the bullet look like it does
        let bulletPath = Bundle.main.path(forResource: "bullet", ofType: "sks")!
        let bullet = NSKeyedUnarchiver.unarchiveObject(withFile: bulletPath) as! SKEmitterNode

        //assign physics body properties
        beam.physicsBody = SKPhysicsBody(rectangleOf: beam.frame.size)
        beam.physicsBody!.isDynamic = true
        beam.physicsBody!.affectedByGravity = false
        beam.physicsBody!.categoryBitMask = PhysicsCategory.Bullet
        beam.physicsBody!.collisionBitMask = PhysicsCategory.None
        beam.physicsBody!.contactTestBitMask = PhysicsCategory.Note
        beam.physicsBody!.usesPreciseCollisionDetection = true
        
        //change to CGPoint later; easier to read this way for now
        beam.position.y = ship.position.y + 50
        beam.position.x = ship.position.x
        bullet.position.y = 7.5
        bullet.position.x = 7.5

        if running {
            beam.addChild(bullet)
            scene?.addChild(beam)

            //shoot the bullet
            beam.physicsBody!.applyImpulse(CGVector(dx: 0.0, dy: 70))
        }
    }

    public func prepareNoteForSpawn(note: String, length: Double) {
        let noteWidth = 50.00
        var x: Double = 0

        //always start off assuming we have a note and not a delay, may be proved otherwise in the switch statement
        var isNote = true
        
        //Based on the note we have, spawn it in at the correct x position
        switch note {
            case "C":
                x = noteWidth * -7
            case "D":
                x = noteWidth * -6
            case "E":
                x = noteWidth * -5
            case "F":
                x = noteWidth * -4
            case "G":
                x = noteWidth * -3
            case "A":
                x = noteWidth * -2
            case "B":
                x = noteWidth * -1
            case "C2":
                x = 0
            case "D2":
                x = noteWidth * 1
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
                isNote = false
            default:
                isNote = false
                print("this shouldn't happen")
        }

        //is note checks if the note being created is not a rest
        if(isNote) {
            //convert length (in beats) into height of note (1 beat is 100px in length)
            let noteHeight = length * Double(100)
            
            //add the note to the scene
            addNoteWithOptions(height: CGFloat(noteHeight), xPosition: CGFloat(x), in: self)
       }
    }
    
    //Spawns new note to the scene
    public func addNoteWithOptions(height: CGFloat, xPosition: CGFloat, in scene: SKScene) {
        
        let newNote = SKShapeNode(rect: CGRect(x: 0, y: height/2, width: 43.75, height: height))
        
        newNote.fillColor = .white
        newNote.name = "note"
        
        //center y is set to length so that the end of the collision works properly
        newNote.physicsBody = SKPhysicsBody(rectangleOf: newNote.frame.size)
        
        //set other physics properties
        newNote.physicsBody!.isDynamic = false
        newNote.physicsBody!.affectedByGravity = false
        newNote.physicsBody!.usesPreciseCollisionDetection = true
        
        newNote.physicsBody!.categoryBitMask = PhysicsCategory.Note
        newNote.physicsBody!.collisionBitMask = PhysicsCategory.None
        newNote.physicsBody!.contactTestBitMask = PhysicsCategory.Ship
        
        //change to CGPoint later; easier to read this way for now
        newNote.position.x = CGFloat(xPosition)
        newNote.position.y = 500
        
        scene.addChild(newNote)
        
        //start moving down the screen
        let move = SKAction.moveBy(x: 0, y: -1500, duration: 2)
        newNote.run(move)
        
        
        //to maintain performance, delete note nodes after they leave the screen.
        delay(2) {
            newNote.removeFromParent()
        }
        
    }

    /////////////////////////////
    //MARK:Physics and Contacts//
    /////////////////////////////

    //allows multiple contacts to be handled in one frame, called once per frame update
    func processContacts(forUpdate currentTime: CFTimeInterval) {
        for contact in contactQueue {
            handle(contact)
            
            if let index = contactQueue.index(of: contact) {
                contactQueue.remove(at: index)
            }
        }
    }
    
    //determine what collided and do something
    public func handle(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil {
            return
        }
        
        let nodeBitmasks = [contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask]
        
        //bullet hit a note:
        if nodeBitmasks.contains(PhysicsCategory.Note) && nodeBitmasks.contains(PhysicsCategory.Bullet) {

            if(contact.bodyA.categoryBitMask == PhysicsCategory.Note) {
                if let note = contact.bodyA.node {
                    //access the length of the note we hit to play the correct sound
                    let input = Int(round(note.position.x * 20) / 20)
                    let length = Double((10 * round(note.frame.size.height / 10.0)))
                    Sound(input: input, length: length).playSound(in: self)
                }
            } else {
                if let note = contact.bodyB.node {
                    //access the length of the note we hit to play the correct sound
                    let input = Int(round(note.position.x * 20) / 20)
                    let length = Double((10 * round(note.frame.size.height / 10.0)))
                    Sound(input: input, length: length).playSound(in: self)
                }
            }
            
            //add to the score & update label
            score += 1
            scoreLabel.text = "\(score)"
          
            //remove both nodes
            contact.bodyA.node!.removeFromParent()
            contact.bodyB.node!.removeFromParent()
        }
        
        //a note hit the ship:
        if nodeBitmasks.contains(PhysicsCategory.Ship) && nodeBitmasks.contains(PhysicsCategory.Note) {
            
            //ANIMATE LATER??
            
            //make sure we delete the note and not the ship
            if(contact.bodyA.categoryBitMask == PhysicsCategory.Note) {
               contact.bodyA.node!.removeFromParent()
            } else {
               contact.bodyB.node!.removeFromParent()
            }
            
            //adjust lives
            if (lives > 1) {
                //lost life sound effect
                lives = lives - 1
                if lives == 2 {
                    //animate?
                    //lost life sound effect
                   life3.removeFromParent()
                } else if lives == 1 {
                    //lost life sound effect
                    //animate?
                   life2.removeFromParent()
                }
            } else {
                life1.removeFromParent()
                //death screen
                deathScreen()
                print("      ^ Re-run to try again")
            }
        }
    }
    
    func deathScreen() {
        running = false
        //death sound effect
        
        //death animation
        ship.removeFromParent()
        scoreTextLabel.removeFromParent()
        scoreLabel.removeFromParent()
        
        booster1.removeFromParent()
        booster2.removeFromParent()
        booster3.removeFromParent()
        
        // Removing existing notes
        for child in self.children {
            if child.name == "note" {
                child.removeFromParent()
            }
        }
        
        let deathLabel = SKLabelNode(text: "You Died!")
        deathLabel.fontName = "Helvetica Neue Light"
        deathLabel.fontSize = 65
        deathLabel.fontColor = .white
        deathLabel.position = CGPoint(x: 0, y : 0)
        
        let deathLabel2 = SKLabelNode(text: "Re-run to try again.")
        deathLabel2.fontName = "Helvetica Neue Light"
        deathLabel2.fontSize = 30
        deathLabel2.fontColor = .white
        deathLabel2.position = CGPoint(x: 0, y : -40)
        
        let finalScoreLabel = SKLabelNode(text: "Score: \(score)")
        finalScoreLabel.fontName = "Helvetica Neue Light"
        finalScoreLabel.fontSize = 60
        finalScoreLabel.fontColor = .white
        finalScoreLabel.position = CGPoint(x: 0, y : -250)
        
        scene?.addChild(deathLabel)
        scene?.addChild(deathLabel2)
        scene?.addChild(finalScoreLabel)
    }
    
    //when we detect a collision, add it to our queue to be handled in the next frame.
    public func didBegin(_ contact: SKPhysicsContact) {
        contactQueue.append(contact)
    }

    //////////////////////////////
    //MARK: Mouse Event Handlers//
    //////////////////////////////
 
    override public func mouseMoved(with event: NSEvent) {
        let location = event.location(in:self)
        
        //only move the ship if the game is still running
        if running {
            // move ship to mouse (only x values)
            ship.position.x = location.x
            //move the boosters along with the ship (keeping thier relative posistions)
            booster1.position.x = ship.position.x + 50
            booster1.position.y = ship.position.y
            booster2.position.x = ship.position.x - 50
            booster2.position.y = ship.position.y
            booster3.position.x = ship.position.x
            booster3.position.y = ship.position.y
        }
    }
    
    public override func mouseDown(with event: NSEvent) {
        //shoots on click
        shootBeam()
    }
 
    ////////////////////
    //MARK: Song Stuff//
    ////////////////////

    let song = Song()
    var i = -1
    
    //this function takes the array of notes from the Song class and prepares to spawn them into the scene
    public func generateSong() {
        //only generate the song if the game is not over
        if running {
            i = i + 1
            if i < song.songArray.count {
                if ((song.songArray[i]).0) == "N/A" {
                    //delay the next iteration by delay amount
                    delay(Double((song.songArray[i]).1)) {
                        self.generateSong()
                    }
                }
                else if ((song.songArray[i]).0) == "end" {
                    //play the next level
                    currentLevel += 1
                    
                    if(songTitles.indices.contains(currentLevel - 1)) {
                        levelAnimation(level:"\(currentLevel)", song: songTitles[currentLevel - 1] )
                        //clear songArray and repopulate with new song
                        song.clear()
                        song.setup(level: currentLevel)
                        //reset index
                        i = -1
                        //wait for the levelAnimation complete before generating the new song
                        delay(6) {
                            self.generateSong()
                        }
                    } else {
                        //you won?
                        print("level does not exist")
                    }
                } else {
                    //spawn note
                    prepareNoteForSpawn(note: ((song.songArray[i]).0), length: ((song.songArray[i]).1))
                    //delay the next iteration by length of not playing
                    delay(Double((song.songArray[i]).1)/2) {
                        self.generateSong()
                    }
                }
            }
        }
    }
    
    ///////////////////////
    //MARK: Update Frames//
    ///////////////////////
    
    public override func update(_ currentTime: TimeInterval) {
        processContacts(forUpdate: currentTime)
    }
}
