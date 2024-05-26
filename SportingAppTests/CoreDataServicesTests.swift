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
    func testFetchSavedEventsAndTeams() {
        // Given
        let event1 = Event(eventKey: nil, eventDate: "2024-05-26", eventTime: "12:00", eventHomeTeam: "Home Team 1", homeTeamKey: nil, eventAwayTeam: "Away Team 1", awayTeamKey: nil, eventFinalResult: "2-1", eventQuarter: nil, eventStatus: nil, countryName: nil, leagueName: nil, leagueKey: nil, leagueRound: nil, leagueSeason: nil, eventLive: nil, eventHomeTeamLogo: "home_logo1.png", eventAwayTeamLogo: "away_logo1.png", homeTeamLogo: nil, awayTeamLogo: nil, eventFirstPlayer: nil, firstPlayerKey: nil, eventSecondPlayer: nil, secondPlayerKey: nil, eventFirstPlayerLogo: nil, eventSecondPlayerLogo: nil, leagueLogo: nil)
        coreDataServices.saveEvent(event: event1)

        let event2 = Event(eventKey: nil, eventDate: "2024-05-27", eventTime: "13:00", eventHomeTeam: "Home Team 2", homeTeamKey: nil, eventAwayTeam: "Away Team 2", awayTeamKey: nil, eventFinalResult: "3-2", eventQuarter: nil, eventStatus: nil, countryName: nil, leagueName: nil, leagueKey: nil, leagueRound: nil, leagueSeason: nil, eventLive: nil, eventHomeTeamLogo: "home_logo2.png", eventAwayTeamLogo: "away_logo2.png", homeTeamLogo: nil, awayTeamLogo: nil, eventFirstPlayer: nil, firstPlayerKey: nil, eventSecondPlayer: nil, secondPlayerKey: nil, eventFirstPlayerLogo: nil, eventSecondPlayerLogo: nil, leagueLogo: nil)

        coreDataServices.saveEvent(event: event2)

        let team1 = Team(teamKey: 1, teamName: "Team 1", teamLogo: "team_logo1.png")
        coreDataServices.saveTeam(team: team1)

        let team2 = Team(teamKey: 2, teamName: "Team 2", teamLogo: "team_logo2.png")
        coreDataServices.saveTeam(team: team2)

        // When
        coreDataServices.fetchSavedEventsAndTeams { fetchedItems, error in
            // Then
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(fetchedItems, "Fetched items should not be nil")

            // Verify fetched events
            let savedEvents = fetchedItems?.filter { $0 is Event } as? [Event]
            XCTAssertEqual(savedEvents?.count, 2, "Expected two events to be fetched")
            XCTAssertEqual(savedEvents?[0].eventHomeTeam, "Home Team 1", "First event home team should match")
            XCTAssertEqual(savedEvents?[1].eventHomeTeam, "Home Team 2", "Second event home team should match")

            // Verify fetched teams
            let savedTeams = fetchedItems?.filter { $0 is Team } as? [Team]
            XCTAssertEqual(savedTeams?.count, 2, "Expected two teams to be fetched")
            XCTAssertEqual(savedTeams?[0].teamName, "Team 1", "First team name should match")
            XCTAssertEqual(savedTeams?[1].teamName, "Team 2", "Second team name should match")
        }
    }

}
