//
//  Member.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/4.
//
import Foundation



class Member : Codable {
    var id : Int = 0
    var name : String = ""
    var nickname : String = ""
    var birthday : String = ""
    var gender : Int = 0
    var email : String = ""
    var password : String = ""
    var phone : String = ""
    var emergency : String = ""
    var relation : String = ""
    var emergencyPhone : String = ""
    var imageId : Int = 0
    var token : Int = 0
    var image : String = ""
//    var date : Date =
    var friendId : Int = 0
    
    
    public init(email: String, password: String){
        self.email = email
        self.password = password
    }
    

    
    public init(_ id: Int , _ name: String, _ nickname: String,_ birthday: String,_ gender: Int,   _ email: String , _ password: String, _ phone: String, _ emergency: String, _ relation: String, _ emergencyPhone: String, _ imageId: Int, _ token: Int, _ image: String, _ friendId: Int) {
        self.id = id
        self.name = name
        self.nickname = nickname
        self.birthday = birthday
        self.gender = gender
        self.email = email
        self.password = password
        self.phone = phone
        self.emergency = emergency
        self.relation = relation
        self.emergencyPhone = emergencyPhone
        self.imageId = imageId
        self.token = token
        self.image = image
        self.friendId = friendId
    }

}

