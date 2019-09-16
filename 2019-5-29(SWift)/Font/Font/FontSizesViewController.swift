//
//  FontSizesViewController.swift
//  Font
//
//  Created by 吉腾蛟 on 2019/9/16.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class FontSizesViewController: UITableViewController {

    var font: UIFont!
    private var pointSizes: [CGFloat] {
        struct Constants {
            static let pointSize: [CGFloat] = [
                9,10,11,12,13,14,18,24,36,48,64,72,96,144]
        }
        return Constants.pointSize
    }
    
    private let cellIdentifier = "FontNameAndSize"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
        let pointSize = pointSizes[indexPath.row]
        return font.withSize(pointSize)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pointSizes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        
        cell.textLabel?.font=fontForDisplay(atIndexPath: indexPath as NSIndexPath)
        cell.textLabel?.text=font.fontName
        cell.detailTextLabel?.text="\(pointSizes[indexPath.row]) point"
        
        return cell
    }
}
