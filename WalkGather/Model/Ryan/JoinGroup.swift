//
//  JoinGroup.swift
//  WalkGather
//
//  Created by Ryan on 2021/3/22.
//

import Foundation
import UIKit
class JoinGroup {
    
    var title :String
    var date: String
    var number:String
    var image:UIImage
    var location:String
    
    internal init(title: String, date: String, number: String, image: UIImage, location: String) {
        self.title = title
        self.date = date
        self.number = number
        self.image = image
        self.location = location
    }
    
    
}
