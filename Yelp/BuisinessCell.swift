//
//  BuisinessCell.swift
//  Yelp
//
//  Created by Eli Scherrer on 1/22/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit

class BuisinessCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name
            thumbImageView.setImageWith(business.imageURL!)
            categoriesLabel.text = business.categories
            addressLabel.text = business.address
            distanceLabel.text = business.distance
            reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
            ratingImageView.setImageWith(business.ratingImageURL!)
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbImageView.layer.cornerRadius = 3
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
