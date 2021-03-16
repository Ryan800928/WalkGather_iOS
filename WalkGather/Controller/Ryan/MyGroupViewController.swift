//
//  MyGroupViewController.swift
//  WalkGather
//
//  Created by Ryan on 2021/2/23.
//

import UIKit

class MyGroupViewController: UIViewController,UITableViewDataSource {
    var spots = [NewAddGroup]()
    let url_server = URL(string: common_url + "PartyServlet")
    
    
    
    
    
    @IBOutlet weak var myGroupTableView: UITableView!
    var myGroupImage = ["volcanic","xiangshan","yushan","xiangshan","xiangshan","xiangshan"]
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return spots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "myGroupCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MyGroupTableViewCell
        let spot = spots[indexPath.row]
        
        // 尚未取得圖片，另外開啟task請求
        var requestParam = [String: Any]()
        requestParam["action"] = "getImage"
        requestParam["id"] = spot.id
        // 圖片寬度為tableViewCell的1/4，ImageView的寬度也建議在storyboard加上比例設定的constraint
        requestParam["imageSize"] = cell.frame.width / 4
        var image: UIImage?
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    image = UIImage(data: data!)
                }
                if image == nil {
                    image = UIImage(named: "noimage.png")
                }
                DispatchQueue.main.async { cell.myGroupImage.image = image }
            } else {
                print(error!.localizedDescription)
            }
        }
        
        //        cell.myGroupImage.image = UIImage(named: myGroupImage[indexPath.row])
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myGroupTableView.dataSource = self
        
        tableViewAddRefreshControl()
        // Do any additional setup after loading the view.
    }
    /** tableView加上下拉更新功能 */
    func tableViewAddRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(showAllSpots), for: .valueChanged)
        self.myGroupTableView.refreshControl = refreshControl
    }
    override func viewWillAppear(_ animated: Bool) {
        showAllSpots()
    }
    @objc func showAllSpots() {
        let requestParam = ["action" : "getAll"]
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    // 將輸入資料列印出來除錯用
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    
                    if let result = try? JSONDecoder().decode([NewAddGroup].self, from: data!) {
                        self.spots = result
                        DispatchQueue.main.async {
                            if let control = self.myGroupTableView.refreshControl {
                                if control.isRefreshing {
                                    // 停止下拉更新動作
                                    control.endRefreshing()
                                }
                            }
                            /* 抓到資料後重刷table view */
                            self.myGroupTableView.reloadData()
                        }
                    }
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
}
