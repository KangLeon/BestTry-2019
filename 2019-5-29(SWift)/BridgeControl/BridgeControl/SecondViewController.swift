//
//  SecondViewController.swift
//  BridgeControl
//
//  Created by 吉腾蛟 on 2019/9/19.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var engineSwitch: UISwitch!
    @IBOutlet var warpFactorSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func engineSwitchTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(engineSwitch.isOn, forKey: warpDriveKey)
        defaults.synchronize()
    }
    
    @IBAction func warpSliderTouched(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(warpFactorSlider.value, forKey: warpFactorKey)
        defaults.synchronize()
    }
    
    @IBAction func settingsButtonClicked(_ sender: Any) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshFields()
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: Selector(("applicationWillEnterForeground:")), name: UIApplication.willEnterForegroundNotification, object: app)
    }
    
   func refreshFields() {
    let defaults = UserDefaults.standard
    engineSwitch.isOn = defaults.bool(forKey: warpDriveKey)
    warpFactorSlider.value = defaults.float(forKey: warpFactorKey)
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
