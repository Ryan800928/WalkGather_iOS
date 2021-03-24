//
//  NewAddGroupViewController.swift
//  WalkGather
//
//  Created by Ryan on 2021/2/4.
//

import UIKit

class NewAddGroupViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate{
    
    @IBOutlet weak var walkCoverImage: UIImageView!
    @IBOutlet weak var newAddFinishButton: UIButton!
    
    @IBOutlet weak var newAddGroupDate: UIDatePicker!
    
    @IBOutlet weak var normalSwitch: UISwitch!
    @IBOutlet weak var mediumSwitch: UISwitch!
    @IBOutlet weak var hellSwitch: UISwitch!
    
    @IBOutlet weak var naturalSwitch: UISwitch!
    @IBOutlet weak var artificialSwitch: UISwitch!
    @IBOutlet weak var mixSwitch: UISwitch!
    
    @IBOutlet weak var walkingStickSwitch: UISwitch!
    @IBOutlet weak var hikingShoesSwitch: UISwitch!
    @IBOutlet weak var waterproofBagSwitch: UISwitch!
    
    
    
    @IBOutlet weak var joinGroupTitleTextField: UITextField!
    @IBOutlet weak var numberOfPeopleTextField: UITextField!
    @IBOutlet weak var musterLocationTextField: UITextField!
    @IBOutlet weak var walkEntranceTextField: UITextField!
    @IBOutlet weak var urgentContactPersonTextField: UITextField!
    @IBOutlet weak var urgentContactPersonPhoneNumberTextField: UITextField!
    
    
    var id:Int = 0
    var groupTitle:String? = ""
    var number:String? = ""
    var date:String? = ""
    //    var mapID:Int = 0
        var memberId:Int = 0
    //    var check:Int = 0
    //    var status:Int = 0
    //    var registrationBegins:Date?
    //    var endOfRegistration:Date?
    //    var startTheParty:Date?
    //    var endOfTheParty:Date?
    var musterLocation:String? = ""
    var walkEntrance:String? = ""
    var urgentContactPerson:String? = ""
    var urgentContactPersonPhoneNumber:String? = ""
    var walkType:Int?
    var walkLevel:Int?
    var equipment:Int?
    
    let url_sever = URL(string: common_url + "PartyServlet")
    let url_serverImage = URL(string: common_url + "ImageServlet")
    var image : UIImage?
    
    @IBAction func demo(_ sender: Any) {
        joinGroupTitleTextField.text = "大坑團"
        musterLocationTextField.text = "大坑7-11"
        numberOfPeopleTextField.text = "3"
        walkEntranceTextField.text = "大坑9號步道"
        urgentContactPersonTextField.text = "Peter"
        urgentContactPersonPhoneNumberTextField.text = "042233344"
    }
    //地形難易按鈕功能
    @IBAction func difficultySwitch(_ sender: UISwitch) {
        //一樣功能寫法
        //        if sender.tag == normalSwitch.tag{
        //
        //        }
        if sender.tag == 1{
            mediumSwitch.isOn = false
            hellSwitch.isOn = false
        }else if sender.tag == 2{
            normalSwitch.isOn = false
            hellSwitch.isOn = false
        }else if sender.tag == 3{
            normalSwitch.isOn = false
            mediumSwitch.isOn = false
        }
    }
    //登山路型分類按鈕功能
    @IBAction func roadType(_ sender: UISwitch) {
        if sender.tag == 1{
            artificialSwitch.isOn = false
            mixSwitch.isOn = false
        }else if sender.tag == 2{
            naturalSwitch.isOn = false
            mixSwitch.isOn = false
        }else if sender.tag == 3{
            naturalSwitch.isOn = false
            artificialSwitch.isOn = false
        }
        
    }
    //登山裝備按鈕功能
    @IBAction func walkEquipment(_ sender: UISwitch) {
        equipment = checkEquipment()
        print("equipment: \(equipment!)")
        
        
        
    }
    
