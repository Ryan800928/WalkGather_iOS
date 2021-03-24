//
//  NewAddGroup.swift
//  WalkGather
//
//  Created by Ryan on 2021/3/10.
//

import Foundation

struct NewAddGroup:Codable {
    
    var id:Int = -1
    var title:String?
    var number:String?
    var date:String?
    var imageId:Int?
//    var mapID:Int?
    var memberId:Int?
//    var check:Int?
//    var status:Int?
//    var registrationBegins:Date?
//    var endOfRegistration:Date?
//    var startTheParty:Date?
//    var endOfTheParty:Date?
    var musterLocation:String
    var walkEntrance:String
    var urgentContactPerson:String
    var urgentContactPersonPhoneNumber:String?
    var walkType:Int?
    var walkLevel:Int?
    var equipment:Int?
    
    internal init(id: Int = -1, title: String, date: String, musterLocation: String, walkEntrance: String, number: String, imageId: Int? = nil, urgentContactPerson: String, urgentContactPersonPhoneNumber: String, walkType: Int? = nil, walkLevel: Int? = nil, equipment: Int? = nil) {
        self.id = id
        self.title = title
        self.date = date
        self.musterLocation = musterLocation
        self.walkEntrance = walkEntrance
        self.number = number
        self.imageId = imageId
        self.urgentContactPerson = urgentContactPerson
        self.urgentContactPersonPhoneNumber = urgentContactPersonPhoneNumber
        self.walkType = walkType
        self.walkLevel = walkLevel
        self.equipment = equipment
    }
    
    internal init(id: Int = -1, title: String, number: String, imageId: Int? = nil, date: String, musterLocation: String, walkEntrance: String, urgentContactPerson: String, urgentContactPersonPhoneNumber: String, walkType: Int? = nil, walkLevel: Int? = nil, equipment: Int? = nil) {
        self.id = id
        self.title = title
        self.number = number
        self.imageId = imageId
        self.date = date
        self.musterLocation = musterLocation
        self.walkEntrance = walkEntrance
        self.urgentContactPerson = urgentContactPerson
        self.urgentContactPersonPhoneNumber = urgentContactPersonPhoneNumber
        self.walkType = walkType
        self.walkLevel = walkLevel
        self.equipment = equipment
    }
    

    
//    internal init(id: Int, title: String, number: String, memberId: Int, date: String, musterLocation: String, walkEntrance: String, urgentContactPerson: String, urgentContactPersonPhoneNumber: String, walkType: Int, walkLevel: Int, equipment: Int) {
//        self.id = id
//        self.title = title
//        self.number = number
//        self.memberId = memberId
//        self.date = date
//        self.musterLocation = musterLocation
//        self.walkEntrance = walkEntrance
//        self.urgentContactPerson = urgentContactPerson
//        self.urgentContactPersonPhoneNumber = urgentContactPersonPhoneNumber
//        self.walkType = walkType
//        self.walkLevel = walkLevel
//        self.equipment = equipment
//    }
    
    
    
   
    
}
