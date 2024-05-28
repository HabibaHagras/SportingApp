//
//  CoreDataServicesTests.swift
//  SportingAppTests
//
//  Created by habiba on 5/26/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import XCTest
@testable import SportingApp
import CoreData

class CoreDataServicesTests: XCTestCase {
    var coreDataServices: CoreDataServices!
       var managedObjectContext: NSManagedObjectContext!
    override func setUp() {
     
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
                   try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
               } catch {
                   XCTFail("Failed to initialize in-memory Core Data stack: \(error)")
               }

               managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
               managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator

               coreDataServices = CoreDataServices(context: managedObjectContext)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        coreDataServices = nil
              managedObjectContext = nil
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
    func testDeleteSavedLeague() {
          // Given
          let id = 1
          let name = "Test League"
          let logo = "test_logo.png"
          let sport = "Football"

          coreDataServices.saveLeague(id: id, name: name, logo: logo, sport: sport)

          let fetchRequest: NSFetchRequest<LeagueEntitiy> = LeagueEntitiy.fetchRequest()
          var savedLeagues: [LeagueEntitiy] = []
          do {
              savedLeagues = try managedObjectContext.fetch(fetchRequest)
          } catch {
              XCTFail("Failed to fetch leagues: \(error)")
          }

          guard let leagueToDelete = savedLeagues.first else {
              XCTFail("No leagues found to delete")
              return
          }

          // When
          coreDataServices.deleteSavedLeague(leagueToDelete) { error in
              XCTAssertNil(error, "Error should be nil")
          }

          // Then
          let remainingLeagues: Int
          do {
              remainingLeagues = try managedObjectContext.count(for: fetchRequest)
          } catch {
              XCTFail("Failed to fetch remaining leagues: \(error)")
              return
          }
          XCTAssertEqual(remainingLeagues, 0, "All leagues should be deleted")
      }
    
  func testFetchSavedLeagues() {
        // Given
        let id = 1
        let name = "Test League"
        let logo = "test_logo.png"
        let sport = "Football"
        
        coreDataServices.saveLeague(id: id, name: name, logo: logo, sport: sport)
        
        // When
        var fetchedLeagues: [NSManagedObject]?
        var fetchError: Error?
        coreDataServices.FetchSavedLeagues { leagues, error in
            fetchedLeagues = leagues
            fetchError = error
        }
        
        // Then
        XCTAssertNil(fetchError, "Error fetching leagues should be nil")
        XCTAssertNotNil(fetchedLeagues, "Fetched leagues should not be nil")
        XCTAssertEqual(fetchedLeagues?.count, 1, "Expected one league to be fetched")
        
        let fetchedLeague = fetchedLeagues?.first!
        XCTAssertEqual(fetchedLeague?.value(forKey: "leagueKey") as? Int, id, "Fetched league ID should match")
        XCTAssertEqual(fetchedLeague?.value(forKey: "leagueName") as? String, name, "Fetched league name should match")
        XCTAssertEqual(fetchedLeague?.value(forKey: "leagueLogo") as? String, logo, "Fetched league logo should match")
        XCTAssertEqual(fetchedLeague?.value(forKey: "sportName") as? String, sport, "Fetched league sport should match")
    }
    
    func testSaveLeague() {
        // Given
        let id = 1
        let name = "Premier League"
        let logo = "premier_league_logo.png"
        let sport = "Football"

        // When
        coreDataServices.saveLeague(id: id, name: name, logo: logo, sport: sport)

        // Then
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LeagueEntitiy")
        var fetchedLeagues: [NSManagedObject] = []
        do {
            fetchedLeagues = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch {
            XCTFail("Failed to fetch leagues: \(error)")
        }

        XCTAssertEqual(fetchedLeagues.count, 1)
        let savedLeague = fetchedLeagues.first
        XCTAssertEqual(savedLeague?.value(forKey: "leagueKey") as? Int, id)
        XCTAssertEqual(savedLeague?.value(forKey: "leagueName") as? String, name)
        XCTAssertEqual(savedLeague?.value(forKey: "leagueLogo") as? String, logo)
        XCTAssertEqual(savedLeague?.value(forKey: "sportName") as? String, sport)
       
    }
    
    func testIsLeagueSaved() {
        // Given
        let leagueId = 123
        let leagueEntity = NSEntityDescription.insertNewObject(forEntityName: "LeagueEntitiy", into: managedObjectContext)
        leagueEntity.setValue(leagueId, forKey: "leagueKey")

        do {
            try managedObjectContext.save()
        } catch {
            XCTFail("Failed to save context: \(error)")
        }

        // When
        let isSaved = coreDataServices.isLeagueSaved(leagueId: leagueId)
        XCTAssertTrue(isSaved, "The league should be saved in Core Data")

        let isNotSaved = coreDataServices.isLeagueSaved(leagueId: 999)
        XCTAssertFalse(isNotSaved, "The league should not be found in Core Data")
    }
    
    func testRemoveLeague() {
           // Given
           let leagueId = 123
           let leagueEntity = NSEntityDescription.insertNewObject(forEntityName: "LeagueEntitiy", into: managedObjectContext)
           leagueEntity.setValue(leagueId, forKey: "leagueKey")

           do {
               try managedObjectContext.save()
           } catch {
               XCTFail("Failed to save context: \(error)")
           }

           // When
           coreDataServices.removeLeague(leagueId: leagueId)

           // Then
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueEntitiy")
           fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueId)

           do {
               let result = try managedObjectContext.fetch(fetchRequest)
               XCTAssertTrue(result.isEmpty, "The league should be removed from Core Data")
           } catch {
               XCTFail("Failed to fetch leagues: \(error)")
           }
       }
}
