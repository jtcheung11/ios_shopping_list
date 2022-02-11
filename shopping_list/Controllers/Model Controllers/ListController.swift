//
//  ListController.swift
//  shopping_list
//
//  Created by Jonmichael Cheung on 2/10/22.
//

import UIKit

class ListController{
    
    //Singleton
    static let shared = ListController()
    
    //Source of Truth (SOT)
    var listItems: [ListItems] = []
    
    
    func createListItemWith(item: String) {
        let newItem = ListItems(item: item)
        listItems.append(newItem)
        saveToPersistenceStore()
    }
    
    func update(item: String){
        saveToPersistenceStore()
    }
    
    func toggleIsComplete(item: ListItems) {
        item.isComplete.toggle()
        saveToPersistenceStore()
    }
    
    func delete(item: ListItems) {
        guard let index = listItems.firstIndex(of: item) else { return }
        listItems.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: - PERSISTENCE
    
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Task.json") // <-- Change file (app) name
        return fileURL
    }
    
    func saveToPersistenceStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(listItems)
            try data.write(to: createPersistenceStore())
        } catch {
            print("\(error) >> \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistenceStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            listItems = try jsonDecoder.decode([ListItems].self, from: data) // <-- Update S.O.T & Update the decoded type
        } catch {
            print("\(error) >> \(error.localizedDescription)") // <-- Update error message
        }
    }
    
    
}//End of class
