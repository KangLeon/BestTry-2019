//
//  FontListViewController.swift
//  Font
//
//  Created by 吉腾蛟 on 2019/9/16.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {

    var fontNames: [String] = []
    var showsFavorites: Bool = false
    private var cellPointSize: CGFloat!
    private let cellIdentifier = "FontName"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: .headline)
        cellPointSize = preferredTableViewFont.pointSize
        
        if showsFavorites {
            navigationItem.rightBarButtonItem = editButtonItem
        }
    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
        let fontName = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointSize)!
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fontNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
        cell.textLabel?.text = fontNames[indexPath.row]
        cell.detailTextLabel?.text = fontNames[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return showsFavorites
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if !showsFavorites {
            return
        }
        
        if editingStyle == .delete {
            let favorite = fontNames[indexPath.row]
            FavoritesList.sharedFavoriteList.removeFavorite(fontName: favorite)
            fontNames = FavoritesList.sharedFavoriteList.favorites
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        FavoritesList.sharedFavoriteList.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        
        fontNames = FavoritesList.sharedFavoriteList.favorites
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if showsFavorites {
            fontNames = FavoritesList.sharedFavoriteList.favorites
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: tableViewCell)
        let font = fontForDisplay(atIndexPath: indexPath! as NSIndexPath)
        
        if segue.identifier == "ShowFontSizes" {
            let sizeVC = segue.destination as! FontSizesViewController
            sizeVC.title = font.fontName
            sizeVC.font = font
        }else{
            let infoVC = segue.destination as! FontInfoViewController
            infoVC.font = font
            infoVC.favorite = FavoritesList.sharedFavoriteList.favorites.contains(font.fontName)
            
        }
    }
    
    
}
