//
//  ViewController.swift
//  Navi-ios
//  2021 Dmitry Alexandrov
//  Read it:
//  https://ioscoachfrank.com/remove-main-storyboard.html
//
//  NSLocationWhenInUseUsageDescription | .requestWhenInUseAuthorization() позволяет приложению иметь доступ к местоположению пользователя в то время как используется приложение.
//  NSLocationAlwaysUsageDescription | .requestAlwaysAuthorization()  позволяет приложению получить доступ к местоположению пользователя, даже в то время, когда приложение находится в фоновом режиме.



import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate
{
    
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        return manager
    }()
    
    
    
    let mapView: MKMapView = {
        let control = MKMapView()
        control.layer.masksToBounds = true
        control.layer.cornerRadius = 15
        control.clipsToBounds = false
        control.translatesAutoresizingMaskIntoConstraints = false
        control.showsScale = true
        control.showsCompass = true
        control.showsTraffic = true
        control.showsBuildings = true
        control.showsUserLocation = true
        return control
    }()
    
    
    let startLocation: UITextField = {
        let control = UITextField()
        control.backgroundColor = UIColor.gray
        control.textColor = UIColor.white
        control.placeholder = "From"
        control.layer.cornerRadius = 2
        control.clipsToBounds = false
        control.translatesAutoresizingMaskIntoConstraints = false
        
        control.font = UIFont.systemFont(ofSize: 15)
        control.borderStyle = UITextField.BorderStyle.roundedRect
        control.autocorrectionType = UITextAutocorrectionType.yes
        control.keyboardType = UIKeyboardType.default
        control.returnKeyType = UIReturnKeyType.done
        control.clearButtonMode = UITextField.ViewMode.whileEditing
        control.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return control
    }()
    
    
    let finishLocation: UITextField = {
        let control = UITextField()
        control.backgroundColor = UIColor.gray
        control.textColor = UIColor.white
        control.placeholder = "To"
        control.layer.cornerRadius = 2
        control.clipsToBounds = false
        control.translatesAutoresizingMaskIntoConstraints = false
        
        control.font = UIFont.systemFont(ofSize: 15)
        control.borderStyle = UITextField.BorderStyle.roundedRect
        control.autocorrectionType = UITextAutocorrectionType.no
        control.keyboardType = UIKeyboardType.default
        control.returnKeyType = UIReturnKeyType.done
        control.clearButtonMode = UITextField.ViewMode.whileEditing
        control.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return control
    }()
    
    
    let goButton: UIButton = {
        let control = UIButton()
        control.addTarget(self, action: #selector(getYourRoute), for: .touchUpInside)
        control.setTitle("Go!", for: .normal)
        control.backgroundColor = UIColor.blue
        control.titleLabel?.textColor = UIColor.white
        control.layer.cornerRadius = 4
        control.clipsToBounds = false
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    
    var coordinatesArray = [CLLocationCoordinate2D]()
    var annotationsArray = [MKAnnotation]()
    var overlaysArray = [MKOverlay]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTapRecognizer()

    }
    
    private func addTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.delegate = self
        mapView.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        startLocation.resignFirstResponder()
        finishLocation.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startMap()
    }
    
    private func setupUI() {
        startLocation.delegate = self
        finishLocation.delegate = self
        
        locationManager.delegate = self
        locationManager.requestLocation()
        
        mapView.delegate = self
        
        self.view.addSubview(startLocation)
        self.view.addSubview(finishLocation)
        self.view.addSubview(goButton)
        self.view.addSubview(mapView)
        
        
        self.mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()

        
        goButton.pinRight(to: view)
        goButton.pinTop(to: view)
        goButton.setHeight(34.0)
        goButton.setWidth(34.0)
        
        startLocation.pinLeft(to: view)
        startLocation.pinTop(to: view)
        startLocation.pinRight(to: goButton, 44)
        
        finishLocation.pinLeft(to: view)
        finishLocation.pinTop(to: startLocation, 44)
        finishLocation.pinRight(to: view)
        
        mapView.pinLeft(to: view)
        mapView.pinTop(to: finishLocation, 44)
        mapView.pinRight(to: view)
        mapView.pinBottom(to: view)
    }
    
    
    @objc func getYourRoute(_ sender: UIButton) {
        
        if self.mapView.annotations.count > 0 {
            self.mapView.removeAnnotations(self.annotationsArray)
            self.annotationsArray = []
        }
        
        if self.overlaysArray.count  > 0 {
            self.mapView.removeOverlays(self.overlaysArray)
            self.overlaysArray = []
        }
        self.coordinatesArray = []
        
        if self.finishLocation.text!.count == 0 || self.startLocation.text! == self.finishLocation.text! {
            return
        }
        
        if self.startLocation.text!.count == 0 {
            if let userLocation = self.locationManager.location?.coordinate {
                self.coordinatesArray.append(userLocation)
                self.doAfterOne()
            }
        } else {
            self.findLocation(location: self.startLocation.text!, showRegion: false, completion: self.doAfterOne)
        }
    }
    
    
    func doAfterOne() {
        let completion2 = findLocations
        DispatchQueue.global(qos: .utility).async {
            self.findLocation(location: self.finishLocation.text!, showRegion: true, completion: completion2)
        }
    }
    
    
    func findLocations() {
        if self.coordinatesArray.count < 2 {
            return
        }
        let markLocationOne = MKPlacemark(coordinate: self.coordinatesArray.first!)
        let markLocationTwo = MKPlacemark(coordinate: self.coordinatesArray.last!)
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: markLocationOne)
        directionRequest.destination = MKMapItem(placemark: markLocationTwo)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { (response, error) in
            if error != nil {
                print(String(describing: error))
            } else {
                let myRoute: MKRoute? = response?.routes.first
                if let a = myRoute?.polyline {
                    if self.overlaysArray.count > 0 {
                        self.mapView.removeOverlays(self.overlaysArray)
                        self.overlaysArray = []
                    }
                    self.overlaysArray.append(a)
                    self.mapView.addOverlay(a)
                    
                    let rect = a.boundingMapRect
                    let expandedRect = rect.insetBy(dx: -(rect.width * 0.1), dy: -(rect.height * 0.1))
                    self.mapView.setRegion(MKCoordinateRegion(expandedRect), animated: true)
                }
            }
        }
    }
    
    
    func findLocation(location: String, showRegion: Bool = false, completion: @escaping () -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let placemark = placemarks?.first {
                let coordinates = placemark.location!.coordinate
                self.coordinatesArray.append(coordinates)
                let point = MKPointAnnotation()
                point.coordinate = coordinates
                point.title = location
                
                if let country = placemark.country {
                    point.subtitle = country
                }
                self.mapView.addAnnotation(point)
                self.annotationsArray.append(point)
                
                if showRegion {
                    self.mapView.centerCoordinate = coordinates
                    let span = MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9)
                    let region = MKCoordinateRegion(center: coordinates, span: span)
                    self.mapView.setRegion(region, animated: showRegion)
                }
            } else {
                print(String(describing: error))
            }
            completion()
        }
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        if overlay is MKPolyline {
            polylineRenderer.strokeColor = UIColor.green
            polylineRenderer.lineWidth = 4
        }
        return polylineRenderer
    }
    
    func startMap() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userlocation:CLLocation = locations[0] as CLLocation

        manager.stopUpdatingLocation()

        let location = CLLocationCoordinate2D(latitude: userlocation.coordinate.latitude, longitude: userlocation.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
      }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("err")
    }
    
    
    
}
