//
//  EventTableViewController.swift
//  Attendr
//
//  Created by Thao Vo on 27/10/2016.
//  Copyright © 2016 Matt Vickers. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EventTableViewController: UITableViewController {

    // MARK: Properties
    var TableData:Array< Array<String> > = Array < Array<String>>()
    
    var eventName = ""
    var eventAddress = ""
    var eventDate = ""
    var eventLink = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        get_data_from_url("https://attendr-server.herokuapp.com/events")
    }
    
    
    func get_data_from_url(_ link:String) {
        let url:URL = URL(string: link)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
                guard let _:Data = data, let _:URLResponse = response, error == nil else {
                    return
                }
            self.extract_json(data!)
            })
            task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TableData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventTableViewCell
        
        // Configure the cell...
        cell.nameLabel?.text = TableData[indexPath.row][0]
        cell.addressLabel?.text = TableData[indexPath.row][1]
        cell.dateLabel?.text = TableData[indexPath.row][2]
        cell.responseButton.tag = indexPath.row
        
        cell.responseButton.addTarget(self, action: #selector(buttonHandler(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
      
    }

    
    func extract_json(_ data: Data) {
    
        let json: Any?
            
        do {
            json = try JSONSerialization.jsonObject(with: data, options: [])
        }
        
        catch {
            return
        }
        
        guard let _ = json as? NSDictionary else {
            return
        }
        
        if let events_object = json as? NSDictionary
            {
                if let events = events_object["events"] as? NSArray
                    {
                        for i in 0 ..< (events.count) {
                            if let event = events[i] as? NSDictionary
                            {
                                if let name = event["name"] as? String , let address = event["address"] as? String , let date = event["date"] as? String
                                {
                                    let event_id = "\(event["id"] ?? "")" 
                                    let item = [name, address, date, event_id]
                                    TableData.append(item)
                                }
                            }
                            
                        }
                    }
                }
        DispatchQueue.main.async(execute: {self.do_table_refresh()})
    }

    
    func do_table_refresh() {
        self.tableView.reloadData()
    }
    
    func buttonHandler(_ sender:UIButton!) {
            // Instantiate SecondViewController
            let responseViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResponseViewController") as! ResponseViewController
            
            // Set "Hello World" as a value to myStringValue
            responseViewController.myStringValue = TableData[sender.tag]
        
            // Take user to SecondViewController
            self.present(responseViewController, animated: true)
            

    }
    
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
