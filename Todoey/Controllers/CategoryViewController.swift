//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Gary Naz on 9/14/19.
//  Copyright © 2019 Gari Nazarian. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories : Results<Category>? //A collection of Results that are Category objects...
        
    override func viewDidLoad() {
        super.viewDidLoad()

         loadCategories()

    }

    //MARK: - TableView DataSource Methods
        //To display all categories inside the persistent container.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
                
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
    }
    
    //MARK: - Data Manipulation Methods
        //SaveData and LoadData so we can use CRUD.
    
    func save(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(){
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //To add new categories using the categories entity.
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert) //The Alert box
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in //The Add Item Button
            
            let newCategory = Category()
            newCategory.name = textField.text!
                        
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (AlertTextField) in
            AlertTextField.placeholder = "Create new Category" //The Textbox
            textField = AlertTextField   //we're extending the scope of the alertTextField to the scope of the addButtonPressed.
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil) //Presents the alert over the CategoryViewController.
        
    }
    


    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow { //Grabs the current row that is selected...
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
}
