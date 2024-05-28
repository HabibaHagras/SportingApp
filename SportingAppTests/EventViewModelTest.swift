//
//  EventViewModelTest.swift
//  SportingAppTests
//
//  Created by maha on 5/27/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import XCTest

import XCTest
@testable import SportingApp
import CoreData
class LeagueDetailsViewModleTest: XCTestCase {

    var leagueDetailsViewModle: LeagueDetailsViewModle!
    var coreDataServices: CoreDataServices!
 var managedObjectContext: NSManagedObjectContext!

                override func setUp() {
                    super.setUp()

                    // Setting up the in-memory Core Data stack
                    let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
                    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
                    do {
                        try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
                    } catch {
                        XCTFail("Failed to initialize in-memory Core Data stack: \(error)")
                    }

                    managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
                    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator

                    coreDataServices = CoreDataServices(context: managedObjectContext)
                    leagueDetailsViewModle = LeagueDetailsViewModle(coreDataServices: coreDataServices)
                }

                override func tearDown() {
                    leagueDetailsViewModle = nil
                    coreDataServices = nil
                    managedObjectContext = nil
                    super.tearDown()
   }

   func testFetchUpcomingEvents() {
       // Given
       let expectation = self.expectation(description: "Upcoming events fetched")

       leagueDetailsViewModle.bindResultToViewController = {
           expectation.fulfill()
       }

       // When
       leagueDetailsViewModle.fetchUpcomingEvents()

       // Then
       waitForExpectations(timeout: 5, handler: nil)
       XCTAssertNotNil(leagueDetailsViewModle.eventResponse)
       XCTAssertEqual(leagueDetailsViewModle.eventResponse?.result?.count, 2) // Assuming mock data has 2 events
   }

   func testFetchLatestResults() {
       // Given
       let expectation = self.expectation(description: "Latest results fetched")

       leagueDetailsViewModle.bindResultToViewController = {
           expectation.fulfill()
       }

       // When
       leagueDetailsViewModle.fetchLatestResults()

       // Then
       waitForExpectations(timeout: 5, handler: nil)
       XCTAssertNotNil(leagueDetailsViewModle.eventResponse)
       XCTAssertEqual(leagueDetailsViewModle.latestResults?.count, 2) // Assuming mock data has 2 results
   }

   func testFetchTeams() {
       // Given
       let expectation = self.expectation(description: "Teams fetched")

       leagueDetailsViewModle.bindResultToViewController = {
           expectation.fulfill()
       }

       // When
       leagueDetailsViewModle.fetchTeams()

       // Then
       waitForExpectations(timeout: 5, handler: nil)
       XCTAssertNotNil(leagueDetailsViewModle.teamsResponse)
       XCTAssertEqual(leagueDetailsViewModle.legueTeams?.count, 2) // Assuming mock data has 2 teams
   }
}
