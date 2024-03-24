//
//  TouristPlaceView.swift
//  WeatherApp
//
//  Created by Kavishka Ganewattha on 2024-01-04.
//

import Foundation
import SwiftUI

struct TouristPlaceView:View {
    var location:Location
    var body: some View{
        VStack(alignment:.leading){
    
                Text(location.name)
                    .font(.title)
                    .bold()
                
                Text(location.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Link(destination: URL(string: location.link)!) {
                    Text("Learn more ... ")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                
                ForEach(location.imageNames ,id: \.self){image in
                    Image("\(image)")
                        .resizable()
                        .cornerRadius(10)

                }

        }
        .padding(20)
        .padding(.vertical,-60)
        .padding(.bottom,40)
        
    }
}
