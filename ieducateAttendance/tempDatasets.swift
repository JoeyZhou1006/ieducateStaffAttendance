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
    
    
    //after getting the result of the name and pictures url, start the 2nd asyn calls to download the images, and update the staff array
    self.Model.getListOfImageByArrayOfStaff(list: response){(response2)-> Void in
    

    //getting the lastonsite infomation of staff in the array
    self.Model.getLastOnsiteInfoByArrayOfStuff(list: response2){(response3)-> Void in
    
    

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

                let index = Model.staffInfoSet.index(where: {$0.tableName == staff.tableName})
                Model.staffInfoSet[index!].onSite = "0"
                offlineStaff[staff.tableName] = Model.staffInfoSet[index!]
            }
        
        }

    }
}
