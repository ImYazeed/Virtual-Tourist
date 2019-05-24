//
//  ViewController.swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 20/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
    
    // Outlet
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var longPressGesture: UILongPressGestureRecognizer!
    // Variables
    var fetchedResultController: NSFetchedResultsController<Pin>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchedResultsController()
        setupMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchedResultsController()
        if let pins = fetchedResultController.fetchedObjects {
            showPinsOnTheMap(pins: pins)
        }
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultController = nil
    }
    
    // MARK: UI Handling
    
    func setupMapView() {
        mapView.delegate = self
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    func showPinsOnTheMap(pins: [Pin]) {
        if mapView.annotations.count != 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        for pin in pins {
            addAnnotation(pin: pin)
        }
    }
    
    func pushAlbumVC(pin: Pin) {
        guard let albumVC = storyboard?.instantiateViewController(withIdentifier: "AlbumVC") as? AlbumViewController else {
            return
        }
        albumVC.selectedPin = pin
        navigationController?.pushViewController(albumVC, animated: true)
    }
    
    // MARK: ACTIONS
    
    @IBAction func gestureLongPressedAction(_ sender: Any) {
        
        guard let gesture = sender as? UILongPressGestureRecognizer else {
            return
        }
        guard gesture.state == .began else {
            return
        }
        let pressedPoint = gesture.location(in: mapView)
        let pointCordination = mapView.convert(pressedPoint, toCoordinateFrom: mapView)
        let pin = PinManager.getNewPin(latitude: pointCordination.latitude, longitude: pointCordination.longitude)
        addAnnotation(pin: pin)
    }
}

extension MapViewController: NSFetchedResultsControllerDelegate {
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Pin> = Pin.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataController.shared.viewContext, sectionNameKeyPath: nil, cacheName: "pin")
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
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
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let annotation = (view.annotation) as! PinAnnotation
        if let pin = annotation.pinObject {
            pushAlbumVC(pin: pin)
        }
        mapView.deselectAnnotation(annotation, animated: true)
    }
    
    func addAnnotation(pin: Pin) {
        let pinAnnotation = PinAnnotation(pin: pin)
        mapView.addAnnotation(pinAnnotation)
    }
    
}

