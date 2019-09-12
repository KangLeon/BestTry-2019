//
//  CustomPickerViewController.swift
//  Pickers
//
//  Created by 吉腾蛟 on 2019/9/11.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit
import AudioToolbox

class CustomPickerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    private var images : [UIImage]!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var button : UIButton!
    
    private var winSoundID : SystemSoundID = 0
    private var crunchSoundID : SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        images = [UIImage(named: "seven")!,
                  UIImage(named: "bar")!,
                  UIImage(named: "crown")!,
                  UIImage(named: "cherry")!,
                  UIImage(named: "lemon")!,
                  UIImage(named: "apple")!
        ]
        winLabel.text = " "
    }
    
    @IBAction func spin(_ sender: Any) {
        var win = false
        var numInRow = -1
        var lastVal = -1
        
        for i in 0..<5 {
            let newValue = Int(arc4random_uniform(UInt32(images.count)))
            if newValue == lastVal {
                numInRow+=1
            }else{
                numInRow = 1
            }
            
            lastVal = newValue
            
            picker.selectRow(newValue, inComponent: i, animated: true)
            picker.reloadComponent(i)
            if numInRow >= 3 {
                win = true
            }
        }
        
        if crunchSoundID == 0 {
            let soundURL = Bundle.main.url(forResource: "crunch", withExtension: "wav")! as CFURL
            AudioServicesCreateSystemSoundID(soundURL, &crunchSoundID)
        }
        AudioServicesPlaySystemSound(crunchSoundID)
        
        if win {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.playWinSound()
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.showButton()
            }
        }
        
        button.isHidden=true
        winLabel.text = " "
    }
    
    func showButton() {
        button.isHidden = false
    }
    
    func playWinSound() {
        if winSoundID == 0 {
            let soundURL = Bundle.main.url(forResource: "win", withExtension: "wav")! as CFURL
            AudioServicesCreateSystemSoundID(soundURL, &winSoundID)
        }
        AudioServicesPlaySystemSound(winSoundID)
        winLabel.text = "WINNER!"
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            DispatchQueue.main.async {
                self.showButton()
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let image = images[row]
        let imageView = UIImageView(image: image)
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 64
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
