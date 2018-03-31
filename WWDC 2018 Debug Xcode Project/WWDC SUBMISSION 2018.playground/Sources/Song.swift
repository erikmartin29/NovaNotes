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
}
