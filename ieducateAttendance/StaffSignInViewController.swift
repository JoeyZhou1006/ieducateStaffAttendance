//
//  StaffSignInViewController.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 4/12/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//
protocol GetMessageDelegate:NSObjectProtocol
{
    func getMessage(controller: StaffSignInViewController, changedOnsite: Bool)
    


}




import UIKit
import EPSignature
import SCLAlertView


class StaffSignInViewController: UIViewController,UINavigationControllerDelegate,EPSignatureDelegate {
    
    //use optional because it might be nil
    var delegate: GetMessageDelegate?
    
    var uid: String?
    
    var staffName: String!
    var staffImage: UIImage!
    
    var onsite: String!
    
    //shared model object
  let Model = StaffDataFromServer()
    
    
    var vc: SignatureChilViewController!
    
    //staff name label to display staff name
    @IBOutlet weak var staffNameLabel: UILabel!

    //staff image view to present staff image
    @IBOutlet weak var staffImageView: UIImageView!
    

    
    
    @IBOutlet weak var signatureParentView: UIView!
    
    
    @IBOutlet weak var submitBtn: UIButton!
    
    
    
    @IBOutlet weak var uploadRecordIndicatory: UIActivityIndicatorView!
    
    func goBack(){
        if(delegate != nil){
            delegate?.getMessage(controller: self, changedOnsite: true)
            self.navigationController?.popToRootViewController(animated: true)
        }
        else{
            print("delegate is nil!!!!!!")
        
        }
    
    }
    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.uploadRecordIndicatory.isHidden = true
        staffNameLabel.text = staffName
        staffImageView.image = staffImage

    
        //manually configure the signature child view
        vc = storyboard?.instantiateViewController(withIdentifier: "SignatureChilViewController") as! SignatureChilViewController
        //add this signature child view to its parent view
       self.addChildViewController(vc)
        //make sure the signature image is taken up the whole container view
        vc.view.frame = CGRect(x: 0, y: 0, width: self.signatureParentView.frame.size.width, height: self.signatureParentView.frame.size.height);
        
        self.signatureParentView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        
        //configure top bar label to indicate user their current onsite status
        //staff is currently offsite, indicate them that they need to sign in

        if(onsite! == "0"){
            //staff is currently offsite, indicate them that they need to sign in
            self.navigationItem.title = "Good day, \(self.staffName!), please punch in here"
            
        
            
            
        }else{
            print(onsite!)
           self.navigationItem.title = "Hi, \(self.staffName!), please punch out here"
            
        
        
        }
        
        
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func configureSignature(_ sender: Any) {
        
        //removing viewcontollers
        
        vc.willMove(toParentViewController: nil)
        
        vc.view.removeFromSuperview()
        
        vc.removeFromParentViewController()
        
        
        //readding new view controllers
        
        //manually configure the signature child view
        vc = storyboard?.instantiateViewController(withIdentifier: "SignatureChilViewController") as! SignatureChilViewController
        //add this signature child view to its parent view
        self.addChildViewController(vc)
        //make sure the signature image is taken up the whole container view
        vc.view.frame = CGRect(x: 0, y: 0, width: self.signatureParentView.frame.size.width, height: self.signatureParentView.frame.size.height);
        
        self.signatureParentView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        
        
    }
    
    
    
    
    
    @IBAction func submitToServer(_ sender: Any) {
        
        self.uploadRecordIndicatory.isHidden = false
        self.uploadRecordIndicatory.startAnimating()
        
        
        
        
      //  self.goBack()
        
        //add a reference to child view which is the one that capture users signature
        print(vc.signatureImage.image)
        //check whether the the signature imageview of child view has any image, if yes, push data to the server
        //if not, prompt user to configure their signature with a alerview
        
        if(vc.signatureImage.image == nil){
            let alert = UIAlertController(title: "Alert", message: "Please Configure your signature first", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
         //call the method in staffdatafrom server to submit the data to the server side
        else{
            
     
            print(uid)
           
           
            var staffDictionary: [String: String] = ["Date": vc.date.text!]
            
             staffDictionary["TableName"] = uid
            staffDictionary["Time"] = vc.time.text!

            
            if(onsite == "0"){
                staffDictionary["Onsite"] = "1"
            }
            else if (onsite == "1"){
                staffDictionary["Onsite"] = "0"
                
                
            }
            
     
            
            
            
            
            
           //. self.Model.uploadImage(image: vc.signatureImage.image!)
            
            
            self.Model.uploadImage(image: vc.signatureImage.image!) {(response)-> Void in
                
                print("in side call backs")
                
                
                //and now we got the signature image of the staff
                print(response)
                //update the staff object with the server returned image url
                staffDictionary["signatureURL"] = response
                
                //post all the other information to the server
                self.Model.submitAttendanceInfoToServer(staffToServer: staffDictionary) {(response) -> Void in
                    
                    if(response == "true"){
                        print("uploaded successfully")
                        
                       
                        
                        
                        // Bounce back to the main thread to update the UI
                        DispatchQueue.main.async {
                            self.uploadRecordIndicatory.stopAnimating()
                            self.uploadRecordIndicatory.isHidden = true
                            
                            let appearance = SCLAlertView.SCLAppearance(
                                showCloseButton: false
                            )
                           
                            let alertView = SCLAlertView(appearance: appearance)
                            
                         
              
                            alertView.addButton("OK") {
                               
                                 self.goBack()
                            }
                            alertView.showSuccess("Congratulations!", subTitle: "Your information is uploaded successfully")
                            
                            
                            
                            
                            
                        }
                        
                       
                    
                    }else{
                        print("uploaded unsuccessfully")
                    
                    }
                
                }
            
            }
            
           
            
            
            
        }
        
    }
  

}
