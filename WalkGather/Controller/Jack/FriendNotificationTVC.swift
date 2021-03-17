//
//  FriendNotificationTVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/12.
//

import UIKit

class FriendNotificationTVC: UITableViewController {
    
    var members = [Member]()
    let userDefaults = UserDefaults.standard
    let url_server = URL(string: common_url + "MemberServlet")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showFriend()
    }
    
    @objc func showFriend() {
        
        let id = Int(userDefaults.string(forKey: "id")!)!
//        let imageId = Int(userDefaults.string(forKey: "imageId") ?? "" )!
        let imageId = userDefaults.integer(forKey: "imageId")
        
        let member = Member(id:id, imageId:imageId)
        
        var requestParam = [String: Any]()
        requestParam["action"] = "friendNotification"
        requestParam["friendId"] = try! String(data: JSONEncoder().encode(member), encoding: .utf8)
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    // 將輸入資料列印出來除錯用
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    
                    if let download = try? JSONDecoder().decode([String : String].self, from: data!){
                        if let friendStr = download["invite"]{
                            print("friendStr: \(friendStr)")
                            let friendData = Data(friendStr.utf8)
                            
//                                self.member = try JSONDecoder().decode([Member].self, from: friendData)
                                // let jsonDatas = try JSONDecoder().decode([[String:Any]].self, from: friendData)
                                if let jsonDatas = try? JSONSerialization.jsonObject(with: friendData) {
                                    if let jsonDics = jsonDatas as? [[String:Any]] {
                                        for dic in jsonDics {
                                                    let member = Member()
                                            member.name = dic["name"] as? String
                                                    member.image = Data(base64Encoded: dic["image"] as! String)
                                            member.date = dic["date"] as? String
                                            member.friendId = dic["friendId"] as? Int
                                                    self.members.append(member)                                          
                                            }
                                        }
                                    }
//                                }
                               
                                
//                                        let newImageData = Data(base64Encoded: imageStr)
//                                        let dataDecode:NSData = NSData(base64Encoded: newImageData!,
//                                                                      options:.ignoreUnknownCharacters)!
//                                        self.image = UIImage(data: dataDecode as Data)!
//                                    }
//                                }
                                DispatchQueue.main.async {
                                    if let control = self.tableView.refreshControl {
                                        if control.isRefreshing {
                                            // 停止下拉更新動作
                                            control.endRefreshing()
                                        }
                                    }
                                    self.tableView.reloadData()
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return members.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "friendCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! FriendNotificationCell
        let friendCell = members[indexPath.row]

        cell.lbName.text = friendCell.name
        cell.ivAvatar.image = UIImage(data: friendCell.image!)
        
        
        return cell
    }
    

}
