//
//  PinAnnotation.swift
//  BornesRecharches
//
//  Created by Philippe MICHEL on 05/12/2022.
//

import SwiftUI

struct PinAnnotation: View {
    let tailleTrameCercle:CGFloat = 35
    let tailleImage:CGFloat = 12
    let tailleTriangle:CGFloat = 10
    
    var body: some View {
        VStack(spacing: 0)  {
            ZStack{
                Circle()
                    .frame(width: tailleTrameCercle, height:tailleTrameCercle)
                    .foregroundColor(.red)
                Image(systemName: Ressources.image.borneRecharge.rawValue )
                    .resizable()
                    .scaledToFit()
                    .frame(width: tailleImage, height: tailleImage)
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding(6)
                    .background()
                    .cornerRadius(36)
            }
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: tailleTriangle, height: tailleTriangle)
                .rotationEffect(Angle(degrees: 180))
                .offset(y:-3)
                .padding(.bottom, 40)

        }
    }
}

struct PinAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            PinAnnotation()
        }
        
    }
}
