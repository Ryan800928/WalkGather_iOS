//
//  RegisterVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/8.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfNickName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var label: UILabel!
    
    let url_server = URL(string: common_url + "RegisterServlet")
    
    @IBAction func clickInsert(_ sender: Any) {

        let name = tfName.text == nil ? "" :
            tfName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let nickName = tfNickName.text == nil ? "" :
            tfNickName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = tfEmail.text == nil ? "" :
            tfEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = tfPassword.text == nil ? "" :
            tfPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPassword = tfConfirmPassword.text == nil ? "" :
            tfPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = tfPhoneNumber.text != nil ? "" :
            tfPhoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if name != "" || nickName != "" ||
            email != "" || password != "" || phone != ""{
            let register = Register(name: name, nickname: nickName, email: email, password: password, phone: phone)
            
            var requestParam = [String: String]()
            
            if password == confirmPassword {
                requestParam["action"] = "registerInsert"
                requestParam["register"] = try! String(data: JSONEncoder().encode(register), encoding: .utf8)
                
                
                executeTask(self.url_server!, requestParam) { (data, response, error) in
                    if error == nil {
                        if data != nil {
                            if let result = String(data: data!, encoding: .utf8) {
                                if let count = Int(result) {
                                    DispatchQueue.main.async {
                                        // 新增成功則回前頁
                                        if count != 0 {                                            self.navigationController?.popViewController(animated: true)
                                        } else {
                                            self.label.text = "insert fail"
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        print(error!.localizedDescription)
                    }
                }
            }else {
                print("confirmPassword not equal Password")
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        addKeyboardObserver()
    }
    
    @IBAction func didEndOnExit(_ sender: Any) { }
    
    @IBAction func touchView(_ sender: Any) {
        hideKeyboard()
    }
    
}





extension RegisterVC {
    
    func hideKeyboard() {
        tfName.resignFirstResponder()
        tfNickName.resignFirstResponder()
        tfEmail.resignFirstResponder()
        tfPassword.resignFirstResponder()
        tfConfirmPassword.resignFirstResponder()
        tfPhoneNumber.resignFirstResponder()
    }
    
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
