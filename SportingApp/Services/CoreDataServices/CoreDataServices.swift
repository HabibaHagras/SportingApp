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
               let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "News")
               
               do {
                   let fetchedItems = try context.fetch(fetchRequest)
                   completion(fetchedItems, nil)
               } catch let error {
                   completion(nil, error)
               }
           }
       
        
       
    }
