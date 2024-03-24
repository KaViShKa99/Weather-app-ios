//
//  WeatherNowView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct WeatherNowView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State private var isLoading = false
    @State private var temporaryCity = "London"
    @State private var data: [(String, Any)] = []
    
    
    var body: some View {
        ScrollView{
            
            VStack(alignment:.center){
                HStack{
                    Text("Change Location")
                    
                    TextField("Enter New Location", text: $temporaryCity)
                        .onSubmit {
                            weatherMapViewModel.city = temporaryCity
                            
                            Task {
                                    do {
                                        try await weatherMapViewModel.getCoordinatesForCity()
                                        let lat = weatherMapViewModel.coordinates?.latitude ?? 0
                                        let long = weatherMapViewModel.coordinates?.longitude ?? 0
                                        try await weatherMapViewModel.loadData(lat: lat, lon:long)
                                        
                                    } catch {
                                        print("Error:- \(error)")
                                        isLoading = false
                                    }
                                }
                            
                        }
                }
                
                .bold()
                .font(.system(size: 20))
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Arial", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)
                VStack{
                    HStack{
                        Text("Current Location: \(weatherMapViewModel.city)")
                    }
                    .bold()
                    .font(.system(size: 20))
                    .padding(10)
                    .shadow(color: .blue, radius: 10)
                    .cornerRadius(10)
                    .fixedSize()
                    .font(.custom("Arial", size: 26))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(15)
                    let timestamp = TimeInterval(weatherMapViewModel.weatherDataModel?.current.dt ?? 0)
                    let formattedDate = DateFormatterUtils.formattedDateTime(from: timestamp)
                    Text(formattedDate)
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 1)
                    

                    ForEach(currentWeatherData, id: \.0){ key, value in
                        HStack(alignment:.center){
                            
                            if key.elementsEqual("weather"){
                                
                                if let (icon,weatherDescription) = value as? (String, String) {
                                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon).png")) { phase in
                                        switch phase {
                                        case .empty:
                                            Text("Loading...")
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .padding(.leading, 50)
                                        case .failure:
                                            Text("Failed to load image")
                                                .padding(.leading,50)
                                        @unknown default:
                                            Text("Unexpected state")
                                            
                                            
                                        }
                                    }
                                    Text(getText(for: (key,weatherDescription)))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    
                                    
                                }
                                
                            }
                            else {
                                getImage(for: (key,value))
                                    .resizable()
                                    .frame(width: 40,height: 40)
                                    .padding(.leading,50)
                            }
                            if !key.elementsEqual("weather"){
                                Text(getText(for: (key,value)))
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }

                        }
                        .listRowBackground(Color.clear)
                        .font(.custom("Arial", size: 24))
                        .padding(.vertical,5)
                        
                        
                        
                    }
                    .padding(.top,18)
                    Spacer()
                }//VS2
            }// VS1
            .padding(.vertical,40)
        }// scroll view
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear{

            Task{
                    do {
                        try await weatherMapViewModel.getCoordinatesForCity()
                        let lat = weatherMapViewModel.coordinates?.latitude ?? 0
                        let long = weatherMapViewModel.coordinates?.longitude ?? 0
                        try await weatherMapViewModel.loadData(lat: lat, lon:long)
                        
                    } catch {
                        print("Error:- \(error)")
                        isLoading = false
                    }
                }
          
            }

        
    }
    
    private var currentWeatherData: [(String, Any)] {
        
        if !temporaryCity.isEmpty{
            
            if let forecast = weatherMapViewModel.weatherDataModel {
                let weather = forecast.current.weather
                let pressure = forecast.current.pressure
                let temp = forecast.current.temp
                let windSpeed = forecast.current.windSpeed
                let humidity = forecast.current.humidity
                let weatherDescription = weather[0].weatherDescription.rawValue
                let icon = weather[0].icon
                
                return [
                    
                    ("weather", (icon,weatherDescription)),
                    ("temp", "\(String(temp)) ºC"),
                    ("humidity", "\(String(humidity)) %"),
                    ("pressure", "\(String(pressure)) hPa"),
                    ("windSpeed", "\(String(windSpeed)) mph"),
                ]
            } else {
                return [
                    ("weather", "N/A"),
                    ("temp", "N/A"),
                    ("humidity", "N/A"),
                    ("pressure", "N/A"),
                    ("windSpeed", "N/A"),
                ]
            }
            
        }else{
            return [
                ("weather", "N/A"),
                ("temp", "N/A"),
                ("humidity", "N/A"),
                ("pressure", "N/A"),
                ("windSpeed", "N/A"),
            ]
        }
        
        }
    
}



private func getImage(for property: (key: String, value: Any)) -> Image {
        switch property.key {
        case "pressure":
            return Image("pressure")
        case "temp":
            return Image("temperature")
        case "windSpeed":
            return Image("windSpeed")
        case "humidity":
            return Image("humidity")
        default:
            return Image(systemName: "questionmark")
        }
    }

private func getText(for property: (key: String, value: Any)) -> String {
    switch property.key {
    case "weather":
        return "\(property.value)"
    case "pressure":
        return "Pressure: \(property.value)"
    case "temp":
        return "Temp: \(property.value)"
    case "windSpeed":
        return "Wind Speed: \(property.value)"
    case "humidity":
        return "Humidity: \(property.value)"
    default:
        return "icon: "
    }
}




struct WeatherNowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherNowView()
            .environmentObject(WeatherMapViewModel())
    }
}
