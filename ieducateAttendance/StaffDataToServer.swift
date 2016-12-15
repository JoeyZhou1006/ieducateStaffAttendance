//
//  StaffDataToServer.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 15/12/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import Foundation
import ObjectMapper

class StaffDataToServer: Mappable {
    var TableName: String?
    var Date: String?
    var Time: String?
    var OnSite: String?
    var SignUrl: String?
    
    
    init(TableName: String, Date: String, Time: String, OnSite: String, SignUrl: String) {
        self.TableName = TableName
        self.Date = Date
        self.Time = Time
        self.OnSite = OnSite
        self.SignUrl = SignUrl
    }
    
    required init?(map: Map) {
    
    
    
    }
    
    func mapping(map: Map) {
        TableName <- map["TableName"]
        Date <- map["Date"]
        Time <- map["Time"]
        OnSite <- map["OnSite"]
        SignUrl <- map["SignUrl"]
    }
    
    
    
    
    
    






}
