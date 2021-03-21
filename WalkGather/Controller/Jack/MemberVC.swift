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
    var auth : Auth!

    let url_serverMember = URL(string: common_url + "MemberServlet")
    let url_serverImage = URL(string: common_url + "ImageServlet")
    
    @IBOutlet weak var lbNickName: UILabel!
    @IBOutlet weak var ivAvatar: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        loadDataAndCheck()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbNickName.text = ""
        getAvatar()
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
        
        ivAvatar.image = UIImage(named: "nobody.jpg")
        lbNickName.text = ""
        
        loadDataAndCheck()
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
        requestParam["imageId"] = userDefaults.integer(forKey: "imageId")
        requestParam["imageSize"] = ivAvatar.frame.width
        
        var image: UIImage?
        executeTask(url_serverImage!, requestParam) { (data, response, error) in
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
    
    
    func loadDataAndCheck(){
        let userDefaults = UserDefaults.standard
        
        if userDefaults.integer(forKey: "id") >= 1 || userDefaults.string(forKey: "id") != nil {
            
            _ = UIAlertController(title: "會員", message: "登入成功", preferredStyle: .alert)
            
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
        
        if let image = userDefaults.data(forKey: "avatar"){
            ivAvatar.image = UIImage(data: image)
        }
        if let nickName = userDefaults.string(forKey: "nickname") {
            lbNickName.text = nickName
        }
    }
    
    
    
    
}
