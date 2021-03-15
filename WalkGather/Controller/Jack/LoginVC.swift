//
//  LoginVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/8.
//

import UIKit

class LoginVC: UIViewController {
    
    var member : Member!
        
    let url_server = URL(string: common_url + "MemberServlet")
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
        
    @IBAction func btLogin(_ sender: Any) {
            
    let email = tfEmail.text == nil ? "" :
            tfEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = tfPassword.text == nil ? "" :
            tfPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if email != "" || password != "" {
            let member = Member(email: email, password: password)

            var requestParam = [String: String]()

            requestParam["action"] = "memberLogin"
            requestParam["member"] = try! String(data: JSONEncoder().encode(member), encoding: .utf8)

            executeTask(self.url_server!, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        // 將輸入資料列印出來除錯用
                        print("input: \(String(data: data!, encoding: .utf8)!)")
                        
                        if let download = try? JSONDecoder().decode([String : String].self, from: data!){
                            if let memberStr = download["member"]{
                                let memberData = Data(memberStr.utf8)
                                do {
                                    self.member = try JSONDecoder().decode(Member.self, from: memberData)
                                    
                                    self.saveData()
                                    
                                    DispatchQueue.main.async {
                                        self.navigationController?.popViewController(animated: true)
                                    }
                                    
                                    print("member_ID \(member.id)")
                                } catch let err {
                                    print("Decode error: \(err)")
                                }
                            }
                        }
//                        self.saveData()
                        
//                        if let result = try? JSONDecoder().decode(Login.self, from: data!) {
//                                DispatchQueue.main.async {
//                                        self.navigationController?.popViewController(animated: true)
//                                }
//                            print("result: \(result)")
//                            self.login = result
//                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObserver()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    func saveData(){
        let userDefaults = UserDefaults.standard
        
        let id = member?.id
        let name = member?.name
        let nickname = member?.nickname
        let birthday = member?.birthday?.prefix(10)
        let gender = member?.gender
        let email = member?.email
        let phone = member?.phone
        let emergency = member?.emergency
        let relation = member?.relation
        let emergencyPhone = member?.emergencyPhone
        let imageId = member?.imageId
        
        
        userDefaults.set(id, forKey: "id")
        userDefaults.set(name, forKey: "name")
        userDefaults.set(nickname, forKey: "nickname")
        userDefaults.set(birthday, forKey: "birthday")
        userDefaults.set(gender, forKey: "gender")
        userDefaults.set(email, forKey: "email")
        userDefaults.set(phone, forKey: "phone")
        userDefaults.set(emergency, forKey: "emergency")
        userDefaults.set(relation, forKey: "relation")
        userDefaults.set(emergencyPhone, forKey: "emergencyPhone")
        userDefaults.set(imageId, forKey: "ImageId")
        
        print("name \(userDefaults.string(forKey: "name"))")
        
    }
    
}
    


extension LoginVC {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        // 能取得鍵盤高度就讓view上移鍵盤高度，否則上移view的1/3高度
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            view.frame.origin.y = -keyboardHeight / 2
        } else {
            view.frame.origin.y = -view.frame.height / 3
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        view.frame.origin.y = 0
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}


