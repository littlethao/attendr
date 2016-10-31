//
//  TablePhoto.swift
//  Attendr
//
//  Created by Thao Vo on 31/10/2016.
//  Copyright © 2016 Matt Vickers. All rights reserved.
//

import Foundation

class TablePhoto {
    class Entry {
        let filename: String
        init(fname: String) {
            self.filename = fname
        }
    }
    
    let captures = [
        Entry(fname: "travel_meetup.jpg"),
        Entry(fname: "seaside_meetup.jpg"),
        Entry(fname: "wine_tasting_meetup.jpg"),
        Entry(fname: "party_meetup.jpg"),
        Entry(fname: "music_meetup.jpg"),
        Entry(fname: "dining_meetup.jpg"),
        Entry(fname: "online_dating.jpg"),
        Entry(fname: "fun_time.jpg")
    ]
}
