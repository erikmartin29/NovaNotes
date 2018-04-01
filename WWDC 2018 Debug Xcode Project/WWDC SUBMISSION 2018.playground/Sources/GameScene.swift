import Foundation
import SpriteKit

public class GameScene: SKScene, SKPhysicsContactDelegate {

    //nodes:
    private var ship: SKSpriteNode!

    private var life1: SKShapeNode!
    private var life2: SKShapeNode!
    private var life3: SKShapeNode!
    private var life4: SKShapeNode!
    private var life5: SKShapeNode!
    private var scoreLabel: SKLabelNode!

    private var stars: SKEmitterNode!
    private var asteroids: SKEmitterNode!

    private var booster1: SKEmitterNode!
    private var booster2: SKEmitterNode!
    private var booster3: SKEmitterNode!

    private var levelLabel: SKLabelNode!
    private var songLabel: SKLabelNode!
    private var scoreTextLabel: SKLabelNode!

    private let deathLabel = SKLabelNode(text: "You Died!")
    private let deathLabel2 = SKLabelNode(text: "Click anywhere to try again.")
    private let finalScoreLabel = SKLabelNode(text: "Score: ")

    //Scoring & levels
    private var lives = 5
    private var score = 0
    private var currentLevel = 1

    //this node detects if notes hit the bottom of the screen
    private var bottomDetector: SKShapeNode!

    private var userInterationEnabled = false
    private var resettingEnabled = false

    //array of all contacts to be handled in the next frame
    var contactQueue = [SKPhysicsContact]()

    ////////////////////
    //MARK:Scene Setup//
    ////////////////////

    public override func sceneDidLoad() {
        size = CGSize(width: 700, height: 1000)
    }

    public override func didMove(to view: SKView) {
        //initialzise & setup node properties
        setupNodes()
        assignNodeProperties()

        //play the intro animation
        intro()

        //delay 6 seconds so intro has time to complete
        delay(6) {
            //setup & start generating the song
            self.song.setup(level: self.currentLevel)
            self.generateSong()
        }

        //setup physics
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
    }


    func assignNodeProperties() {
        //center in the bottom
        ship.position.y = -570
        ship.position.x = 0
        ship.zPosition = 0

        //ship node physics body
        ship.physicsBody = SKPhysicsBody(rectangleOf: ship.frame.size)
        ship.physicsBody!.collisionBitMask = PhysicsCategory.None
        ship.physicsBody!.categoryBitMask = PhysicsCategory.Ship
        ship.physicsBody!.contactTestBitMask = PhysicsCategory.Note
        ship.physicsBody!.affectedByGravity = false
        ship.zPosition = 100

        //set y posistions
        life1.position.y = -550
        life2.position.y = -550
        life3.position.y = -550
        life4.position.y = -550
        life5.position.y = -550

        //unhide nodes function later
        ship.isHidden = false
        life1.isHidden = false
        life2.isHidden = false
        life3.isHidden = false
        life4.isHidden = false
        life5.isHidden = false
        scoreTextLabel.isHidden = false
        scoreLabel.isHidden = false

        scoreLabel.position.y = -575
        scoreTextLabel.position.y = -575

        levelLabel.position.y = -500
        songLabel.position.y = -540

        booster1.position.x = ship.position.x + 50
        booster1.position.y = ship.position.y
        booster1.particleScale = 0.1
        booster1.targetNode = self

        booster2.position.x = ship.position.x - 50
        booster2.position.y = ship.position.y
        booster2.particleScale = 0.1
        booster2.targetNode = self

        booster3.position.x = ship.position.x
        booster3.position.y = ship.position.y
        booster3.particleScale = 0.3
        booster3.targetNode = self

        booster1.zPosition = 0
        booster2.zPosition = 0
        booster3.zPosition = 0
    }

