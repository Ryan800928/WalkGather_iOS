

import UIKit


class GroupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    // 儲存所有資料
//    var allGroups:[NewAddGroup]!
//    // 儲存要呈現的資料
//    var searchGroups: [NewAddGroup]!
    
    var newAddGroups = [NewAddGroup]()
    let url_server = URL(string: common_url + "PartyServlet")
    
    
    @IBOutlet weak var groupSearchBar: UISearchBar!
    @IBOutlet weak var groupTableView: UITableView!
    var walkImage = ["xiangshan","volcanic","yushan","xiangshan","volcanic","yushan"]
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
        //        self.groupSearchBar.delegate = self
        //        taiwanAreaPickerView.delegate = self
        //        taiwanAreaPickerView.dataSource = self
        //        walkTimePickerView.delegate = self
        //        walkTimePickerView.dataSource = self
        //        walkDifficultyPickerView.delegate = self
        //        walkDifficultyPickerView.dataSource = self
        
        //        taiwanAreaTextVIew.inputView = taiwanAreaPickerView
        //        walkTimeTextView.inputView = walkTimePickerView
        //        walkDifficultyTextView.inputView = walkDifficultyPickerView
        
        
        taiwanAreaPickerView.tag = 1
        walkTimePickerView.tag = 2
        walkDifficultyPickerView.tag = 3
        
//        allGroups = newAddGroups
        createPicker()

        
        
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        let text = groupSearchBar.text ?? ""
//        // 如果搜尋條件為空字串，就顯示原始資料；否則就顯示搜尋後結果
//        if text == "" {
//            searchGroups = newAddGroups
//            
//        } else {
//            // 搜尋原始資料內有無包含關鍵字(不區別大小寫)
//            
//            searchGroups = newAddGroups.filter({ (newaddGroup) -> Bool in
//                return newaddGroup.title.uppercased().contains(text.uppercased())
//            })
//        }
//        groupTableView.reloadData()
//    }
    // 點擊鍵盤上的Search按鈕時將鍵盤隱藏
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showAllGroup()
    }
    @objc func showAllGroup() {
        let requestParam = ["action" : "allPartys"]
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    // 將輸入資料列印出來除錯用
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    
                    do{
                        let result = try JSONDecoder().decode([NewAddGroup].self, from: data!)
                        self.newAddGroups = result
                        print("result : \(result)" )
                        DispatchQueue.main.async {
                            if let control = self.groupTableView.refreshControl {
                                if control.isRefreshing {
                                    // 停止下拉更新動作
                                    control.endRefreshing()
                                }
                            }
                            /* 抓到資料後重刷table view */
                            self.groupTableView.reloadData()
                        }
                    
                    }catch let err{
                        print("error \(err)")
                    }
                }
            } else {
                print(error!.localizedDescription)
            }
        }
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
        //        taiwanAreaTextVIew.inputAccessoryView = toolbar
        //        taiwanAreaTextVIew.inputView = taiwanAreaPickerView
        //        walkTimeTextView.inputAccessoryView = toolbar
        //        walkTimeTextView.inputView = walkTimePickerView
        //        walkDifficultyTextView.inputAccessoryView = toolbar
        //        walkDifficultyTextView.inputView = walkDifficultyPickerView
        
    }
    //Done Button方法
    @objc func donePressed(){
        self.view.endEditing(true)
    }
    /* UITableViewDataSource的方法，定義表格的區塊數，預設值為1 */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //顯示TableVIewCell表格幾列
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newAddGroups.count
    }
    
    
    
    //顯示TableViewCell資料
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cell"
        // tableViewCell預設的imageView點擊後會改變尺寸，所以建立UITableViewCell子類別SpotCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! GroupTableViewCell
        let newAddGroup = newAddGroups[indexPath.row]
        
        // 尚未取得圖片，另外開啟task請求
        var requestParam = [String: Any]()
        requestParam["action"] = "getImage"
        requestParam["imageId"] = newAddGroup.imageId
        print(newAddGroup.imageId)
        requestParam["imageSize"] = cell.walkImage.frame.width
        // 圖片寬度為tableViewCell的1/4，ImageView的寬度也建議在storyboard加上比例設定的constraint
        var image: UIImage?
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    image = UIImage(data: data!)
                    
                }
                if image == nil {
                    image = UIImage(named: "noImage.jpg")
                }
//                DispatchQueue.main.async { cell.walkImage.image = image }
            } else {
                print(error!.localizedDescription)
            }
        }
        
        cell.groupNameLabel.text = newAddGroup.title
        print("newAddGroup: \(newAddGroup.title)")
        cell.groupDateLabel.text = newAddGroup.date
        cell.numberOfPeopleLabel.text = newAddGroup.number
        cell.musterLocationLabel.text = newAddGroup.musterLocation
        cell.walkImage.image = UIImage (named: walkImage[indexPath.row])
        
        return cell
    }
    //日期 -> 字符串
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_TW")
        formatter.dateFormat = dateFormat
        
        let date = formatter.string(from: date)
        print("date : + \(date)")
        print(" formatter: + \( formatter)")
        return date
        
    }
    
    
    
    @IBAction func memberLogin(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        
        if userDefaults.integer(forKey: "id") >= 1 {
            
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "newAddGruop") as? NewAddGroupViewController {
                navigationController?.pushViewController(controller, animated: true)
            }
        }else{
            let alert = UIAlertController(title: "遊客", message: "請登入", preferredStyle: .alert)
            let ok = UIAlertAction(title: "確定", style: .default) {_ in
                let con = UIStoryboard(name: "Jack", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginVC
                self.present(con, animated: true, completion: nil)

                }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
            
            
            
        }
   
    
        
        
        
        
        
        //extension GroupViewController : UIPickerViewDataSource,UIPickerViewDelegate{
        //    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //        return 1
        //    }
        //
        //    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //        switch pickerView.tag {
        //        case 1:
        //            return taiwanArea.count
        //        case 2:
        //            return walkTime.count
        //        case 3:
        //            return walkDifficulty.count
        //        default:
        //            return 1
        //        }
        //    }
        //
        //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //        switch pickerView.tag {
        //        case 1:
        //            return taiwanArea[row]
        //        case 2:
        //            return walkTime[row]
        //        case 3:
        //            return walkDifficulty[row]
        //        default:
        //            return "test"
        //        }
        //    }
        //    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        switch pickerView.tag {
        //        case 1:
        //            taiwanAreaTextVIew.text = taiwanArea[row]
        //        //taiwanAreaField.resignFirstResponder()
        //        case 2:
        //            walkTimeTextView.text = walkTime[row]
        //        //walkTimeField.resignFirstResponder()
        //        case 3:
        //            walkDifficultyTextView.text = walkDifficulty[row]
        //        //walkDifficultyField.resignFirstResponder()
        //        default:
        //            return
        //        }
        //
        //    }
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //}
        
    }

