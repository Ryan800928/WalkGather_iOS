//
//  MemberVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/7.
//

import UIKit
import GoogleSignIn
import Firebase

class MemberVC: UIViewController {
    
    @IBOutlet weak var lbNickName: UILabel!
    @IBOutlet weak var ivAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    @IBAction func btLogOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signOut: %@", signOutError)
        }
        
        let userDefaults = UserDefaults.standard
         //1.
          //userDefaults.removePersistentDomain(forName:  Bundle.main.bundleIdentifier!)
         //2.
        userDefaults.dictionaryRepresentation().forEach { (key, _) in
            userDefaults.removeObject(forKey: key)
        }
    }
    
    
    
    @IBAction func Notification(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        if userDefaults.integer(forKey: "id") >= 1 {
            if let controller = storyboard?.instantiateViewController(withIdentifier: "Notification") {
                present(controller, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "遊客", message: "請登入", preferredStyle: .alert)
            let ok = UIAlertAction(title: "確定", style: .default) { (_) in
                if let con =  self.storyboard?.instantiateViewController(withIdentifier: "Login"){
                    self.present(con, animated: true, completion: nil)
                }
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    func loadData(){
        let userDefaults = UserDefaults.standard
        
        if let nickName = userDefaults.string(forKey: "nickname") {
            lbNickName.text = nickName
        }
    }
    
    
    
    
}
