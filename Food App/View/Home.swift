//
//  Home.swift
//  Food App
//
//  Created by Abdul Halim on 01/03/21.
//  Copyright © 2021 NEONFACT. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var HomeModel =  HomeViewModel()
    var body: some View {
        ZStack{
            VStack(spacing : 10){
                HStack(spacing : 15){
                    
                    Button(action : {
                        withAnimation(.easeIn){self.HomeModel.showMenu.toggle()}
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.pink)
                    })
                    
                    Text(HomeModel.userLocation == nil ? "Locating..." : "Deliver to"  )
                        .foregroundColor(.black)
                    
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.pink)
                    
                    Spacer(minLength: 0)
                }
                .padding([.horizontal, .top])
                
                Divider()
                
                HStack(spacing : 15){
                    TextField("Search", text: $HomeModel.seacrh)
                    
                    if HomeModel.seacrh != ""{
                        Button(action: {}, label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title)
                                .foregroundColor(.gray)
                        })
                            .animation(.easeIn)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
                
                Spacer()
            }
            
            HStack{
                Menu(homeData: HomeModel)
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
            }
            .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0 ).edgesIgnoringSafeArea(.all)
                .onTapGesture(perform: {
                    withAnimation(.easeIn){self.HomeModel.showMenu.toggle()}
                })
            )
            if HomeModel.noLocation {
                Text("Please Enable Location Addres In Settings To Further Move On!!")
                    .foregroundColor(.black)
                    .frame(width : UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth : .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).edgesIgnoringSafeArea(.all))
            }
            
        }
    .onAppear(perform: {
        self.HomeModel.locationManagaer.delegate = self.HomeModel
    })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
