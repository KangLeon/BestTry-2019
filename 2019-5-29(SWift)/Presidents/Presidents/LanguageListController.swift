//
//  LanguageListController.swift
//  Presidents
//
//  Created by 吉腾蛟 on 2019/9/18.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class LanguageListController: UITableViewController {

    weak var detailViewController: DetailViewController? = nil
    private let languageNames: [String] = ["English", "French", "German", "Spanish"]
    private let languageCodes: [String] = ["en", "fr", "de", "es"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clearsSelectionOnViewWillAppear = false
        preferredContentSize = CGSize(width: 320, height: CGFloat(languageCodes.count * 44))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return languageCodes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = languageNames[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailViewController!.languageString = languageCodes[indexPath.row]
    }
}
