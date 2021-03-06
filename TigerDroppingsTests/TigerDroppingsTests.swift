//
//  TigerDroppingsTests.swift
//  TigerDroppingsTests
//
//  Created by James Kiel on 11/25/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import XCTest
@testable import TigerDroppings

class TigerDroppingsTests: XCTestCase {
    
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
        let homeBoard = Board.init(boardName: "Home", boardURL: "https://tigerdroppings.com")
        XCTAssertNotNil(homeBoard)
        
    }
    
    func testInitializeFails(){
        
        //Is nil
        let nilBoard = Board.init(boardName: "Nil", boardURL: "")
        XCTAssertNil(nilBoard)
    }
    
    func testLoadPageAndTable(){
        let testBoard = Board.init(boardName: "Test", boardURL: "Test")
        apiManager.makeHTTPGetRequest(path: "https://tigerdroppings.com") { json in
            print(json)
            XCTAssertNotNil(testBoard)
        }
    
    }
    
    
    
}
