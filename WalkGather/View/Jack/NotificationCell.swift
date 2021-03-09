//
//  NotificationTVC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/7.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var cellLable: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
