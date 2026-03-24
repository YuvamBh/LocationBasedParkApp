//
//  AddParkView.swift
//  lab5
//
//  Created by Yuvam Bhargav on 3/23/26.
//

import SwiftUI

struct AddParkView: View {
    @ObservedObject var parkVM: ParkViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var location = ""
    @State private var imageName = ""
    @State private var description = ""
    
    var body: some View {
        Form {
            Section(header: Text("Park Information")) {
                TextField("Park name", text: $name)
                TextField("Location", text: $location)
                TextField("Image name (optional)", text: $imageName)
                TextField("Description", text: $description, axis: .vertical)
            }
            
            Button("Save Park") {
                parkVM.addPark(
                    name: name,
                    location: location,
                    imageName: imageName,
                    description: description
                )
                dismiss()
            }
        }
        .navigationTitle("Add Park")
    }
}