    func checkEquipment() -> Int? {
        var text = ""
        if walkingStickSwitch.isOn {
            text += "2"
        } else {
            text += "1"
        }
        
        if hikingShoesSwitch.isOn {
            text += "2"
        } else {
            text += "1"
        }
        if waterproofBagSwitch.isOn {
            text += "2"
        } else {
            text += "1"
        }
        return Int(text)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDate()
        
        if Locale.current.description.contains("TW") {
            newAddGroupDate.locale = Locale(identifier: "zh_TW")
        }
        
        joinGroupTitleTextField.delegate = self
        numberOfPeopleTextField.delegate = self
        musterLocationTextField.delegate = self
        walkEntranceTextField.delegate = self
        urgentContactPersonTextField.delegate = self
        urgentContactPersonPhoneNumberTextField.delegate = self
        
        normalSwitch.tag = 1
        mediumSwitch.tag = 2
        hellSwitch.tag = 3
        
        naturalSwitch.tag = 1
        artificialSwitch.tag = 2
        mixSwitch.tag = 3
        
        //        walkingStickSwitch.tag = 1
        //        hikingShoesSwitch.tag = 2
        //        waterproofBagSwitch.tag = 3
        
        
        /* 即使iPhone語言設為繁體中文，地區設為台灣，Locale.current仍為en_TW，導致date picker(Locale設為default)無法切換成中文日期。只好檢查Locale.current文字有包含TW者就將date picker的Locale設為zh_TW */
        print("Locale.current: \(Locale.current)")
        if Locale.current.description.contains("TW") {
            newAddGroupDate.locale = Locale(identifier: "zh_TW")
        }
        addKeyboardObserver()
        //取代開始觸控
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        
    }
    //解除鍵盤
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    //添加鍵盤監控
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //鍵盤將顯示
    @objc func keyboardWillShow(notification: Notification) {
        // 能取得鍵盤高度就讓view上移鍵盤高度，否則上移view的1/3高度
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            view.frame.origin.y = -keyboardHeight / 15
        } else {
            view.frame.origin.y = -view.frame.height / 3
        }
    }
    //鍵盤將隱藏
    @objc func keyboardWillHide(notification: Notification) {
        view.frame.origin.y = 0
    }
    //日期時間選擇
    @IBAction func newAddGroupDate(_ sender: UIDatePicker) {
        /* 準備格式化物件(中日期、短時間格式) */
        let dateFormatter = DateFormatter()
        dateFormatter.locale = newAddGroupDate.locale
        print("Locale.current: \(Locale.current)")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        /* date屬性可以取得/設定datePicker目前的日期 */
        dateFormatter.string(from: newAddGroupDate.date)
        
    }
    //選擇照片按鈕
    @IBAction func uploadPhotos(_ sender: UIButton) {
        pickSelectAlbumPhoto(type: .photoLibrary)
    }
    func pickSelectAlbumPhoto (type:UIImagePickerController.SourceType){
        //        hideKeyboard()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = type
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func newAddFinish(_ sender: Any) {
        
        
        
        let userDefaults = UserDefaults.standard
        
        memberId = userDefaults.integer(forKey: "id")
        
        groupTitle = joinGroupTitleTextField.text == nil ? "" :joinGroupTitleTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        musterLocation = musterLocationTextField.text == nil ? "" :musterLocationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        walkEntrance = walkEntranceTextField.text == nil ? "" :walkEntranceTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        urgentContactPerson = urgentContactPersonTextField.text == nil ? "" :urgentContactPersonTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        number = numberOfPeopleTextField.text == nil ? "":numberOfPeopleTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        urgentContactPersonPhoneNumber = urgentContactPersonPhoneNumberTextField.text  == nil ? "":urgentContactPersonPhoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        date = formatter.string(from: newAddGroupDate.date)
        
        if groupTitle != "" || musterLocation != "" || walkEntrance != "" ||  urgentContactPerson != "" || number != "" || urgentContactPersonPhoneNumber != "" {
            
            let party = NewAddGroup(id: id, title: groupTitle!, date: date!, musterLocation: musterLocation!, walkEntrance: walkEntrance!, number: number!, imageId: nil, urgentContactPerson: urgentContactPerson!, urgentContactPersonPhoneNumber: urgentContactPersonPhoneNumber!, walkType: walkType, walkLevel: walkLevel, equipment: equipment!)
            
            
            
            
            var requestParam = [String:String]()
            let encoder = JSONEncoder()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            encoder.dateEncodingStrategy = .formatted(format)
            
            requestParam["action"] = "partyCreate"
            requestParam["party"] = try? String(data:encoder.encode(party),encoding: .utf8)
            
            //有圖才傳
            if self.image != nil {
                requestParam["imageBase64"] = self.image!.jpegData(compressionQuality: 1.0)!.base64EncodedString()
            }
            executeTask(self.url_sever!, requestParam){ (data,response,error) in
                if error == nil {
                    if data != nil{
                        if let result = String(data:data!,encoding: .utf8){
                            if let count = Int(result){
                                DispatchQueue.main.async {
                                    //新增成功後到頁面
                                    if count != 0{
                                        self.saveDate()
                                        self.navigationController?.popViewController(animated: true)
                                        
                                    }else {
                                        print("Update Fail")
                                    }
                                }
                            }
                        }
                        
                    }
                }else {
                    print(error!.localizedDescription)
                }
                
            }
            
            
        }
        //將難易度開關值傳入後端
        if normalSwitch.isOn == true && mediumSwitch.isOn == false && hellSwitch.isOn == false {
            walkType = 1
        }else if normalSwitch.isOn == false && mediumSwitch.isOn == true && hellSwitch.isOn == false {
            walkType = 2
        }else if normalSwitch.isOn == false && mediumSwitch.isOn == false && hellSwitch.isOn == true{
            walkType = 3
            
        }
        
        if naturalSwitch.isOn == true && artificialSwitch.isOn == false && mixSwitch.isOn == false {
            walkLevel = 1
        }else if naturalSwitch.isOn == false && artificialSwitch.isOn == true && mixSwitch.isOn == false {
            walkLevel = 2
        }else if naturalSwitch.isOn == false && artificialSwitch.isOn == false && mixSwitch.isOn == true{
            walkLevel = 3
        }
        
        func getData(){
            let userDefaults = UserDefaults.standard
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
            joinGroupTitleTextField.text = userDefaults.string(forKey: "groupTitle")
            numberOfPeopleTextField.text = userDefaults.string(forKey: "number")
            if let groupDateStr = userDefaults.string(forKey: "date"), let groupDate = formatter.date(from: groupDateStr) {
                newAddGroupDate.date = groupDate
            }else{
                newAddGroupDate.date = Date()
            }
            musterLocationTextField.text = userDefaults.string(forKey: "musterLocation")
            walkEntranceTextField.text = userDefaults.string(forKey: "walkEntrance")
            urgentContactPersonTextField.text = userDefaults.string(forKey: "urgentContactPerson")
            urgentContactPersonPhoneNumberTextField.text = userDefaults.string(forKey: "urgentContactPersonPhoneNumber")
        }
    }
    func saveDate(){
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(memberId, forKey: "memberId")
        userDefaults.set(groupTitle,forKey: "groupTitle")
        userDefaults.set(number,forKey: "number")
        userDefaults.set(date, forKey: "date")
        userDefaults.set(musterLocation,forKey: "musterLocation")
        userDefaults.set(walkEntrance, forKey: "walkEntrance")
        userDefaults.set(urgentContactPerson, forKey: "urgentContactPerson")
        userDefaults.set(urgentContactPersonPhoneNumber,forKey: "urgentContactPersonPhoneNumber")
        userDefaults.set(walkType, forKey: "walkType")
        userDefaults.set(walkLevel, forKey: "walkLevel")
        userDefaults.set(equipment, forKey: "equipment")
    }
    @IBAction func createDate() {
        /* 準備格式化物件(中日期、短時間格式) */
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = newAddGroupDate.locale
//        print("Locale.current: \(Locale.current)")
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .short
//        /* date屬性可以取得/設定datePicker目前的日期 */
//        dateFormatter.string(from: newAddGroupDate.date)
        print(newAddGroupDate!)
//        date = newAddGroupDate.date
         
    }
    
    
}
extension NewAddGroupViewController {
    
