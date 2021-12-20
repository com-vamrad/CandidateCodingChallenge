//
//  Meta.swift
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
//Detail description:http://platform.seatgeek.com/

struct Meta: Codable {
    let took: Int
    let perPage: Int
    let total: Int
    let page: Int
}

extension Meta {
    var totalPages: Int {
        total/perPage+1
    }
    var canLoad: Bool {
        page<totalPages
    }
    var nextPage: Int {
        page+1
    }
}

