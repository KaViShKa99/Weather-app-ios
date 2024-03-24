//
//  WeatherForcastView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct WeatherForecastView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 16) {
                    if let hourlyData = weatherMapViewModel.weatherDataModel?.hourly {
                    
                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 10) {

//                                ForEach(hourlyData) { hour in
                                ForEach(hourlyData) { hour in
                                    HourWeatherView(current: hour)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        .frame(height: 180)
                        
                    }else{
                        Text("Error Loading Hourly Data !")
                            .bold()
                            .padding(.leading, 50)
                            .font(.body)
                    }
                    
                    Divider()
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    
                    VStack {
//                        let dailyDay:[Daily]=[
//                            Daily(
//                                    dt: 1684951200,
//                                    sunrise: 1578918600,
//                                    sunset: 1578963635,
//                                    moonrise: 1578956760,
//                                    moonset: 1578935340,
//                                    moonPhase: 0.53,
//                                    temp: Temp(day: 25.0, min: 11.0, max: 15.0, night: 22.0, eve: 28.0, morn: 18.0),
//                                    feelsLike: FeelsLike(day: 26.0, night: 23.0, eve: 29.0, morn: 19.0),
//                                    pressure: 1020,
//                                    humidity: 50,
//                                    dewPoint: 10.0,
//                                    windSpeed: 5.0,
//                                    windDeg: 180,
//                                    windGust: 8.0,
//                                    weather: [Weather(id: 800, main: .rain, weatherDescription: .moderateRain, icon: "01d")],
//                                    clouds: 10,
//                                    pop: 0.1,
//                                    rain: 0.5,
//                                    uvi: 7.0
//                                ),
//                            Daily(
//                                    dt: 1684951200,
//                                    sunrise: 1578918600,
//                                    sunset: 1578963635,
//                                    moonrise: 1578956760,
//                                    moonset: 1578935340,
//                                    moonPhase: 0.53,
//                                    temp: Temp(day: 25.0, min: 11.0, max: 15.0, night: 22.0, eve: 28.0, morn: 18.0),
//                                    feelsLike: FeelsLike(day: 26.0, night: 23.0, eve: 29.0, morn: 19.0),
//                                    pressure: 1020,
//                                    humidity: 50,
//                                    dewPoint: 10.0,
//                                    windSpeed: 5.0,
//                                    windDeg: 180,
//                                    windGust: 8.0,
//                                    weather: [Weather(id: 800, main: .rain, weatherDescription: .moderateRain, icon: "01d")],
//                                    clouds: 10,
//                                    pop: 0.1,
//                                    rain: 0.5,
//                                    uvi: 7.0
//                                ),
//                            Daily(
//                                    dt: 1684951200,
//                                    sunrise: 1578918600,
//                                    sunset: 1578963635,
//                                    moonrise: 1578956760,
//                                    moonset: 1578935340,
//                                    moonPhase: 0.53,
//                                    temp: Temp(day: 25.0, min: 11.0, max: 15.0, night: 22.0, eve: 28.0, morn: 18.0),
//                                    feelsLike: FeelsLike(day: 26.0, night: 23.0, eve: 29.0, morn: 19.0),
//                                    pressure: 1020,
//                                    humidity: 50,
//                                    dewPoint: 10.0,
//                                    windSpeed: 5.0,
//                                    windDeg: 180,
//                                    windGust: 8.0,
//                                    weather: [Weather(id: 800, main: .rain, weatherDescription: .moderateRain, icon: "01d")],
//                                    clouds: 10,
//                                    pop: 0.1,
//                                    rain: 0.5,
//                                    uvi: 7.0
//                                ), 
//                            Daily(
//                                    dt: 1684951200,
//                                    sunrise: 1578918600,
//                                    sunset: 1578963635,
//                                    moonrise: 1578956760,
//                                    moonset: 1578935340,
//                                    moonPhase: 0.53,
//                                    temp: Temp(day: 25.0, min: 11.0, max: 15.0, night: 22.0, eve: 28.0, morn: 18.0),
//                                    feelsLike: FeelsLike(day: 26.0, night: 23.0, eve: 29.0, morn: 19.0),
//                                    pressure: 1020,
//                                    humidity: 50,
//                                    dewPoint: 10.0,
//                                    windSpeed: 5.0,
//                                    windDeg: 180,
//                                    windGust: 8.0,
//                                    weather: [Weather(id: 800, main: .rain, weatherDescription: .moderateRain, icon: "01d")],
//                                    clouds: 10,
//                                    pop: 0.1,
//                                    rain: 0.5,
//                                    uvi: 7.0
//                                ),
//                            Daily(
//                                    dt: 1684951200,
//                                    sunrise: 1578918600,
//                                    sunset: 1578963635,
//                                    moonrise: 1578956760,
//                                    moonset: 1578935340,
//                                    moonPhase: 0.53,
//                                    temp: Temp(day: 25.0, min: 11.0, max: 15.0, night: 22.0, eve: 28.0, morn: 18.0),
//                                    feelsLike: FeelsLike(day: 26.0, night: 23.0, eve: 29.0, morn: 19.0),
//                                    pressure: 1020,
//                                    humidity: 50,
//                                    dewPoint: 10.0,
//                                    windSpeed: 5.0,
//                                    windDeg: 180,
//                                    windGust: 8.0,
//                                    weather: [Weather(id: 800, main: .rain, weatherDescription: .moderateRain, icon: "01d")],
//                                    clouds: 10,
//                                    pop: 0.1,
//                                    rain: 0.5,
//                                    uvi: 7.0
//                                ),
//                            Daily(
//                                    dt: 1684951200,
//                                    sunrise: 1578918600,
//                                    sunset: 1578963635,
//                                    moonrise: 1578956760,
//                                    moonset: 1578935340,
//                                    moonPhase: 0.53,
//                                    temp: Temp(day: 25.0, min: 11.0, max: 15.0, night: 22.0, eve: 28.0, morn: 18.0),
//                                    feelsLike: FeelsLike(day: 26.0, night: 23.0, eve: 29.0, morn: 19.0),
//                                    pressure: 1020,
//                                    humidity: 50,
//                                    dewPoint: 10.0,
//                                    windSpeed: 5.0,
//                                    windDeg: 180,
//                                    windGust: 8.0,
//                                    weather: [Weather(id: 800, main: .rain, weatherDescription: .moderateRain, icon: "01d")],
//                                    clouds: 10,
//                                    pop: 0.1,
//                                    rain: 0.5,
//                                    uvi: 7.0
//                                ),
//                        ]
                        
                        if let dailyDay = weatherMapViewModel.weatherDataModel?.daily{
                            List {
                                ForEach(dailyDay) { day in
                                    DailyWeatherView(day: day)
                                }
                                .padding(.vertical, -20)
                            }
                            .listStyle(GroupedListStyle())
                            .frame(height: 500)
                            
                        }else{
                            Text("Error Loading Daily Data !")
                                .bold()
                                .padding(.leading, 50)
                                .font(.body)
                        }
                        
                        
                        
//                         .opacity(0.2)
                    }
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 15)
                
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Image(systemName: "sun.min.fill")
                                VStack{
                                    Text("Weather Forecast for \(weatherMapViewModel.city)").font(.title3)
                                        .fontWeight(.bold)
//                                    Text("See EPL examples from weeek 4 onwards")
                                }
                            }
                        }
                    }
        }
    }
}

struct WeatherForcastView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherForecastView()
            .environmentObject(WeatherMapViewModel())
    }
}
