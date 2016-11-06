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
    
    static let sharedModel = StaffDataFromServer()
    
    
    var staffNameandPic: [Array<String>] = []
    
    var staffImages: [UIImage] = []

    var myGroup = DispatchGroup()
    
    
    
    var groupOfAllImages:[String] = []
    
    
    
    
    
    //an array holds the data of every employee
    var staffInfoSet:[Staff] = []
    
    
    //create an empty dictionary to store each staff with their informtion as a sub array of the name which is a key in the dictionary
    
    var staffInfo:[String: [AnyObject]] = [:]
    
    
    //get the last onsite status of a specific staff by given name
    func getLatestOnsiteStatusOfStaffByName(name: String){
        
    }
    

    
    
    //use alamofire to get all users from web server and put the names in an array
    func getNamesAndPicUrls(completionHandler: @escaping (Array<Staff>) -> ()) -> (){
        
        //need to change the ip address according to the wifi you are connecting to
        Alamofire.request("http://localhost/Test/api/getAllUsers.php/get") .responseJSON { response in // 1
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
                let photo_url = itemObject["Photo_Url"] as! String
                
                //store the staffs' names into the staff names arrary
                //self.staffNames.append(name)
                //insert method to deal with the downloaded image
                //print(self.staffNames)
                
                
                var staff = Staff(Name: name, Image_Url: photo_url,ProfilePic: nil,ImageLocalUrl: nil, onSite: nil)
                
                self.staffInfoSet.append(staff)
                
                print(staff.Name, staff.Image_Url)
                
                
                
            }
                //if failed, print the error response
            case .failure(let error):
                print("cannot connect to the server")
                print("inside the method that is trying to get image")
                print(error)
               
        }
            
              print("should be 21 ")
              print(self.staffInfoSet.count)
            //give the updated staff infoset to be hanlder later on in viewcontroller
           completionHandler(self.staffInfoSet)
        print("2nd row, it should be 21 as well")
        }
    }
    
    

    
    
    //go through staff array to get a list of photo url of each staff
    func getListOfImageByArrayOfStaff(list: [Staff],completionHandler: @escaping (Array<Staff>) -> ()){
        for staff in list {
            // downloadUserImageByUrl(url: staff[1])
            print("printing the staff's image url")
            print(staff.Image_Url)
            //this is an asyn function, !!!!!!!!!
            //downloadUserImageByUrl(url: staff[1])
            
            self.myGroup.enter()
            Alamofire.request(staff.Image_Url ).responseImage { response in
               debugPrint(response)
                
               print(response.request)
               print(response.response)
               debugPrint(response.result)
                
                print("Finished request \(staff.Name)")
               // print("request url\(staff[1]) ")
               // self.groupOfAllImages.append(staff[1])
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    
                   // self.staffInfo[staff[0]] = [staff[1] as AnyObject,image]
                    //append the image to the profile pic of the staff in staffinfoset
                    staff.profilePic = image
                }
            self.myGroup.leave()
        }
        }
        myGroup.notify(queue: DispatchQueue.main) {
            print("finished alll the requests , donneeeeeeeeeeeeeeeee")
           
           // self.storeFetchedImagesToCoreData()
             completionHandler(self.staffInfoSet)
        }
    }
    
    
    
    
    func getLastOnsiteInfoByArrayOfStuff(list: [Staff], completionHandler: @escaping (Array<Staff>) ->()){
        
        for staff in list {
           // var userName = staff.
            Alamofire.request("http://localhost/Test/api/getAllUsers.php/get") .responseJSON { response in // 1
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
                    
                    
                //if failed, print the error response
                case .failure(let error):
                    print("cannot connect to the server")
                    print(error)
                    
                }
                
            }
      
        }
    }
    
    
    

  
    //stored the fetched images to local device directory
    func storeFetchedImagesToCoreData(){
        
        
        
        for staff in self.staffInfoSet {
            //convert uiimage to jpg format
            if let data = UIImagePNGRepresentation(staff.profilePic!) {
            
                
                //get the url part of a staff from staff information array
                let temp = staff.Image_Url as NSString
                
                //get the last part of the url which is the name and store it into staff
                //information array as the local url directory
               //let filename = fileInDocumentsDirectory(filename: temp.lastPathComponent)
                
                //make the filename of the image, and append it to the local direcotry
                let imageLocalUrl = getDocumentsURL().appendingPathComponent(temp.lastPathComponent)
                
                //try to store the images into phone's directory
                try? data.write(to: imageLocalUrl!)
              //  print("file path is    ",getDocumentsURL())
                //print("file name is    ", imageLocalUrl)
                staff.ImageLocalUrl = imageLocalUrl?.absoluteString
            }
        }
        
//        for staff in self.staffInfoSet {
//            print("hahahahahahahah")
//        print(staff.Image_Url,staff.ImageLocalUrl,staff.Name,staff.onSite,staff.profilePic)
//        
//        }
        
        
        
      
        
    
    
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

