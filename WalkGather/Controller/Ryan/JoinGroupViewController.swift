//
//  JoinGroupViewController.swift
//  WalkGather
//
//  Created by Ryan on 2021/2/22.
//

import UIKit

class JoinGroupViewController: UIViewController {
    var joinGroup:JoinGroup?
    
    var walkImage = ["xiangshan","volcanic","yushan","xiangshan","volcanic","yushan"]
    var groupHost = ["Peter","Peter","Peter","Peter"]
    var launchDate = ["2021年3月30日","2021年3月30日","2021年月30日","2021年3月30日"]
    var numberOfPeople = ["3","6","2","4"]
    var groupName = ["象山團","火炎山團","玉山團","象山團"]
    var groupLocation = ["象山轉運站"]
    var walkEntrance = ["象山入口"]
    var urgentContactPersonData = ["Peter"]
    var urgentContactPersonPhoneNumberData = ["022233344"]
    @IBOutlet weak var joinGroupTitle: UILabel!
    @IBOutlet weak var joinGroupCoverImage: UIImageView!
    @IBOutlet weak var joinGroupDateLabel: UILabel!
    
    @IBOutlet weak var joinGroupNumberOfPeopleLabel: UILabel!
    @IBOutlet weak var joinGroupLocationLabel: UILabel!
    @IBOutlet weak var joinWalkEntance: UILabel!
    @IBOutlet weak var urgentContactPerson: UILabel!
    @IBOutlet weak var urgentContactPersonPhoneNumber: UILabel!
    
    func showJoinGroupData(){
        joinGroupTitle.text = groupName[0]
        joinGroupCoverImage.image = UIImage(named: walkImage[0])
        joinGroupDateLabel.text = launchDate[0]
        
        joinGroupNumberOfPeopleLabel.text = numberOfPeople[0]
        joinGroupLocationLabel.text = groupLocation[0]
        joinWalkEntance.text = walkEntrance[0]
        urgentContactPerson.text = urgentContactPersonData[0]
        urgentContactPersonPhoneNumber.text = urgentContactPersonPhoneNumberData[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showJoinGroupData()
//        if let joinGroup = joinGroup{
//            self.title = joinGroup.title
//            joinGroupTitle.text = groupName[0]
//            joinGroupDateLabel.text = launchDate[0]
//            joinGroupNumberOfPeopleLabel.text = numberOfPeople[0]
//            joinGroupLocationLabel.text = groupLocation[0]
//            joinGroupCoverImage.image = UIImage(named: "象山")
//    }
}
    
}
