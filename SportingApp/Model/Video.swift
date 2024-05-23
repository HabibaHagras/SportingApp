//
//  Video.swift
//  SportingApp
//
//  Created by habiba on 5/23/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation

struct VideoResponse: Codable {
    let success: Int
    var result: [Video]
}


struct Video  : Codable{
    var event_key : Int?
    var video_title_full :String?
    var video_title :String?
    var video_url :String?
    
    
}