    //initialises the nodes
    func setupNodes() {
        //ship node
        ship = scene?.childNode(withName: "ship") as? SKSpriteNode

        //hearts
        life1 = scene?.childNode(withName: "life1") as? SKShapeNode
        life2 = scene?.childNode(withName: "life2") as? SKShapeNode
        life3 = scene?.childNode(withName: "life3") as? SKShapeNode
        life4 = scene?.childNode(withName: "life4") as? SKShapeNode
        life5 = scene?.childNode(withName: "life5") as? SKShapeNode

        //score labels
        scoreLabel = scene?.childNode(withName: "score") as? SKLabelNode
        scoreTextLabel = scene?.childNode(withName: "scoreTextLabel") as? SKLabelNode

        //stars emitter
        let starsPath = Bundle.main.path(forResource: "stars", ofType: "sks")!
        stars = NSKeyedUnarchiver.unarchiveObject(withFile: starsPath) as! SKEmitterNode

        stars.position.y = 500
        stars.zPosition = -1
        stars.targetNode = self

        //asteroid emiiter
        let asteroidsPath = Bundle.main.path(forResource: "asteroid", ofType: "sks")!
        asteroids = NSKeyedUnarchiver.unarchiveObject(withFile: asteroidsPath) as! SKEmitterNode

        asteroids.position.y = 500
        asteroids.zPosition = -1
        asteroids.targetNode = self

        scene?.addChild(stars)
        scene?.addChild(asteroids)

        //level labels
        levelLabel = scene?.childNode(withName: "levelLabel") as? SKLabelNode
        songLabel = scene?.childNode(withName: "songLabel") as? SKLabelNode

        //ship booster effects
        let boosterPath = Bundle.main.path(forResource: "booster", ofType: "sks")!
        booster1 = NSKeyedUnarchiver.unarchiveObject(withFile: boosterPath) as! SKEmitterNode
        booster2 = NSKeyedUnarchiver.unarchiveObject(withFile: boosterPath) as! SKEmitterNode
        booster3 = NSKeyedUnarchiver.unarchiveObject(withFile: boosterPath) as! SKEmitterNode

        //add noteDetector
        bottomDetector = scene?.childNode(withName: "bottomDetector") as? SKShapeNode
        bottomDetector.physicsBody = SKPhysicsBody(rectangleOf: bottomDetector.frame.size)
        bottomDetector.physicsBody!.collisionBitMask = PhysicsCategory.None
        bottomDetector.physicsBody!.categoryBitMask = PhysicsCategory.Bottom
        bottomDetector.physicsBody!.contactTestBitMask = PhysicsCategory.Note
        bottomDetector.physicsBody!.affectedByGravity = false
    }

    //resets the game if you die
    func resetGame() {

        //go back to the first level
        currentLevel = 1

        //reset lives
        lives = 5

        //remove the death menu labels
        deathLabel.removeFromParent()
        deathLabel2.removeFromParent()
        finalScoreLabel.removeFromParent()

        //set the nodes back to thier starting posistions
        assignNodeProperties()
        //play intro
        intro()

        //reset song array
        i = -1
        self.song.clear()

        //delay 6 seconds so intro has time to complete
        delay(6) {
            //setup & start generating the song
            self.song.setup(level: self.currentLevel)
            self.generateSong()
        }
    }

    //intro sequence when game starts
    func intro() {

        //reset score and lives (since this function is also called to reset the game)
        score = 0
        scoreLabel.text = "\(score)"
        lives = 5

        //add the emitters to the ship
        scene?.addChild(booster1)
        scene?.addChild(booster2)
        scene?.addChild(booster3)

        //play the level animation
        levelAnimation(level: "1", song: "Mary Had A Little Lamb")

        delay(2) {
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
            self.life4.run(moveLives)
            self.life5.run(moveLives)
            self.scoreLabel.run(moveLives)
            self.scoreTextLabel.run(moveLives)

            //after these animations complete, enable user interaction
            delay(2) {
                self.userInterationEnabled = true
            }
        }
    }

