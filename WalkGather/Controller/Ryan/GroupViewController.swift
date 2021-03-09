

import UIKit


class GroupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var groupTableView: UITableView!
    var walkImage = ["volcanic","xiangshan","yushan","xiangshan","xiangshan","xiangshan"]
    var groupHost = ["Ryan","羅志祥","EDGE","CENA"]
    var launchDate = ["2021年2月23日","2021年2月24日","2021年2月25日","2021年2月23日"]
    var numberOfPeople = ["3","6","2","4"]
    var groupName = ["佛系爬山團","極限爬山團","垂直爬山團","健走團"]
    
    var taiwanArea = ["北部", "中部", "南部", "東部"]
    var walkTime = ["最新","最多人數"]
    var walkDifficulty = ["一般","中級","地獄"]
    
    @IBOutlet weak var taiwanAreaTextVIew: UITextView!
    @IBOutlet weak var walkTimeTextView: UITextView!
    @IBOutlet weak var walkDifficultyTextView: UITextView!
    
    var pickerTextView :UITextView!
    
    var taiwanAreaPickerView = UIPickerView()
    var walkTimePickerView = UIPickerView()
    var walkDifficultyPickerView = UIPickerView()
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.groupTableView.dataSource = self
        
        taiwanAreaPickerView.delegate = self
        taiwanAreaPickerView.dataSource = self
        walkTimePickerView.delegate = self
        walkTimePickerView.dataSource = self
        walkDifficultyPickerView.delegate = self
        walkDifficultyPickerView.dataSource = self
        
        taiwanAreaTextVIew.inputView = taiwanAreaPickerView
        walkTimeTextView.inputView = walkTimePickerView
        walkDifficultyTextView.inputView = walkDifficultyPickerView
        
        
        taiwanAreaPickerView.tag = 1
        walkTimePickerView.tag = 2
        walkDifficultyPickerView.tag = 3
        
        
        createPicker()
        
        
        
        
    }
    //將PickerView加入上方工具欄
    func createPicker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(title: "關閉", style: .plain, target: self, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: true)
        
        //inputAccessoryView輸入附件視圖
        taiwanAreaTextVIew.inputAccessoryView = toolbar
        taiwanAreaTextVIew.inputView = taiwanAreaPickerView
        walkTimeTextView.inputAccessoryView = toolbar
        walkTimeTextView.inputView = walkTimePickerView
        walkDifficultyTextView.inputAccessoryView = toolbar
        walkDifficultyTextView.inputView = walkDifficultyPickerView
        
    }
    //Done Button方法
    @objc func donePressed(){
        self.view.endEditing(true)
    }
    
    
    //顯示TableVIewCell表格幾列
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    //顯示TableViewCell資料
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroupTableViewCell
        cell.walkImage.image = UIImage(named: walkImage[indexPath.row])
        cell.groupNameLabel.text = groupName[indexPath.row]
        cell.groupDateLabel.text = launchDate[indexPath.row]
        cell.numberOfPeopleLabel.text = numberOfPeople[indexPath.row]
        cell.groupHostLabel.text = groupHost[indexPath.row]
        
        return cell
        
    }
}
extension GroupViewController : UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return taiwanArea.count
        case 2:
            return walkTime.count
        case 3:
            return walkDifficulty.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return taiwanArea[row]
        case 2:
            return walkTime[row]
        case 3:
            return walkDifficulty[row]
        default:
            return "test"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            taiwanAreaTextVIew.text = taiwanArea[row]
        //taiwanAreaField.resignFirstResponder()
        case 2:
            walkTimeTextView.text = walkTime[row]
        //walkTimeField.resignFirstResponder()
        case 3:
            walkDifficultyTextView.text = walkDifficulty[row]
        //walkDifficultyField.resignFirstResponder()
        default:
            return
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
