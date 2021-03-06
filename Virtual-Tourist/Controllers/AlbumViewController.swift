//
//  AlbumViewController.swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 21/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class AlbumViewController: UIViewController {
    
    // Outlet
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    // Variables
    var selectedPin: Pin!
    var fetchedResultsController:NSFetchedResultsController<Photo>!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchedResultsController()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchedResultsController()
        ensurePhotosAppearance()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
    }
    
    // MARK: UI Handling
    
    func configureUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        //Zooming in on region
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(selectedPin.latitude, selectedPin.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = PinAnnotation(pin: selectedPin)
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    fileprivate func ensurePhotosAppearance() {
        if fetchedResultsController.fetchedObjects?.count == 0 {
            loadPhotos()
        }
    }
    
    func loadPhotos() {
        FlickrClient.fetchPhotos(latitude: self.selectedPin.latitude, longitude: self.selectedPin.longitude, sucssess: { images in
            
            if images.count == 0 {
                AlertManager.shared.showFailureFromViewController(viewController: self, message: "There is no photos in here")
            }
            else {
                PhotoManager.savePhotos(pin: self.selectedPin, images: images)
            }
           
        }) { (error) in
            AlertManager.shared.showFailureFromViewController(viewController: self, message: error.localizedDescription)
        }
    }
    
    // MARK: ACTIONS
    
    @IBAction func newCollectionClicked(_ sender: Any) {
        guard fetchedResultsController.fetchedObjects!.count > 0 else {
            return
        }
       PhotoManager.deletePhotos(photos: fetchedResultsController.fetchedObjects!)
        loadPhotos()
    }

}


extension AlbumViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photo = fetchedResultsController.object(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        cell.photo = photo
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photoToBeDeleted = fetchedResultsController.object(at: indexPath)
       PhotoManager.deletePhotos(photos: [photoToBeDeleted])
    }
    
}

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 40) / 3
        return CGSize(width: width, height: width)
    }
}

extension AlbumViewController: NSFetchedResultsControllerDelegate {
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Photo> = Photo.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let predicate = NSPredicate(format: "pin == %@", selectedPin)
        fetchRequest.predicate = predicate
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataController.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert,.delete :
            collectionView.reloadData()
        default:
            break
        }
    }
    
}
