//
//  StaffSignInViewController.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 4/12/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import UIKit

class StaffSignInViewController: UIViewController,UINavigationControllerDelegate {
    
    var uid: String!
    
    var staffName: String!
    

    @IBOutlet weak var staffNameLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        staffNameLabel.text = staffName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
