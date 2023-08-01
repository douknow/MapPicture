//
//  ViewController.swift
//  MapPicture
//
//  Created by 韩显钊 on 2023/7/24.
//

import UIKit
import MapKit
import QuickLook

class ViewController: UIViewController {
    
    static let pictureAnnotationViewID = "pictureAnnotationViewID"
    
    lazy var mapView = {
        let view = MKMapView()
        return view
    }()
    
    var previewItems: [QLPreviewItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        mapView.register(
            PictureAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: Self.pictureAnnotationViewID)
        mapView.delegate = self

        setData()
    }

    func setData() {
        guard let url = Bundle.main.url(forResource: "dataset", withExtension: "json") else {
            return
        }
        
        let pictures = Picture.loadData(from: url)
        
        pictures.forEach { picture in
            let annotation = PictureAnnotation(
                picture: picture,
                coordinate: .init(
                    latitude: picture.latitude,
                    longitude: picture.longitude))
            mapView.addAnnotation(annotation)
        }
        
        let centerPicture = pictures[0]
        mapView.setRegion(
            .init(
                center: .init(
                    latitude: centerPicture.latitude,
                    longitude: centerPicture.longitude),
                span: .init(latitudeDelta: 68, longitudeDelta: 68)),
            animated: false)
    }

}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let view = mapView.dequeueReusableAnnotationView(
            withIdentifier: Self.pictureAnnotationViewID,
            for: annotation) as? PictureAnnotationView,
              let annotation = annotation as? PictureAnnotation
        else {
            return nil
        }

        view.config(annotation: annotation)
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        mapView.deselectAnnotation(annotation, animated: true)
        
        guard let pictureAnnotation = annotation as? PictureAnnotation else {
            return
        }
        
        previewItems = [pictureAnnotation.picture.imageURL].compactMap { $0 as? NSURL }
        
        let vc = QLPreviewController()
        vc.dataSource = self
        present(vc, animated: true)
    }
    
}

extension ViewController: QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        previewItems[index]
    }
    
}
