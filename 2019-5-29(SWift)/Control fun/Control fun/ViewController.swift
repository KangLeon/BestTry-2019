//
//  ViewController.swift
//  Control fun
//
//  Created by admin on 2019/6/1.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var numberField: UITextField!
    
    @IBOutlet weak var sliderLabel: UILabel!
    
    @IBOutlet weak var leftSwitch: UISwitch!
    @IBOutlet weak var rightSwitch: UISwitch!
    
    @IBOutlet weak var doSomethingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sliderLabel.text="50"
    }

    @IBAction func textFieldDoneEditing(_ sender: UITextField){
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTap(_ sender: UIControl){
        nameField.resignFirstResponder()
        numberField.resignFirstResponder()
    }
    
    @IBAction func sliderChange(_ sender: UISlider) {
        let progress = lroundf(sender.value)
        sliderLabel.text="\(progress)"
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        let setting = sender.isOn
        leftSwitch.setOn(setting, animated: true)
        rightSwitch.setOn(setting, animated: true)
    }
    
    @IBAction func toggleControls(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex==0 {
            leftSwitch.isHidden=false
            rightSwitch.isHidden=false
            doSomethingButton.isHidden=true
        }else{
            leftSwitch.isHidden=true
            rightSwitch.isHidden=true
            doSomethingButton.isHidden=false
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let controller=UIAlertController(title: "你确定吗？", message: nil, preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "是的，我确定！", style: .destructive) { (action) in
            let msg = self.nameField.text!.isEmpty ? "你可以松口气了，一切正常" : "你可以松口气了，\(self.nameField.text)," + "一切正常"
            
            let controller2 = UIAlertController(title: "完成了", message: msg, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "松口气", style: .cancel, handler: nil)
            
            controller2.addAction(cancelAction)
            
            self.present(controller2, animated: true, completion: nil)
        }
        
        let noAction = UIAlertAction(title: "不行", style: .cancel, handler: nil)
        
        controller.addAction(yesAction)
        controller.addAction(noAction)
        
        if let ppc = controller.popoverPresentationController {
            ppc.sourceView=sender
            ppc.sourceRect=sender.bounds
        }
        
        present(controller, animated: true, completion: nil)
    }
}

