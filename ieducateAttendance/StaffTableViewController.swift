//
//  StaffTableViewController.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 21/11/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class StaffTableViewController: UITableViewController, GetMessageDelegate,NVActivityIndicatorViewable {
    var onlineStaff : [String: Staff] = [:]

    var offlineStaff : [String: Staff] = [:]
    
    
    var currentCellGlobal: staffTableViewCell?

    


    
    
    
    var  activityIndicatorView:NVActivityIndicatorView!
    
    
    
    @IBOutlet weak var staffTableView: UITableView!
    
    
    
    
    var tempdata = tempDatasets.tempData
    //var temp = tempDatasets.tempData

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show loading animation
        self.loadingAnimation()
  
                   //access method in model to get online and offline staff dictionaries ready, so we can use it for the table view
        self.tempdata.retrieveDataFromServer(){(response) in
        
            print(response)
            if(response != nil){
            self.onlineStaff = response.0
            self.offlineStaff = response.1
            }else{
                print("response is nil")
            
            }
       
            
            
            self.activityIndicatorView.stopAnimating()
            //reload data after retriving data from the web
            self.staffTableView.reloadData()

        
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadingAnimation(){
        
      
            let frame = CGRect(x: 30, y: 60, width: 130, height: 130)
        activityIndicatorView = NVActivityIndicatorView(frame: frame)
    

            activityIndicatorView.padding = 20
            activityIndicatorView.type = .ballPulse
            
            activityIndicatorView.color = .gray
            
            activityIndicatorView.center = self.view.center
            
            self.view.addSubview(activityIndicatorView)
            self.view.bringSubview(toFront: activityIndicatorView)
            
            activityIndicatorView.startAnimating()
            print(activityIndicatorView.isHidden)

    
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            
            return self.onlineStaff.count
        }
        else{
            
            return self.offlineStaff.count
        }

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! staffTableViewCell
        
        //keep a copy of dictionary keys of onlinestaff
        var onlinestaffkeys = Array(onlineStaff.keys)
        
        //keep a copy of dictionary keys of offlinestaff
        
        var offlinestaffkeys = Array(offlineStaff.keys)
        
        print("configuring staff cells")
        if(indexPath.section == 0){
            let key = onlinestaffkeys[indexPath.row]
            
           
            cell.staffImage.image = onlineStaff[key]!.profilePic!
            cell.staffName.text = onlineStaff[key]?.Name
            cell.uid = onlineStaff[key]?.tableName
            cell.lastOnsiteInfo = onlineStaff[key]?.onSite
           
            
            
        }else{
            let index = offlinestaffkeys[indexPath.row]
            
            cell.staffImage.image = offlineStaff[index]!.profilePic!
            // cell.staffImage.frame = CGRect(x:0.0,y:0.0,width:40.0,height:40.0)
            cell.staffName.text = offlineStaff[index]!.Name
            cell.uid = offlineStaff[index]?.tableName

            cell.lastOnsiteInfo = offlineStaff[index]?.onSite
  
        }
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        if(section  == 0 ){
            
            
            return "Online"
        }
        else{
            
            return "Offline"
            
        }
    }

    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "staffSignIn" {
        let destination = segue.destination as! StaffSignInViewController
        let indexpath = self.tableView.indexPathForSelectedRow!
        let currentcell = tableView.cellForRow(at: indexpath) as! staffTableViewCell

            
        currentCellGlobal = currentcell
         
        let staffname = currentcell.staffName.text!
        print(staffname)
    
        destination.staffName = staffname
        destination.staffImage = currentcell.staffImage.image
        destination.uid = currentcell.uid
        destination.onsite = currentcell.lastOnsiteInfo
            
        destination.delegate = self
       
      }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
 
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func getMessage(controller: StaffSignInViewController, changedOnsite: Bool) {
       // currentCellGlobal?.lastOnsiteInfo = 0
        
        //if the current selected staff is onsite, change it to offsite
        if(currentCellGlobal?.lastOnsiteInfo == "1"){
            //get the full information of this staff first
            let tempStaff = onlineStaff[(currentCellGlobal?.uid)!]
            //remove the changed staff cell from online in global singleton tempdata
            tempdata.onlineStaff.removeValue(forKey: (currentCellGlobal?.uid)!)
            //insert it to offline list in global singleton tempdata
            tempdata.offlineStaff[(currentCellGlobal?.uid)!] = tempStaff
        
        }else if(currentCellGlobal?.lastOnsiteInfo == "0"){
            //get the ful information of this staff 
            let tempStaff = offlineStaff[(currentCellGlobal?.uid)!]
            //remove the changed staff from offline in global singleton tempdata
            tempdata.offlineStaff.removeValue(forKey: (currentCellGlobal?.uid)!)
            //insert it to online staff list in global singleton tempdata
            tempdata.onlineStaff[(currentCellGlobal?.uid)!] = tempStaff
        }

        
        //here, we need to reload the tableview according to the changed online and offline dictionaries in global singleton tempdata
        self.onlineStaff = tempdata.onlineStaff
        self.offlineStaff = tempdata.offlineStaff
        self.staffTableView.reloadData()
        
    }
    
    

}
