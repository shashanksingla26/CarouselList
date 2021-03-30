//
//  ContentView.swift
//  CarouselList
//
//  Created by shashank on 30/03/21.
//

import SwiftUI

struct ContentView: View {
    
    func getScalledValue(proxy: GeometryProxy) -> CGFloat {
        let x = proxy.frame(in: .global).minX
        let value = abs(x-32)
        if  value < 150 {
            //print(value)
            let scaleValue = 1 + (150 - value) / 700
            //print(scaleValue)
            return scaleValue
        }
        return 1
    }
    
    func getOpacity(proxy: GeometryProxy) -> CGFloat {
        let x = proxy.frame(in: .global).minX
        let value = abs(x-32)
        if  value > 150 {
            let scaleValue = 1 - (value / 400)
            return scaleValue
        }
        return 1
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<8, id: \.self) { index in
                            GeometryReader { proxy in
                                VStack {
                                    Spacer()
                                    Image("image\(index + 1)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width - 100, height: 300, alignment: .center)
                                        .clipped()
                                        .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(lineWidth: 1)
                                            .fill(Color.secondary)
                                        )
                                        .cornerRadius(20)
                                        .opacity(Double(getOpacity(proxy: proxy)))
                                        .scaleEffect(CGSize(width: 1, height: getScalledValue(proxy: proxy)))
                                       
                                        .animation(.easeInOut)
                                    Spacer()
                                }
                                
                            }
                            .frame(width: UIScreen.main.bounds.width - 100, height: 400)
                            
                            
                        }
                    }
                    .padding()
                    
                }
                Spacer()
            }
            .navigationTitle("Carousel")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
