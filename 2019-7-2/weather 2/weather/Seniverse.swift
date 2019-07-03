//
//  Seniverse.swift
//  weather
//
//  Created by Kevin on 6/19/18.
//  Copyright © 2018 gix. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Seniverse {
    
    static func daily(completionHandler: @escaping (JSON) -> () ) {
        // 1.
        guard let url = URL(string: "https://api.seniverse.com/v3/weather/daily.json?key=0vqagh2b5b5rcws7&language=en&location=shanghai&start=0&days=5") else {
            fatalError()
        }
        // 2.
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let jsonData = data else {
                fatalError()
            }
            
            guard let json = try? JSON(data: jsonData) else {
                fatalError()
            }
            
            debugPrint(json)
            guard let first = json["results"].arrayValue.first else {
                fatalError()
            }
            
            debugPrint("last_update = " + first["last_update"].stringValue)
            debugPrint("locatioin-name = " + first["location", "name"].stringValue)
            
            completionHandler(json)
        }
        task.resume()
    }
}
