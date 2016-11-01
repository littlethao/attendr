//
//  ResponseViewController.swift
//  
//
//  Created by Thao Vo on 28/10/2016.
//
//

import UIKit
import MapKit

class ResponseViewController: UIViewController {

    var myStringValue:Array<String>!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var interestedButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var meetupLinkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = "\(myStringValue[0])"
        addressLabel.text = "\(myStringValue[1])"
        dateLabel.text = "\(myStringValue[2])"
        descriptionLabel.text = "\(myStringValue[4].html2String)"
        
        interestedButton.setImage(UIImage(named: "heart_icon.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
        interestedButton.setImage(UIImage(named: "filled_heart_icon.png")?.withRenderingMode(.alwaysOriginal), for: .selected)
        
        mapButton.addTarget(self, action: #selector(openMap(_:)), for: UIControlEvents.touchUpInside)

        interestedButton.addTarget(self, action: #selector(postRSVP(_:)), for: UIControlEvents.touchUpInside)
        meetupLinkButton.addTarget(self, action: #selector(didTapMeetupLink(_:)), for: UIControlEvents.touchUpInside)
    }

    @IBAction func didTapMeetupLink(_ sender:UIButton!) {
        let url = URL(string: "\(myStringValue[5])")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func openMap(_ sender:UIButton!) {
            var lng1 = "0.1278" as NSString
            var lat1 = "51.5074" as NSString
        
            if "\(myStringValue[7])" != "" {
                lng1 = "\(myStringValue[7])" as NSString
                lat1 = "\(myStringValue[6])" as NSString
            }
        
            let latitude:CLLocationDegrees =  lat1.doubleValue
            let longitude:CLLocationDegrees =  lng1.doubleValue
            
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Event Location"
            mapItem.openInMaps(launchOptions: options)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func postRSVP(_ sender:UIButton!) {
        // We will simply print out the value here
        print("The value of myStringValue is: \(myStringValue)")
        let event_id = myStringValue[3] 
        let defaults = UserDefaults.standard
        if let user_id = defaults.string(forKey: "user_id") {
            print("User ID is: \(user_id)")
            print("Event ID is: \(event_id)")
        
        var request = URLRequest(url: URL(string: "https://attendr-server.herokuapp.com/response/new")!)
        request.httpMethod = "POST"
        let postString = "user_id=\(user_id)&event_id=\(event_id)"
        print("\(postString)")
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        sender.isSelected = !sender.isSelected;
        task.resume()
        }
    }
    
}

extension String {
    var html2AttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