    //animation that plays between levels
    func levelAnimation(level: String, song: String) {
        //move the labels back to the bottom
        levelLabel.position.y = 0
        songLabel.position.y = -30
        levelLabel.position.x = -500
        songLabel.position.x = -500

        //set the label text
        levelLabel.text = "Level \(level)"
        songLabel.text = song

        //move the label
        let move = SKAction.moveBy(x: 1100, y: 0, duration: 4)
        levelLabel.run(move)
        songLabel.run(move)
    }

    ///////////////////////
    //MARK:Spawning Nodes//
    ///////////////////////

    //shoots a bullet (called whenever the mouse is clicked)
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

        //only shoot bullets if the game is userInterationEnabled
        if userInterationEnabled {
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

        //isNote checks if the note being created is not a rest
        if(isNote) {
            //convert length (in beats) into height of note (1 beat is 100px in length)
            let noteHeight = length * Double(100)

            //add the note to the scene
            addNoteWithOptions(height: CGFloat(noteHeight), xPosition: CGFloat(x))
        }
    }

    //Spawns new note to the scene
    public func addNoteWithOptions(height: CGFloat, xPosition: CGFloat) {

        let newNote = SKShapeNode(rect: CGRect(x: 0, y: height / 2, width: 43.75, height: height))

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

        scene?.addChild(newNote)

        //start moving down the screen
        let move = SKAction.moveBy(x: 0, y: -1500, duration: 4)
        newNote.run(move)

        //to maintain performance, delete note nodes after they leave the screen.
        delay(4) {
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

            //this big if-else statement essentially finds the x pos. of the collision and plays the right note by calling the Sound.playSound() function
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

            //make sure we delete the note and not the ship
            if(contact.bodyA.categoryBitMask == PhysicsCategory.Note) {
                contact.bodyA.node!.removeFromParent()
            } else {
                contact.bodyB.node!.removeFromParent()
            }

            //take off one life
            adjustLives()
        }

        //a note hit the bottom:
        if nodeBitmasks.contains(PhysicsCategory.Bottom) && nodeBitmasks.contains(PhysicsCategory.Note) {

            //take off one life
            adjustLives()
        }
    }

    func adjustLives() {
        lives = lives - 1
        switch lives {
        case 4:
            life5.isHidden = true
        case 3:
            life4.isHidden = true
        case 2:
            life3.isHidden = true
        case 1:
            life2.isHidden = true
        case 0:
            life1.isHidden = true
            deathScreen()
        default:
            print("this should not happen")
        }
    }

    func deathScreen() {
        userInterationEnabled = false
        resettingEnabled = true

        //hide nodes
        ship.isHidden = true
        scoreTextLabel.isHidden = true
        scoreLabel.isHidden = true
        life1.isHidden = true
        life2.isHidden = true
        life3.isHidden = true
        life4.isHidden = true
        life5.isHidden = true

        booster1.removeFromParent()
        booster2.removeFromParent()
        booster3.removeFromParent()

        // Removing existing notes
        for child in self.children {
            if child.name == "note" {
                child.removeFromParent()
            }
        }

        //display the death labels
        deathLabel.fontName = "Helvetica Neue Light"
        deathLabel.fontSize = 65
        deathLabel.fontColor = .white
        deathLabel.position = CGPoint(x: 0, y: 0)

        deathLabel2.fontName = "Helvetica Neue Light"
        deathLabel2.fontSize = 30
        deathLabel2.fontColor = .white
        deathLabel2.position = CGPoint(x: 0, y: -40)

        finalScoreLabel.text = "Score: \(score)"
        finalScoreLabel.fontName = "Helvetica Neue Light"
        finalScoreLabel.fontSize = 60
        finalScoreLabel.fontColor = .white
        finalScoreLabel.position = CGPoint(x: 0, y: -250)

        scene?.addChild(deathLabel)
        scene?.addChild(deathLabel2)
        scene?.addChild(finalScoreLabel)
    }

