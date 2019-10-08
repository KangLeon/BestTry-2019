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
    
    let layerOne = ProgressLayer()
    let layerTwo = ProgressLayer()
    let layerThree = ProgressLayer()
    let layerFour = ProgressLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.slider)
        self.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        self.view.layer.addSublayer(layerOne)
        self.layerOne.number = 0.0
        self.view.layer.addSublayer(layerTwo)
        self.layerTwo.number = 0.0
        self.view.layer.addSublayer(layerThree)
        self.layerThree.number = 0.0
        self.view.layer.addSublayer(layerFour)
        self.layerFour.number = 0.0
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
        self.layerOne.number = Double(self.slider.value)
        self.layerTwo.number = Double(self.slider.value)
        self.layerThree.number = Double(self.slider.value)
        self.layerFour.number = Double(self.slider.value)
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

//圆形进度条的父类，用于显示百分比文本
class ProgressLayer: CALayer {
    var number : Double = 0.0{
        didSet{
            self.tLayer.string = String(format: "%.01f", number*100)
            self.tLayer.setNeedsDisplay()
        }
    }
    
    let tLayer : CATextLayer = {
        let labelLayer = CATextLayer()
        let font = UIFont.systemFont(ofSize: 12)
        labelLayer.font = font.fontName as CFTypeRef
        labelLayer.fontSize = font.pointSize
        labelLayer.alignmentMode = .center
        labelLayer.foregroundColor = UIColor.black.cgColor
        labelLayer.contentsScale = UIScreen.main.scale
        labelLayer.isWrapped = true
        labelLayer.string = ""
        return labelLayer
    }()
    
    override init() {
        super.init()
        self.addSublayer(tLayer)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        let th = NSString(string: "100%").boundingRect(with: CGSize(width: CGFloat.infinity, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12)], context: nil).height
        
        self.tLayer.frame = CGRect(x: 0, y: self.frame.height*0.5-th*0.5, width: self.frame.width, height: th)
        
        
    }
}
