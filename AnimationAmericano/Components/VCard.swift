//
//  VCard.swift
//  AnimationAmericano
//
//  Created by Santiago Torres Alvarez on 21/11/23.
//

import SwiftUI

struct VCard: View {
    var course: Course
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(course.title)
                .customFont(.title2)
                .frame(maxWidth: 170, alignment: .leading)
            //para que el texto del title sea visto sin cortarse antes que el subtitle
                .layoutPriority(1)
            Text(course.subtitle)
                .customFont(.subheadline)
            Text(course.caption.uppercased())
                .customFont(.footnote2)
            Spacer()
            HStack {
                ForEach(Array([4,5,6].shuffled().enumerated()), id: \.offset) { index, number in
                    Image("Avatar \(number)")
                        .resizable()
                        .frame(width:44, height:44)
                        .mask(Circle())
                    //for 3 images putting them together, this math is only for that
                        .offset(x: CGFloat(index * -20))
                }
            }
        }
        .foregroundColor(.white)
        .padding(30)
        .frame(width:260, height: 310)
        .background(.linearGradient(colors: [course.color, course.color.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: course.color.opacity(0.3), radius: 8, x:0, y: 13)
        .overlay(
            course.image
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding()
            
        )
       
        
    }
}


struct VCard_Previews: PreviewProvider {
    static var previews: some View{
        VCard(course: courses[1])
    }
}
