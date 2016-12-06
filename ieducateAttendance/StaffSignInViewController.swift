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
    
//staff name label to display staff name
    @IBOutlet weak var staffNameLabel: UILabel!

    //staff image view to present staff image
    @IBOutlet weak var staffImageView: UIImageView!
    

    
    
    @IBOutlet weak var signatureParentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        staffNameLabel.text = staffName
        staffImageView.image = staffImage
        // Do any additional setup after loading the view.
        print("inside sign in page")
        print(uid)
        
        //manually configure the signature child view
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignatureChilViewController") as! SignatureChilViewController
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
        
        //removeing viewcontollers
        var signatureView = self.childViewControllers[0] as! SignatureChilViewController
        
      //  signatureView.initializeSignaturePad()
       // signatureView.viewWillAppear(true);
        
        signatureView.willMove(toParentViewController: nil)
        
        signatureView.view.removeFromSuperview()
        
        signatureView.removeFromParentViewController()
        
        
        //readding new view controllers
        
        //manually configure the signature child view
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignatureChilViewController") as! SignatureChilViewController
        //add this signature child view to its parent view
        self.addChildViewController(vc)
        //make sure the signature image is taken up the whole container view
        vc.view.frame = CGRect(x: 0, y: 0, width: self.signatureParentView.frame.size.width, height: self.signatureParentView.frame.size.height);
        
        self.signatureParentView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        
        
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
