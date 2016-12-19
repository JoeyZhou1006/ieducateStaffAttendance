//
//  tempDatasets.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 21/11/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import Foundation
public class tempDatasets {
    
    public static let tempData = tempDatasets()


    
    let Model = StaffDataFromServer()
    
    
    
    var onlineStaff : [String: Staff] = [:]
    var offlineStaff : [String: Staff] = [:]
    init() {
        
    }
    
    
    func retrieveDataFromServer(completionHandler: @escaping (Dictionary<String, Staff>,Dictionary<String, Staff>) -> ())-> (){
    
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
    
    
    
    for staff in self.Model.staffInfoSet{
    print("blablabalbalbalbalablablabalbalbalblablabla++++++++++++++++++++++++++++")
    print(staff.Image_Url,staff.ImageLocalUrl,staff.Name,staff.onSite,staff.profilePic, staff.onSite as String!)
    
    }
    //now the staff's data is ready to be used, as all the needed information of staff at this stagee is retrieve
        
        //tell the completion hanlder that both array sets are ready to be used and deliver it to be used in other places
        self.onlineAndOfflineSeparationToLists()
        completionHandler(self.onlineStaff,self.offlineStaff)
        
        
    }
    
    
    }
        }
    }
    
    
    
    private func onlineAndOfflineSeparationToLists(){
        
        
        for staff in Model.staffInfoSet{
            
            //check whether the staff is already onsite or not, and put the online stuff to the onlinestaff list
            if(staff.onSite == "1"){
                
                onlineStaff[staff.tableName] = staff
            }else if (staff.onSite == "0"){
                offlineStaff[staff.tableName] = staff
            
            //this else statement is used for deal with the stuation that a staff has no lastonsite information, so by default, we treat it as an offline staff
            }else {
                
                print("dealing with staff that has 0 record")
                let index = Model.staffInfoSet.index(where: {$0.tableName == staff.tableName})
                Model.staffInfoSet[index!].onSite = "0"
                offlineStaff[staff.tableName] = Model.staffInfoSet[index!]
                print("their onsite information should be 0")
                print(offlineStaff[staff.tableName]?.onSite!)
                print("blabalabl")
            
            }
        
        }
        
        print("after separating of the online and offlinestaff")
        print(onlineStaff.count)
        print(offlineStaff.count)
    }
}
