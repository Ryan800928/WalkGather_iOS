//
//  LoginVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/8.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginVC: UIViewController, GIDSignInDelegate {
    
    let url_server = URL(string: common_url + "MemberServlet")
    var member : Member!
    var auth: Auth!
    var gidSignIn: GIDSignIn!
    
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBAction func btLogin(_ sender: Any) {
                    
    let email = tfEmail.text == nil ? "" :
            tfEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = tfPassword.text == nil ? "" :
            tfPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if  validateEmail(email: email) != false || password != "" {
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
                                        self.dismiss(animated: true, completion: nil)
                                        }
                                    
                                } catch let err {
                                    print("Decode error: \(err)")
                                }
                            }
                        }
                    }
                }
            }
        }else{
            let alert = UIAlertController(title: "遊客", message: "請登入", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
        }
    }


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auth = Auth.auth()
        gidSignIn = GIDSignIn.sharedInstance()
        // 設定要跳出登入網頁
        gidSignIn.presentingViewController = self
        gidSignIn.clientID = FirebaseApp.app()?.options.clientID
        gidSignIn.delegate = self
        
        addKeyboardObserver()
        
        signInButton.layer.cornerRadius = CGFloat(10)
        signInButton.layer.borderWidth = CGFloat(5)
        signInButton.layer.borderColor = CGColor.init(red: 10, green: 10, blue: 10, alpha: 1)
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        print("sign(_:didSignInFor)")
      if let error = error {
        print("Google sign in error: \(error.localizedDescription)")
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        signInFirebase(with: credential)
        
        saveGoogleData()
    }
    
    // 使用Google帳號完成Firebase驗證
    func signInFirebase(with credential: AuthCredential) {
        auth.signIn(with: credential) { (authResult, error) in
            if error == nil {
                print("Firebase logged in, authResult: \(authResult!)")
                self.dismiss(animated: true)
            } else {
                print("Firebase login failed, error: \(error!)")
            }
        }
    }
    
    
    func saveGoogleData(){
        let userDefaults = UserDefaults.standard

        let id = auth.currentUser?.uid
        print("id: \(String(describing: id))")
        let name = auth.currentUser?.displayName
        let email = auth.currentUser?.email
        let phone = auth.currentUser?.phoneNumber
//        let photo = auth.currentUser?.photoURL
        
        userDefaults.set(id, forKey: "id")
        userDefaults.set(name, forKey: "name")
        userDefaults.set(email, forKey: "email")
        userDefaults.set(phone, forKey: "phone")
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
        userDefaults.set(imageId, forKey: "imageId")
                
    }
    
}
    


extension LoginVC {
    
    func validateEmail(email: String) -> Bool {
            if email.count == 0 {
                return false
            }
            let emailRegex = "[A-Z0-9a-z._%+-][email protected][A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailTest.evaluate(with: email)
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


