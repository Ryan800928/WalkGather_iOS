//
//  Member.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/4.
//
import Foundation



class Member : Codable {
    var id : Int? = -1
    var name : String? = ""
    var nickname : String? = ""
    var birthday : String? = ""
    var gender : Int? = 0
    var email : String? = ""
    var password : String? = ""
    var phone : String? = ""
    var emergency : String? = ""
    var relation : String? = ""
    var emergencyPhone : String? = ""
    var imageId : Int? = 0
    var token : Int? = 0
    var image : Data?
    var date : String?
    var friendId : Int? = 0
    
    public init() {
        
    }
    
    public init(email: String, password: String){
        self.email = email
        self.password = password
    }
    
    public init(id: Int, imageId: Int){
        self.id = id
        self.imageId = imageId
    }
    
    
    
    public init(id: Int, name: String, nickname: String, birthday: String, phone: String, emergency: String, emergencyPhone:String, relation: String){
        self.id = id
        self.name = name
        self.nickname = nickname
        self.birthday = birthday
        self.phone = phone
        self.emergency = emergency
        self.emergencyPhone = emergencyPhone
        self.relation = relation
    }
    
    public init(_ id: Int , _ name: String, _ nickname: String,_ birthday: String,_ gender: Int,   _ email: String , _ password: String, _ phone: String, _ emergency: String, _ relation: String, _ emergencyPhone: String, _ imageId: Int, _ token: Int) {
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
//        self.image = image
//        self.friendId = friendId
    }

    


}

