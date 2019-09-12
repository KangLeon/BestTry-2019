//
//  DependentComponentPickerViewController.swift
//  Pickers
//
//  Created by 吉腾蛟 on 2019/9/11.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class DependentComponentPickerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == stateComponent {
            return states.count
        }else{
            return zips.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == stateComponent {
            return states[row]
        }else{
            return zips[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == stateComponent {
            let selectedState = states[row]
            zips = stateZips[selectedState]
            dependentPicker.reloadComponent(zipComponent)
            dependentPicker.selectRow(0, inComponent: zipComponent, animated: true)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickerWidth = pickerView.bounds.size.width
        
        if component == stateComponent {
            return 2*pickerWidth/3
        }else{
            return pickerWidth/3
        }
    }
    
    @IBOutlet weak var dependentPicker: UIPickerView!
    private let stateComponent = 0
    private let zipComponent = 1
    private var stateZips : [String : [String]]!
    private var states : [String]!
    private var zips : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let bundle = Bundle.main
        let plistURL = bundle.url(forResource: "statedictionary", withExtension: "plist")
        stateZips = NSDictionary(contentsOf: plistURL!) as? [String : [String]]
        
        let allStates = stateZips.keys
        states = allStates.sorted()
        
        let selectedState = states[0]
        zips = stateZips[selectedState]
        
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let stateRow = dependentPicker.selectedRow(inComponent: stateComponent)
        let zipRow = dependentPicker.selectedRow(inComponent: zipComponent)
        
        let state = states[stateRow]
        let zip = zips[zipRow]
        
        let title = "您选择的邮政编码是：\(zip)"
        
        let message = "\(zip) is in \(state)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
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
