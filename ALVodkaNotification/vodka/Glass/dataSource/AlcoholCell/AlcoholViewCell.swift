//
//  AlcoholViewCell.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 02.04.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

class AlcoholViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageIconView: UIImageView!
    @IBOutlet var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func reloadCell(model: Alcohol) {
        titleLabel.text = model.title
        subTitle.text = model.subtitle
        imageIconView.image = model.image
    }
}