    func getCover(){
        let userDefaults = UserDefaults.standard
        
        var requestParam = [String: Any]()
        requestParam["action"] = "getImage"
        requestParam["imageId"] = userDefaults.integer(forKey: "imageId")
        requestParam["imageSize"] = walkCoverImage.frame.width
        
        var image: UIImage?
        executeTask(url_serverImage!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    image = UIImage(data: data!)
                    
                    if image == nil {
                        image = UIImage(named: "nobody.jpg")
                    }
                    DispatchQueue.main.async {
                        self.walkCoverImage.image = image
                    }
                }
            }else {
                print(error!.localizedDescription)
            }
        }
    }
    //宣告照片選擇控制
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /* 利用指定的key從info dictionary取出照片 */
        if let pickedImage = info[.originalImage] as? UIImage {
            walkCoverImage.image = pickedImage
            image = pickedImage
        }
        imageUpload()
        dismiss(animated: true)
        }
        
    
    //圖像選擇器控制器沒有取消
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
                                    if let cover = self.image?.jpegData(compressionQuality: 1.0){
                                        userDefaults.set(cover, forKey: "cover")
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
    //鍵盤按return鍵盤消失(目前無反應)
    func hideKeyboard(_ textField: UITextField) -> Bool {
        joinGroupTitleTextField.resignFirstResponder()
        numberOfPeopleTextField.resignFirstResponder()
        musterLocationTextField.resignFirstResponder()
        walkEntranceTextField.resignFirstResponder()
        urgentContactPersonTextField.resignFirstResponder()
        urgentContactPersonPhoneNumberTextField.resignFirstResponder()
        
        return true
    }
    //查看view是否消失了
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
