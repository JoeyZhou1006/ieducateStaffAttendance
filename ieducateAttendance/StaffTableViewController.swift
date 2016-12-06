//
//  StaffTableViewController.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 21/11/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import UIKit

class StaffTableViewController: UITableViewController {
    var onlineStaff : [String: Staff] = [:]

    var offlineStaff : [String: Staff] = [:]

    @IBOutlet weak var staffTableView: UITableView!
    
    var tempdata = tempDatasets()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.staffTableView.rowHeight = 44.0
        //access method in model to get online and offline staff dictionaries ready, so we can use it for the table view
        self.tempdata.retrieveDataFromServer(){(response) in
        
            self.onlineStaff = response.0
            self.offlineStaff = response.1
            
            print("after retriving from the web")
            print(self.onlineStaff.count)
            print(self.offlineStaff.count)
            
            
            print("reloading data now")
            //reload data after retriving data from the web
            self.staffTableView.reloadData()
            print("after reloading data")
        
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func imageWithImage(image:UIImage,scaledToSize newSize:CGSize)->UIImage{
//        
//        UIGraphicsBeginImageContext( newSize )
//        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!.withRenderingMode(.alwaysTemplate)
//    }

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
            
           
            cell.staffImage.image = onlineStaff[key]!.profilePic!           // cell.staffImage.frame = CGRect(x:0.0,y:0.0,width:40.0,height:40.0)
            print(onlineStaff[key]?.profilePic)
            cell.staffName.text = onlineStaff[key]?.Name
            cell.uid = onlineStaff[key]?.tableName
            print("here is the table name which should be uique")
            print(cell.uid)
            print(onlineStaff[key]?.Name)
            
        }else{
            let index = offlinestaffkeys[indexPath.row]
            
            cell.staffImage.image = offlineStaff[index]!.profilePic!
            // cell.staffImage.frame = CGRect(x:0.0,y:0.0,width:40.0,height:40.0)
            cell.staffName.text = offlineStaff[index]!.Name
        }

        
        // Configure the cell...

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
//            
//        
        let indexpath = self.tableView.indexPathForSelectedRow!
        let currentcell = tableView.cellForRow(at: indexpath) as! staffTableViewCell
//        
//        
//            print("preparing for segue")
//        print(currentcell.staffName)
//        print(currentcell.staffName.text)
//            
        let staffname = currentcell.staffName.text!
        print(staffname)
    
        destination.staffName = staffname
        destination.staffImage = currentcell.staffImage.image
            destination.uid = currentcell.uid
        
       //if segue.identifier == "staffSignIn" {
//            let destinationNavigationController = segue.destination. as! UINavigationController
//            
//            let destinationController = destinationNavigationController.topViewController as! StaffSignInViewController
//            
//            destinationController.staffName?.text = currentcell.staffName.text!
        
 
        
      }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var destination: StaffSignInViewController = storyboard?.instantiateViewController(withIdentifier: "staffSignIn") as! StaffSignInViewController
//        
//        self.navigationController?.pushViewController(destination, animated: true)
        
        
        //performSegue(withIdentifier: "staffSignIn", sender: self)
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

}
