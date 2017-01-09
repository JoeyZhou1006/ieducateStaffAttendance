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
public class StaffDataFromServer {
    
  
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
        Alamofire.request("http://localhost:80/Test/api/getAllUsers.php/get") .responseJSON { response in // 1
          
            switch response.result {
            // in regards of the reponse from server, if success, do the following
            case .success:
            let retrievedValue = response.result.value as! NSDictionary

            
            //print all the users in this object
            let arrayValueOfPerson = retrievedValue["users"] as! NSArray
         
            //loop through each user array to ger their name and image url
            for num in 0 ..< arrayValueOfPerson.count {
                
                let itemObject = arrayValueOfPerson[num] as! NSDictionary
                let name = itemObject["Name"] as! String
                let tableName = itemObject["TableName"] as! String
                let photo_url = itemObject["Photo_Url"] as! String
                
                //store the staffs' names into the staff names arrary
                //start to fill the each staff's object
                let staff = Staff(Name: name,TableName: tableName, Image_Url: photo_url,ProfilePic: nil,ImageLocalUrl: nil, onSite: nil)
                
                self.staffInfoSet.append(staff)
                
            }
                //if failed, print the error response
            case .failure(let error):
                print("cannot connect to the server")
               
        }
        //give the updated staff infoset to be handled later on in viewcontroller
        completionHandler(self.staffInfoSet)
 
        }
    }
    
    

    
    
    //go through staff array to get a list of photo url of each staff
    func getListOfImageByArrayOfStaff(list: [Staff],completionHandler: @escaping (Array<Staff>) -> ()){
        for staff in list {
            
            //start to use GCD to organize multiple async calls
            self.myGroup.enter()
            Alamofire.request(staff.Image_Url ).responseImage { response in
                if let image = response.result.value {
                    //append the image to the profile pic of the staff in staffinfoset
                    staff.profilePic = image
                }
            self.myGroup.leave()
        }
        }
        myGroup.notify(queue: DispatchQueue.main) {
           // finished alll the async requests
             completionHandler(self.staffInfoSet)
        }
    }
    
    
    
    
    func getLastOnsiteInfoByArrayOfStuff(list: [Staff], completionHandler: @escaping (Array<Staff>) ->()){
        
        for staff in list {
            let userName = staff.tableName
            
            //concatenate base url with the user table that we want to query
            let onsiteUrl = "http://localhost:80/Test/api/getLastOnSiteInfoByName.php?Name=\(userName)"
            self.myGroup.enter()
            Alamofire.request(onsiteUrl) .responseString { response in // 1
                
                switch response.result {
                    
                case .success:
                    
                    let var1 = response.result.value as String!
                    staff.onSite = var1
 
                    
                case .failure(let error):
                    print("cannot connect to the server")

                }
                
                self.myGroup.leave()
            }
        }
        
        myGroup.notify(queue: DispatchQueue.main) {

            
            
            // when reaches here, it means finished all the last onsite information of staff here
            completionHandler(self.staffInfoSet)
        }
    }
    
    
    //submit staff attendance record to server
    func submitAttendanceInfoToServer(staffToServer: [String:String],completionHandler: @escaping (String) ->()){
     
        let jsonData = try? JSONSerialization.data(withJSONObject: staffToServer)
        
        // create post request
        let url = URL(string: "http://localhost/Test/api/UploadStaffSiteIno.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
//            let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            
//            print(jsonStr)
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                    throw JSONError.ConversionFailed
                }
                
                
                
                completionHandler(json["success"] as! String)
                print(json)
               
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            
            
            
            
            
        }
        
        
        task.resume()

  
    }
    
    

    func uploadImage(image: UIImage, completionHandler: @escaping (String) ->()){
        
       // Now use image to create into NSData format
                let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
        
                //convert the nsdata to base64 encoded string
        
                   let strBase64:String = imageData.base64EncodedString(options: .lineLength64Characters)
                

        
        // prepare json data
        let json: [String: Any] = ["image": strBase64]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "http://localhost/Test/api/UploadPhoto.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                    throw JSONError.ConversionFailed
                }
                
                 completionHandler(json["sign"] as! String)
               
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            
            

           
           
            }

        
        task.resume()
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
              //make the filename of the image, and append it to the local direcotry
                let imageLocalUrl = getDocumentsURL().appendingPathComponent(temp.lastPathComponent)
                
                //try to store the images into phone's directory
                try? data.write(to: imageLocalUrl!)
                 staff.ImageLocalUrl = imageLocalUrl?.absoluteString
            }
        }
    }
    
    
    
    
    //get the documents directory of the device to be used for storing images
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    
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

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}
    
}




