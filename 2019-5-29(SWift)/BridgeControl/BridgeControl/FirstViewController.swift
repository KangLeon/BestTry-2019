//
//  ViewController.swift
//  BridgeControl
//
//  Created by 吉腾蛟 on 2019/9/19.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var officerLabel: UILabel!
    @IBOutlet var authorizationCodeLabel: UILabel!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var warpDriveLabel: UILabel!
    @IBOutlet var warpFactorLabel: UILabel!
    @IBOutlet var favoriteTeaLabel: UILabel!
    @IBOutlet var favoriteCaptainLabel: UILabel!
    @IBOutlet var favoriteGadgetLabel: UILabel!
    @IBOutlet var favoriteAlienLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func refreshFields() {
        let defaults = UserDefaults.standard
        officerLabel.text = defaults.string(forKey: officerKey)
        authorizationCodeLabel.text = defaults.string(forKey: authorizationCodeKey)
        rankLabel.text = defaults.string(forKey: authorizationCodeKey)
        warpDriveLabel.text = defaults.bool(forKey: warpDriveKey) ? "Engaged" : "Disabled"
        warpFactorLabel.text = (defaults.object(forKey: warpFactorKey) as! NSNumber).stringValue
        favoriteTeaLabel.text = defaults.string(forKey: favoriteTeaKey)
        favoriteCaptainLabel.text = defaults.string(forKey: favoriteCaptainKey)
        favoriteGadgetLabel.text = defaults.string(forKey: favoriteGadgetKey)
        favoriteAlienLabel.text = defaults.string(forKey: favoriteAlienKey)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshFields()
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: Selector(("applicationWillEnterForeground:")), name: UIApplication.willEnterForegroundNotification, object: app)
    }
    
    func applicationWillEnterForeground(notification: NSNotification) {
        let defaults = UserDefaults.standard
        defaults.synchronize()
        refreshFields()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

