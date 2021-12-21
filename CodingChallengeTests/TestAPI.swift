//
//  TestJSON.swift
//  CodingChallengeTests
//  Toolchain Swift version: 5.0
//
//  Created by Alex Kiselov on 12/18/21.
//  Vamrad LLC
//	www.vamrad.com
//
//  
//
//  

import XCTest
import Combine

@testable import CodingChallenge

class TestAPI: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        cancellables = []
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
    
    func testAPI() throws {
        
        let page = 1
        let query: String? = nil
        
        let expectation = self.expectation(description: "ServerResponse")
        let api = API()
        var err: API.Error?
        var bulkResponse: BulkResponse?
        let eventReq = API.EventRequest(page: page, query: query, endPoint: API.EndPoint.events)
        api
            .makeRequest(request: eventReq, type: BulkResponse.self, requiresAuth: true)
            .sink(receiveCompletion: {completion in
                if case .failure(let error) = completion {
                    err = error
                }
                expectation.fulfill()
            }, receiveValue: {val in
                
                bulkResponse = val
            })
            .store(in: &cancellables)
        XCTAssertNil(err)
        waitForExpectations(timeout: 10, handler: nil)
        guard let bulkResponse = bulkResponse else {
            XCTFail()
            return
        }
        XCTAssertEqual(1, bulkResponse.meta.page)
        XCTAssertGreaterThan(bulkResponse.events.count, 0)
        
    }
    
    
    func testLongRequest() {
       
        var page = 1
        let query: String? = nil
        var meta: Meta? = nil
        
        while meta?.canLoad ?? true {
        let expectation = self.expectation(description: "ServerResponse")
        let api = API()
        var err: API.Error?
        var bulkResponse: BulkResponse?
            let eventReq = API.EventRequest(page: page, query: query, endPoint: API.EndPoint.events)
        api
           // .events(req: eventReq)
            .makeRequest(request: eventReq, type: BulkResponse.self, requiresAuth: true)
            .sink(receiveCompletion: {completion in
                if case .failure(let error) = completion {
                    err = error
                }
                expectation.fulfill()
            }, receiveValue: {val in
                
                bulkResponse = val
                meta = val.meta
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(err)
        guard let bulkResponse = bulkResponse else {
            XCTFail("Error decoding page \(page)")
            return
        }
        XCTAssertEqual(page, bulkResponse.meta.page)
            if page == 1 {
        XCTAssertGreaterThan(bulkResponse.events.count, 0)
            }
            
            print("Testing page: \(page) of \(meta?.totalPages ?? -1)")
            page += 1
    }
    }
    
    
    
}
