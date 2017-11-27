//
//  APIManagerTests.swift
//  TigerDroppingsTests
//
//  Created by James Kiel on 11/26/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import XCTest
@testable import TigerDroppings

class APIManagerTests: XCTestCase {
    
    var apiManager = APIManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitializeSucceeds(){
        
        // Not nil
        apiManager.makeHTTPGetRequest(path: "https://tigerdroppings.com") { json in
            XCTAssertNotNil(json)
        }
        
    }

    func testInitializeFails(){
        
        //Is nil
        let nilBoard = Board.init(boardName: "Nil", boardURL: "")
        XCTAssertNil(nilBoard)
    }
}
