//
//  FavoriteViewModelTests.swift
//  SportingAppTests
//
//  Created by habiba on 5/27/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import XCTest
import CoreData
@testable import SportingApp
class FavoriteViewModelTests: XCTestCase {
            var viewModel: FavoriteViewModel!
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
                viewModel = FavoriteViewModel(coreDataServices: coreDataServices)
            }

            override func tearDown() {
                viewModel = nil
                coreDataServices = nil
                managedObjectContext = nil
                super.tearDown()
            }

            func testFetchData() {
                // Given
                let id = 1
                let name = "Test League"
                let logo = "test_logo.png"
                let sport = "Football"
                coreDataServices.saveLeague(id: id, name: name, logo: logo, sport: sport)

                let expectation = self.expectation(description: "FetchData")

                // When
                viewModel.bindResultCoreDataToViewController = {
                    expectation.fulfill()
                }

                var fetchError: Error?
                viewModel.fetchData { error in
                    fetchError = error
                }

                waitForExpectations(timeout: 2, handler: nil)

                // Then
                XCTAssertNil(fetchError, "Error should be nil")
                XCTAssertEqual(viewModel.news.count, 1, "One league should be fetched")
                XCTAssertEqual(viewModel.news.first?.value(forKey: "leagueName") as? String, name, "Fetched league name should match")
            }

          
//                func testDelete() {
//                         let id = 1
//                       let name = "Test League"
//                       let logo = "test_logo.png"
//                       let sport = "Football"
//
//                       coreDataServices.saveLeague(id: id, name: name, logo: logo, sport: sport)
//
//                    let fetchRequest: NSFetchRequest<LeagueEntitiy> = LeagueEntitiy.fetchRequest()
//                    var savedLeagues: [LeagueEntitiy] = []
//                    do {
//                        savedLeagues = try managedObjectContext.fetch(fetchRequest)
//                    } catch {
//                        XCTFail("Failed to fetch leagues: \(error)")
//                    }
//
//                    guard let leagueToDelete = savedLeagues.first else {
//                        XCTFail("No leagues found to delete")
//                        return
//                    }
//
//                    let expectation = self.expectation(description: "DeleteData")
//
//                    viewModel.bindResultDeleteCoreDataToViewController = {
//                        expectation.fulfill()
//                    }
//
//                    var deleteError: Error?
//                    viewModel.delete(item: leagueToDelete) { error in
//                        deleteError = error
//                    }
//
//                    waitForExpectations(timeout: 10, handler: nil)
//
//                    XCTAssertNil(deleteError, "Error should be nil")
//
//                    let remainingLeagues: Int
//                    do {
//                        remainingLeagues = try managedObjectContext.count(for: fetchRequest)
//                    } catch {
//                        XCTFail("Failed to fetch remaining leagues: \(error)")
//                        return
//                    }
//                    XCTAssertEqual(remainingLeagues, 0, "All leagues should be deleted")
//                }
            
        }
