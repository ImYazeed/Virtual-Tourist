//
//  AlbumViewController.swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 21/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit
import CoreData

class AlbumViewController: UIViewController {
    
    var selectedPin: Pin!
    var fetchedResultsController:NSFetchedResultsController<Photo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AlbumViewController: NSFetchedResultsControllerDelegate {
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Photo> = Photo.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataController.shared.viewContext, sectionNameKeyPath: nil, cacheName: "photo")
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
}
