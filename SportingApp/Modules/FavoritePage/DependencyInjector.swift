//
//  DependencyInjector.swift
//  SportingApp
//
//  Created by habiba on 5/23/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
import UIKit
class DependencyInjector {
    static let shared = DependencyInjector()
    private init() {}

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func resolveFavoriteViewModel() -> FavoriteViewModel {
        let coreDataServices = CoreDataServices(context: context)
        return FavoriteViewModel(coreDataServices: coreDataServices)
    }
}
