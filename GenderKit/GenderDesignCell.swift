//
//  GenderDesignCell.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/5/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import UIKit

class GenderDesignCell: UITableViewCell {
    var equivalentLabel = UILabel()
    var otherTextField = UITextField()
    
    var equivalentLabelCollapsed: Bool = false {
        didSet {
            if equivalentLabelCollapsed {
                equivalentLabel.hidden = true
                collapsingConstraint = NSLayoutConstraint(item: equivalentLabel, attribute: .Left, relatedBy: .Equal, toItem: otherTextField, attribute: .Left, multiplier: 1, constant: 0)
            }
            else {
                equivalentLabel.hidden = false
                collapsingConstraint = nil
            }
        }
    }
    private var collapsingConstraint: NSLayoutConstraint? {
        willSet {
            if let constraint = collapsingConstraint {
                NSLayoutConstraint.deactivateConstraints([ constraint ])
            }
        }
        didSet {
            if let constraint = collapsingConstraint {
                NSLayoutConstraint.activateConstraints([ constraint ])
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        otherTextField.placeholder = NSLocalizedString("Enter Yours", comment: "")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        equivalentLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        equivalentLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(equivalentLabel)
        
        otherTextField.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        otherTextField.borderStyle = .None
        otherTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        otherTextField.placeholder = NSLocalizedString("Enter Yours", comment: "")
        addSubview(otherTextField)
        
        NSLayoutConstraint.activateConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("|-16-[equivalent]-(8@995)-[other(==equivalent)]-16-|", options: .AlignAllCenterY, metrics: nil, views: [ "equivalent": equivalentLabel, "other": otherTextField ])
        )
        NSLayoutConstraint.activateConstraints(
            [equivalentLabel, otherTextField].map { view in NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0) }
        )
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported for GenderDesignCell")
    }
}
