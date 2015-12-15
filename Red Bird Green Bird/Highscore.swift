//
//  Highscore.swift
//  Red Bird Green Bird
//
//  Created by Dawood Khan on 1/17/15.
//  Copyright (c) 2015 Dawood Khan. All rights reserved.
//

import Foundation

class HighScore: NSObject {
    
    var highScore: Int = 0
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeInteger(highScore, forKey: "highScore")
    }
    
    init(coder aDecoder: NSCoder!) {
        highScore = aDecoder.decodeIntegerForKey("highScore")
    }
    
    override init() {
    }
}

class SaveHighScore:NSObject {
    
    var documentDirectories:NSArray = []
    var documentDirectory:String = ""
    var path:String = ""
    
    func ArchiveHighScore(highScore highScore: HighScore) {
        documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        documentDirectory = documentDirectories.objectAtIndex(0) as! String
        //path = documentDirectory.stringByAppendingPathComponent("highScore.archive")
        
        if NSKeyedArchiver.archiveRootObject(highScore, toFile: path) {
            print("Success writing to file!")
        } else {
            print("Unable to write to file!")
        }
    }
    
    func RetrieveHighScore() -> NSObject {
        var dataToRetrieve = HighScore()
        documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        documentDirectory = documentDirectories.objectAtIndex(0) as! String
        //path = documentDirectory.stringByAppendingPathComponent("highScore.archive")
        if let dataToRetrieve2 = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? HighScore {
            dataToRetrieve = dataToRetrieve2
        }
        return(dataToRetrieve)
    }
}