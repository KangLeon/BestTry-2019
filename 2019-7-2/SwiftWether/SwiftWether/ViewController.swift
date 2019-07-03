//
//  ViewController.swift
//  SwiftWether
//
//  Created by 吉腾蛟 on 2019/7/3.
//  Copyright © 2019 JY. All rights reserved.
//

//SFtKp14pi5P89u_dv

//https://api.seniverse.com/v3/weather/daily.json?key=SFtKp14pi5P89u_dv&language=en&location=shanghai&start=0&days=5

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Seniverse.daily { data in
            DispatchQueue.main.async {
                guard let first = data["results"].arrayValue.first else {
                    fatalError()
                }
                let daily = first["daily"].arrayValue
                let today = daily.first
                
                
            }
        }
    }


}

