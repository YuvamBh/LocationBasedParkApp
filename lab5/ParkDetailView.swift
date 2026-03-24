//
//  ParkDetailView.swift
//  lab5
//
//  Created by Yuvam Bhargav on 3/23/26.
//



import SwiftUI
import Foundation
import MapKit
import CoreLocation

struct PlaceMarker: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ParkDetailView: View {
    let park: Park
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.4255, longitude: -111.9400),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    @State private var markers: [PlaceMarker] = []
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Image(park.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .cornerRadius(10)
                
                Text(park.name)
                    .font(.title)
                    .bold()
                
                Text(park.location)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Map(coordinateRegion: $region, annotationItems: markers) { marker in
                    MapMarker(coordinate: marker.coordinate)
                }
                .frame(height: 300)
                .cornerRadius(10)
                
                HStack {
                    TextField("Search nearby place", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Search") {
                        searchNearbyPlaces()
                    }
                }
                
                Text("Description")
                    .font(.headline)
                
                Text(park.description)
            }
            .padding()
        }
        .navigationTitle("Park Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            showParkLocation()
        }
    }
    
    func showParkLocation() {
        CLGeocoder().geocodeAddressString(park.location) { placemarks, error in
            if let first = placemarks?.first,
               let location = first.location {
                let coordinate = location.coordinate
                
                DispatchQueue.main.async {
                    region.center = coordinate
                    markers = [
                        PlaceMarker(name: park.name, coordinate: coordinate)
                    ]
                }
            }
        }
    }
    
    func searchNearbyPlaces() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region
        
        MKLocalSearch(request: request).start { response, error in
            guard let response = response else {
                print("Search error")
                return
            }
            
            DispatchQueue.main.async {
                markers = response.mapItems.map { item in
                    PlaceMarker(
                        name: item.name ?? "Place",
                        coordinate: item.placemark.coordinate
                    )
                }
            }
        }
    }
}
