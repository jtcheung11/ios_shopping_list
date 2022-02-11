//
//  ShoppingListTableViewController.swift
//  shopping_list
//
//  Created by Jonmichael Cheung on 2/10/22.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    var listItems: [ListItems]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListController.shared.loadFromPersistenceStore()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListController.shared.listItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        let item = ListController.shared.listItems[indexPath.row]
        cell.delegate = self
        cell.listItems = item
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = ListController.shared.listItems[indexPath.row]
            ListController.shared.delete(item: itemToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - ACTION    @IBAction func listButtonTapped(_ sender: Any) {
    
    @IBAction func addItemButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Item", message: "Please add your item.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let addAct = UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let field = alertController.textFields else { return }
            let input = field[0]
            guard let newItem = input.text, !newItem.isEmpty else { return }
            print("Got the \(newItem)!")
            ListController.shared.createListItemWith(item: newItem)
            self.tableView.reloadData()
        })
    
        //Cancel
        alertController.addAction(cancelAction)
        //Add
        alertController.addAction(addAct)
        //textfield
        alertController.addTextField {field in
            field.placeholder = "What do you need from the store?"
        }
        present(alertController, animated: true)
    }
}// END of class

extension ShoppingListTableViewController: itemBoughtDelegate {
    func checkButtonTapped(_ sender :ListTableViewCell) {
        guard let item = sender.listItems else { return }
        ListController.shared.toggleIsComplete(item: item)
        sender.updateViews()
    }
}// End of extension

