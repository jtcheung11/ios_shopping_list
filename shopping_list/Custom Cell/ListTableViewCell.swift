//
//  ListTableViewCell.swift
//  shopping_list
//
//  Created by Jonmichael Cheung on 2/11/22.
//

import UIKit

protocol itemBoughtDelegate: AnyObject {
    
    func checkButtonTapped(_ sender :ListTableViewCell)
}

class ListTableViewCell: UITableViewCell {
    
    
    var listItems: ListItems?{
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet var completeButton: UIButton!
    @IBOutlet var itemLabel: UILabel!
    
    weak var delegate:itemBoughtDelegate?
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.checkButtonTapped(self)
        }
    }
    
    func updateViews() {
        guard let item = listItems else { return }
        itemLabel.text = item.item
        if item.isComplete {
            completeButton.setImage(UIImage(named: "complete"), for: .normal)
        } else {
            completeButton.setImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
    
}// End of class
