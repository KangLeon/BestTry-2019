//
//  RootViewController.swift
//  Presidents
//
//  Created by 吉腾蛟 on 2019/9/19.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let spliVC = viewControllers[0] as UIViewController
        let newTraits = traitCollection
        
        if newTraits.horizontalSizeClass == .compact && newTraits.verticalSizeClass == .compact {
            let childTraits = UITraitCollection(horizontalSizeClass: .regular)
            setOverrideTraitCollection(childTraits, forChild: spliVC)
        }else{
            setOverrideTraitCollection(nil, forChild: spliVC)
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
