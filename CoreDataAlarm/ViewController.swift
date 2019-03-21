//
//  ViewController.swift
//  CoreDataAlarm
//
//  Created by phoebe on 3/19/19.
//  Copyright © 2019 phoebe. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LoadAlarm()
    }
    var alarmo = [Alarm]()
    let formatter = DateFormatter()
   
    //to create alarm
    @IBAction func addAlarm(_ sender: UIButton) {
         formatter.dateFormat = "HH:mm"
        let DateTime = formatter.date(from: "05:30");
        create(name: "myAlarm", fireDate: DateTime!, enabled: true)
    }
    @IBAction func removeAlarm(_ sender:UIButton) {
         formatter.dateFormat = "HH:mm"
        let DateTime = formatter.date(from: "06:30");
        
        delete(date: DateTime!)
        
    }
    //done
    @IBAction func updateAlarm(_ sender: UIButton) {
        formatter.dateFormat = "HH:mm"
        let DateTime = formatter.date(from: "08:30");
        let NEWdate = formatter.date(from: "09:30");
        changeDate(newDate: NEWdate!, fireDate: DateTime!)
    }
    @IBAction func updateEnableAlarm(_ sender: UIButton) {
        formatter.dateFormat = "HH:mm"
        let DateTime = formatter.date(from: "09:30");
        changeenabled(enabled: false, fireDate: DateTime!)
    }
    func create(name: String, fireDate: Date, enabled: Bool){
        //initialize the alarm
        let alarm = Alarm(context: context)
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
           alarm.stringofDate =  formatter.string(from: fireDate)
        (UIApplication.shared.delegate as! AppDelegate ).saveContext()
       
        //to be added global
        //yratb al notification bta3t alarm
      //  scheduleUserNotification(for: alarm)
        
        
    }
    //fhmthaaa
    func changeDate(newDate: Date,  fireDate: Date) {
        
        var coun : Int = 0
//cancelUserNotification(for: alarm)
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        LoadAlarm()
        for alarm in alarmo{
            
            if alarm.stringofDate == formatter.string(from: fireDate){
                alarm.fireDate = newDate
                alarm.stringofDate =  formatter.string(from: newDate)
                (UIApplication.shared.delegate as! AppDelegate ).saveContext()
              
            }else{
                coun += 1
            }
            if(coun == alarmo.count){
                    let alert = UIAlertController(title: "alarm couldn't find", message: "no matched date", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(OKAction)
                    
                    self.present(alert, animated: true, completion: nil)
        }
        }
      //  scheduleUserNotification(for: alarm)
           }
    func changeenabled(enabled: Bool,  fireDate: Date){
        var coun : Int = 0
        //cancelUserNotification(for: alarm)
        LoadAlarm()
        for alarm in alarmo{
            if alarm.fireDate == fireDate{
                alarm.enabled = enabled
                (UIApplication.shared.delegate as! AppDelegate ).saveContext()
            
            }else{
                coun += 1
            }
            if(coun == alarmo.count){
                let alert = UIAlertController(title: "alarm couldn't find", message: "no matched date", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                
                self.present(alert, animated: true, completion: nil)
            }
       
        }}
   
    //fhmtha
    func delete(date: Date){
        var coun : Int = 0
       LoadAlarm()
        for alarm in alarmo{
            if alarm.fireDate == date{
                 // self.cancelUserNotification(for: alarm)
                context.delete(alarm)
                (UIApplication.shared.delegate as! AppDelegate ).saveContext()
              //saveToPersistentStore()
            }else{   coun += 1
            }
            if (coun == alarmo.count){
                let alert = UIAlertController(title: "alarm couldn't delete", message: "no matched date", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                
                self.present(alert, animated: true, completion: nil)
            }
            (UIApplication.shared.delegate as! AppDelegate ).saveContext()
        }

        
        
    }
    //fhmtha
    func toggleEnabled(index: Int ){
        print("yes")
        LoadAlarm()
        alarmo[index].enabled = !alarmo[index].enabled
        (UIApplication.shared.delegate as! AppDelegate ).saveContext()

    }
    func LoadAlarm(){
        let request : NSFetchRequest<Alarm>=Alarm.fetchRequest()
        do{
            alarmo = try context.fetch(request)
        }catch {
            print("Error fetching")
        }
        for alarm in alarmo{
            print(alarm.enabled)
        }
    }
}
