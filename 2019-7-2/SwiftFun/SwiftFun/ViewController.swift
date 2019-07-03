//
//  ViewController.swift
//  SwiftFun
//
//  Created by 吉腾蛟 on 2019/7/3.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let label = UILabel()
    private let testView = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
    private let testView2 = UIView(frame: CGRect(x: 100, y: 300, width: 200, height: 200))
    private let button = UIButton(type: .detailDisclosure)
    private let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    private let textField = UITextField(frame: CGRect(x: 50, y: 100, width: 300, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor=UIColor.orange
        label.frame=CGRect(origin: CGPoint(x: 200, y: 400), size: CGSize(width: 100, height: 40))
        label.text="Hello world"
        label.font=UIFont.systemFont(ofSize: 20)
        label.textColor=UIColor.yellow
        label.textAlignment = .right
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeTextContent))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled=true
        
//        view.addSubview(label)
        
        testView.backgroundColor=UIColor.white
//        view.addSubview(testView)
//        print("view frmae is \(testView.frame)")
//        print("view.bounds is \(testView.bounds)")
        
        testView2.backgroundColor=UIColor.gray
//        view.addSubview(testView2)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(handleTap1))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(handleTap2))
        
        testView.tag=1
        testView2.tag=2
        
        testView.addGestureRecognizer(tap1)
        testView2.addGestureRecognizer(tap2)
        
        for subView in view.subviews {
            if subView.tag==1{
                print("subview`s frame \(subView.frame)")
            }
        }
        
        button.frame=CGRect(x: 50, y: 100, width: 300, height: 100)
        button.backgroundColor=UIColor.red
        button.setTitle("Hello", for: .normal)
        
        button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        
//        view.addSubview(button)
        
        imageView.backgroundColor=UIColor.red
        imageView.contentMode = .scaleAspectFit
        
//        view.addSubview(imageView);
        
        textField.backgroundColor=UIColor.clear
        textField.borderStyle = .roundedRect
        if textField.isEditing {
            print("isEditing is true")
        }else{
            print("isEditing is false")
        }
        textField.placeholder="请输入您的手机号"
        textField.clearButtonMode = .always
        textField.isSecureTextEntry = true
        textField.delegate = self
        
        view.addSubview(textField)
    }

    @objc func changeTextContent() {
        if label.text=="你好" {
            label.text="Hello world"
        }else{
            label.text="你好"
        }
    }
    
    @objc func handleTap1() {
        print("testview tag is \(testView.tag)")
    }
    
    @objc func handleTap2 () {
        print("testview2 tag is \(testView2.tag)")
    }
    
    @objc func clickAction () {
        print("点击了按钮!")
    }
}

extension ViewController: UITextFieldDelegate {
    //设置是否可以开始编辑
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    //返回键是否可按
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //结束编辑
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("text field end editing")
    }
}

