//
//  Album.swift
//  ios-albums-AP
//
//  Created by Jorge Alvarez on 2/10/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

struct Album: Decodable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
    }
    
    /*
     {
     "artist" : "Weezer",
     "coverArt" : [ {
       "url" : "https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png"
     } ],
     "genres" : [ "Alternative" ],
     "id" : "5E58FA0F-7DBD-4F1D-956F-89756CF1EB22",
     "name" : "Weezer (The Blue Album)",
     "songs" : [ {
       "duration" : {
         "duration" : "3:25"
       },
       "id" : "82BDE132-E492-4FED-9A77-B49CADBC2BFD",
       "name" : {
         "title" : "My Name Is Jonas"
       }
     }...
     */
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        // artist
        artist = try container.decode(String.self, forKey: .artist)
        
        // coverArt
        coverArt = try container.decode([URL].self, forKey: .coverArt)
        
        // genres
        genres = try container.decode([String].self, forKey: .genres)
        
        // id
        id = try container.decode(String.self, forKey: .id)
        
        // name
        name = try container.decode(String.self, forKey: .name)
        
        // songs
        songs = try container.decode([Song].self, forKey: .songs)
        
    }
}

struct Song: Decodable {
    var duration: String // ?
    var id: String
    var name: String
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
        
        enum NameKeys: String, CodingKey {
            case name
        }
    }
    
    init(from decoder: Decoder) throws {
        
        /*
         [... {
           "duration" : {
             "duration" : "3:25"
           },
           "id" : "82BDE132-E492-4FED-9A77-B49CADBC2BFD",
           "name" : {
             "title" : "My Name Is Jonas"
           }
         } ...]
         */
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        // duration
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        // id
        id = try container.decode(String.self, forKey: .id)
        
        // name
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .name)
    }
}


// Example JSON
/*
 {
   "artist" : "Weezer",
   "coverArt" : [ {
     "url" : "https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png"
   } ],
   "genres" : [ "Alternative" ],
   "id" : "5E58FA0F-7DBD-4F1D-956F-89756CF1EB22",
   "name" : "Weezer (The Blue Album)",
   "songs" : [ {
     "duration" : {
       "duration" : "3:25"
     },
     "id" : "82BDE132-E492-4FED-9A77-B49CADBC2BFD",
     "name" : {
       "title" : "My Name Is Jonas"
     }
   }, {
     "duration" : {
       "duration" : "3:05"
     },
     "id" : "6E8AC92B-ABB4-4303-89CC-51020CEBB557",
     "name" : {
       "title" : "No One Else"
     }
   }, {
     "duration" : {
       "duration" : "4:19"
     },
     "id" : "0A856A54-2E15-4D4A-9B4B-1870F7783EBE",
     "name" : {
       "title" : "The World Has Turned And Left Me Here"
     }
   }, {
     "duration" : {
       "duration" : "2:39"
     },
     "id" : "7119F603-B37E-40B5-968D-E0091A610765",
     "name" : {
       "title" : "Buddy Holly"
     }
   }, {
     "duration" : {
       "duration" : "5:06"
     },
     "id" : "DDECE717-E075-4A64-9A9F-68CB2A5A58B6",
     "name" : {
       "title" : "Undone (The Sweater Song)"
     }
   }, {
     "duration" : {
       "duration" : "3:06"
     },
     "id" : "3FD6E647-4DF1-48CF-8E76-B932DF773ED3",
     "name" : {
       "title" : "Surf Wax America"
     }
   }, {
     "duration" : {
       "duration" : "4:17"
     },
     "id" : "214FB379-4032-4310-8B7C-C69BA21C4394",
     "name" : {
       "title" : "Say It Ain’t So"
     }
   }, {
     "duration" : {
       "duration" : "3:56"
     },
     "id" : "E4ECC640-120D-4A35-8938-3D83DE031430",
     "name" : {
       "title" : "In The Garage"
     }
   }, {
     "duration" : {
       "duration" : "3:25"
     },
     "id" : "34C44D53-6B14-40F7-8438-F147BD2B321D",
     "name" : {
       "title" : "Holiday"
     }
   }, {
     "duration" : {
       "duration" : "7:59"
     },
     "id" : "BA71E72D-E148-4D81-9A11-D7EA048F2949",
     "name" : {
       "title" : "Only In Dreams"
     }
   } ]
 }


 */