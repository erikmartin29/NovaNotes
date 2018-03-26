import Foundation
import SpriteKit

struct Sound {
    private let action : SKAction
    init(fileNamed filename : String) {
        action = .playSoundFileNamed(filename, waitForCompletion: false)
    }
    func playSound(in scene : SKScene) {
        scene.run(action)
    }
    
}
