//
//  FavoriteViewModel.swift
//  SportingApp
//
//  Created by habiba on 5/23/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
import CoreData
class FavoriteViewModel {
      var news: [NSManagedObject] = []
        var bindResultCoreDataToViewController: (() -> ()) = {}
        let coreDataServices: CoreDataServices 
        
        init(coreDataServices: CoreDataServices) {
            self.coreDataServices = coreDataServices
        }
        
        func fetchData(completion: @escaping (Error?) -> Void) {
            coreDataServices.FetchSavedLeagues{ [weak self] (fetchedItems, error) in
                if let error = error {
                    completion(error)
                    return
                }
                print("fffffffffffffffffff")
             self?.news = fetchedItems ?? []
                self?.bindResultCoreDataToViewController()
                completion(nil)
            }
        }
     
     }


