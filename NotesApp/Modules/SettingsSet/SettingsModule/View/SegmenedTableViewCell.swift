//
//  SegmenedTableViewCell.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 18.09.2022.
//

import UIKit

protocol SegmenedTableViewCellDelegate: AnyObject {
    func segmenedTableViewCell(_ cell: SegmenedTableViewCell, didSet segment: Int)
}

class SegmenedTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        setNeedsUpdateConstraints()
        return label
    }()
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: [NSLocalizedString("System", comment: ""),
                                                 NSLocalizedString("Light", comment: ""),
                                                 NSLocalizedString("Dark", comment: "")])
        control.addTarget(self, action: #selector(selectSegment), for: .touchUpInside)
        control.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(control)
        setNeedsUpdateConstraints()
        return control
    }()
    weak var delegate: SegmenedTableViewCellDelegate?
    
    @objc
    private func selectSegment(_ sender: UISegmentedControl) {
        delegate?.segmenedTableViewCell(self, didSet: sender.selectedSegmentIndex)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 20))
        
        contentView.addConstraint(NSLayoutConstraint(item: segmentedControl, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: segmentedControl, attribute: .bottom, multiplier: 1, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: segmentedControl, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 20))
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .right, relatedBy: .equal, toItem: segmentedControl, attribute: .right, multiplier: 1, constant: 8))
    }
    
    func fill(title: String, theme: Int) {
        titleLabel.text = title
        segmentedControl.selectedSegmentIndex = theme
    }
}
