//
//  StaffDataFromServer.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 13/10/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage



//network controller
class StaffDataFromServer {
    
    
    var staffNameandPic: [Array<String>] = []
    
    var staffImages: [UIImage] = []

    var myGroup = DispatchGroup()
    
    
    
    var groupOfAllImages:[String] = []
    
    init() {
        

        
        
        
        
    }
    
    
    
   
    
    
    
    //receive a name string to search in server to get the picture and insert them into staff object
    func getStaffDataFromServer(name: String){
        
        
    }
    
    
    
    //download image of a specific staff by given name
    func downloadImageByname(name: String){
        
        
    
    }

    
    //get the last onsite status of a specific staff by given name
    func getLatestOnsiteStatusOfStaffByName(name: String){
        
    }
    
    
    //this will talk to the server to get all the names from the mysql database
    func retrieveAllStaffObject() -> Array<String> {
    
    
    
        return ["",""]
    }
    
    
    //use alamofire to get all users from web server and put the names in an array
    func getAllStaffNames(){
        
        //need to change the ip address according to the wifi you are connecting to
        Alamofire.request("http://192.168.1.7/Test/api/getAllUsers.php/get") .responseJSON { response in // 1
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            
            switch response.result {
                // in regards of the reponse from server, if success, do the following
            case .success:
            let retrievedValue = response.result.value as! NSDictionary
            //print(retrievedValue.description)
            
            //print all the users in this object
            let arrayValueOfPerson = retrievedValue["users"] as! NSArray
            //let JsonDataset = JSON(retrievedValue)
            //  print("JSON: \(self.JSON)")
            
            
            //loop through each user array to ger their anme and image url
            for num in 0 ..< arrayValueOfPerson.count {
                
                let itemObject = arrayValueOfPerson[num] as! NSDictionary
                let name = itemObject["Name"] as! String
                let photo_64Encoded = itemObject["Photo_Url"] as! String
                
               // print("name is ",name,"photo that is encoded into base64",photo_64Encoded)
                //store the staffs' names into the staff names arrary
                //self.staffNames.append(name)
                //insert method to deal with the downloaded image
                //print(self.staffNames)
                
                //self.staffNameandPic[name]=photo_64Encoded
               // self.staffNameandPic.
                var tempArrary: [String] = []
                tempArrary.append(name )
                tempArrary.append(photo_64Encoded )
                
                self.staffNameandPic.insert(tempArrary, at: num)
                //print(self.staffNameandPic)
                
                
            }
                //if failed, print the error response
            case .failure(let error):
                print(error)
                print("cannot connect to the server")
        }
            
              print("should be 11 ")
              print(self.staffNameandPic.count)
           
            
            
            
        print("2nd row, it should be 11 as well")
        self.getListOfImageByArrayOfStaff(list: self.staffNameandPic)
            
            
        
        }
      
        
        //deal with name and pic
   
    
    }
    
    
    
    //get the image from server by given url string
    func downloadUserImageByUrl(url: String){
        
        
        //"192.168.1.7/Test/uploads/profile/"
        //var BaseUrl = "http://192.168.1.7/Test/uploads/profile/"
        
       // BaseUrl.append(url)
        Alamofire.request(url).responseImage { response in
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                //self.userImage.image = image
            }
            
        }
        
        
    }
    
    
    
    //go through staff array to get a list of photo url of each staff
    func getListOfImageByArrayOfStaff(list: [Array<String>]){
        
        
        for staff in list {
            
           // downloadUserImageByUrl(url: staff[1])
            print("printing the staff's image url")
            print(staff[0])
            print(staff[1])
            
            
            //this is an asyn function, !!!!!!!!!
            //downloadUserImageByUrl(url: staff[1])
            
            self.myGroup.enter()
            Alamofire.request(staff[1]).responseImage { response in
               // debugPrint(response)
                
               // print(response.request)
                //print(response.response)
                //debugPrint(response.result)
                
                print("Finished request \(staff[0])")
                self.groupOfAllImages.append(staff[1])
                self.myGroup.leave()
            }
        }
        
        
//        DispatchGroup.notify(myGroup, DispatchQueue.main, {
//            print("Finished all requests.")
//        })
        
        myGroup.notify(queue: DispatchQueue.main) {
            print("finished alll the requests , donneeeeeeeeeeeeeeeee")
        
        }
        
    
    }

    
    
    
    
    //stored the fetched results to coredata
    func storeFetchedDataToCoreDate(){
    
    
    }
    
    
    func updataCoreDataByFetchedData(){
    
    }
    
    
    func decodingBase64(strBase64: String) -> UIImage{
        
        
        //now we get the decoded nsdata
        let dataDecoded:NSData = NSData(base64Encoded: strBase64, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        
        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
        print(decodedimage)
       // yourImageView.image = decodedimage
        return decodedimage
    
    }
    
    
    
    // self.getAllStaffNamesAndPic()
    
    //let parameter: Parameters = ["foo":"bar"]
    
    //        for i in 0 ..< 5 {
    //            myGroup.enter()
    //
    //            Alamofire.request("http://httpbin.org/get").responseJSON{ response in
    //                //print("Finished request \(i)")
    //                // dispatch_group_leave(self.myGroup)
    //                print(response.result)
    //            }
    //        }
    //
    //        
    
    
    
    
    

    
    
    //try to get the image name
    //        var name = "uploads/profile/_57d642356baf1daniel.jpg"
    //
    //        let index = name.index(name.startIndex, offsetBy: 16)
    //        print(name.substring(from: index)) // playground
    
    
    
    


}
