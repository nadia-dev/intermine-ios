//
//  TemplateDetailCell.swift
//  intermine-ios
//
//  Created by Nadia on 7/27/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

protocol TemplateDetailCellDelegate: class {
    func templateDetailCellDidTapSelectButton(cell: TemplateDetailCell)
}

class TemplateDetailCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var containerView: UIView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var operationTitleLabel: UILabel?
    @IBOutlet weak var operationLabel: UILabel?
    @IBOutlet weak var operationSelectButton: UIButton?

    @IBOutlet weak var valueTitleLabel: UILabel?
    @IBOutlet weak var valueTextField: UITextField?
    
    weak var delegate: TemplateDetailCellDelegate?
    
    var index: Int? = nil
    
    static let identifier = "TemplateDetailCell"
    
    var templateQuery: TemplateQuery? {
        didSet {
            if let op = templateQuery?.getOperation() {
                if op != "LOOKUP" {
                    titleLabel?.isHidden = false
                    operationSelectButton?.isHidden = false
                    titleLabel?.text = templateQuery?.getPath()
                } else {
                    titleLabel?.isHidden = true
                    operationSelectButton?.isHidden = true
                }
            }
            operationLabel?.text = templateQuery?.getOperation()
            valueTextField?.text = templateQuery?.getValue()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        operationTitleLabel?.text = String.localize("Templates.Operator")
        valueTitleLabel?.text = String.localize("Templates.Value")
        operationSelectButton?.setTitle(String.localize("Templates.CTA.SelectOperation"), for: .normal)
        operationSelectButton?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        operationSelectButton?.titleLabel?.numberOfLines = 2
        operationSelectButton?.titleLabel?.textAlignment = NSTextAlignment.center
        NotificationCenter.default.addObserver(self, selector: #selector(self.operationChanged(_:)), name: NSNotification.Name(rawValue: Notifications.operationChanged), object: nil)
        valueTextField?.delegate = self
        valueTextField?.addTarget(self, action: #selector(textFieldEdited(_:)), for: UIControlEvents.editingChanged)
        
        containerView?.layer.borderWidth = 1
        containerView?.layer.borderColor = Colors.gray56.withAlphaComponent(0.3).cgColor
    }
    
    @IBAction func operationSelectButtonTap(_ sender: Any) {
        self.delegate?.templateDetailCellDidTapSelectButton(cell: self)
    }
    
    func textFieldEdited(_ sender : UITextField) {
        guard let index = self.index else {
            return
        }
        var info: [String: Any] = [:]
        if let value = sender.text {
            info = ["value": value, "index": index]
        } else {
            info = ["value": "", "index": index]
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notifications.valueChanged), object: self, userInfo: info)
    }
    
    // MARK: Notification when operation is changed
    
    func operationChanged(_ notification: NSNotification) {
        if let op = notification.userInfo?["op"] as? String, let index = notification.userInfo?["index"] as? Int {
            if self.index == index {
                templateQuery?.changeOperation(operation: op)
                operationLabel?.text = op
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        templateQuery = nil
        index = nil
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
