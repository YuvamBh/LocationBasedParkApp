//
//  ContentView.swift
//  lab5
//
//  Created by Yuvam Bhargav on 3/23/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var parkVM = ParkViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(parkVM.sortedSectionKeys, id: \.self) { key in
                    if let sectionParks = parkVM.groupedParks[key] {
                        Section(header: Text(key)) {
                            ForEach(sectionParks) { park in
                                NavigationLink(destination: ParkDetailView(park: park)) {
                                    HStack {
                                        Image(park.imageName)
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(8)
                                        
                                        VStack(alignment: .leading) {
                                            Text(park.name)
                                                .font(.headline)
                                            Text(park.location)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                            .onDelete { offsets in
                                parkVM.deletePark(at: offsets, in: sectionParks)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorite Parks")
            .toolbar {
                NavigationLink("Add Park") {
                    AddParkView(parkVM: parkVM)
                }
            }
        }
    }
}
