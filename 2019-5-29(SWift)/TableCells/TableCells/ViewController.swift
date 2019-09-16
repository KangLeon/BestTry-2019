//
//  ViewController.swift
//  TableCells
//
//  Created by 吉腾蛟 on 2019/9/16.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
    let cellTableIdentifier = "CellTableIdentifier"
    @IBOutlet var tableView: UITableView!
    let computers = [
    ["Name" : "MacBook Air","Color" : "Silver"],
    ["Name" : "MacBook Pro","Color" : "Silver"],
    ["Name" : "iMac","Color" : "Silver"],
    ["Name" : "Mac Mini","Color" : "Silver"],
    ["Name" : "Mac Pro","Color" : "Black"]]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return computers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTableIdentifier, for: indexPath) as! NameAndColorCell
        let rowData = computers[indexPath.row]
        cell.name = rowData["Name"]!
        cell.color = rowData["Color"]!
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(NameAndColorCell.self, forCellReuseIdentifier: cellTableIdentifier)
    }


}

