//
//  NetworkServices.swift
//  SportingApp
//
//  Created by habiba on 5/18/24.
//  Copyright © 2024 habiba. All rights reserved.
//
import Foundation
import Alamofire
//func fetchLeagues(for sport: String, handler: @escaping (LeagueResponse?) -> Void) {
//let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=c89682f0a5d6ea43d1961761ea5adfb507df5320a61e1918ed0781e03ad20081&fbclid=IwZXh0bgNhZW0CMTAAAR3O-bHItUbdiNodf1zmAi48ZNdhsGe46gNYq972gXP-i-XPCsH--77FzX4_aem_AU8yYQORBt5XB1HWT_K3V6a4Zba6exdup7WqhG7ZbImoNE5nf3tt1KmwX3vtuLlQWPmZqksrypWvPPLjjMjhBU51"
//
//guard let url = URL(string: urlString) else {
//    print("Invalid URL")
//    handler(nil)
//    return
//}
//
//    let req = URLRequest(url: url)
//    let session = URLSession(configuration: .default)
//    let task = session.dataTask(with: req) { data, response, error in
//        if let error = error {
//            print("Error during data task: \(error.localizedDescription)")
//            handler(nil)
//            return
//        }
//
//        guard let data = data else {
//            print("No data received")
//            handler(nil)
//            return
//        }
//
//        do {
//            let leagueResponse = try JSONDecoder().decode(LeagueResponse.self, from: data)
//            handler(leagueResponse)
//            print(leagueResponse)
//        } catch {
//            print("Error decoding JSON: \(error.localizedDescription)")
//            print("Data:", data)
//
//            handler(nil)
//        }
//    }
//https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=15217216adc4a8d0eb9fc199593c980ada1693e793d69f681e94a7685b0359b4
//    task.resume()
//}
class NetworkServices {

static func fetchLeagues(for sport: String, handler: @escaping (LeagueResponse?) -> Void) {
    let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=15217216adc4a8d0eb9fc199593c980ada1693e793d69f681e94a7685b0359b4"

    Alamofire.request(urlString).responseJSON { response in
        switch response.result {
        case .success(let value):
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                let leagueResponse = try JSONDecoder().decode(LeagueResponse.self, from: jsonData)
                handler(leagueResponse)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                handler(nil)
            }
        case .failure(let error):
            print("Error fetching leagues: \(error.localizedDescription)")
            handler(nil)
        }
    }
}
    
    
    
    static func fetchVideos(for sport: String, handler: @escaping (VideoResponse?) -> Void) {
        let urlString = "https://apiv2.allsportsapi.com/\(sport)/?&met=Videos&eventId=86392&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644"

        Alamofire.request(urlString).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let videoResponse = try JSONDecoder().decode(VideoResponse.self, from: jsonData)
                    handler(videoResponse)
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    handler(nil)
                }
            case .failure(let error):
                print("Error fetching leagues: \(error.localizedDescription)")
                handler(nil)
            }
        }
    }
    
    func fetchData<T: Decodable>(url: String, handler: @escaping (T?) -> Void) {
    Alamofire.request(url).responseJSON { response in
        switch response.result {
        case .success(let value):
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                let leagueResponse = try JSONDecoder().decode(T.self, from: jsonData)
                handler(leagueResponse)
                print("success")
                // print(leagueResponse.result?[0] ?? "not received")
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                handler(nil)
            }
        case .failure(let error):
            print("Error fetching leagues: \(error.localizedDescription)")
            handler(nil)
        }
    }
    
    }
}
