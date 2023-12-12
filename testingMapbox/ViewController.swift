//
//  ViewController.swift
//  testingMapbox
//
//  Created by Sameer Amjad on 13/12/2023.
//

import UIKit
import MapboxMaps

class ViewController: UIViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MapView(frame: view.bounds)
        let cameraOptions = CameraOptions(center:
                                            CLLocationCoordinate2D(latitude: 39.5, longitude: -98.0),
                                          zoom: 2, bearing: 0, pitch: 0)
        mapView.mapboxMap.setCamera(to: cameraOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(mapView)
    }
    func showTrailOnMap(selectedTrail: Trail) {
        // Assuming you have a MapView in your ViewController
        // Implement the logic to show the selected trail on the map here
        // For example, set the camera to the selected trail's coordinates
        
        let mapView = MapView(frame: view.bounds)
        let cameraOptions = CameraOptions(center: selectedTrail.coordinates, zoom: 12, bearing: 0, pitch: 0)
        mapView.mapboxMap.setCamera(to: cameraOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Replace the existing map view with the new one
        view.subviews.forEach { $0.removeFromSuperview() }
        view.addSubview(mapView)
    }
}
