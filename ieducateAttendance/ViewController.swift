//
//  ViewController.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 13/10/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    let Model = StaffDataFromServer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.Model.downloadUserImageByUrl(url: "_57d6504d62850ren.jpg")
        self.Model.getAllStaffNames()
        
    
        
}

}
