//
//  ball.swift
//  GAME-3
//
//  Created by User16 on 2021/3/31.
//

import SwiftUI

struct circule: Shape {
    func path(in rect: CGRect) ->Path{
        Path{(path) in
            path.move(to:CGPoint(x:rect.width,y:0))
            path.addQuadCurve(to: CGPoint(x:0,y:rect.height), control: CGPoint(x:rect.width/5,y:rect.height/5))
            path.addQuadCurve(to: CGPoint(x:rect.width,y:0), control: CGPoint(x:rect.width*17/20,y:rect.height*13/15))
            path.closeSubpath()
            
        }
    }
}
struct off {
   // var key = Int()
    var offset = CGSize.zero
    var newPosition = CGSize.zero
    var degrees: Double = 0
    var scale : CGFloat = 1
    var Word : String
   // var
}
struct ball: View {
    @State private var scale: CGFloat = 1
    @State var color1 = Color.yellow
    @State private var degrees: Double = 0
    @State private var circ = [off]()
    func vocab_ball()  {
        
    }
    func addcircle()
   {

        circ.append(off(offset: CGSize(width: 3, height: 3), newPosition: CGSize(width: 1, height: 1),degrees: 0, Word: " "))

   }
    var body: some View {
        VStack{
            ZStack{
           
                ForEach(0..<circ.count, id: \.self)
                 { (item) in

                        Circle()
                           
                        .frame(width: 100, height: 100)
                        .rotationEffect(Angle.degrees(degrees))
                            .foregroundColor(color1)
                            .offset(circ[item].offset)
                            .rotationEffect(Angle.degrees(circ[item].degrees))
                            .scaleEffect(circ[item].scale)
                           
                             .gesture(
                                 DragGesture()
                                         .onChanged({(value) in
                                            circ[item].offset = CGSize(width: value.translation.width +  circ[item].newPosition.width, height: value.translation.height +  circ[item].newPosition.height)
                                         })
                                         .onEnded({(value) in
                                            circ[item].newPosition =  circ[item].offset
                                         })
                             )
                            .gesture(MagnificationGesture()
                                        .onChanged{value in
                                            circ[item].scale = value.magnitude
                                        })
                            .gesture(RotationGesture()
                                        .onChanged{
                                            angle in
                                            circ[item].degrees = angle.degrees
                                        })
                 }
                Button(action: addcircle) {
                    Text("新增圓形")
                        .fontWeight(.bold)
                            //.font(.little)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .padding(5)
                            .border(Color.purple, width: 1)
                      //  .offset(x:122, y:45)
                    
                }
                .padding(.top, 500)
            }
        }
   
    }

}

struct ball_Previews: PreviewProvider {
    static var previews: some View {
        ball()
    }
}
