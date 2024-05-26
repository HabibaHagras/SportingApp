//
//  CoreDataServices.swift
//  SportingApp
//
//  Created by habiba on 5/23/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
import CoreData

class CoreDataServices {
            var fetchedItems: [NSManagedObject] = []

           let context: NSManagedObjectContext
           
           init(context: NSManagedObjectContext) {
               self.context = context
           }
           
             func fetchData(completion: @escaping ([NSManagedObject]?, Error?) -> Void) {
               let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "")
               
               do {
                   let fetchedItems = try context.fetch(fetchRequest)
                   completion(fetchedItems, nil)
               } catch let error {
                   completion(nil, error)
               }
           }
  
  
    func saveEvent(event: Event) {
           let entity = NSEntityDescription.entity(forEntityName: "LeagueTable", in: context)!
           let eventObject = NSManagedObject(entity: entity, insertInto: context)

           eventObject.setValue(event.eventDate, forKey: "eventDate")
           eventObject.setValue(event.eventTime, forKey: "eventTime")
           eventObject.setValue(event.eventHomeTeam, forKey: "eventHomeTeam")
           eventObject.setValue(event.eventAwayTeam, forKey: "eventAwayTeam")
           eventObject.setValue(event.homeTeamLogo, forKey: "homeTeamLogo")
           eventObject.setValue(event.awayTeamLogo, forKey: "awayTeamLogo")
           eventObject.setValue(event.eventFinalResult, forKey: "eventFinalResult")

           do {
               try context.save()
            print("save event data**********")
           } catch let error as NSError {
               print("Could not save event. \(error), \(error.userInfo)")
           }
       }

       func saveTeam(team: Team) {
           let entity = NSEntityDescription.entity(forEntityName: "LeagueTable", in: context)!
           let teamObject = NSManagedObject(entity: entity, insertInto: context)

          // teamObject.setValue(team.teamKey, forKey: "teamID")
           //teamObject.setValue(team.teamName, forKey: "teamName")
           teamObject.setValue(team.teamLogo, forKey: "teamLogo")

           do {
               try context.save()
            print("save team")
           } catch let error as NSError {
               print("Could not save team. \(error), \(error.userInfo)")
           }
       }

   func fetchSavedEventsAndTeams() {
         let eventFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueTable")
         let teamFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueTable")

         do {
             let savedEvents = try context.fetch(eventFetchRequest)
             let savedTeams = try context.fetch(teamFetchRequest)

             print("Saved Events:")
             for event in savedEvents {
                 
                 print("Event Date: \(event.value(forKey: "eventDate") ?? "N/A")")
                 print("Event Time: \(event.value(forKey: "eventTime") ?? "N/A")")
                 print("Home Team: \(event.value(forKey: "eventHomeTeam") ?? "N/A")")
                 print("Away Team: \(event.value(forKey: "eventAwayTeam") ?? "N/A")")
                 print("Home Team Logo: \(event.value(forKey: "homeTeamLogo") ?? "N/A")")
                 print("Away Team Logo: \(event.value(forKey: "awayTeamLogo") ?? "N/A")")
                 print("Final Result: \(event.value(forKey: "eventFinalResult") ?? "N/A")")
                 print("---------------")
             }

             print("Saved Teams:")
             for team in savedTeams {
                 //print("Team ID: \(team.value(forKey: "teamId") ?? "N/A")")
                 //print("Team Name: \(team.value(forKey: "teamName") ?? "N/A")")
                 print("Team Logo: \(team.value(forKey: "teamLogo") ?? "N/A")")
                 print("---------------")
             }
         } catch {
             print("Failed to fetch saved events and teams: \(error)")
         }
     }
    
    func saveLeague(id: Int, name: String,logo: String ,sport: String) {
           let entity = NSEntityDescription.entity(forEntityName: "LeagueEntitiy", in: context)!
           let league = NSManagedObject(entity: entity, insertInto: context)
           league.setValue(id, forKey: "leagueKey")
           league.setValue(name, forKey: "leagueName")
        league.setValue(logo, forKey: "leagueLogo")
           league.setValue(sport, forKey: "sportName")

           do {
               try context.save()
           } catch let error as NSError {
               print("Could not save. \(error), \(error.userInfo)")
           }
       }
    func printSavedLeagues() {
         let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntitiy")

         do {
             let leagues = try context.fetch(fetchRequest)
             for league in leagues {
                 let id = league.value(forKey: "leagueKey") as? Int ?? 0
                 let name = league.value(forKey: "leagueName") as? String ?? "Unknown"
                 let sport = league.value(forKey: "sportName") as? String ?? "Unknown"
                let logo = league.value(forKey: "leagueLogo") as? String ?? "Unknown"
                 print("League ID: \(id), Name: \(name), Sport: \(sport),logo: \(logo)")
             }
         } catch let error as NSError {
             print("Could not fetch. \(error), \(error.userInfo)")
         }
     }
    }

