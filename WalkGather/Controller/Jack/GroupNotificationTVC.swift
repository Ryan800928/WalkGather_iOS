//
//  GroupNotificationTVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/7.
//

import UIKit

class GroupNotificationTVC: UITableViewController{
    
    
    @IBOutlet var GroupNotificationTV: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells") as! NotificationCell
        
        cell.cellImage.image = UIImage(named: "noimage")
        cell.cellLable.text = "12345"
        
        return cell
    }

}
