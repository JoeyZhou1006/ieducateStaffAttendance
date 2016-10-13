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
    //properties of staff that store names and images of
    var Name: String
    //the image can be nil
    var profilePic: UIImage?
    
    var onSite :Int
    
    init(Name: String, ProfilePic: UIImage?) {
        self.Name = Name
        self.profilePic = ProfilePic
    }
    



}
