//
//  HourWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct HourWeatherView: View {
    var current: Current

    var body: some View {
        let formattedDate = DateFormatterUtils.formattedDateWithDay(from: TimeInterval(current.dt))
        VStack(alignment: .center, spacing: 5) {
            Text(formattedDate)
                .font(.body)
                .foregroundColor(.black)
                .bold()
            
            
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(current.weather[0].icon).png")) { phase in
                switch phase {
                case .empty:
                    Text("Loading...")
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30,height: 30, alignment: .center)
                        .padding(.vertical)
                case .failure:
                    Text("Failed to load image")
                        .padding(.leading,50)
                @unknown default:
                    Text("Unexpected state")
                    
                    
                }
            }

            
            Text("\((Double)(current.temp), specifier: "%.f") ºC")
                .bold()
    
            
            if let weatherDis = current.weather.first{
                
                Text(weatherDis.weatherDescription.rawValue.capitalized)
                    .bold()
                    .frame(alignment:.center)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .foregroundColor(.black)
            }
            
        }
        .frame(width: 150,height: 200)
        .background(Color.teal)
        .cornerRadius(10)
        
        
        
    }
}

struct HourWeatherView_Previews:PreviewProvider{
    static var previews: some View{
        let currentInstance = Current(
                    dt: 1684951200,
                    sunrise: 0,
                    sunset: 0,
                    temp: 292.01,
                    feelsLike: 0.0,
                    pressure: 0,
                    humidity: 0,
                    dewPoint: 0.0,
                    uvi: 0.0,
                    clouds: 0,
                    visibility: 0,
                    windSpeed: 0.0,
                    windDeg: 0,
                    weather: [Weather(id: 0, main: .clear, weatherDescription: .brokenClouds, icon: "10d")],
                    windGust: 0.0,
                    pop: 0.0,
                    rain: nil
                )
        HourWeatherView(current:currentInstance )
            .environmentObject(WeatherMapViewModel())
    }
}




