//
//  LocalDataFromCoreData.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 20/10/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class InteractionWithCoreData {
    
    
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    
    }
    
    
    func storeStaff(name: String, imagename: String, localUrl: String){
        let context = getContext()
        
        
        let entity = NSEntityDescription.entity(forEntityName: "Staff", in: context)
        
        
        //set up an empty staff object to be filled with data and inserted to the core data
        let staff = NSManagedObject(entity: entity!, insertInto: context)
        staff.setValue(name, forKey: "name")
        staff.setValue(imagename, forKey: "imageName")
        staff.setValue(localUrl, forKey: "localImageUrl")
        
        
        do {
            try context.save()
            print("new staff record saved!!!!")

        
        }catch{
        
            print("error occured on saving record")
        }
        
        
    
    
    }
    
    
    func fetchStaff(){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Staff")
        
        do {
            let searchResult = try getContext().fetch(fetchRequest)
            
            print("number of fetched requests \(searchResult.count)")
            
            
            
            for p in (searchResult as! [NSManagedObject]){
                print("name \(p.value(forKey: "name")!) imageName: \(p.value(forKey: "imageName")!)   imagelocalURl : \(p.value(forKey: "localImageUrl"))")
            
            
            }
        
        
        } catch{
        
            print(error)
        
        }
        
    
    
    }
    
    
    
    

    
    



}
