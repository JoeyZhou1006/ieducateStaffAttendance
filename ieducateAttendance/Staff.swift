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
    //properties of staff that store names and images
    var Name: String
    
    
    var Image_Url: String
    
    
    
    //the image can be nil
    var profilePic: UIImage?
    
    
    var ImageLocalUrl: String?
    
    //the onsite can be nil
    var onSite :Int?
    
    init(Name: String, Image_Url: String, ProfilePic: UIImage?, ImageLocalUrl: String?, onSite: Int?) {
        self.Name = Name
        self.Image_Url = Image_Url
        self.profilePic = ProfilePic
        self.ImageLocalUrl = ImageLocalUrl
        
        //use the name to search through the server to get the latest onsite status of the staff
        self.onSite = onSite
        
    }
    
    
    



}
