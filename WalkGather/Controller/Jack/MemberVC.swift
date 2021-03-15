//
//  MemberVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/7.
//

import UIKit

class MemberVC: UIViewController {
    @IBOutlet weak var lbNickName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    @IBAction func btLogOut(_ sender: Any) {
        let userDefaults = UserDefaults.standard
//        //1.
//        userDefaults.removePersistentDomain(forName:  Bundle.main.bundleIdentifier!)
        
        //2.
        userDefaults.dictionaryRepresentation().forEach { (key, _) in
            userDefaults.removeObject(forKey: key)
        }
        
    }
    
    
    
    @IBAction func Notification(_ sender: Any) {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "Notification") {
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    
    
    func loadData(){
        let userDefaults = UserDefaults.standard
        
        if let nickName = userDefaults.string(forKey: "nickname") {
            lbNickName.text = nickName
        }
    }
    
    
    
    
}
