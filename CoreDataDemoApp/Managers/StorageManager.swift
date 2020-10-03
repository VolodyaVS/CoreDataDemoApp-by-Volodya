//
//  StorageManager.swift
//  CoreDataDemoApp
//
//  Created by Vladimir Stepanchikov on 03.10.2020.
//

import UIKit
import CoreData

class StorageManager {
    
    // MARK: - Public Properties
    static let shared = StorageManager()
    
    // MARK: - Private Properties
    private var tasks: [Task] = []
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - Public Methods
    func fetchData() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        return tasks
    }
    
    func save(_ taskName: String) -> [Task] {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return tasks}
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return tasks}
        task.name = taskName
        tasks.append(task)
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
        
        return tasks
    }
    
    func deleteData(_ task: Task) {
        context.delete(task)
        
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
    func saveTask(_ textField: String) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        task.name = textField
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
    }
    
}
