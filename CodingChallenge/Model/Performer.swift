//
//  Performer.swift
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
//Detail description: http://platform.seatgeek.com/#performers

struct Performer: Codable, Hashable {
    let id: Int
    let name: String?
    let image: URL?
}



