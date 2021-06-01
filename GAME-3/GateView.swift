//
//  GateView.swift
//  GAME-3
//
//  Created by 吳庭愷 on 2021/5/30.
//

import SwiftUI

struct GateView: View {
    @EnvironmentObject var gameObject: GameObject
    var body: some View {
        
        ZStack{
        Color("Color").edgesIgnoringSafeArea(.all)
        VStack{
            Text("嚐嚐西班牙文的威力")
                .bold()
                .font(.system(size:40))
                .padding()
            Button(action: {
                gameObject.isGameView = true
                gameObject.wintime = 0
                gameObject.vocab.shuffle()
                gameObject.fail = false
            }) {
                Text("開始遊戲")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 6)
            }
            
            Button (action: {
                
                withAnimation{
                    gameObject.isRank = true
                }
          
            }) {
                Text("排行榜")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 6)
                }
            Button (action: {
                
            }) {
                Text("規則說明")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 6)
                }

            }
            if gameObject.isGameView {
                PlayView()
            }
            if(gameObject.isRank){
                rankView()
                    
            }
            else if !gameObject.isRank{
                rankView()
                    .hidden()
            }
          

        }.onAppear(perform: {
            gameObject.isRank = false
            gameObject.backtoGateView = false
        })
    }
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
                        gameObject.isRank = false
                        gameObject.backtoGateView = true
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

}

struct GateView_Previews: PreviewProvider {
    static var previews: some View {
        GateView()
            .environmentObject(GameObject())
            .previewLayout(.fixed(width: 844, height: 390))

    }
}
