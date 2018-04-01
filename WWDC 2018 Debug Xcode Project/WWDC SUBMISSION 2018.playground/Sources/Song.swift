import Foundation

public class Song {
    
    //all the information about each note is stored in this array.
    public var songArray = [(String, Double)]()
    
    //adds a note to the song array
    public func addNote(note: String, length: Double) {
        songArray.append((note,length))
    }
    
    //adds a rest in the song array, note is assigned "N/A" which will be recognised as a delay
    public func addDelay(length: Double) {
        songArray.append(("N/A",length))
    }
    
    //marks the end of a song so the next level can play
    public func addEndMarker() {
        songArray.append(("end",0))
    }
    
    //clears the songArray
    public func clear() {
        songArray.removeAll()
    }

    //adds all of the notes to the song array
    public func setup(level: Int) {

        switch level {
            case 1:
                //Mary Had a Little Lamb:
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "D", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C", length: half)
                self.addEndMarker()
            
        case 2: 
                //Old MacDonald Had a Farm
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "A", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "A", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "A", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "A", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "A", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "A", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: half)
                self.addDelay(length: quarter)
                self.addEndMarker()
            
        case 3:
                //I'm A Little Teapot
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "F2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G2", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "A2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "A2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G2", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "F2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "F2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "F2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: half)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: half)
                self.addEndMarker()
    
        case 4:
                //Itsy-Bitsy Spider
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "F2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "F2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "F2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "G", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "D2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "E2", length: quarter)
                self.addDelay(length: quarter)
                self.addNote(note: "C2", length: quarter)
                self.addDelay(length: quarter)
                self.addEndMarker()
        default:
            print("level does not exist")
        }
    }
}
