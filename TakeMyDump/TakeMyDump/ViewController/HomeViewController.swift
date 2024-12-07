//
//  ViewController.swift
//  TakeMyDump
//
//  Created by 신민규 on 12/6/24.
//

import CoreLocation
import MapKit
import UIKit

final class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    private var mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        settingMap()
        createAnnotations()
        configureUI()
        setupNavigationBar()
    }
}

extension HomeViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 16
        mapView.layer.masksToBounds = true
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
        
        if let userLocation = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: false)
        }
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let identifier = "Mark"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(systemName: "toilet.fill")
            annotationView?.tintColor = UIColor(red: 165/255, green: 42/255, blue: 42/255, alpha: 1.0)
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        }
        
        return annotationView
    }
}

extension HomeViewController {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .denied, .restricted:
            self.locationManager.requestWhenInUseAuthorization()
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    private func showSettingsAlert() {
        let alert = UIAlertController(
            title: "위치 권한 필요",
            message: "앱이 정상적으로 작동하려면 위치 권한이 필요합니다. 설정에서 권한을 부여해주세요.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension HomeViewController {
    func setupNavigationBar() {
        let logoButton = UIButton(type: .custom)
        logoButton.setImage(UIImage(named: "textLogo"), for: .normal)  // 로고 이미지 이름
        logoButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)  // 버튼 크기 조정
        let logoBarButton = UIBarButtonItem(customView: logoButton)
        navigationItem.leftBarButtonItem = logoBarButton
    }
}
