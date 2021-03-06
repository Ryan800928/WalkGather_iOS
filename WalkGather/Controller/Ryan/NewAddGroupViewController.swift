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
        joinGroupTitleTextField.text = "?????????"
        musterLocationTextField.text = "??????7-11"
        numberOfPeopleTextField.text = "3"
        walkEntranceTextField.text = "??????9?????????"
        urgentContactPersonTextField.text = "Peter"
        urgentContactPersonPhoneNumberTextField.text = "042233344"
    }
    //????????????????????????
    @IBAction func difficultySwitch(_ sender: UISwitch) {
        //??????????????????
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
    //??????????????????????????????
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
    //????????????????????????
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
        
        
        /* ??????iPhone????????????????????????????????????????????????Locale.current??????en_TW?????????date picker(Locale??????default)??????????????????????????????????????????Locale.current???????????????TW?????????date picker???Locale??????zh_TW */
        print("Locale.current: \(Locale.current)")
        if Locale.current.description.contains("TW") {
            newAddGroupDate.locale = Locale(identifier: "zh_TW")
        }
        addKeyboardObserver()
        //??????????????????
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        
    }
    //????????????
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    //??????????????????
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //???????????????
    @objc func keyboardWillShow(notification: Notification) {
        // ???????????????????????????view?????????????????????????????????view???1/3??????
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            view.frame.origin.y = -keyboardHeight / 15
        } else {
            view.frame.origin.y = -view.frame.height / 3
        }
    }
    //???????????????
    @objc func keyboardWillHide(notification: Notification) {
        view.frame.origin.y = 0
    }
    //??????????????????
    @IBAction func newAddGroupDate(_ sender: UIDatePicker) {
        /* ?????????????????????(???????????????????????????) */
        let dateFormatter = DateFormatter()
        dateFormatter.locale = newAddGroupDate.locale
        print("Locale.current: \(Locale.current)")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        /* date??????????????????/??????datePicker??????????????? */
        dateFormatter.string(from: newAddGroupDate.date)
        
    }
    //??????????????????
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
            
            //????????????
            if self.image != nil {
                requestParam["imageBase64"] = self.image!.jpegData(compressionQuality: 1.0)!.base64EncodedString()
            }
            executeTask(self.url_sever!, requestParam){ (data,response,error) in
                if error == nil {
                    if data != nil{
                        if let result = String(data:data!,encoding: .utf8){
                            if let count = Int(result){
                                DispatchQueue.main.async {
                                    //????????????????????????
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
        //?????????????????????????????????
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
        /* ?????????????????????(???????????????????????????) */
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = newAddGroupDate.locale
//        print("Locale.current: \(Locale.current)")
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .short
//        /* date??????????????????/??????datePicker??????????????? */
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
    //????????????????????????
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /* ???????????????key???info dictionary???????????? */
        if let pickedImage = info[.originalImage] as? UIImage {
            walkCoverImage.image = pickedImage
            image = pickedImage
        }
        imageUpload()
        dismiss(animated: true)
        }
        
    
    //????????????????????????????????????
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
    //?????????return????????????(???????????????)
    func hideKeyboard(_ textField: UITextField) -> Bool {
        joinGroupTitleTextField.resignFirstResponder()
        numberOfPeopleTextField.resignFirstResponder()
        musterLocationTextField.resignFirstResponder()
        walkEntranceTextField.resignFirstResponder()
        urgentContactPersonTextField.resignFirstResponder()
        urgentContactPersonPhoneNumberTextField.resignFirstResponder()
        
        return true
    }
    //??????view???????????????
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
