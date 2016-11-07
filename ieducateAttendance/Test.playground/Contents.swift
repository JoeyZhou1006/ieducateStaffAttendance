//: Playground - noun: a place where people can play

import UIKit
import Alamofire
import XCPlayground




class Staff {
    //properties of staff that store names and images
    var Name: String
    
    
    var tableName: String
    
    var Image_Url: String?
    
    
    
    //the image can be nil
    var profilePic: UIImage?
    
    
    var ImageLocalUrl: String?
    
    //the onsite can be nil
    var onSite :Int?
    
    init(Name: String, TableName: String, Image_Url: String?, ProfilePic: UIImage?, ImageLocalUrl: String?, onSite: Int?) {
        self.Name = Name
        self.tableName = TableName
        self.Image_Url = Image_Url
        self.profilePic = ProfilePic
        self.ImageLocalUrl = ImageLocalUrl
        
        //use the name to search through the server to get the latest onsite status of the staff
        self.onSite = onSite
        
    }
}

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

var staff1 = Staff(Name: "Daniel Custance" , TableName:"DanielCustance", Image_Url: nil , ProfilePic: nil, ImageLocalUrl: nil, onSite: nil)


var staff2 = Staff(Name: "Nazmul Alam" , TableName:"NazmulAlam", Image_Url: nil , ProfilePic: nil, ImageLocalUrl: nil, onSite: nil)

var staff3 = Staff(Name: "Tish Custance" , TableName:"TishCustance", Image_Url: nil , ProfilePic: nil, ImageLocalUrl: nil, onSite: nil)

var staff4 = Staff(Name: "Ren Tharakan" , TableName:"RenTharakan", Image_Url: nil , ProfilePic: nil, ImageLocalUrl: nil, onSite: nil)

var staff5 = Staff(Name: "Athuai Door" , TableName:"AthuaiDoor", Image_Url: nil , ProfilePic: nil, ImageLocalUrl: nil, onSite: nil)



var staffInfoSet:[Staff] = [staff1,staff2,staff3,staff4,staff5]


var myGroup = DispatchGroup()


for staff in staffInfoSet {
    let userName = staff.tableName
    
    //concatenate base url with the user table that we want to query
    let onsiteUrl = "http://localhost/Test/api/getLastOnSiteInfoByName.php?Name=\(userName)"
    print(onsiteUrl)
    myGroup.enter()
    Alamofire.request(onsiteUrl) .responseString { response in // 1

        switch response.result {
            
        case .success:
            
            let var1 = response.result.value as! String!
            print(var1)
        case .failure(let error):
            
            print("cannot connect to the server")
            print(error)
        }
        
          myGroup.leave()
    }
}

myGroup.notify(queue: DispatchQueue.main) {
    print("finished alll last onsite information of staff , donneeeeeeeeeeeeeeeee")
    
}





