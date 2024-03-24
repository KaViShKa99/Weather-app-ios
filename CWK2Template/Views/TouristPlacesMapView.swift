//
//  TouristPlacesMapView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit



struct TouristPlacesMapView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State var locations: [Location] = []
    @State private var position: MapCameraPosition = .automatic
    @State private var avilable:Bool = false
    @State private var userCurrentLocation: CLLocationCoordinate2D?

    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
//                if weatherMapViewModel.coordinates != nil {
                    VStack(spacing: 10){

                        Map(position: $position){
                            
                            ForEach(locations){ location in
                               Marker(location.name,coordinate: location.coordinates)
                            }
                                                        
                        }
                        .mapControls{
                            MapUserLocationButton()
                            MapPitchToggle()
                        }
                        .onAppear {
                                position = .item(MKMapItem(placemark: .init(coordinate: .init(latitude: getLatAndLong.0, longitude: getLatAndLong.1))))
                            
                               
                        }
                        .safeAreaInset(edge: .leading) {
                            VStack(alignment:.leading) {
                                ForEach(locations) { location in
                                   
                                    Button(action: {
                                        withAnimation {
                                            position = .item(MKMapItem(placemark: .init(coordinate: .init(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude))))
                                        }
                                    }) {
                                        Text(location.name)
                                            
                                    }
                                    .tint(.black)
                                    .buttonStyle(.borderedProminent)
                                    .padding(.leading,10)
                                }
                            }

                        }
                        
                        
                        VStack{
                            Text("Tourist Attraction in \(weatherMapViewModel.city)")
                                .font(.title2)
                                .padding(.top,30)
                        }.multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                if !(weatherMapViewModel.loadLocationsFromJSONFile(cityName : weatherMapViewModel.city)?.isEmpty ?? true){
                    List{
                        ForEach(locations) { location in
                            
                            NavigationLink {
                                TouristPlaceView(location:location)
                            } label: {
                                HStack {
                                    Image("\(location.imageNames[1])")
                                        .resizable()
                                        .frame(width: 100,height: 100)
                                        .cornerRadius(10)
                                    Text(location.name)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .padding(.horizontal,30)
                                }
                            }
                            
                            
                        }
                    }
                    .listStyle(.plain)
                    .padding(.leading,20)
                    
                }else{
                    HStack{
                        Text("Not data available")
                            .font(.title2)
                            .padding(.bottom,100)
                    }

                }
                
                
            }.frame(height:750)
        }
        .onAppear {
            // process the loading of tourist places
            let specificLocation = weatherMapViewModel.loadLocationsFromJSONFile(cityName : weatherMapViewModel.city)
            locations = specificLocation ?? []
            
            
        }
    }
    
    private var getLatAndLong: (Double, Double) {
        
        if let coordinates = weatherMapViewModel.coordinates {
            let latitude = coordinates.latitude
            let longitude = coordinates.longitude
            return (latitude,longitude)
        } else {
            return (51.5216871,-0.1391574)
        }
       
    }
}

//class LocationManagerDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
//    @Published var userCurrentLocation: CLLocationCoordinate2D?
//
//    let locationManager = CLLocationManager()
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let userLocation = locations.first?.coordinate else { return }
//        userCurrentLocation = userLocation
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Location manager error: \(error.localizedDescription)")
//    }
//}


struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView()
            .environmentObject(WeatherMapViewModel())
    }
}
