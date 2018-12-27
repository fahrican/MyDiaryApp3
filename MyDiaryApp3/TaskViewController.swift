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
    
    @IBOutlet weak var myDays: UITextView!
    
    @IBOutlet weak var headline: UILabel!
    
    @IBOutlet weak var textAddDay: UIButton!
    
    @IBOutlet weak var textAddToDo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.myToDos.text = ""
        self.myDays.text = ""
        self.headline.text = NSLocalizedString("WhatIdidToday", comment: "")
        self.textAddDay.setTitle(NSLocalizedString("AddDay", comment: ""), for: .normal)
        self.textAddToDo.setTitle(NSLocalizedString("AddToDo", comment: ""), for: .normal)
    }

    @IBAction func addDayButton(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let dayEntity = NSEntityDescription.entity(forEntityName: "Day", in: managedContext)!
        
        let day = NSManagedObject(entity: dayEntity, insertInto: managedContext)
        
        day.setValue(self.userInput.text, forKey: "day_name")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
        
        // auslesen
        let dayFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
        let days = try! managedContext.fetch(dayFetch)
        
        var dayNames = ""
        
        for case let day as Day in days {
            dayNames = dayNames + day.day_name! + "\n"
        }
        self.myDays.text = dayNames
        
        self.userInput.text = ""
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

