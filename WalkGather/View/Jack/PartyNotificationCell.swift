//
//  PartyNotificationCell.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/12.
//

import UIKit

class PartyNotificationCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var lbPartyStart: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
