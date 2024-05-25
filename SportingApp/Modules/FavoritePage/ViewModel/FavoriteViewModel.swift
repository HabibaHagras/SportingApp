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
        var bindResultDeleteCoreDataToViewController: (() -> ()) = {}
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
    
    
    func delete(item: NSManagedObject,completion: @escaping (Error?) -> Void) {
        coreDataServices.deleteSavedLeague(item) { [weak self] error in
            if let error = error {
                completion(error)
                return
            }
            print("Leagues deleted successfully")
            guard let index = self?.news.firstIndex(where: { $0 == item }) else {       completion(nil) 
                     return}
                self?.news.remove(at: index)
                
            
            self?.bindResultDeleteCoreDataToViewController()
            completion(nil)
        }
    }
    
    
    
    
 
    }

     
     


