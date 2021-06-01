////
////  GameOverView.swift
////  GAME-3
////
////  Created by 吳庭愷 on 2021/6/1.
////
//
//import SwiftUI
//
//struct GameOverView: View {
//    @EnvironmentObject var gameObject: GameObject
//    var body: some View {
//        ZStack{
//            RoundedRectangle(cornerRadius: 25, style: .continuous)
//                .fill(Color(red: 250/255, green: 243/255, blue: 221/255))
//                .frame(width: 400, height: 300)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 25, style: .continuous)
//                        .stroke(Color("Color"), lineWidth: 6)
//                        .shadow(color: Color("Color"), radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
//                        .frame(width: 400, height: 300)
//                )
//            VStack{
//                Text("Game Over")
//                    .font(.system(size: 30))
//                    //padding()
//                HStack{
//                    Button {
//                        withAnimation{
//                            gameObject.isGameOverView = false
//                        }
//                        
//                        gameObject.isGameView = false
//                        gameObject.isGameOverView = false
//                    } label: {
//                        Text("")
//                            .fontWeight(.bold)
//                            .padding()
//                            .background(Color.red)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                    Button {
//                        withAnimation{
//                            gameObject.isEnterNameView = false
//                        }
//                        
//                        gameObject.isGameView = true
//                        gameObject.isGameOverView = false
//                    } label: {
//                        Text("回到選單")
//                            .fontWeight(.bold)
//                            .padding()
//                            .background(Color.red)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                }
//               
//                
//            }
//        }
//        
//    }
//}

//struct GameOverView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameOverView()
//    }
//}
