//
//  SwitchingViewController.swift
//  View Switcher
//
//  Created by admin on 2019/6/2.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {

    private var blueViewController: BlueViewController!
    private var yellowViewController: YellowViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        blueViewController=storyboard?.instantiateViewController(withIdentifier: "Blue") as? BlueViewController
        blueViewController.view.frame=view.frame
        switchViewcontroller(from: nil, to: blueViewController)
    }
    
    @IBAction func switchViews(sender: UIBarButtonItem){
        if yellowViewController?.view.superview == nil {
            if yellowViewController == nil {
                yellowViewController = storyboard?.instantiateViewController(withIdentifier: "Yellow") as? YellowViewController
            }
        }else if blueViewController?.view.superview == nil{
            if blueViewController == nil{
                blueViewController=storyboard?.instantiateViewController(withIdentifier: "Blue") as? BlueViewController
            }
        }
        
        //切换视图控制器
        if blueViewController != nil && blueViewController!.view.superview != nil {
            yellowViewController.view.frame = view.frame
            switchViewcontroller(from: blueViewController, to: blueViewController)
        }else{
            blueViewController.view.frame = view.frame
            switchViewcontroller(from: yellowViewController, to: blueViewController)
        }
    }
    
    private func switchViewcontroller(from fromVC:UIViewController?,to toVC: UIViewController?){
        if fromVC != nil {
            fromVC!.willMove(toParent: nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParent()
        }
        
        if toVC != nil {
            self.addChild(toVC!)
            self.view.insertSubview(toVC!.view, at: 0)
            toVC!.didMove(toParent: self)
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
