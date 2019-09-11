//
//  BlueViewController.swift
//  View Switcher
//
//  Created by admin on 2019/6/2.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func blueButtonPressed(sender: UIButton){
        let alert = UIAlertController(title: "Blue View button Pressed", message: "You pressed the button on the blue view", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yep, I did", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
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
