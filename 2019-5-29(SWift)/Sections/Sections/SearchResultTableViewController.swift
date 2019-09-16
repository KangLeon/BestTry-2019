//
//  SearchResultTableViewController.swift
//  Sections
//
//  Created by 吉腾蛟 on 2019/9/16.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class SearchResultTableViewController: UITableViewController,UISearchResultsUpdating {
    
    let sectionsTableIdentifier = "SectionsTableIdentifier"
    var names: [String: [String]] = [String: [String]]()
    var keys: [String] = []
    var filteredNames: [String] = []
    
    private let longNameSzie = 6
    private let shortNamebuttonIndex = 1
    private let longNameButtonIndex = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString: String = searchController.searchBar.text!
        let buttonIndex = searchController.searchBar.selectedScopeButtonIndex
        filteredNames.removeAll(keepingCapacity: true)
        
        if !searchString.isEmpty {
            let filter: (String) -> Bool = {
                name in
                let nameLength = name.count
                if (buttonIndex == self.shortNamebuttonIndex && nameLength >= self.longNameSzie) || (buttonIndex == self.longNameButtonIndex && nameLength < self.longNameSzie)  {
                    return false
                }
                
                let range = name.range(of: searchString, options: .caseInsensitive, range: nil, locale: nil)
                
                return range != nil
            }
            
            for key in keys {
                let nameforKey = names[key]!
                let matches = nameforKey.filter(filter)
                filteredNames += matches
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionsTableIdentifier)
        cell?.textLabel?.text = filteredNames[indexPath.row]
        
        return cell!
    }

}
