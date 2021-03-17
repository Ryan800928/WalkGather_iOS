//
//  NewAddGroup.swift
//  WalkGather
//
//  Created by Ryan on 2021/3/10.
//

import Foundation

struct NewAddGroup:Codable {
    
    var id:Int = -1
    var title:String
    var number:Int?
    var groupDate:Date?
    var groupCoverImage:String?
//    var mapID:Int?
//    var member:Int?
//    var check:Int?
//    var status:Int?
//    var registrationBegins:Date?
//    var endOfRegistration:Date?
//    var startTheParty:Date?
//    var endOfTheParty:Date?
    var musterLocation:String
    var walkEntrance:String
    var urgentContactPerson:String
    var urgentContactPersonPhoneNumber:Int?
    var walkType:Int?
    var walkLevel:Int?
    var equipment:Int?
    
    internal init(id: Int = -1, title: String, number: Int? = nil, groupDate: Date? = nil, groupCoverImage: String? = nil, musterLocation: String, walkEntrance: String, urgentContactPerson: String, urgentContactPersonPhoneNumber: Int? = nil, walkType: Int? = nil, walkLevel: Int? = nil, equipment: Int? = nil) {
        self.id = id
        self.title = title
        self.number = number
        self.groupDate = groupDate
        self.groupCoverImage = groupCoverImage
        self.musterLocation = musterLocation
        self.walkEntrance = walkEntrance
        self.urgentContactPerson = urgentContactPerson
        self.urgentContactPersonPhoneNumber = urgentContactPersonPhoneNumber
        self.walkType = walkType
        self.walkLevel = walkLevel
        self.equipment = equipment
    }
    
}