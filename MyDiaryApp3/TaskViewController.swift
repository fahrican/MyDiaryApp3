//
//  ViewController.swift
//  MyDiaryApp3
//
//  Created by fahri on 26.12.18.
//  Copyright © 2018 fahri. All rights reserved.
//

import UIKit
import CoreData


class TaskViewController: UIViewController {

    @IBOutlet weak var userInput: UITextField!
    
    @IBOutlet weak var myToDos: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.myToDos.text = ""
    }

    @IBAction func addTextButton(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        
        let task = NSManagedObject(entity: taskEntity, insertInto: managedContext)
        
        task.setValue(self.userInput.text, forKey: "today")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
        
        // auslesen
        let taskFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        let tasks = try! managedContext.fetch(taskFetch)
        
        var outPutText = ""
        
        for case let task as Task in tasks {
            outPutText = outPutText + task.today! + "\n"
        }
        
        self.myToDos.text = outPutText
        
        self.userInput.text = ""

        
    }
    

}

