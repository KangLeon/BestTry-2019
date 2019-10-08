//
//  ProgressViewController.swift
//  CALayer
//
//  Created by 吉腾蛟 on 2019/10/8.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {

    let slider = UISlider(frame: CGRect.zero)
    
    let layerOne = CALayer()
    let layerTwo = CALayer()
    let layerThree = CALayer()
    let layerFour = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.slider)
        self.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        self.view.layer.addSublayer(layerOne)
        self.view.layer.addSublayer(layerTwo)
        self.view.layer.addSublayer(layerThree)
        self.view.layer.addSublayer(layerFour)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.slider.frame = CGRect(x: 50, y: 70, width: self.view.frame.width-100.0, height: 30)
        
        let lWH : CGFloat = 100
        let horSpace = (self.view.frame.width - 2*lWH) / 3
        
        self.layerOne.frame = CGRect(x: horSpace, y: 110, width: lWH, height: lWH)
        self.layerTwo.frame = CGRect(x: horSpace*2+lWH, y: 110, width: lWH, height: lWH)
        self.layerThree.frame = CGRect(x: horSpace, y: 110+lWH+30, width: lWH, height: lWH)
        self.layerFour.frame = CGRect(x: horSpace*2+lWH, y: 110+lWH+30, width: lWH, height: lWH)
    }
    
    @objc func sliderValueChanged() {
        
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

class ProgressLayer: CALayer {
    <#code#>
}
