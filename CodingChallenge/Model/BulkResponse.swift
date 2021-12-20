//
//  BulkResponse.swift
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

struct BulkResponse: Codable {
    let events: [Event]
    let meta: Meta
}
