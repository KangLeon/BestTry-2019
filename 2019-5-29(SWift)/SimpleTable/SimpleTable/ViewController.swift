//
//  ViewController.swift
//  SimpleTable
//
//  Created by 吉腾蛟 on 2019/9/16.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private let dwarves = ["Sleepy", "Sneezy", "Bashful", "Happy", "Doc", "Grumpy", "Dopey", "Thorin", "Dorin", "Nori", "Ori", "Balin", "Dwalin", "Fili", "Kili", "Oin", "Gloin", "Bifur", "Bofur", "Bombur"]
    
    let simpleTableIdentifier = "SimpleTableIdentidier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dwarves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: simpleTableIdentifier)
        }
        
        let image = UIImage(named: "star")
        cell?.imageView?.image=image
        let highlightedImage = UIImage(named: "star2")
        cell?.imageView?.highlightedImage=highlightedImage
        
        if indexPath.row < 7 {
            cell?.detailTextLabel?.text="Mr disney"
        }else{
            cell?.detailTextLabel?.text="Mr Tolkien"
        }
        
        cell?.textLabel?.text = dwarves[indexPath.row]
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return indexPath.row % 4
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 {
            return nil
        }else if (indexPath.row%2 == 0){
            return IndexPath(row: indexPath.row+1, section: indexPath.section)
        }else{
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowValue = dwarves[indexPath.row]
        let message = "You selected \(rowValue)"
        
        let controller = UIAlertController(title: "Row Selected", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Yes", style: .default, handler: nil)
        
        controller.addAction(action)
        
        present(controller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 120 : 70
    }
}

