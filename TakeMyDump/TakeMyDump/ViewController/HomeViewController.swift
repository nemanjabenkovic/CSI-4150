//
//  ViewController.swift
//  TakeMyDump
//
//  Created by 신민규 on 12/6/24.
//

import UIKit
import MapKit

final class HomeViewController: UIViewController {
    
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingMap()
        configureUI()
    }
}

extension HomeViewController {
    func configureUI() {
        self.view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
        ])
    }
}

extension HomeViewController: MKMapViewDelegate {
    func settingMap() {
        mapView.delegate = self
        
        mapView.preferredConfiguration = MKStandardMapConfiguration()
        
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        
        mapView.userTrackingMode = .follow
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: userLocation.coordinate,
                                        latitudinalMeters: 500,
                                        longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }

    func createAnnotations() {
        /// Mock Location Data
        let locations = [
            ("대우월드타운상가", 37.546613, 127.019327),
            ("시온교회", 37.546385, 127.018230),
            ("용비쉼터", 37.545463, 127.020385),
            ("아이들세상유치원", 37.545311, 127.017947)
        ]
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.1, longitude: location.2)
            annotation.title = location.0
            mapView.addAnnotation(annotation)
        }
    }
}


