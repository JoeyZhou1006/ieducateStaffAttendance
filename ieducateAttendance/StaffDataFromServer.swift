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
    
    
    //create an empty dictionary to store each staff with their informtion as a sub array of the name which is a key in the dictionary
    
    var staffInfo:[String: [AnyObject]] = [:]
    
    
    //get the last onsite status of a specific staff by given name
    func getLatestOnsiteStatusOfStaffByName(name: String){
        
    }
    

    
    
    //use alamofire to get all users from web server and put the names in an array
    func getNamesAndPicUrls(){
        
        //need to change the ip address according to the wifi you are connecting to
        Alamofire.request("http://10.10.10.72/Test/api/getAllUsers.php/get") .responseJSON { response in // 1
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
    
    
    
//    //get the image from server by given url string
//    func downloadUserImageByUrl(url: String){
//        
//        
//        //"192.168.1.7/Test/uploads/profile/"
//        
//       // BaseUrl.append(url)
//        Alamofire.request(url).responseImage { response in
//            debugPrint(response)
//            
//            print(response.request)
//            print(response.response)
//            debugPrint(response.result)
//            
//            if let image = response.result.value {
//                print("image downloaded: \(image)")
//                //self.userImage.image = image
//            }
//            
//        }
//        
//        
//    }
    
    
    
    //go through staff array to get a list of photo url of each staff
    func getListOfImageByArrayOfStaff(list: [Array<String>]){
        
        
        for staff in list {
            
           // downloadUserImageByUrl(url: staff[1])
            print("printing the staff's image url")
            print(staff[0])
          //  print(staff[1])
            
            
            //this is an asyn function, !!!!!!!!!
            //downloadUserImageByUrl(url: staff[1])
            
            self.myGroup.enter()
            Alamofire.request(staff[1] ).responseImage { response in
               debugPrint(response)
                
               print(response.request)
               print(response.response)
               debugPrint(response.result)
                
                print("Finished request \(staff[0])")
               // print("request url\(staff[1]) ")
                self.groupOfAllImages.append(staff[1])
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    
                    self.staffInfo[staff[0]] = [staff[1] as AnyObject,image]
                   
                }

                
                
                self.myGroup.leave()
                
                //self.groupOfAllImages.append(UIImage(response.result.value))
                
                
                           }
        }
        
        
        myGroup.notify(queue: DispatchQueue.main) {
            print("finished alll the requests , donneeeeeeeeeeeeeeeee")
            
            print(self.staffInfo.count)
            print(self.staffInfo["Megan O'Neil"])
            
            
            
            self.storeFetchedImagesToCoreData()

        
        }
        
    
    }


    //stored the fetched images to local device directory
    func storeFetchedImagesToCoreData(){
        
        
        
        for (name, infoArray) in self.staffInfo {
            //convert uiimage to jpg format
            if let data = UIImagePNGRepresentation(infoArray[1] as! UIImage) {
            
                
                //get the url part of a staff from staff information array
                let temp = infoArray[0] as! NSString
                
                //get the last part of the url which is the name and store it into staff
                //information array as the local url directory
               //let filename = fileInDocumentsDirectory(filename: temp.lastPathComponent)
                
                //make the filename of the image, and append it to the local direcotry
                let filename = getDocumentsURL().appendingPathComponent(temp.lastPathComponent)
                
                //try to store the images into phone's directory
                try? data.write(to: filename!)
                print("file path is    ",getDocumentsURL())
                print("file name is    ", filename)
            }
        }
        
      
        
    
    
    }
    
    
    //get the documents directory of the device to be used for storing images
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    
    }
    
    
    
    func updateCoreDataByFetchedData(){
    
    }
    
    
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL as NSURL
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
        
    }
    
    
    // Define the specific path, image name
    //let imagePath = fileInDocumentsDirectory(myImageName)
    
}

