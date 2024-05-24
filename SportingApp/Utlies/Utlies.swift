//
//  Utlies.swift
//  SportingApp
//
//  Created by maha on 5/24/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
class Utlies {
    
    static var currentTime:String!
    static  var futureTime:String!
    
    static var myCurrentTime:String!
    static var pastTime:String!
    
    
    
    
    static func dateForCurrentEvents(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        currentTime = dateFormatter.string(from: date)
        print(currentTime)
        var dateComponent = DateComponents()
        dateComponent.year = 1
        let LastTimeDate = Calendar.current.date(byAdding: dateComponent, to: date)
        futureTime = dateFormatter.string(from: LastTimeDate!)
        print(futureTime)
        
        
    }
    
    
    static func dateForLatestResEvents(){
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        myCurrentTime = dateFormatter.string(from: date)
        
        var dateComponent = DateComponents()
        dateComponent.month = -2
        let startLatestResultTimeDate = Calendar.current.date(byAdding: dateComponent, to: date)
         pastTime = dateFormatter.string(from: startLatestResultTimeDate!)
        
    }
    
}