    func winScreen() {

        //stop user interation, but reset is not enabled because you can't reset after a win
        userInterationEnabled = false
        resettingEnabled = false

        //hide all nodes
        ship.isHidden = true
        scoreTextLabel.isHidden = true
        scoreLabel.isHidden = true
        life1.isHidden = true
        life2.isHidden = true
        life3.isHidden = true
        life4.isHidden = true
        life5.isHidden = true

        booster1.removeFromParent()
        booster2.removeFromParent()
        booster3.removeFromParent()

        // Removing existing notes
        for child in self.children {
            if child.name == "note" {
                child.removeFromParent()
            }
        }

        //display win labels
        let winLabel = SKLabelNode(text: "You Won!")
        winLabel.fontName = "Helvetica Neue Light"
        winLabel.fontSize = 65
        winLabel.fontColor = .white
        winLabel.position = CGPoint(x: 0, y: 0)

        let winLabel2 = SKLabelNode(text: "I hope to see you at WWDC!")
        winLabel2.fontName = "Helvetica Neue Light"
        winLabel2.fontSize = 30
        winLabel2.fontColor = .white
        winLabel2.position = CGPoint(x: 0, y: -40)

        let finalScoreLabel = SKLabelNode(text: "Score: \(score)")
        finalScoreLabel.fontName = "Helvetica Neue Light"
        finalScoreLabel.fontSize = 50
        finalScoreLabel.fontColor = .white
        finalScoreLabel.position = CGPoint(x: 0, y: -250)

        scene?.addChild(winLabel)
        scene?.addChild(winLabel2)
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
        let location = event.location(in: self)

        //only move the ship if user interation is enabled
        if userInterationEnabled {
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

        //reset game if we're in the death menu & click
        if !userInterationEnabled && resettingEnabled {
            resetGame()
        }
    }

    ////////////////////
    //MARK: Song Stuff//
    ////////////////////

    let song = Song()

    //this will keep track of how far we are in the song:
    var i = -1

    //this function takes the array of notes from the Song class and prepares to spawn them into the scene
    public func generateSong() {

        //only generate the song if the game is not over
        if userInterationEnabled {

            i = i + 1
            if i < song.songArray.count {

                //it was a delay:
                if ((song.songArray[i]).0) == "N/A" {
                    //delay the next iteration by delay amount
                    delay(Double((song.songArray[i]).1)) {
                        self.generateSong()
                    }
                }

                //it was the end of the song
                else if ((song.songArray[i]).0) == "end" {
                        //play the next level
                        currentLevel += 1

                        //make sure the song title actually exists
                        if(songTitles.indices.contains(currentLevel - 1)) {

                            
                            //ensure the game hasn't ended while the last note is generatedcontains
                            if userInterationEnabled {
                                delay(2) {
                                    //play level animation
                                    self.levelAnimation(level: "\(self.currentLevel)", song: songTitles[self.currentLevel - 1])
                                    //clear songArray and re-populate with new song
                                    self.song.clear()
                                    self.song.setup(level: self.currentLevel)
                                    //reset index
                                    self.i = -1

                                    //wait for the levelAnimation complete before generating the new song
                                    delay(4) {
                                        self.generateSong()
                                    }
                                }
                            }
                            
                            
                        } else {
                            
                            //if song title doesn't exist; you either won the game or something went wrong you probably won, but double check
                            if currentLevel > 4 {
                                delay(2) {
                                    self.winScreen()
                                }
                            } else {
                                print("level does not exist")
                            }
                            
                            
                        }

                    
                //it is a note:
                } else {
                    
                        //spawn note
                        prepareNoteForSpawn(note: ((song.songArray[i]).0), length: ((song.songArray[i]).1))

                        //delay the next iteration by length of note
                        delay(Double((song.songArray[i]).1) / 2) {
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
        //procces all the contacts that were detected last frame
        processContacts(forUpdate: currentTime)
    }
}
