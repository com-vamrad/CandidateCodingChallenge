//
//  Venue.swift
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

//Performer model
//Detail description:  http://platform.seatgeek.com/#venues

struct Venue: Codable, Hashable {
    let id: Int
    let city: String?
    let state: String?
}

extension Venue {
    func cityState() -> String {
        if let city = self.city, let state = self.state {
            return "\(city), \(state)"
        }
        if let city = self.city {
            return "\(city)"
        }
        if let state = self.city {
            return "\(state)"
        }
        return " "
    }
}

