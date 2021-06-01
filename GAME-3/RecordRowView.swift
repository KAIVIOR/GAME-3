//
//  RecordRowView.swift
//  GAME-3
//
//  Created by 吳庭愷 on 2021/6/1.
//

import SwiftUI

struct RecordRowView: View {
    var player: Player
    var num: Int
    var body: some View {
        ZStack{
            if(!player.fail){
                HStack {
                    Text(" ")
                          Text("No.\(num) ")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            Spacer(minLength: 50)
                            //.offset(x: -100.0, y: 0.0)
                            
                            Text(player.name )
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                //.offset(x: -50.0, y: 0.0)
                            
                    Spacer()
                   
                                Text("\(player.wintime)  s")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    //.offset(x: 50.0, y: 0.0)
                                    .padding()
                            
                                    
                            
                        }
                .frame(width: 320, height: 50, alignment: .center)
                .background(Color("Color"))
                .cornerRadius(10)
            }
            else{
                HStack {
                    Text(" ")
                          Text("No.\(num) ")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            Spacer(minLength: 50)
                            //.offset(x: -100.0, y: 0.0)
                            
                            Text(player.name )
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                //.offset(x: -50.0, y: 0.0)
                            
                    Spacer()
                   
                                Text("\(player.wintime)  s")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    //.offset(x: 50.0, y: 0.0)
                                    .padding()
                            
                                    
                            
                        }
                .frame(width: 320, height: 50, alignment: .center)
                .background(Color("Color-2"))
                .cornerRadius(10)
            }

        }
        
        
    }
}

struct RecordRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        RecordRowView(player: Player(name: "KAIVIOR", wintime: 10000, firstwin: "2019/5/21/4:45", fail: false), num: 0)
                  .previewLayout(.sizeThatFits)
    }
}
