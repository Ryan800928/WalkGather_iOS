//
//  Group.swift
//  WalkGather
//
//  Created by Ryan on 2021/2/23.
//

import Foundation

class Party : Codable {
    var id : Int? = -1
    var title : String? = ""
    var date : String? = ""
    var number : Int? = 0
    var location : String? = ""
    var memberID : Int? = 0
    var startTheParty : String? = ""
    
    public init(title:String, date: String, number: Int, location: String, startTheParty: String){
        self.title = title
        self.date = date
        self.number = number
        self.location = location
        self.startTheParty = startTheParty
    }
}
