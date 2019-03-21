//
//  AlarmTableViewController.swift
//  CoreDataAlarm
//
//  Created by phoebe on 3/19/19.
//  Copyright © 2019 phoebe. All rights reserved.
//

import UIKit
import CoreData
protocol soso: class{
    func alarmWasToggled(sender: AlarmTableViewCell, ison : Bool)
}

class AlarmTableViewController: UITableViewController,soso {
    var del = ViewController()
    func alarmWasToggled(sender: AlarmTableViewCell, ison: Bool) {
        let indexPath = self.tableView.indexPath(for: sender)
        del.toggleEnabled(index: indexPath!.row)
    }
    
  /*  func alarmWasToggled(sender: AlarmTableViewCell,ison : Bool) {
        let indexPath = self.tableView.indexPath(for: sender)
       print("yes")
        
    }*/
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    var alarmo = [Alarm]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LoadAlarm()
}
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(alarmo.count)
        return alarmo.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath) as? AlarmTableViewCell
        
        cell!.nameLabel!.text = alarmo[indexPath.row].name
        cell!.timeLabel!.text = alarmo[indexPath.row].stringofDate
        cell?.alarmSwitch.isOn = alarmo[indexPath.row].enabled
        cell?.delegatess = self
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func LoadAlarm(){
        let request : NSFetchRequest<Alarm>=Alarm.fetchRequest()
        do{
            alarmo = try context.fetch(request)
        }catch {
            print("Error fetching")
        }
    }
    /*func alarmWasToggled(sender: AlarmTableViewCell) {
     
    }*/
    
}
