//
//  AccountVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/6.
//

import UIKit

class AccountVC: UIViewController {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbNickName: UILabel!
    @IBOutlet weak var lbBirthday: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbGender: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbEmergency: UILabel!
    @IBOutlet weak var lbEmergencyPhone: UILabel!
    @IBOutlet weak var lbRelation: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    
    
    
    func loadData(){
        let userDefaults = UserDefaults.standard
        
        if let name = userDefaults.string(forKey: "name") {
            lbName.text = name
        }
        if let nickname = userDefaults.string(forKey: "nickname") {
            lbNickName.text = nickname
        }
        if let birthday = userDefaults.object(forKey: "birthday"){
            lbBirthday.text = birthday as? String
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

