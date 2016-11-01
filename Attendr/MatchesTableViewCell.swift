//
//  MatchesTableViewCell.swift
//  Attendr
//
//  Created by Ewan Sheldon on 31/10/2016.
//  Copyright © 2016 Matt Vickers. All rights reserved.
//

import UIKit

class MatchesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var matchPhoto: UIImageView!
    
    @IBOutlet weak var responseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}


//if let url = NSURL(string: "http://graph.facebook.com/\(fbId)/picture?type=large") {
//    if let data = NSData(contentsOf: url as URL) {
//        imageURL.image = UIImage(data: data as Data)
//        print(imageURL)
//    }
//}
