//
//  tempDatasets.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 21/11/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import Foundation
class tempDatasets {
    
let Model = StaffDataFromServer()
    
    var onlineStaff : [String: Staff] = [:]
    var offlineStaff : [String: Staff] = [:]
    init() {
        
    }
    
    
    func retrieveDataFromServer() {
    
    self.Model.getNamesAndPicUrls(){(response) in
    
    print("inside the view controllerlelellelelelelelele")
    for staff in  response{
    print("hahahahahahahah")
    print(staff.Image_Url, staff.tableName,staff.ImageLocalUrl,staff.Name,staff.onSite,staff.profilePic)
    }
    
    //secondly, after getting the result of the name and pictures url, start the 2nd asyn calls to download the images, and update the staff array
    self.Model.getListOfImageByArrayOfStaff(list: response){(response2)-> Void in
    
    
    for staff in  self.Model.staffInfoSet{
    print("blablabalbalba")
    print(staff.Image_Url,staff.ImageLocalUrl,staff.Name,staff.onSite,staff.profilePic)
    
    }
    
    self.Model.getLastOnsiteInfoByArrayOfStuff(list: response2){(response3)-> Void in
    
    
    
    for staff in  self.Model.staffInfoSet{
    print("blablabalbalbalbalablablabalbalbalblablabla++++++++++++++++++++++++++++")
    print(staff.Image_Url,staff.ImageLocalUrl,staff.Name,staff.onSite,staff.profilePic, staff.onSite as! String!)
    
    }
    //now the staff's data is ready to be used, as all the needed information of staff at this stagee is retrieve
        
        self.onlineAndOfflineSeparationToLists()
        
    }
    
    
    }
        }
    }
    
    
    
    private func onlineAndOfflineSeparationToLists(){
        
        
        for staff in Model.staffInfoSet{
            
            //check whether the staff is already onsite or not, and put the online stuff to the onlinestaff list
            if(staff.onSite == "1"){
                
                onlineStaff[staff.tableName] = staff
            }else{
                offlineStaff[staff.tableName] = staff
            
            }
        
        }
        
        print("after separating of the online and offlinestaff")
        print(onlineStaff.count)
        print(offlineStaff.count)
    }
}
