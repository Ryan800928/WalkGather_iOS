//
//  AccountEditVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/10.
//

import UIKit

class AccountEditVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var image : UIImage?
    
    let  userDefaults = UserDefaults.standard
    
    let url_serverMember = URL(string: common_url + "MemberServlet")
    let url_serverImage = URL(string: common_url + "ImageServlet")
    let datePicker = UIDatePicker()

    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfNickName: UITextField!
    @IBOutlet weak var dpBirthday: UIDatePicker!
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
    
    
    @IBAction func clickPickImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()

        imagePicker.delegate = self
        /* 照片來源為相簿 */
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func clickEdit(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        
        id = userDefaults.integer(forKey: "id")
        
        name = tfName.text == nil ? "" :
            tfName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        nickname = tfNickName.text == nil ? "" :
            tfNickName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        birthday = formatter.string(from: dpBirthday.date)
        
        phone = tfPhone.text == nil ? "" :
            tfPhone.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        emergency = tfEmergency.text == nil ? "" :
            tfEmergency.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        emergencyPhone = tfEmergencyPhnoe.text == nil ? "" :
            tfEmergencyPhnoe.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        relation = tfRelation.text == nil ? "" :
            tfRelation.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if  name != "" || nickname != "" ||
            phone != "" || emergency != "" || emergencyPhone != "" || relation != ""{
            
            let member = Member(id:id, name:name, nickname:nickname, birthday:birthday, phone:phone, emergency:emergency, emergencyPhone:emergencyPhone, relation:relation)
            print("birthday: \(String(describing: birthday))")
            
            var requestParam = [String: String]()
            
            requestParam["action"] = "memberUpdate"
            requestParam["member"] = try! String(data: JSONEncoder().encode(member), encoding: .utf8)
            
            executeTask(self.url_serverMember!, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        if let result = String(data: data!, encoding: .utf8) {
                            if let count = Int(result) {
                                DispatchQueue.main.async {
                                    
                                    if count != 0 {
                                        self.saveData()
                                        self.navigationController?.popViewController(animated: true)
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
        }else{
            let alert = UIAlertController(title: "未填寫", message: "請全部填寫完再送出哦～", preferredStyle: .alert)
            let ok = UIAlertAction (title: "確定", style: .default)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
    }
}
        
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        getAvatar()
        addKeyboardObserver()
    }
    
    
    func getData(){
        let userDefaults = UserDefaults.standard
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"

        tfName.text = userDefaults.string(forKey: "name")
        tfNickName.text = userDefaults.string(forKey: "nickname")
        if let birthdayStr = userDefaults.string(forKey: "birthday"), let birthday = formatter.date(from: birthdayStr) {
            dpBirthday.date = birthday
        }else{
            dpBirthday.date = Date()
        }
        tfPhone.text = userDefaults.string(forKey: "phone")
        tfEmergency.text = userDefaults.string(forKey: "emergency")
        tfEmergencyPhnoe.text = userDefaults.string(forKey: "emergencyPhone")
        tfRelation.text = userDefaults.string(forKey: "relation")
    }
    
    
    func saveData(){
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(id, forKey: "id")
        userDefaults.set(name, forKey: "name")
        userDefaults.set(nickname, forKey: "nickname")
        userDefaults.set(birthday.prefix(10), forKey: "birthday")
        userDefaults.set(phone, forKey: "phone")
        userDefaults.set(emergency, forKey: "emergency")
        userDefaults.set(relation, forKey: "relation")
        userDefaults.set(emergencyPhone, forKey: "emergencyPhone")
    }
    
    
}





extension AccountEditVC {
    
    func getAvatar(){
        let userDefaults = UserDefaults.standard
        
        var requestParam = [String: Any]()
        requestParam["action"] = "getImage"
        requestParam["id"] = userDefaults.integer(forKey: "id")
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
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /* 利用指定的key從info dictionary取出照片 */
        if let pickedImage = info[.originalImage] as? UIImage {
            ivAvatar.image = pickedImage
            image = pickedImage
        }
        imageUpload()
        dismiss(animated: true)
    }
    
    /* 挑選照片過程中如果按了Cancel，關閉挑選畫面 */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    
    func imageUpload() {
        let userDefaults = UserDefaults.standard
        
        var requestParam = [String: Any]()
        requestParam["action"] = "setImage"
        requestParam["id"] = Int(userDefaults.integer(forKey: "id"))
        if image != nil {
            requestParam["imageBase64"] = image!.jpegData(compressionQuality: 1.0)!.base64EncodedString()
        }
        executeTask(url_serverImage!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    if let result = String(data: data!, encoding: .utf8) {
                        print("data \(String(describing: data))")
                        if let count = Int(result) {
                            print("count: \(count)")
                            DispatchQueue.main.async {
                                if count != 0 {
                                    print("setImage Success")
                                    if let avatar = self.image?.jpegData(compressionQuality: 1.0){
                                        userDefaults.set(avatar, forKey: "avatar")
                                    }
                                }
                            else{
                                print("SetImage Fail")
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
