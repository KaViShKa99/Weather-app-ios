//
//  NavBar.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI
import CoreLocation

struct NavBar: View {
    
    var body: some View {
        
            TabView {
                WeatherNowView()
                    .tabItem {
                        Label("City", systemImage: "magnifyingglass")
                    }
                    .background(
                        Image("sky2")
                            .resizable()
                            .edgesIgnoringSafeArea(.top)
                            .colorMultiply(Color.white.opacity(0.7))
                            
                            
                    )
                WeatherForecastView()
                    .tabItem {
                        Label("Forecast", systemImage: "calendar")
                    }
                TouristPlacesMapView()
                    .tabItem {
                        Label("Place Map", systemImage: "map")
                    }
            }
            .onAppear{
                CLLocationManager().requestWhenInUseAuthorization()
            }
            
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
            .environmentObject(WeatherMapViewModel())
        
    }
}

