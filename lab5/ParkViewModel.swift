//
//  ViewModel.swift
//  lab5
//
//  Created by Yuvam Bhargav on 3/23/26.
//
import Foundation
import Combine

class ParkViewModel: ObservableObject {
    @Published var parks: [Park] = [
        Park(
            name: "Bryce Canyon",
            location: "Utah, USA",
            imageName: "bryce",
            description: "Bryce Canyon is famous for its red rock formations and beautiful scenic views."
        ),
        Park(
            name: "Central Park",
            location: "New York, USA",
            imageName: "centralpark",
            description: "Central Park is a large urban park in New York City and is popular for walking and recreation."
        ),
        Park(
            name: "Grand Canyon",
            location: "Arizona, USA",
            imageName: "grandcanyon",
            description: "Grand Canyon is one of the most famous national parks with amazing canyon views."
        ),
        Park(
            name: "Yellowstone",
            location: "Wyoming, USA",
            imageName: "yellowstone",
            description: "Yellowstone is known for geysers, wildlife, and natural beauty."
        ),
        Park(
            name: "Yosemite",
            location: "California, USA",
            imageName: "yosemite",
            description: "Yosemite is known for waterfalls, cliffs, and giant sequoia trees."
        )
    ]
    
    func addPark(name: String, location: String, imageName: String, description: String) {
        let finalImage = imageName.isEmpty ? "defaultPark" : imageName
        
        let newPark = Park(
            name: name,
            location: location,
            imageName: finalImage,
            description: description
        )
        
        parks.append(newPark)
    }
    
    func deletePark(at offsets: IndexSet, in sectionParks: [Park]) {
        let parksToDelete = offsets.map { sectionParks[$0] }
        parks.removeAll { park in
            parksToDelete.contains(park)
        }
    }
    
    var groupedParks: [String: [Park]] {
        Dictionary(grouping: parks) { park in
            String(park.name.prefix(1)).uppercased()
        }
    }
    
    var sortedSectionKeys: [String] {
        groupedParks.keys.sorted()
    }
}
