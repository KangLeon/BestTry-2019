//
//  Seniverse.swift
//  SwiftWether
//
//  Created by 吉腾蛟 on 2019/7/3.
//  Copyright © 2019 JY. All rights reserved.
//

//https://api.seniverse.com/v3/weather/daily.json?key=SFtKp14pi5P89u_dv&language=en&location=shanghai&start=0&days=5

import Foundation
import SwiftyJSON

struct Seniverse {
    static func daily(completionHandler: @escaping (JSON) -> ()) {
        guard let url = URL(string: "https://api.seniverse.com/v3/weather/now.json?key=SFtKp14pi5P89u_dv&location=shanghai&&start=0&days=3") else {
            fatalError()
        }
        
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
            
            debugPrint("last_ update =" + first["last_update"].stringValue)
            debugPrint("location_name=" + first["location", "name"].stringValue)
            
            completionHandler(json)
        }
        
        task.resume()
    }
}
