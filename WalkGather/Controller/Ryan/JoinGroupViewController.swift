//
//  JoinGroupViewController.swift
//  WalkGather
//
//  Created by Ryan on 2021/2/22.
//

import UIKit

class JoinGroupViewController: UIViewController {
    var walkImage = ["volcanic","xiangshan","yushan","xiangshan","xiangshan","xiangshan"]
    var groupHost = ["Ryan","羅志祥","EDGE","CENA"]
    var launchDate = ["2021年2月23日","2021年2月24日","2021年2月25日","2021年2月23日"]
    var numberOfPeople = ["3","6","2","4"]
    var groupName = ["佛系爬山團","極限爬山團","垂直爬山團","健走團"]
    var groupLocation = ["火炎山"]
    @IBOutlet weak var joinGroupTitle: UILabel!
    @IBOutlet weak var joinGroupCoverImage: UIImageView!
    @IBOutlet weak var joinGroupDateLabel: UILabel!
    @IBOutlet weak var lastJoinGroupDateLabel: UILabel!
    @IBOutlet weak var joinGroupNumberOfPeopleLabel: UILabel!
    @IBOutlet weak var joinGroupLocationLabel: UILabel!
    
    func showJoinGroupData(){
        joinGroupTitle.text = groupName[0]
        joinGroupCoverImage.image = UIImage(named: walkImage[0])
        joinGroupDateLabel.text = launchDate[0]
        lastJoinGroupDateLabel.text = launchDate[3]
        joinGroupNumberOfPeopleLabel.text = numberOfPeople[0]
        joinGroupLocationLabel.text = groupLocation[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showJoinGroupData()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
