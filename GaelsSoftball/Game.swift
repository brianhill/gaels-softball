//
//  Game.swift
//  GaelsSoftball
//
//  Created by Brian Hill on 3/3/16.
//

import Foundation

// In XML plist format, a game dictionary looks like:

//    <dict>
//    <key>DTSTART</key><string>20160324T220000Z</string>
//    <key>DTEND</key><string>20160325T000000Z</string>
//    <key>DTSTAMP</key><string>20160303T073206Z</string>
//    <key>SUMMARY</key><string>Saint Mary's College Softball vs. Iona - 3:00 PM PT</string>
//    <key>CATEGORIES</key><array><string>Athletics</string><string>Varsity Sports</string><string>Women</string></array>
//    <key>DESCRIPTION</key><string>Saint Mary's College Softball vs. Iona - 3:00 PM PT</string><key>LOCATIONTYPE</key><string>Home</string>
//    <key>TZID</key><string>20160303T073206Z</string>
//    <key>UID</key><string>CAL.6533006.20160324</string>
//    <key>LOCATION</key><string>Moraga  Calif.</string>
//    <key>CONTACT</key><string>SMCGaels.com</string>
//    </dict>

// All-caps key names are awful look at, so they shouldn't be in the class definition.

// Therefore we are going to need a mapping between the all-caps names and the property names.


let IcalKeysByProperty = [
    "start": "DTSTART",
    "end": "DTEND",
    "summary": "SUMMARY",
    "description": "DESCRIPTION",
    "locationType": "LOCATIONTYPE",
    "location": "LOCATION"
]

enum LocationType: String {
    case Home = "Home"
    case Away = "Away"
    case Neutral = "Neutral"
}

class Game {
    
    let start: NSDate
    let end: NSDate
    let summary: String
    let description: String
    let locationType: LocationType
    let location: String
    
    init(dict: NSDictionary) {
        let iso8601DateFormatter = NSDateFormatter()
        iso8601DateFormatter.dateFormat = "yyyyMMdd'T'HHmmssZ"
        start = iso8601DateFormatter.dateFromString(dict.objectForKey(IcalKeysByProperty["start"]!)! as! String)!
        end = iso8601DateFormatter.dateFromString(dict.objectForKey(IcalKeysByProperty["end"]!)! as! String)!
        summary = dict.objectForKey(IcalKeysByProperty["summary"]!)! as! String
        description = dict.objectForKey(IcalKeysByProperty["description"]!)! as! String
        locationType = LocationType(rawValue: dict.objectForKey(IcalKeysByProperty["locationType"]!)! as! String)!
        location = dict.objectForKey(IcalKeysByProperty["location"]!)! as! String
    }
    
}

func gameFromDictionary(dict: NSDictionary) -> Game {
    return Game.init(dict: dict)
}

func softballGames() -> [Game] {
    let path = NSBundle.mainBundle().pathForResource("SoftballGames", ofType: "plist")!
    let rawGames: [NSDictionary] = NSArray(contentsOfFile: path) as! [NSDictionary]
    return rawGames.map(gameFromDictionary)
}
