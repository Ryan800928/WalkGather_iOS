//
//  GroupNotificationTVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/7.
//

import UIKit

class PartyNotificationTVC: UITableViewController{
    
    var party = [Party]()
    let userDefaults = UserDefaults.standard
    let url_server = URL(string: common_url + "MemberServlet")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showParty()
    }
    
    
    @objc func showParty() {
        var requestParam = [String: String]()
        requestParam["action"] = "partyNotification"
        requestParam["memberId"] = userDefaults.string(forKey: "id")
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    // 將輸入資料列印出來除錯用
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    
                    if let download = try? JSONDecoder().decode([String : String].self, from: data!){
                        if let partyStr = download["party"]{
                            let partyData = Data(partyStr.utf8)
                            do {
                                self.party = try JSONDecoder().decode([Party].self, from: partyData)
                                //                        self.party = result
                                //                        print("party \(self.party)")
                                DispatchQueue.main.async {
                                    if let control = self.tableView.refreshControl {
                                        if control.isRefreshing {
                                            // 停止下拉更新動作
                                            control.endRefreshing()
                                        }
                                    }
                                    /* 抓到資料後重刷table view */
                                    self.tableView.reloadData()
                                }
                                
                            }catch let err {
                                print("Decode error: \(err)")
                            }
                        }
                    }
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return party.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "partyCell"
        // tableViewCell預設的imageView點擊後會改變尺寸，所以建立UITableViewCell子類別SpotCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! PartyNotificationCell
        let partyCell = party[indexPath.row]
        
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells") as! FriendNotificationCell
        //
        //        cell.cellImage.image = UIImage(named: "noimage")
        //        cell.cellLable.text = "12345"
        
        cell.lbTitle.text = partyCell.title
        cell.lbTime.text = partyCell.date
        cell.lbNumber.text = String(partyCell.number!)
        cell.lbLocation.text = partyCell.musterLocation
        
        return cell
    }
    
}
