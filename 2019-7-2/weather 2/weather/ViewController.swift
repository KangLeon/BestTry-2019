//
//  ViewController.swift
//  weather
//
//  Created by Kevin on 6/16/18.
//  Copyright © 2018 gix. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var textDayLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    private var daily: [JSON]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
        
        Seniverse.daily { data in
            DispatchQueue.main.async {
                guard let first = data["results"].arrayValue.first else { fatalError() }
                let daily = first["daily"].arrayValue
                let today = daily.first
                
                self.highLabel.text = today?["high"].string
                self.textDayLabel.text = today?["text_day"].string
                self.locationLabel.text = first["location", "path"].string
                
                self.daily = daily
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daily?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? WeatherTableViewCell else {
            fatalError()
        }
        
        cell.transform = tableView.transform
        if let item = daily?[indexPath.row] {
            cell.configure(item)
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textDayLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    
//     -12℃
    func configure(_ item: JSON) {
        titleLabel.text = item["date"].string
        textDayLabel.text = item["text_day"].string
        highLabel.text = item["high"].stringValue + "℃"
    }
}
