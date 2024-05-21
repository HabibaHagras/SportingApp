//
//  MockingTest.swift
//  SportingAppTests
//
//  Created by habiba on 5/21/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import XCTest

class MockingTest: XCTestCase {
    let mockObject = MockNetwork(shouldreturnError: false)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testMockFetchData(){
        mockObject.fetchDataFromApi{
            result , error in
            if let error = error {
                XCTFail()
            }else{
                XCTAssertNotNil(result)
            }
        }
    }

}
