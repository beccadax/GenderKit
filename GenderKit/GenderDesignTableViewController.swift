//
//  GenderDesignTableViewController.swift
//  GenderKit
//
//  Created by Brent Royal-Gordon on 9/5/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import UIKit

protocol GenderDesignTableViewControllerDelegate: class {
    func genderDesignController(sender: GenderDesignTableViewController, didDesignGender gender: Gender)
    func genderDesignControllerDidCancel(sender: GenderDesignTableViewController)
}

class GenderDesignTableViewController: UITableViewController {
    weak var delegate: GenderDesignTableViewControllerDelegate?
    
    override init() {
        super.init(style: .Grouped)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder: NSCoder) {
        fatalError("GenderDesignTableViewController does not support NSCoding")
    }
    
    var currentGender: Gender = .Other(description: "", pronouns: PronounSet(heShe: "", himHer: "", hisHer: "", hisHers: "")) {
        didSet {
            updateDoneEnabled()
        }
    }
    
    private func valueForIndexPath(indexPath: NSIndexPath, ofGender gender: Gender) -> String {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            return gender.description
        case (1, 0):
            return gender.pronouns.heShe
        case (1, 1):
            return gender.pronouns.himHer
        case (1, 2):
            return gender.pronouns.hisHer
        case (1, 3):
            return gender.pronouns.hisHers
        default:
            fatalError("Invalid gender component index")
        }
    }
    
    private func setValue(value: String, forIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            currentGender.description = value
        case (1, 0):
            currentGender.pronouns.heShe = value
        case (1, 1):
            currentGender.pronouns.himHer = value
        case (1, 2):
            currentGender.pronouns.hisHer = value
        case (1, 3):
            currentGender.pronouns.hisHers = value
        default:
            fatalError("Invalid gender component index")
        }
    }
    
    @IBAction func done(sender: AnyObject?) {
        delegate?.genderDesignController(self, didDesignGender: currentGender)
    }
    
    @IBAction func cancel(sender: AnyObject?) {
        delegate?.genderDesignControllerDidCancel(self)
    }
    
    @IBAction func edit(sender: AnyObject?) {
        if let sender = sender as? UITextField {
            setValue(sender.text, forIndexPath: tableView.indexPathForCell(sender.enclosingTableViewCell!)!)
        }
    }
    
    @IBAction func next(sender: AnyObject?) {
        if let sender = sender as? UITextField {
            let indexPath = tableView.indexPathForCell(sender.enclosingTableViewCell!)!
            if let nextIndexPath = tableView.indexPathForRowAfterIndexPath(indexPath) {
                let cell = tableView.cellForRowAtIndexPath(nextIndexPath) as GenderDesignCell
                cell.otherTextField.becomeFirstResponder()
            }
        }
    }
    
    private func updateDoneEnabled() {
        navigationItem.rightBarButtonItem?.enabled = reduce(map(tableView.indexPathsForAllRows) { self.valueForIndexPath($0, ofGender: self.currentGender) != "" }, true, &)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Gender Designer", comment: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel:")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "done:")
        updateDoneEnabled()
        
        tableView.registerClass(GenderDesignCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Force cells to exist
        tableView.reloadData()
        
        let firstCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as GenderDesignCell
        firstCell.otherTextField.becomeFirstResponder()
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 4
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? NSLocalizedString("Gender Identity", comment: "") : NSLocalizedString("Pronouns", comment: "")
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as GenderDesignCell
        
        cell.equivalentLabelCollapsed = (indexPath.section == 0)
        
        cell.equivalentLabel.text = NSString(format: NSLocalizedString("“%@” or “%@”", comment: ""), valueForIndexPath(indexPath, ofGender: .Male), valueForIndexPath(indexPath, ofGender: .Female))
        cell.otherTextField.text = valueForIndexPath(indexPath, ofGender: currentGender)
        
        cell.otherTextField.tag = indexPath.row
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? GenderDesignCell {
            cell.otherTextField.addTarget(self, action: "edit:", forControlEvents: .EditingChanged)
            cell.otherTextField.addTarget(self, action: "next:", forControlEvents: .EditingDidEndOnExit)
        }
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? GenderDesignCell {
            cell.otherTextField.removeTarget(self, action: "edit:", forControlEvents: .ValueChanged)
            cell.otherTextField.removeTarget(self, action: "next:", forControlEvents: .EditingDidEndOnExit)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as GenderDesignCell
        cell.otherTextField.becomeFirstResponder()
    }
}

extension UIView {
    var enclosingTableViewCell: UITableViewCell? {
        return superview?.enclosingTableViewCell
    }
}

extension UITableViewCell {
    override var enclosingTableViewCell: UITableViewCell? {
        return self
    }
}

extension UITableView {
    var indexPathsForAllRows: [NSIndexPath] {
        let nestedIndexPaths = map(0 ..< numberOfSections()) { section in
            map(0 ..< self.numberOfRowsInSection(section)) { row in
                NSIndexPath(forRow: row, inSection: section)
            }
        }
        return reduce(nestedIndexPaths, [], +)
    }
    
    func indexPathForRowAfterIndexPath(indexPath: NSIndexPath) -> NSIndexPath? {
        let row = indexPath.row + 1
        if numberOfRowsInSection(indexPath.section) == row {
            let section = indexPath.section + 1
            if section == numberOfSections() {
                return nil
            }
            return NSIndexPath(forRow: 0, inSection: section)
        }
        return NSIndexPath(forRow: row, inSection: indexPath.section)
    }
}
