//
//  staffTableViewCell.swift
//  ieducateAttendance
//
//  Created by JoeyZhou on 21/11/16.
//  Copyright © 2016 JoeyZhou. All rights reserved.
//

import UIKit

class staffTableViewCell: UITableViewCell {
    
    
       
    @IBOutlet weak var staffName: UILabel!
    
    @IBOutlet weak var staffImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
