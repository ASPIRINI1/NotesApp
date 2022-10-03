//
//  SignInTableViewCell.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.09.2022.
//

import UIKit

protocol ButtonTableViewCellDelegate: AnyObject {
    func buttonTableViewCell(_ cell: ButtonTableViewCell, didTap button: UIButton)
}

class ButtonTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        return label
    }()
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .right
        button.addAction(UIAction(handler: { _ in
            self.delegate?.buttonTableViewCell(self, didTap: button)
        }), for: .touchUpInside)
        contentView.addSubview(button)
        return button
    }()
    weak var delegate: ButtonTableViewCellDelegate?
    
    override func updateConstraints() {
        super.updateConstraints()
        
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 20))
        
        contentView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: button, attribute: .bottom, multiplier: 1, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .right, relatedBy: .equal, toItem: button, attribute: .right, multiplier: 1, constant: 20))
    }
    
    func fill(title: String, button: String) {
        titleLabel.text = title
        self.button.setTitle(button, for: .normal)
        setNeedsUpdateConstraints()
    }
}
