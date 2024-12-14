//
//  SplashScreenView.swift
//  GroceryApp
//
//  Created by IM Student on 2024-11-26.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var scaleEffect: CGFloat = 0.5
    @State private var opacity: Double = 0.0
    @State private var isActive: Bool = false

    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.blue.edgesIgnoringSafeArea(.all) // Customize the background color

                VStack {
                    Image(systemName: "cart.fill") // Replace with custom image name if needed
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .scaleEffect(scaleEffect)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                scaleEffect = 1.0
                                opacity = 1.0
                            }
                        }

                    Text("GroceryApp")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
