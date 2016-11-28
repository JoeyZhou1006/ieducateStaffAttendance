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
            
            cell.staffImage.image = onlineStaff[key]?.profilePic
            
            print(onlineStaff[key]?.profilePic)
            cell.staffName.text = onlineStaff[key]?.Name
            print(onlineStaff[key]?.Name)
            
        }else{
            let index = offlinestaffkeys[indexPath.row]
            cell.staffImage.image = offlineStaff[index]!.profilePic
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
