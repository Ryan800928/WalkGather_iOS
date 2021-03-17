//
//  AccountVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/6.
//

import UIKit

class AccountVC: UIViewController {
    let userDefaults = UserDefaults.standard
    
    let url_serverMember = URL(string: common_url + "MemberServlet")
    let url_serverImage = URL(string: common_url + "ImageServlet")
    
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbNickName: UILabel!
    @IBOutlet weak var lbBirthday: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbGender: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbEmergency: UILabel!
    @IBOutlet weak var lbEmergencyPhone: UILabel!
    @IBOutlet weak var lbRelation: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {

        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        getAvatar()
        loadData()
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
    
    
    
    func loadData(){
        let userDefaults = UserDefaults.standard
        
        if let image = userDefaults.data(forKey: "avatar"){
            ivAvatar.image = UIImage(data: image)
        }
        
        if let name = userDefaults.string(forKey: "name") {
            lbName.text = name
        }
        if let nickname = userDefaults.string(forKey: "nickname") {
            lbNickName.text = nickname
        }
        if let birthday = userDefaults.string(forKey: "birthday"){
            lbBirthday.text = birthday
        }
        if let email = userDefaults.string(forKey: "email"){
            lbEmail.text = email
        }
        if let gender = userDefaults.string(forKey: "gender"){
            if gender == "0" {
                lbGender.text = "男性"
            }
            if gender == "1" {
                lbGender.text = "女性"
            }
            if gender == "2" {
                lbGender.text = "第三性"
            }
        }
        if let phone = userDefaults.string(forKey: "phone"){
            lbPhone.text = phone
        }
        if let emergency = userDefaults.string(forKey: "emergency"){
            lbEmergency.text = emergency
        }
        if let emergencyPhone = userDefaults.string(forKey: "emergencyPhone"){
            lbEmergencyPhone.text = emergencyPhone
        }
        if let relation = userDefaults.string(forKey: "relation"){
            lbRelation.text = relation
        }
            
    }

}

