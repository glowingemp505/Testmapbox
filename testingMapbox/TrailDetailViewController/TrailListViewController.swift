//
//  ViewController.swift
//  testingMapbox
//
//  Created by Sameer Amjad on 13/12/2023.
//

//import UIKit
//import CoreLocation
//import MapboxMaps
//
//class TrailListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
//
//    var trails: [Trail] = []
//
//    let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//
//    let locationManager = CLLocationManager()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        title = "Trail List"
//
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TrailCell")
//
//        view.addSubview(tableView)
//
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//
//        // Set up location manager
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    // MARK: - CLLocationManagerDelegate
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let currentLocation = locations.last else {
//            return
//        }
//
//        // Fetch hiking areas near the current location
//        fetchHikingAreas(near: currentLocation.coordinate)
//    }
//
//    func fetchHikingAreas(near coordinates: CLLocationCoordinate2D) {
//        // Example: Replace this with your actual logic to fetch hiking areas from a service or database
//        // For simplicity, we'll use hardcoded data
//        trails = [
//            Trail(name: "Trail 1", coordinates: CLLocationCoordinate2D(latitude: coordinates.latitude + 0.01, longitude: coordinates.longitude + 0.01)),
//            Trail(name: "Trail 2", coordinates: CLLocationCoordinate2D(latitude: coordinates.latitude - 0.01, longitude: coordinates.longitude - 0.01)),
//            // Add more trails as needed
//        ]
//
//        // Update the table view with the fetched hiking areas
//        tableView.reloadData()
//    }
//
//    // MARK: - UITableViewDataSource
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return trails.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailCell", for: indexPath)
//        cell.textLabel?.text = trails[indexPath.row].name
//        return cell
//    }
//
//    // MARK: - UITableViewDelegate
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedTrail = trails[indexPath.row]
//        navigateToTrailDetail(with: selectedTrail)
//    }
//
//    // MARK: - Navigation
//
//    func navigateToTrailDetail(with trail: Trail) {
//        let mapViewController = TrailDetailViewController()
//        mapViewController.selectedTrail = trail
//        navigationController?.pushViewController(mapViewController, animated: true)
//    }
//}
//
//

import UIKit
import CoreLocation
import MapboxMaps

class TrailListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    var trails: [Trail] = []

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let locationManager = CLLocationManager()

    var mapView: MapView!

    let showLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show My Location", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Trail List"

        // Initialize MapView
        mapView = MapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)

        // Set up location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // Set up the "Show My Location" button
        view.addSubview(showLocationButton)

        NSLayoutConstraint.activate([
            showLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            showLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            showLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            showLocationButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        showLocationButton.addTarget(self, action: #selector(showMyLocation), for: .touchUpInside)

        // Set up table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TrailCell")

        view.addSubview(tableView)
        //tableView.isHidden = true

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc func showMyLocation() {
        if let currentLocation = locationManager.location?.coordinate {
            // Center the map on the current location
            mapView.camera.ease(to: CameraOptions(center: currentLocation, zoom: 14.0), duration: 1.0)

        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last?.coordinate else {
            return
        }

        // Fetch hiking areas near the current location
        fetchHikingAreas(near: currentLocation)
    }

    func fetchHikingAreas(near coordinates: CLLocationCoordinate2D) {
        // Example: Replace this with your actual logic to fetch hiking areas from a service or database
        // For simplicity, we'll use hardcoded data
        trails = [
            Trail(name: "Trail 1", coordinates: CLLocationCoordinate2D(latitude: coordinates.latitude + 0.01, longitude: coordinates.longitude + 0.01)),
            Trail(name: "Trail 2", coordinates: CLLocationCoordinate2D(latitude: coordinates.latitude - 0.01, longitude: coordinates.longitude - 0.01)),
            // Add more trails as needed
        ]

        // Update the table view with the fetched hiking areas
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailCell", for: indexPath)
        cell.textLabel?.text = trails[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedTrail = trails[indexPath.row]
           navigateToTrailDetail(with: selectedTrail)
       }
   
       // MARK: - Navigation
   
       func navigateToTrailDetail(with trail: Trail) {
           let mapViewController = TrailDetailViewController()
           mapViewController.selectedTrail = trail
           navigationController?.pushViewController(mapViewController, animated: true)
       }
}
