//
//  Event.swift
//  CodingChallenge
//  Toolchain Swift version: 5.0
//
//  Created by Alex Kiselov on 12/17/21.
//  Vamrad LLC
//	www.vamrad.com
//
//  
//
//  

import Foundation

//Event model
//Detail description: http://platform.seatgeek.com/#events

struct Event: Codable, Identifiable, Hashable {
    
    var id: Int
    var title: String
    var datetimeLocal: Date
    var performers:[Performer]
    var venue: Venue
//    var shortTitle: String
    
    
}
