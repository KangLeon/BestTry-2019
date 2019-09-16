//
//  ViewController.swift
//  Sections
//
//  Created by 吉腾蛟 on 2019/9/16.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
    let sectionsTableIdentifier = "SectionsTableIdentifier"
    var names: [String: [ String]]!
    var keys: [String]!
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
        
        let path = Bundle.main.path(forResource: "sortednames", ofType: "plist")
        let namesDict = NSDictionary(contentsOfFile: path!)
        names = namesDict as? [String : [String]]
        keys = (namesDict?.allKeys as? [String])?.sorted(by: <)
        
        let resultController = SearchResultTableViewController()
        resultController.names = names
        resultController.keys = keys
        searchController = UISearchController(searchResultsController: resultController)
        let searchBar = searchController.searchBar
        searchBar.scopeButtonTitles = ["All","Short","Long"]
        searchBar.placeholder = "Enter a search term"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultController
        
        tableView.sectionIndexBackgroundColor = UIColor.black
        tableView.sectionIndexTrackingBackgroundColor = UIColor.darkGray
        tableView.sectionIndexColor = UIColor.white
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        let nameSection = names[key]!
        return nameSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionsTableIdentifier, for: indexPath) as UITableViewCell
        
        let key = keys[indexPath.section]
        let nameSection = names[key]!
        
        cell.textLabel?.text=nameSection[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }
    
    
}

