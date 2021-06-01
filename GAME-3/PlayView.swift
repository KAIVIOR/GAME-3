//
//  PlayView.swift
//  GAME-3
//
//  Created by User16 on 2021/3/31.
//

import SwiftUI
import UIKit
import AVFoundation
import UserNotifications



extension AVPlayer {
static let sharedDingPlayer: AVPlayer = {
guard let url = Bundle.main.url(forResource: "9808", withExtension:
"mp3")
    else { fatalError("Failed to find sound file.") }
    
return AVPlayer(url: url)
}()

static let sharedSpinPlayer: AVPlayer = {
    guard let url = Bundle.main.url(forResource: "spin", withExtension:
"mp3") else { fatalError("Failed to find sound file.") }
return AVPlayer(url: url)
}()

func playFromStart() {
    seek(to: .zero)
        play()
    }
}

struct setting :View {
    var body: some View {
        Image("setting")
            .resizable()
            .scaledToFit()
            .frame(width: 70, height: 70, alignment: .center)
    }
}
struct PlayView: View {
    @StateObject var playersData = PlayerData()
    //@State private var select_vocab = vocab[1].select
    @EnvironmentObject var gameObject: GameObject
    var dingPlayer: AVPlayer { AVPlayer.sharedDingPlayer}
    @State private var userFirstLoginStr = ""
    @State var chang_number = 1
    @State private var menu = 0
    @State private var targetsize: CGFloat = 80
   //通知題目已經到底了
    @State private var NoQuestion = false
   //下一題
    @State private var nextQuestion = false
    //對的題目
    @State private var correctword = 0
    //test number
    @State private var test_number = 0
    @State private var screen_number = 2
    
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var to: CGFloat = 0
    @State var count = 0
    @State var start = false
    @State private var total_grade = 0
    let flgFormatter = DateFormatter()
    func Notify() {

        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "Timer Is Completed Successfully In Background !!!"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
    var body: some View {
        GeometryReader{ geometry in
        ZStack{
            
            
            Color("Color")
                .edgesIgnoringSafeArea(.all)
            ZStack{
              

                Text("\(gameObject.playerName)")
                    .bold()
                    .font(.title)
                    .offset(x: -320, y: -125)
                //Text("\(gameObject.wintime)")
                HStack{
                  
                   
                    VStack{
                        ZStack{
                            Circle()
                                .trim(from: 0, to: 1)
                                .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 20, lineCap: .round ))
                                .frame(width: 100, height: 100)
                            Circle()
                                .trim(from: 0, to: self.to)
                                .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round ))
                                .frame(width: 100, height: 100)
                                .rotationEffect(.init(degrees: -90))
                            VStack{
                                Text("\(self.count)")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                
                                Text("Of 30")
                                    .font(.system(size: 20))
                                    .padding(.top)
                            }
                        }


                        .padding(.top, 55)
                    }
                    .offset(x: 320 , y: -140)
                    
                    HStack{
                        Button(action: {
                        }){
                            
                            
                        }
                        .alert(isPresented: $NoQuestion)
                        { () -> Alert in
                            Alert(title: Text("已經答完所有的題目了"), message: Text(""), dismissButton: .default(Text("重新再來一把"), action: {
                                gameObject.questionNum = 0
                            }))
                        }
                    }
                                    }
                ForEach(0..<gameObject.vocab[gameObject.questionNum].answer.count, id: \.self){ index in
                   Image("round")
                    .resizable()
                    .scaledToFit()
                        .frame(width: targetsize, height: targetsize, alignment: .center)
                        .overlay(
                            Circle()
                                    .stroke(Color.white, lineWidth: 6)
                                .shadow(radius: 20)
                        )
                        .position(x: gameObject.plates[index].positionX, y: gameObject.plates[index].positionY)
                }
               
                ZStack{
                //HStack{
                    //這邊是指選項
                    ForEach(0..<gameObject.vocab[gameObject.questionNum].select.count, id: \.self){index in
                        Image("bubble")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .shadow(radius: 20)
                                      .overlay(
                                   
                                          Text("\(gameObject.vocab[gameObject.questionNum].select[index])")
                                            .foregroundColor(.black)
                                            .offset(y: CGFloat(0))
                                            .font(.system(size: 30, weight: .heavy))
                                          )
                                      .position(x: gameObject.selections[index].positionX, y:gameObject.selections[index].positionY)
                                      .offset(gameObject.selections[index].oldOffset)
                            
                                      .gesture(
                                          DragGesture(coordinateSpace: .global)
                                              .onChanged({ (value) in
                                             
                                                gameObject.selections[index].oldOffset.width = gameObject.selections[index].newOffset.width + value.translation.width
                                                  gameObject.selections[index].oldOffset.height = gameObject.selections[index].newOffset.height + value.translation.height
                                              })
                    .onEnded({ (value) in
                    speak(str: gameObject.vocab[gameObject.questionNum].select[index])
                    gameObject.selections[index].newOffset = gameObject.selections[index].oldOffset
                                           
                let intersectionIndex = judgeIntersection(objectX: gameObject.selections[index].positionX + gameObject.selections[index].newOffset.width, objectY: gameObject.selections[index].positionY + gameObject.selections[index].newOffset.height, wordIndex: index)
                                                print("intersectionIndex: \(intersectionIndex)")
        if(intersectionIndex==100 || nextQuestion || intersectionIndex==200){
            
                        withAnimation{
    gameObject.selections[index].oldOffset = CGSize.zero
    gameObject.selections[index].newOffset = gameObject.selections[index].oldOffset
                            
                            
                                                    }
                                                }
            else{
                
                    withAnimation{
    gameObject.selections[index].oldOffset.width = gameObject.plates[intersectionIndex].positionX - gameObject.selections[index].positionX
    gameObject.selections[index].oldOffset.height = gameObject.plates[intersectionIndex].positionY - gameObject.selections[index].positionY - CGFloat(0)
    gameObject.selections[index].newOffset = gameObject.selections[index].oldOffset
                        
                                                    }
                                                }
                             
                                                  
                                              })
                                      )
                        Button(action: {
                            speak(str: gameObject.vocab[gameObject.questionNum].name)
                        }){
                            Image(gameObject.vocab[gameObject.questionNum].Image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 150)
                            
                        }
                        
                          
                        if(gameObject.isEnterNameView){
                            EnterNameView()
                                
                        }
                        else if !gameObject.isEnterNameView{
                            EnterNameView()
                                .hidden()
                        }
                        
                        if self.count == 30{
                            GameOverView()
                            
                            
                        }
                        
                        if gameObject.backtoGateView {
                            EmptyView().fullScreenCover(isPresented: $gameObject.backtoGateView)
                            {
                                GateView()
                            }
                        }

                       
                            
                    }
            
            }
            
           
        }
        .onAppear{
            
                gameObject.backtoGateView = false
            
            self.start.toggle()
            gameObject.questionNum=0
            gameObject.playerName = ""
            gameObject.isEnterNameView = true
            flgFormatter.dateFormat = "y MMM dd HH:mm"
          
            
            //adjustPlatePosition()
            //if(gameObject.starnumber){
                print("開始遊戲")
                for index in 0..<gameObject.vocab[gameObject.questionNum].select.count{
                    withAnimation{
                        gameObject.selections[index].oldOffset = CGSize.zero
                        gameObject.selections[index].newOffset = gameObject.selections[index].oldOffset
                    }
                }
                for index in 0..<gameObject.vocab.count{
                    gameObject.vocab[index].select.shuffle()
                        }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    speak(str: gameObject.vocab[gameObject.questionNum].name)
                }
                UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound,.alert]){
                    (_, _) in
                }
            //}
          

                }
            .onReceive(self.time){ (_) in
                
                if self.start{
                    
                    if self.count != 30{
                        
                        self.count += 1
                        gameObject.wintime += 1
                      //  print("hello")
                        
                        withAnimation(.default){
                            
                            self.to = CGFloat(self.count) / 30
                        }
                    }
                    else{
                        
                            self.start.toggle()
                        
                        
                        self.Notify()
                    }
                }
                
            }
            }
        }
    }
    struct GameOverView: View {
        @StateObject var playersData = PlayerData()
        @EnvironmentObject var gameObject: GameObject
        var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(red: 250/255, green: 243/255, blue: 221/255))
                    .frame(width: 400, height: 300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .stroke(Color("Color"), lineWidth: 6)
                            .shadow(color: Color("Color"), radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                            .frame(width: 400, height: 300)
                    )
                VStack{
                    HStack{
                        Text("Game Over")
                            .font(.system(size: 30))
                            .offset(x: 50, y: 0)
                        Image("fail")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 100)
                            .offset(x: 0, y: 0)
                    }
                    //.padding()
                    HStack{
                        Button {
                           //去標題
                            gameObject.backtoGateView = true
                            withAnimation{
                                gameObject.isGameView = false
                            }
                            gameObject.fail = true
                            gameObject.wintime = 99999
                            addToRecordsData()
                            
                        } label: {
                            Text("回到選單")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                   
                    
                }
            }
            
        }
        func addToRecordsData(){
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "y/MMM/d HH:mm"
            let newRecord = Player( name: gameObject.playerName, wintime: gameObject.wintime , firstwin: formatter3.string(from: Date()), fail: gameObject.fail)
            for index in 0..<playersData.players.count{
                if(gameObject.playerName==playersData.players[index].name){
                    if(gameObject.total_time <= playersData.players[index].wintime){
                            playersData.players.remove(at: index)
                            playersData.players.append(newRecord)
                            playersData.players.sort {
                                $0.wintime < $1.wintime
                            }
                        }
                    return
                }
            }
            playersData.players.append(newRecord)
            playersData.players.sort {
                $0.wintime < $1.wintime
            }
        }
    }

    func Play()  {
        if self.count == 30{
            self.count = 0
                withAnimation(.default){
                            self.to = 0
                                            }
                            }
        self.start.toggle()
    }
    func Restart() {
        self.count = 0
        withAnimation(.default){
            self.to = 0
        }
        
    }
    func judgeIntersection(objectX: CGFloat, objectY: CGFloat, wordIndex: Int)->Int{
        nextQuestion = false
        let objectRect = CGRect(x: objectX, y: objectY, width: 100, height: 100)
        for index in (0..<gameObject.vocab[gameObject.questionNum].answer.count){
            let targetRect = CGRect(x: gameObject.plates[index].positionX, y: gameObject.plates[index].positionY, width: targetsize, height: targetsize)
            let interRect = objectRect.intersection(targetRect)
            if(interRect.width>=60 && interRect.height>=60){
                if(gameObject.vocab[gameObject.questionNum].answer[index].isEqual(gameObject.vocab[gameObject.questionNum].select[wordIndex])){
                    correctword+=1
                    
                    if(correctword==gameObject.vocab[gameObject.questionNum].answer.count){
                        
                        print("已經完成題目了")
                        //total_grade += self.count
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        dingPlayer.playFromStart()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        speak(str: gameObject.vocab[gameObject.questionNum].name)
                        }
                        stop()
                        self.start.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            changeQuestion()
                            Restart()
                            self.start.toggle()
                        }
                        
                    }
                    return index
                }//放對位置
                else{
                    return 200//放錯
                }
                
            }
        }
                return 100//沒放到
        
    }
    func changeQuestion(){
        if(gameObject.questionNum+1>=10){
            print("inn")
            stop()
            gameObject.isEnterNameView = true
        }
        else{
            for index in 0..<gameObject.vocab[gameObject.questionNum].select.count{
                withAnimation{
                    gameObject.selections[index].oldOffset = CGSize.zero
                    gameObject.selections[index].newOffset = gameObject.selections[index].oldOffset
                }
            }
            correctword = 0
            gameObject.questionNum+=1
            adjustPlatePosition()
//            changeCakeImg()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                speak(str: gameObject.vocab[gameObject.questionNum].name)
            }
            nextQuestion  = true
        }
        
    }

    func stop(){
        gameObject.timer?.invalidate()
        gameObject.timer = nil
    }
    
    func changeCakeImg(){
        for index in 0..<gameObject.vocab[gameObject.questionNum].select.count{
            gameObject.imageRandom[index] = Int.random(in: 0...5)
        }
    }
    func chang_vocab()  {
        chang_number = Int.random(in: 0...1)
        //k = vocab[chang_number].select
    }
    func speak(str: String){
        let utterance = AVSpeechUtterance(string: str)
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: "es-ES")
        let synthesizer = AVSpeechSynthesizer()
        
        synthesizer.speak(utterance)
    }
    func adjustPlatePosition(){

        let oddPositionX = [140, 280, 420, 560, 700]
        for index in 0..<gameObject.vocab[gameObject.questionNum].select.count{

                gameObject.plates[index].positionX = CGFloat(oddPositionX[index])
            //}
            
        }
    }
    struct EnterNameView: View {
        @EnvironmentObject var gameObject: GameObject
        var body: some View {
            ZStack{
                if  gameObject.startgame{
                    PlayView()
                }
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(red: 250/255, green: 243/255, blue: 221/255))
                    .frame(width: 400, height: 300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .stroke(Color("Color"), lineWidth: 6)
                            .shadow(color: Color("Color"), radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                            .frame(width: 400, height: 300)
                    )
                VStack{
                    Text("勇者你的名字是什麼")
                        .font(.system(size: 30))
                        .padding()
                    Text("你以為我會給你想想名字的時間嗎！！")
                    HStack{
                        TextField("", text: $gameObject.playerName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300)
                   
                    }
                    Button {
                        
                        //gameObject.isGameOverView = true
                        withAnimation{
                            gameObject.isEnterNameView = false
                        }
                        //gameObject.isGameView = false
                        
                        gameObject.starnumber = true
                        
                    } label: {
                        Text("完成")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .frame(width: 100, height: 100, alignment: .center)
                }
            }
            
        }
        
    
    }

    }



struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
            .environmentObject(GameObject())
            .previewLayout(.fixed(width: 844, height: 390))
           
    }
}

