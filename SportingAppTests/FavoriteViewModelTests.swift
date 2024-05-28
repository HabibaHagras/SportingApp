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
             var mockPersistentContainer: NSPersistentContainer!
               var coreDataServices: CoreDataServices!
               var viewModel: FavoriteViewModel!

               override func setUp() {
                   super.setUp()

                   mockPersistentContainer = {
                       let container = NSPersistentContainer(name: "SportingApp")
                       let description = NSPersistentStoreDescription()
                       description.type = NSInMemoryStoreType
                       container.persistentStoreDescriptions = [description]
                       container.loadPersistentStores { description, error in
                           if let error = error {
                               fatalError("Failed to load persistent stores: \(error)")
                           }
                       }
                       return container
                   }()

                   coreDataServices = CoreDataServices(context: mockPersistentContainer.viewContext)
                   viewModel = FavoriteViewModel(coreDataServices: coreDataServices)
               }

               override func tearDown() {
                   super.tearDown()

                   viewModel = nil
                   coreDataServices = nil
                   mockPersistentContainer = nil
               }

               func testFetchData() {
                   let expectation = self.expectation(description: "Fetch data")

                   // Insert mock data
                   coreDataServices.saveLeague(id: 1, name: "Test League", logo: "logo.png", sport: "Soccer")

                   viewModel.bindResultCoreDataToViewController = {
                       expectation.fulfill()
                   }

                   viewModel.fetchData { error in
                       XCTAssertNil(error, "Fetch data should not produce an error")
                       XCTAssertEqual(self.viewModel.news.count, 1, "There should be one item in news array")
                   }

                   waitForExpectations(timeout: 1, handler: nil)
               }

               func testDelete() {
                   let fetchExpectation = self.expectation(description: "Fetch data")
                   let deleteExpectation = self.expectation(description: "Delete data")

                   coreDataServices.saveLeague(id: 1, name: "Test League", logo: "logo.png", sport: "Soccer")

                   viewModel.bindResultCoreDataToViewController = {
                       fetchExpectation.fulfill()
                   }

                   viewModel.fetchData { error in
                       XCTAssertNil(error, "Fetch data should not produce an error")
                       XCTAssertEqual(self.viewModel.news.count, 1, "There should be one item in news array")

                       if let item = self.viewModel.news.first {
                           self.viewModel.bindResultDeleteCoreDataToViewController = {
                               deleteExpectation.fulfill()
                           }

                           self.viewModel.delete(item: item) { error in
                               XCTAssertNil(error, "Delete data should not produce an error")
                               XCTAssertEqual(self.viewModel.news.count, 0, "News array should be empty after deletion")
                           }
                       }
                   }

                   waitForExpectations(timeout: 1, handler: nil)
               }
        }
