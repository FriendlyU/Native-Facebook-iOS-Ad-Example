//
//  AdTableCell.swift
//  Native FB Ads Example
//
//  Created by Henry Saniuk on 2/5/17.
//  Copyright © 2017 Henry Saniuk. All rights reserved.
//

import UIKit

class AdTableCell: UITableViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak internal var postView: UIView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var callToActionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postView.layer.cornerRadius = 5
        self.backgroundColor = UIColor.gray
        self.postView.backgroundColor = UIColor.white
        callToActionButton.setTitleColor(UIColor.red, for: UIControlState.normal)
        callToActionButton.backgroundColor = UIColor.clear
        callToActionButton.layer.borderWidth = 1.0
        callToActionButton.layer.borderColor = UIColor.red.cgColor
        callToActionButton.layer.cornerRadius = 5
        callToActionButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

