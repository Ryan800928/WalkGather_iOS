//
//  MemberVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/7.
//

import UIKit

class MemberVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func Notification(_ sender: Any) {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "Notification") {
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    
}
