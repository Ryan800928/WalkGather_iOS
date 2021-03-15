//
//  NotificationTVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/7.
//

import UIKit

class FriendNotificationCell: UITableViewCell {
    
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var btAccept: UIButton!
    @IBOutlet weak var btRefuse: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
