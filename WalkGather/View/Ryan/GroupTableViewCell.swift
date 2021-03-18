//
//  ImageTableViewCell.swift
//  WalkGather
//
//  Created by Ryan on 2021/1/27.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    @IBOutlet weak var walkImage: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupDateLabel: UILabel!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var musterLocationLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
