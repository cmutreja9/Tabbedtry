//
//  FirstViewController.swift
//  Tabbedtry
//
//  Created by Chinky Mutreja on 30/4/18.
//  Copyright © 2018 Chinky Mutreja. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latt: UILabel!
    
    var location : CLLocation?
    let locationManager = CLLocationManager()

    @IBOutlet weak var getaddress: UILabel!
    
    @IBAction func GetLocation(_ sender: UIButton) {
        let authorisation = CLLocationManager.authorizationStatus()
        if authorisation == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
            deniedAlert()
            return
        }
        if authorisation == .denied || authorisation == .restricted{
            locationManager.requestWhenInUseAuthorization()
            return
            
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()

    }
    

func locationManager(_ manager: CLLocationManager,didFailWithError error: Error){
    print("failed \(error)")
}

func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]){
    let newLocation = locations.last!
    
    print("Updated location \(newLocation)")
    location = newLocation
    updateLatLong()
}

    func updateLatLong(){
        if let location = location{
            latt.text = String(format: "%.6f",location.coordinate.latitude)
            longg.text = String(format:"%.6f",location.coordinate.longitude)
            
            var address = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude )
            print(address)
            
            CLGeocoder().reverseGeocodeLocation(address, completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                    return
                }
                
                if placemarks!.count > 0 {
                    let pm = placemarks![0] as! CLPlacemark
                    print(pm.locality)
                    self.getaddress.text = pm.locality
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            })
            //getaddress.text = String(describing: address)
        }
    }
    @IBOutlet weak var longg: UILabel!
    
    func deniedAlert(){
        let alert = UIAlertController(title: "Location Services disabled",message: "Enable your location services to continue using the app",preferredStyle: .alert)
        let Ok = UIAlertAction(title: "Ok", style: .default,handler:nil)
        alert.addAction(Ok)
        present(alert,animated: true,completion: nil)
    }
    
  
    
override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

}
}

