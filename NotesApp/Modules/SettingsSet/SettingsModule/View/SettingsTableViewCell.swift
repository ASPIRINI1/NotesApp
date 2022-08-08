//
//  SettingsTableViewCell.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 30.07.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    var leftItem: UIView? {
        didSet {
            createCell()
        }
    }
    var rightItem: UIView? {
        didSet {
            createCell()
        }
    }
    var height: CGFloat?
    
    private func createCell() {
        
        self.selectionStyle = .none
        
        if let leftItem = leftItem {

            addSubview(leftItem)
            leftItem.translatesAutoresizingMaskIntoConstraints = false
            var constraints = [NSLayoutConstraint]()

            constraints.append(NSLayoutConstraint(item: layoutMarginsGuide, attribute: .top, relatedBy: .equal, toItem: leftItem, attribute: .top, multiplier: 1, constant: 5))
            constraints.append(NSLayoutConstraint(item: layoutMarginsGuide, attribute: .bottom, relatedBy: .equal, toItem: leftItem, attribute: .bottom, multiplier: 1, constant: 5))
            constraints.append(NSLayoutConstraint(item: layoutMarginsGuide, attribute: .left, relatedBy: .equal, toItem: leftItem, attribute: .left, multiplier: 1, constant: 5))

//            leftItem.backgroundColor = .blue

            addConstraints(constraints)
        }

        if let rightItem = rightItem {

            addSubview(rightItem)
            
            rightItem.translatesAutoresizingMaskIntoConstraints = false
            var constraints = [NSLayoutConstraint]()
//
            constraints.append(NSLayoutConstraint(item: layoutMarginsGuide, attribute: .top, relatedBy: .equal, toItem: rightItem, attribute: .top, multiplier: 1, constant: 5))
            constraints.append(NSLayoutConstraint(item: layoutMarginsGuide, attribute: .bottom, relatedBy: .equal, toItem: rightItem, attribute: .bottom, multiplier: 1, constant: 5))
            constraints.append(NSLayoutConstraint(item: layoutMarginsGuide, attribute: .right, relatedBy: .equal, toItem: rightItem, attribute: .right, multiplier: 1, constant: 5))
            rightItem.frame = CGRect(origin: CGPoint(x: 20, y: 20), size: CGSize(width: 100, height: 20))

            if let leftItem = leftItem {
                constraints.append(NSLayoutConstraint(item: leftItem, attribute: .right, relatedBy: .equal, toItem: rightItem, attribute: .left, multiplier: 1, constant: 5))
            }
            
            addConstraints(constraints)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
