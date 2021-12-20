//
//  CodingChallengeTests.swift
//  CodingChallengeTests
//  Toolchain Swift version: 5.0
//
//  Created by Alex Kiselov on 12/17/21.
//  Vamrad LLC
//	www.vamrad.com
//
//  
//
//  

import XCTest
@testable import CodingChallenge

class TestJSON: XCTestCase {
    
    private let decoder = JSONDecoder()
    
    override func setUpWithError() throws {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
    }
    
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//    
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testJSONBulkResponseModel() throws {
        let mockFile = "MockResponseJSON_2"
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: mockFile, withExtension: "json") else {
            XCTFail("Can't find \(mockFile) file")
            return
        }
        let data = try Data(contentsOf: fileURL)
        let response = try decoder.decode(BulkResponse.self, from: data)
        XCTAssertGreaterThan(response.events.count, 0)
    }
    
    func testJSONEventModel() throws {
        let mockFile = "MockEventJSON"
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: mockFile, withExtension: "json") else {
            XCTFail("Can't find \(mockFile) file")
            return
        }
        let data = try Data(contentsOf: fileURL)
        let event = try decoder.decode(Event.self, from: data)
        XCTAssertEqual(event.id, 5444278)
    }
    
    func testJSONVenueModel() throws {
        let mockFile = "MockVenueJSON"
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: mockFile, withExtension: "json") else {
            XCTFail("Can't find \(mockFile) file")
            return
        }
        let data = try Data(contentsOf: fileURL)
        let venue = try decoder.decode(Venue.self, from: data)
        XCTAssertEqual(venue.id, 67444)
    }
    
    func testJSONPerformerModel() throws {
        let mockFile = "MockPerformerJSON"
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: mockFile, withExtension: "json") else {
            XCTFail("Can't find \(mockFile) file")
            return
        }
        let data = try Data(contentsOf: fileURL)
        let performer = try decoder.decode(Performer.self, from: data)
        XCTAssertEqual(performer.id, 97580)
    }
    
    
    func testJSONMetaModel() throws {
        let mockFile = "MockMetaJSON"
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: mockFile, withExtension: "json") else {
            XCTFail("Can't find \(mockFile) file")
            return
        }
        let data = try Data(contentsOf: fileURL)
        let meta = try decoder.decode(Meta.self, from: data)
        XCTAssertEqual(meta.total, 12738)
    }
    
    
    
}
