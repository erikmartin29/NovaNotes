import Foundation

public class Song {
    //all the information about each note is stored in this array.
    public var songArray = [(String, Int, Double)]()
    
    //array of all the playable notes
    public var noteArray = [String]()
   
    public func addNote(note: String, octave: Int, length: Double) {
        songArray.append((note,octave,length))
        //noteArray.append(note)
        //print function for testing purposes
        //print(songArray)
    }
    
    public func addDelay(length: Double) {
        songArray.append(("N/A",0,length))
        //print function for testing purposes
        //print(songArray)
    }
}
