import UIKit
import MapboxMaps

class TrailDetailViewController: UIViewController {
    
    var selectedTrail: Trail? // Define a Trail model or use your existing data structure

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Add code to display detailed information about the selectedTrail
        if let selectedTrail = selectedTrail {
            let trailInfoLabel = UILabel()
            trailInfoLabel.text = "Trail Name: \(selectedTrail.name)\nCoordinates: \(selectedTrail.coordinates.latitude), \(selectedTrail.coordinates.longitude)"
            trailInfoLabel.numberOfLines = 0
            trailInfoLabel.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(trailInfoLabel)

            // Set up constraints for the label
            NSLayoutConstraint.activate([
                trailInfoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                trailInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                trailInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        }


        // Add a button to start the hike
        let startHikeButton = UIButton(type: .system)
        startHikeButton.setTitle("Start Hike", for: .normal)
        startHikeButton.addTarget(self, action: #selector(startHikeButtonTapped), for: .touchUpInside)
        startHikeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startHikeButton)

        // Add layout constraints for the button
        NSLayoutConstraint.activate([
            startHikeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startHikeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc func startHikeButtonTapped() {
        // Handle starting the hike, e.g., navigate to the map view with the selected trail coordinates
        if let selectedTrail = selectedTrail {
            
            
                let trailDetailVC = ViewController()
            trailDetailVC.showTrailOnMap(selectedTrail: selectedTrail)
            
                navigationController?.pushViewController(trailDetailVC, animated: true)
            
            
           
        }
    }

}
