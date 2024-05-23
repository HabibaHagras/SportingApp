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
    private let coreDataServices: CoreDataServices
    var news: [NSManagedObject] = []
    var bindResultCoreDataToViewController :(()->()) = {}

 //   var news: [NewsViewModel] = []//
    
    init(coreDataServices: CoreDataServices) {
        self.coreDataServices = coreDataServices
    }
    
    func fetchData(completion: @escaping (Error?) -> Void) {
        coreDataServices.fetchData { [weak self] (fetchedItems, error) in
            if let error = error {
                completion(error)
                return
            }
            
            // Assuming your entity is called "News"
            self?.news = fetchedItems!
            self?.bindResultCoreDataToViewController()
            completion(nil)
        }
    }
    
    
    
    
}
