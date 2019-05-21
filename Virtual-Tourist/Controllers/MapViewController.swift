//
//  ViewController.swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 20/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var longPressGesture: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMapView()
    }
    
    func setupMapView() {
        mapView.delegate = self
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    @IBAction func gestureLongPressedAction(_ sender: Any) {
        
        guard let gesture = sender as? UILongPressGestureRecognizer else {
         return
        }
        guard gesture.state == .began else {
            return
        }
        
        let pressedPoint = gesture.location(in: mapView)
        let pointCordination = mapView.convert(pressedPoint, toCoordinateFrom: mapView)
        addAnnotation(pointCordination: pointCordination)
        
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
            dequeuedView.tintColor = .orange
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = false
        }
        
        return view
    }
    func addAnnotation(pointCordination: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = pointCordination
        mapView.addAnnotation(annotation)
        
    }
}

