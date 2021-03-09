//
//  LoginVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/8.
//

import UIKit

class LoginVC: UIViewController {
    
    var members = [Member]()
    
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

                        if let result = try? JSONDecoder().decode([Member].self, from: data!) {
                            self.members = result

                            DispatchQueue.main.async {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObserver()
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


