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
//    func printSavedLeagues(){
//         let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntitiy")
//
//         do {
//             let leagues = try context.fetch(fetchRequest)
//             for league in leagues {
//                 let id = league.value(forKey: "leagueKey") as? Int ?? 0
//                 let name = league.value(forKey: "leagueName") as? String ?? "Unknown"
//                 let sport = league.value(forKey: "sportName") as? String ?? "Unknown"
//                let logo = league.value(forKey: "leagueLogo") as? String ?? "Unknown"
//                 print("League ID: \(id), Name: \(name), Sport: \(sport),logo: \(logo)")
//             }
//         } catch let error as NSError {
//             print("Could not fetch. \(error), \(error.userInfo)")
//         }
//     }
    
    func FetchSavedLeagues(completion: @escaping ([NSManagedObject]?, Error?) -> Void) {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntitiy")

            do {
                let leagues = try context.fetch(fetchRequest)
                completion(leagues, nil)
                for league in leagues {
                    let id = league.value(forKey: "leagueKey") as? Int ?? 0
                    let name = league.value(forKey: "leagueName") as? String ?? "Unknown"
                    let sport = league.value(forKey: "sportName") as? String ?? "Unknown"
                   let logo = league.value(forKey: "leagueLogo") as? String ?? "Unknown"
                    print("League ID: \(id), Name: \(name), Sport: \(sport),logo: \(logo)")
                }
            } catch let error as NSError {
                completion(nil, error)

                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    func deleteSavedLeague(_ item: NSManagedObject,completion: @escaping (Error?) -> Void) {
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueEntitiy")
           let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

           do {
            context.delete(item)
            try context.save()
               completion(nil)
           } catch let error {
               completion(error)
               print("Error deleting saved leagues: \(error)")
           }
       }
    
    // for favorite button
    func isLeagueSaved(leagueId: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueEntitiy")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueId)
        print("---Saved To Favorite--")
        do {
            let result = try context.fetch(fetchRequest)
            return !result.isEmpty
        } catch {
            print("Error fetching league: \(error.localizedDescription)")
            return false
        }
    }

    func removeLeague(leagueId: Int) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntitiy")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueId)
        do {
            let data = try context.fetch(fetchRequest)
            for item in data {
                context.delete(item)
            }
            try context.save()
            print("Deleted league from favorite")
        } catch let error {
            print("Failed to delete league: \(error.localizedDescription)")
        }
    }

    }

