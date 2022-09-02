//
//  MapView.swift
//  Northex
//
//  Created by Saksham Jain on 16/05/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var ViewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $ViewModel.coordinates, showsUserLocation: true)
            .onAppear {
                ViewModel.checkLocationServicesEnabled()
            }
            .accentColor(ViewModel.outOfBounds ? Color.blue : Color.red)
            .alert(Text("Location Bounds Alert"),
                   isPresented: $ViewModel.outOfBounds) {
                Button("OK") {
                    //MARK: Implement App Crash
//                    exit(0)
                }
                .foregroundColor(Color.red)
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    
    @Published var outOfBounds: Bool = false
    
    @Published var coordinates = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 28.7129, longitude: 77.1901), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    func checkLocationServicesEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Location Services Off")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location Restricted")
        case .denied:
            print("Location Permission Denied")
        case .authorizedAlways, .authorizedWhenInUse:
            coordinates = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            checkForLocationBounds(lat: locationManager.location!.coordinate.latitude, lon: locationManager.location!.coordinate.longitude)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func checkForLocationBounds(lat: Double, lon: Double) {
        if (pow((pow(lon - 28.7129, 2) * pow(lat - 77.1901, 2)), 0.5) > 100) {
            
            //MARK: Uncomment Below Code
//            outOfBounds = true
            
        }
    }
}

