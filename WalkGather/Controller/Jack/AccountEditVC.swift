//
//  AccountEditVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/10.
//

import UIKit

class AccountEditVC: UIViewController {
    
    let datePicker = UIDatePicker()

    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfNickName: UITextField!
    @IBOutlet weak var tfBirthday: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfEmergency: UITextField!
    @IBOutlet weak var tfEmergencyPhnoe: UITextField!
    @IBOutlet weak var tfRelation: UITextField!
    
    var id : Int = 0
    var name : String = ""
    var nickname : String = ""
    var birthday : String = ""
    var phone : String = ""
    var emergency : String = ""
    var emergencyPhone : String = ""
    var relation : String = ""
    
    let url_server = URL(string: common_url + "MemberServlet")
    
    @IBAction func clickEdit(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        
        id = userDefaults.integer(forKey: "id")
        
        name = tfName.text == nil ? "" :
            tfName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        nickname = tfNickName.text == nil ? "" :
            tfNickName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        birthday = tfBirthday.text!
        phone = tfPhone.text == nil ? "" :
            tfPhone.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        emergency = tfEmergency.text == nil ? "" :
            tfEmergency.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        emergencyPhone = tfEmergencyPhnoe.text == nil ? "" :
            tfEmergencyPhnoe.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        relation = tfRelation.text == nil ? "" :
            tfRelation.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if  name != "" || nickname != "" || birthday != "" ||
            phone != "" || emergency != "" || emergencyPhone != "" || relation != ""{
            
            let member = Member(id:id, name:name, nickname:nickname, birthday:birthday, phone:phone, emergency:emergency, emergencyPhone:emergencyPhone, relation:relation)
            
            var requestParam = [String: String]()
            
            requestParam["action"] = "memberUpdate"
            requestParam["member"] = try! String(data: JSONEncoder().encode(member), encoding: .utf8)
            
            executeTask(self.url_server!, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        if let result = String(data: data!, encoding: .utf8) {
                            if let count = Int(result) {
                                DispatchQueue.main.async {
                                    // 新增成功則回前頁
                                    if count != 0 {
                                        self.saveData()
                                        
                                        self.navigationController?.popToRootViewController(animated: true)
                                        
                                    } else {
                                        print("Update Fail")
                                    }
                                }
                            }
                        }
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        tfBirthday.adjustsFontSizeToFitWidth = true
        tfBirthday.text = "選擇生日"
        addKeyboardObserver()
    }
    
    
    func saveData(){
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(id, forKey: "id")
        userDefaults.set(name, forKey: "name")
        userDefaults.set(nickname, forKey: "nickname")
        userDefaults.set(birthday, forKey: "birthday")
        userDefaults.set(phone, forKey: "phone")
        userDefaults.set(emergency, forKey: "emergency")
        userDefaults.set(relation, forKey: "relation")
        userDefaults.set(emergencyPhone, forKey: "emergencyPhone")
    }
    
    
}





extension AccountEditVC {
    
    func createDatePicker(){
            //建立toolbar
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.isUserInteractionEnabled = true
            let doneButton = UIBarButtonItem(title:"完成",style:.done, target: self, action: #selector(donePressed))
            let spaceButton = UIBarButtonItem(barButtonSystemItem:.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "取消", style:.plain, target: self, action: #selector(cancelPressed))
            
            toolBar.setItems([cancelButton,spaceButton,doneButton], animated: true)

        //建立datePicker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = UIColor.white
        datePicker.locale = Locale(identifier: "zh_TW")
        tfBirthday.inputAccessoryView = toolBar
        tfBirthday.inputView = datePicker
        tfBirthday.textAlignment = .center
    }
    
        
        @objc func donePressed (){
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.dateFormat = "yyyy/MM/dd"

            self.tfBirthday.text = formatter.string(from: datePicker.date)
            self.view.endEditing(true)

        }
        
        @objc func cancelPressed(){
            tfBirthday.resignFirstResponder()
            self.view.autoresizesSubviews = false
        }
    


    
    
    
    
//    func hideKeyboard() {
//        tfName.resignFirstResponder()
//        tfNickName.resignFirstResponder()
//        tfBirthday.resignFirstResponder()
//        tfPhone.resignFirstResponder()
//        tfEmergency.resignFirstResponder()
//        tfEmergencyPhnoe.resignFirstResponder()
//        tfRelation.resignFirstResponder()
//    }
    
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
