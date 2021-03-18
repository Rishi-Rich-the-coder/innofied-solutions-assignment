//
//  UserDataTableViewCell.swift
//  InnofiedSolutionAssignment
//
//  Created by Rishikesh Yadav on 3/15/21.
//

import UIKit

class UserDataTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailIdLabel: UILabel!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.hidesWhenStopped = true
    }
    
    func setupCell(with data: PersonDetails?) {
        
        if let personData = data {
            setViewVisibility(with: true)
            userNameLabel.text = personData.first_name  + " " + personData.last_name
            emailIdLabel.text = data?.email
            setupImageView()
            indicatorView.stopAnimating()
        } else {
            setViewVisibility(with: false)
            indicatorView.startAnimating()
        }
    }
    
    func setViewVisibility(with isVisible: Bool) {
        userNameLabel.alpha = isVisible ? 1 : 0
        emailIdLabel.alpha = isVisible ? 1 : 0
        profilePhotoImageView.alpha = isVisible ? 1 : 0

    }
    
    func setupImageView() {
        profilePhotoImageView.layer.masksToBounds = true
        profilePhotoImageView.clipsToBounds = true
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.size.height / 2
        profilePhotoImageView.layer.borderWidth = 1.0
        profilePhotoImageView.layer.borderColor = UIColor.darkGray.cgColor
    }
}
