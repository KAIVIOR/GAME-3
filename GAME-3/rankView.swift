//
//  rankView.swift
//  GAME-3
//
//  Created by 吳庭愷 on 2021/6/1.
//

import SwiftUI

struct rankView: View {
    @StateObject var playersData = PlayerData()
    @EnvironmentObject var gameObject: GameObject
    var body: some View {
        List{

            HStack{
                Text("No.")
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 100, height: 40, alignment: .center)
                Text("Name")
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 100, height: 40, alignment: .center)
                Text("所花時間")
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 100, height: 40, alignment: .center)
                Button(action: {
                    gameObject.backtoGateView = true
                    withAnimation{
                        gameObject.isRank = false
                    }
                    
                }, label: {
                    Text("返回")
                        .fontWeight(.bold)
                        .padding(7)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 6)
                }).buttonStyle(PlainButtonStyle())
            }
            ForEach(playersData.players.indices, id: \.self) { (index) in
                RecordRowView(player: playersData.players[index], num: index)
            }
            
        }
    }
    
    
}


struct rankView_Previews: PreviewProvider {
    static var previews: some View {
        rankView()
    }
}
