//
//  Staff.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 13/10/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import Foundation
import UIKit

class Staff {
    
    //properties of staff to set up the app initiallly
    var Name: String
    
    
    var tableName: String
    
    var Image_Url: String
    
   
    
    //the image can be nil
    var profilePic: UIImage?
    
    
    var ImageLocalUrl: String?
    
    //the onsite can be nil
    var onSite :String?
    
    
    
    //properties of staff to be sent to server
    var Date: String?
    var Time: String?
    var ChangedOnSite: String?
    var Signature: UIImage?
    var signUrl: String?
    
    
    
    
    
    init(Name: String, TableName: String, Image_Url: String, ProfilePic: UIImage?, ImageLocalUrl: String?, onSite: String?) {
        self.Name = Name
        self.tableName = TableName
        self.Image_Url = Image_Url
        self.profilePic = ProfilePic
        self.ImageLocalUrl = ImageLocalUrl
        
        //use the name to search through the server to get the latest onsite status of the staff
        self.onSite = onSite
    }
    

//    init(TableName: String, Date: String?, Time: String?, OnSite: String?, SignUrl: String?) {
//        
//        self.tableName = TableName
//        self.Date = Date
//        self.Time = Time
//        self.onSite = OnSite
//        self.signUrl = SignUrl
//    }

    
    



}
