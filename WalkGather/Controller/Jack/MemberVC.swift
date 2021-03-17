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
    
    let url_server = URL(string: common_url + "MemberServlet")
    
    @IBOutlet weak var lbNickName: UILabel!
    @IBOutlet weak var ivAvatar: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        
        if userDefaults.integer(forKey: "id") >= 1 {
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
        
        loadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAvatar()
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
    
    
    
    func getAvatar(){
        let userDefaults = UserDefaults.standard
        
        var requestParam = [String: Any]()
        requestParam["action"] = "getImage"
        requestParam["id"] = userDefaults.integer(forKey: "id")
        requestParam["imageSize"] = ivAvatar.frame.width
        
        var image: UIImage?
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    image = UIImage(data: data!)
                    
                    if image == nil {
                        image = UIImage(named: "nobody.jpg")
                    }
                    DispatchQueue.main.async {
                        self.ivAvatar.image = image
                    }
                }
            }else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    func loadData(){
        let userDefaults = UserDefaults.standard
        
        if let image = userDefaults.data(forKey: "avatar"){
            ivAvatar.image = UIImage(data: image)
        }
        
        if let nickName = userDefaults.string(forKey: "nickname") {
            lbNickName.text = nickName
        }
    }
    
    
    
    
}
