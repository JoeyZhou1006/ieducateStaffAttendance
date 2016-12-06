//
//  SignatureChilViewController.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 5/12/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import UIKit
import EPSignature
class SignatureChilViewController: UIViewController, EPSignatureDelegate {


    @IBOutlet weak var signatureImage: UIImageView!
    
    
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
     //load signature view when user tapped 
      initializeSignaturePad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //initialize the signature pad for user to sign on
    func initializeSignaturePad(){
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "I agree to the terms and conditions"
       // signatureVC.title = (self.parent as! StaffSignInViewController).staffName
        let nav = UINavigationController(rootViewController: signatureVC)
 
    
        //manually present it to the user
        present(nav, animated: true, completion: nil)
    }
    
    
    //setting up the actions when user has done sign in (click the done button), and then it will insert the signature to the view to be presented to the user along with current date and current time
    func epSignature(_: EPSignatureViewController, didSign signatureImage: UIImage, boundingRect: CGRect) {
        
        self.signatureImage.image = signatureImage
        
        //setting up the current date in format like dd/mm/yyyy
        let dateFormatter = DateFormatter()
        let dateAsString = "2015-12-09"
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let newDate = dateFormatter.date(from: dateAsString)
        
        let dateString = dateFormatter.string(from: newDate!)
        date.text = dateString
        
        
        //setting up current time in format like hh:mm:ss
        let timeAsString = "23:59:11"
        dateFormatter.dateFormat = "HH:mm:ss"
        let newTime = dateFormatter.date(from: timeAsString)
        let timeString = dateFormatter.string(from: newTime!)
        time.text = timeString
        
    }
    
    
    //setting up the cancel function to handle the action when user press cancel in signature view
    func epSignature(_: EPSignatureViewController, didCancel error: NSError) {
        print("user cancelled")
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
