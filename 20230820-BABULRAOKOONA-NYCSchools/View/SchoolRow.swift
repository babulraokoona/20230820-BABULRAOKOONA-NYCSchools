//
//  SchoolRow.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 21/08/23.
//

import SwiftUI
import MapKit

struct SchoolRow: View {
    
    let schoolData: SchoolDataViewModel
    @State private var shouldShowMapView = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(schoolData.schoolName)
                .multilineTextAlignment(.leading)
                .font(.headline)

            Text(schoolData.overview)
                .font(.caption)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
            
            HStack {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    if schoolData.schoolEmail.count != 0 {
                        HStack {
                            Image(systemName: SFSymbols.emailIcon)
                            Text(schoolData.schoolEmail )
                                .font(.callout).bold()
                        }
                    }
                    
                    HStack {
                        Image(systemName: SFSymbols.phoneIcon)
                        Text(schoolData.phoneNumber)
                            .font(.callout).bold()
                    }
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        shouldShowMapView = true
                    }
                }) {
                    Image(systemName: SFSymbols.mapIcon)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(.green)
                        .frame(width: 32, height: 32)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .sheet(isPresented: $shouldShowMapView, content: {
                MapView(currentLatitude:(Double(schoolData.longitude) ?? 0.0), currentLongitude: (Double(schoolData.longitude) ?? 0.0))
                Button("Dismiss"){
                    shouldShowMapView = false
                }.foregroundColor(.blue)
            })
            .hSpacing(.center)
        }
    }
}


struct MapView: View {
    let currentLatitude: Double
    let currentLongitude: Double
    @State private var region = MKCoordinateRegion()
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
            .onAppear{
                getRegion()
            }
    }

    func getRegion() {
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
}
