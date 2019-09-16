//
//  RootViewController.swift
//  Font
//
//  Created by 吉腾蛟 on 2019/9/16.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

    private var familyNames: [String]!
    private var cellPointSize: CGFloat!
    private var favoriteList: FavoritesList!
    private let familyCell = "FamilyName"
    private let favoritesCell = "Favorites"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        familyNames = UIFont.familyNames.sorted()
        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: .headline)
        cellPointSize = preferredTableViewFont.pointSize
        favoriteList=FavoritesList.sharedFavoriteList
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        tableView.reloadData()
    }

    func fontforDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            let fontName = UIFont.fontNames(forFamilyName: familyName).first as String?
            
            return UIFont(name: fontName ?? "Symbol", size: cellPointSize)
        }else{
            return nil
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return favoriteList.favorites.isEmpty ? 1 : 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? familyNames.count : 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All font Familys" : "My Favorite Fonts"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: familyCell, for: indexPath) as UITableViewCell
            
            cell.textLabel?.font = fontforDisplay(atIndexPath: indexPath as NSIndexPath)
            cell.textLabel?.text = familyNames[indexPath.row]
            cell.detailTextLabel?.text = familyNames[indexPath.row]
            
            return cell
        }else{
            return tableView.dequeueReusableCell(withIdentifier: favoritesCell, for: indexPath) as UITableViewCell
        }
    }

}
