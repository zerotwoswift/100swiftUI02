//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Hubert Leszkiewicz on 12/04/2021.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favourites: Favourites
    @State private var selectedFacility: Facility?
    
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0 ) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFill()
                    
                Group {
                    HStack {
                        if sizeClass == .compact {
                        Spacer()
                            VStack {
                                ResortDetailsView(resort: resort)
                            }
                            VStack {
                        SkiDetailsView(resort: resort)
                            }
                            
                        Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                        
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                        .padding(.vertical)
                }
                .padding(.horizontal)
                
                Button(favourites.contains(resort) ? "Remove from favourites" : "Add to favourites") {
                    if self.favourites.contains(self.resort) {
                        self.favourites.remove(self.resort)
                    } else {
                        self.favourites.add(self.resort)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("\(resort.name), \(resort.country)", displayMode: .inline)
        
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
