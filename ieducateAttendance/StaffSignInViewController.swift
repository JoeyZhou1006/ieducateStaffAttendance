//
//  StaffSignInViewController.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 4/12/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import UIKit
import EPSignature

class StaffSignInViewController: UIViewController,UINavigationControllerDelegate,EPSignatureDelegate {
    
    var uid: String!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //signatureView = self.childViewControllers[0] as! SignatureChilViewController
        //submitBtn.isEnabled = false

        staffNameLabel.text = staffName
        staffImageView.image = staffImage
        // Do any additional setup after loading the view.
        print("inside sign in page")
        print(uid)
        
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
        print(onsite!)
        if(onsite! == "0"){
            print("staff is currently offsite, indicate them that they need to sign in")
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
       
        
        
        //signatureView = self.childViewControllers[0] as! SignatureChilViewController
        
      //  signatureView.initializeSignaturePad()
       // signatureView.viewWillAppear(true);
        
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
        
        //add a reference to child view which is the one that capture users signature
       // self.signatureView = self.childViewControllers[0] as! SignatureChilViewController
        print(vc.signatureImage.image)
        //check whether the the signature imageview of child view has any image, if yes, push data to the server
        //if not, prompt user to configure their signature with a alerview
        
        if(vc.signatureImage.image == nil){
            let alert = UIAlertController(title: "Alert", message: "Please Configure your signature first", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print(" there is no image in the view++++++++++++++++++++++++++++++)_)**90930471949014091-4190")
        }
         //call the method in staffdatafrom server to submit the data to the server side
        else{
            
        print("signature image is not nil")
            
            var staff: StaffDataToServer?
            if(onsite == "0"){
             staff = StaffDataToServer(TableName: uid, Date: vc.date.text!, Time: vc.time.text!, OnSite: "1", SignUrl: "blablablabla")
            }
            else if (onsite == "1"){
            staff = StaffDataToServer(TableName: uid, Date: vc.date.text!, Time: vc.time.text!, OnSite: "0", SignUrl: "blablablabla")
            }
            
           self.Model.submitAttendanceInfoToServer(staffToServer: staff!)
            
            
            
        }
        
    }
  
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
