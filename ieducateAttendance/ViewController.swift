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
       
        //firstly, call the model method to fetch the staff name and pictures url, and store the information in the staff array
        self.Model.getNamesAndPicUrls(){(response) in
            
            print("inside the view controllerlelellelelelelelele")
            for staff in  response{
                print("hahahahahahahah")
                print(staff.Image_Url,staff.ImageLocalUrl,staff.Name,staff.onSite,staff.profilePic)
            }
            
            //secondly, after getting the result of the name and pictures url, start the 2nd asyn calls to download the images, and update the staff array
        self.Model.getListOfImageByArrayOfStaff(list: response){(response2)-> Void in
                
                
            for staff in  self.Model.staffInfoSet{
                print("blablabalbalbalbalablablabalbalbalblablabla")
                print(staff.Image_Url,staff.ImageLocalUrl,staff.Name,staff.onSite,staff.profilePic)
                    
            }
            
            
            }
        }
       // self.Model.getListOfImageByArrayOfStaff(list: )
        
        
        
            
        
        }
        
    
        
}



