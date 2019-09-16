//
//  FontInfoViewController.swift
//  Font
//
//  Created by 吉腾蛟 on 2019/9/16.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class FontInfoViewController: UIViewController {

    var font: UIFont!
    var favorite: Bool = false
    @IBOutlet weak var fontSampleLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fontSampleLabel.font=font
        fontSampleLabel.text="AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz 0123456789"
        
        fontSizeSlider.value = Float(font.pointSize)
        fontSizeLabel.text = "\(Int(font.pointSize))"
        favoriteSwitch.isOn=favorite
    }
    
    @IBAction func slideFontSize(slider: UISlider){
        let newSize = roundf(slider.value)
        fontSampleLabel.font=font.withSize(CGFloat(newSize))
        fontSizeLabel.text="\(Int(newSize))"
    }
    
    @IBAction func toggleFavorite(sender: UISwitch){
        let favoriteList = FavoritesList.sharedFavoriteList
        if sender.isOn {
            favoriteList.addFavorite(fontName: font.fontName)
        }else{
            favoriteList.removeFavorite(fontName: font.fontName)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
