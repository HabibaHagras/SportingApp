//
//  ApiTest.swift
//  SportingAppTests
//
//  Created by habiba on 5/21/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import XCTest
@testable import SportingApp
class ApiTest: XCTestCase {

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
 func testFetchLeagues() {
     let ex = expectation(description: "Fetch leagues expectation")
     NetworkServices.fetchLeagues(for: "football") { (leagueResponse) in
         if let leagueResponse = leagueResponse {
             XCTAssertEqual(leagueResponse.success, 1, "Result should be 1 if the correct call api ")
             ex.fulfill()
         } else {
             XCTFail("Failed to fetch leagues")
         }
     }
     waitForExpectations(timeout: 5, handler: nil)
 }
 func testFetchData() {
     var apiService  = NetworkServices()
        let ex = expectation(description: "Fetch data expectation")
        
        
        let url = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=200&from=2023-01-18&to=2024-01-18&APIkey=a1b95c94c39ff26768ea69c6a678bcd70ea5bb8e6634e604724f0332b29c31d5"



    apiService.fetchData(url: url) { (response: EventsResponse?) in
            if let response = response {
                XCTAssertEqual(response.success, 1, "Result should be 1 if the correct call api ")
                ex.fulfill()
            } else {
                XCTFail("Failed to fetch data")
            }
        }

        // Wait for expectations
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchVideos() {
            let ex = expectation(description: "Fetch videos expectation")
            NetworkServices.fetchVideos(for: "football") { (videoResponse) in
                if let videoResponse = videoResponse {
                    XCTAssertEqual(videoResponse.success, 1, "Result should be 1 if the API call is correct")
                    ex.fulfill()
                } else {
                    XCTFail("Failed to fetch videos")
                }
            }
            waitForExpectations(timeout: 5, handler: nil)
        }





    }

