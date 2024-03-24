//
//  DailyWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct DailyWeatherView: View {
    var day: Daily
    var body: some View {

        let formattedDate = DateFormatterUtils.formattedDateWithWeekdayAndDay(from: TimeInterval(day.dt))
        VStack{
            HStack{

                
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(day.weather[0].icon).png")) { phase in
                    switch phase {
                    case .empty:
                        Text("Loading...")
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 50,height: 50)
                            .padding(.leading,-10)
                    case .failure:
                        Text("Failed to load image")
                            .padding(.leading,50)
                    @unknown default:
                        Text("Unexpected state")
                        
                        
                    }
                }
                VStack{
                    if let weatherDis = day.weather.first{
                        Text("\(weatherDis.weatherDescription.rawValue.capitalized)")
                            .multilineTextAlignment(.center)
                    }
                    
                    Text(formattedDate)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                
                let maxTemp = day.temp.max
                let minTemp = day.temp.min
                Text("\((Double )(minTemp) , specifier: "%.f")ºC / \((Double )(maxTemp) , specifier: "%.f")ºC")
                    .padding(.trailing,-10)
                
            }
            .padding()
        }
        .background(Color(UIColor.systemGray4))
        .padding(10)
        
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var day = WeatherMapViewModel().weatherDataModel!.daily
    static var previews: some View {
        
        let day = Daily(dt: 1684951200,
                       sunrise: 1578918600,
                       sunset: 1578963635,
                       moonrise: 1578956760,
                       moonset: 1578935340,
                       moonPhase: 0.53,
                       temp: Temp(day: 25.0, min: 11.0, max: 15.0, night: 22.0, eve: 28.0, morn: 18.0),
                       feelsLike: FeelsLike(day: 26.0, night: 23.0, eve: 29.0, morn: 19.0),
                       pressure: 1020,
                       humidity: 50,
                       dewPoint: 10.0,
                       windSpeed: 5.0,
                       windDeg: 180,
                       windGust: 8.0,
                        weather: [Weather(id: 800, main: .rain, weatherDescription: .moderateRain, icon: "01d")],
                       clouds: 10,
                       pop: 0.1,
                       rain: 0.5,
                       uvi: 7.0)
        
        DailyWeatherView(day: day)
            .environmentObject(WeatherMapViewModel())
    }
}
