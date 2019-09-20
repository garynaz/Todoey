//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Gary Naz on 9/14/19.
//  Copyright © 2019 Gari Nazarian. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

    }

    //MARK: - TableView DataSource Methods
        //To display all categories inside the persistent container.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //MARK: - Data Manipulation Methods
        //SaveData and LoadData so we can use CRUD.
    
    func saveData(){
        
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        
        self.tableView.reloadData()

    }
    
    func loadData(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            try categoryArray = context.fetch(request)
        } catch {
            print("Error loading category \(error)")
        }
        
        tableView.reloadData()
        
    }
    
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //To add new categories using the categories entity.
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert) //The Alert box
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in //The Add Item Button
            
            let newCategory = Category(context: self.context)

            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            self.saveData()
            
        }
        
        alert.addTextField { (AlertTextField) in
            AlertTextField.placeholder = "Create new Category" //The Textbox
            textField = AlertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    


    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)
        
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow { //Grabs the current row that is selected...
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
}
