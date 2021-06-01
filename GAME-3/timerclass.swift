////
////  timerclass.swift
////  GAME-3
////
////  Created by 吳庭愷 on 2021/5/31.
////
//
//struct TimerBarView : View{
////    @EnvironmentObject var timeObject: TimeObject
////    @Binding var to : CGFloat
////    @Binding var count : Int
////    @Binding var start : Bool
////    @Binding var time : Timer.Publishe
////        @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
////        @State var to: CGFloat = 0
////        @State var count = 0
////        @State var start = false
//    var body: some View{
//        ZStack{
//            //Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)
//                VStack{
//                    ZStack{
//                        Circle()
//                            .trim(from: 0, to: 1)
//                            .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 20, lineCap: .round ))
//                            .frame(width: 100, height: 100)
//                        Circle()
//                            .trim(from: 0, to: self.to)
//                            .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round ))
//                            .frame(width: 100, height: 100)
//                            .rotationEffect(.init(degrees: -90))
//                        VStack{
//                            Text("\(self.count)")
//                                .font(.system(size: 20))
//                                .fontWeight(.bold)
//                            Text("Of 15")
//                                .font(.system(size: 20))
//                                .padding(.top)
//                        }
//                    }
//
//                    HStack(spacing: 20){
//                        Button(action:{
//                            if self.count == 15{
//                                self.count = 0
//                                withAnimation(.default){
//                                    self.to = 0
//                                }
//                            }
//                            self.start.toggle()
//                        }) {
//                            HStack(spacing: 15){
//                                Image(systemName: self.start ? "pause.fill" : "play.fill")
//                                    .foregroundColor(.white)
//
//                                Text(self.start ? "Pause" : "Play")
//                                    .foregroundColor(.white)
//                            }
//                            .padding(.vertical)
//                            .frame(width: (UIScreen.main.bounds.width/2) - 55)
//                            .background(Color.red)
//                            .clipShape(Capsule())
//                            .shadow(radius: 6)
//                        }
//
//                        Button(action:{
//                            self.count = 0
//                            withAnimation(.default){
//                                self.to = 0
//                            }
//                        }) {
//                            HStack(spacing: 15){
//                                Image(systemName: "arrow.clockwise")
//                                    .foregroundColor(.red)
//
//                                Text("Restart")
//                                    .foregroundColor(.red)
//                            }
//                            .padding(.vertical)
//                            .frame(width: (UIScreen.main.bounds.width/2) - 55)
//                            .background(
//                                Capsule()
//                                    .stroke(Color.red, lineWidth: 2)
//                            )
//                            //.shadow(radius: 6)
//                            .shadow(color: Color.red,
//                                    radius: 8.0,
//                                    x: CGFloat(0),
//                                    y: CGFloat(0))
//
//                        }
//
//
//                    }
//
//                    .padding(.top, 55)
//                }
//
//
//        }
////            .onAppear(perform:{
////                UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound,.alert]){
////                    (_, _) in
////                }
////            })
////            .onReceive(self.time){ (_) in
////
////                if self.start{
////
////                    if self.count != 15{
////
////                        self.count += 1
////                        print("hello")
////
////                        withAnimation(.default){
////
////                            self.to = CGFloat(self.count) / 15
////                        }
////                    }
////                    else{
////
////
////                        self.start.toggle()
////                        self.Notify()
////                    }
////                }
////
////            }
//    }
////        func Notify() {
////
////            let content = UNMutableNotificationContent()
////            content.title = "Message"
////            content.body = "Timer Is Completed Successfully In Background !!!"
////
////            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
////
////            let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
////
////            UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
////        }
//}
