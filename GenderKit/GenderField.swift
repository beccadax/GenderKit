//
//  GenderField.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/4/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import UIKit

@IBDesignable public class GenderField: UIControl, GenderDesignTableViewControllerDelegate, UIPopoverControllerDelegate {
    private let segmentedControl = UISegmentedControl(items: [ "Male", "Female", "Other…" ])
    private let pickerTapGesture: UIGestureRecognizer!
    
    public var selectedGender: Gender? {
        didSet {
            var otherName = "Other"
            switch selectedGender {
            case .Some(.Male):
                segmentedControl.selectedSegmentIndex = 0
            case .Some(.Female):
                segmentedControl.selectedSegmentIndex = 1
            case let .Some(.Other):
                segmentedControl.selectedSegmentIndex = 2
                otherName = selectedGender!.description
            case .None:
                segmentedControl.selectedSegmentIndex = (nilGenderLabel != nil) ? 3 : UISegmentedControlNoSegment
            }
            
            segmentedControl.setTitle("\(otherName)…", forSegmentAtIndex: 2)
        }
    }
    
    @IBInspectable public var nilGenderLabel: String? = nil {
        didSet {
            if let label = nilGenderLabel {
                if segmentedControl.numberOfSegments == 4 {
                    segmentedControl.setTitle(label, forSegmentAtIndex: 3)
                }
                else {
                    segmentedControl.insertSegmentWithTitle(label, atIndex: 3, animated: false)
                }
                if selectedGender == nil {
                    segmentedControl.selectedSegmentIndex = 3
                }
            }
            else {
                segmentedControl.removeSegmentAtIndex(3, animated: false)
                if selectedGender == nil {
                    segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
                }
            }
        }
    }
    
    public init(frame: CGRect?, orCoder coder: NSCoder?) {
        precondition((frame == nil) != (coder == nil), "Must provide one of frame and coder")
        
        if let frame = frame {
            super.init(frame: frame)
        }
        else {
            super.init(coder: coder!)
        }
        
        segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        
        segmentedControl.frame = self.bounds
        segmentedControl.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        addSubview(segmentedControl)
        
        segmentedControl.addTarget(self, action: "valueChanged:forEvent:", forControlEvents: .ValueChanged)
        
        pickerTapGesture = UITapGestureRecognizer(target: self, action: "pickerTapped:")
        pickerTapGesture.delaysTouchesBegan = false
        pickerTapGesture.delaysTouchesEnded = false
        pickerTapGesture.cancelsTouchesInView = false
        segmentedControl.addGestureRecognizer(pickerTapGesture)
    }
    
    public convenience override init(frame: CGRect) {
        self.init(frame: frame, orCoder: nil)
    }
    
    public convenience required init(coder: NSCoder) {
        self.init(frame: nil, orCoder: coder)
    }
    
    private var priorGender: Gender?
    private var genderDesignPopoverController: UIPopoverController?
    
    func valueChanged(sender: UISegmentedControl, forEvent event: UIEvent!) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectedGender = .Male
            sendActionsForControlEvents(.ValueChanged)
        case 1:
            selectedGender = .Female
            sendActionsForControlEvents(.ValueChanged)
        case 3, UISegmentedControlNoSegment:
            selectedGender = nil
            sendActionsForControlEvents(.ValueChanged)
        case 2:
            presentGenderDesigner(nil)
        default:
            fatalError("Gender picker segmented control should not have more than 4 segments")
        }
    }
    
    func pickerTapped(gesture: UIGestureRecognizer) {
        // We delay this so that, if valueChanged() is also being called, it's done first.
        dispatch_async(dispatch_get_main_queue()) {
            switch self.selectedGender {
            case .Some(.Other):
                // Did we re-tap the "Other" button?
                if self.segmentedControl.selectedSegmentIndex == 2 {
                    self.presentGenderDesigner(self.selectedGender)
                }
            default:
                break
            }
        }
    }
    
    private func presentGenderDesigner(gender: Gender?) {
        priorGender = selectedGender
        
        let genderDesignController = GenderDesignTableViewController()
        genderDesignController.delegate = self
        
        if let gender = gender {
            genderDesignController.currentGenderLexicon = gender.genderLexicon
        }
        
        let navController = UINavigationController(rootViewController: genderDesignController)
        genderDesignPopoverController = UIPopoverController(contentViewController: navController)
        genderDesignPopoverController!.delegate = self
        
        genderDesignPopoverController!.presentPopoverFromRect(segmentedControl.bounds, inView: segmentedControl, permittedArrowDirections: .Any, animated: true)
    }
    
    func genderDesignController(sender: GenderDesignTableViewController, didChangeLexicon lexicon: GenderLexicon) {
        selectedGender = Gender(lexicon)
        sendActionsForControlEvents(.ValueChanged)
        
        genderDesignPopoverController!.dismissPopoverAnimated(true)
        genderDesignPopoverController!.contentViewController.dismissViewControllerAnimated(true, completion: nil)
        genderDesignPopoverController = nil
    }
    
    func genderDesignControllerDidCancel(sender: GenderDesignTableViewController) {
        selectedGender = priorGender
        genderDesignPopoverController!.dismissPopoverAnimated(true)
        genderDesignPopoverController!.contentViewController.dismissViewControllerAnimated(true, completion: nil)
        genderDesignPopoverController = nil
    }
    
    public func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        genderDesignPopoverController = nil
    }
}
