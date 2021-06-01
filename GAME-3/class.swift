//
//  class.swift
//  GAME-3
//
//  Created by 吳庭愷 on 2021/4/14.
//

import Foundation

struct Player: Identifiable, Codable {
    var id = UUID()
    var name: String
    var wintime: Int
    var firstwin: String
    var fail: Bool
}


class GameObject: ObservableObject{
    @Published var fail = false
    @Published var total_time = 0
    @Published var isRank = false
    @Published var startgame = false
    @Published var starnumber = false
    @Published var backtoGateView = false
    @Published var userFirstLogin =  ""
    @Published var isHomeView = true
    @Published var isGameView = false
    @Published var isGameOverView = false
    @Published var isEnterNameView = false
    @Published var isInfoView = false
    @Published var playerName = ""
    @Published var questionNum = 0
    @Published var correctNum = 0
    @Published var wintime = 0
    @Published var remainTime = 15
    @Published var isTimeUp = false
    @Published var secondsElapsed = 0
    @Published var frequency = 1.0
    @Published var timer: Timer?
    @Published var startDate: Date?
    @Published var selections = [SelectionObject(positionX: 210), SelectionObject(positionX: 310), SelectionObject(positionX: 410), SelectionObject(positionX: 510), SelectionObject(positionX: 610), SelectionObject(positionX: 716), SelectionObject(positionX: 866)]
    @Published var plates = [PlateObject(positionX: 140), PlateObject(positionX: 280), PlateObject(positionX: 420), PlateObject(positionX: 560), PlateObject(positionX: 700)]

    @Published var imageRandom: [Int] = [0, 0, 0, 0, 0, 0, 0]
    
    
    var vocab = [
                 spanish(name: "madre",chinese: "母親",answer: ["m","a","d","r","e"],select:["m","a","d","r","e"], Image: "madre"),
        spanish(name: "padre",chinese: "父親",answer: ["p","a","d","r","e"],select:["p","a","d","r","e"], Image: "padre"),
                 spanish(name: "nieto",chinese: "孫子",answer: ["n","i","e","t","o"],select:["n","i","e","t","o"], Image: "nieto"),
                 spanish(name: "leche",chinese: "牛奶",answer: ["l","e","c","h","e"],select:["l","e","c","h","e"], Image: "leche"),
                 spanish(name: "carne",chinese: "肉",answer: ["c","a","r","n","e"],select:["c","a","r","n","e"], Image: "carne"),
                 spanish(name: "señor",chinese: "先生",answer: ["s","e","ñ","o","r"],select:["s","e","ñ","o","r"], Image: "señor"),
                 spanish(name: "calle",chinese: "大道",answer: ["c","a","l","l","e"],select:["c","a","l","l","e"], Image: "calle"),
                 spanish(name: "móvil ",chinese: "手機",answer: ["m","ó","v","i","l"],select:["m","ó","v","i","l"], Image: "móvil"),
                 spanish(name: "calle",chinese: "大道",answer: ["c","a","l","l","e"],select:["c","a","l","l","e"], Image: "calle"),
                 spanish(name: "chico",chinese: "兒童",answer: ["c","h","i","c","o"],select:["c","h","i","c","o"], Image: "chico"),
                 spanish(name: "joven",chinese: "年輕的",answer: ["j","o","v","e","n"],select:["j","o","v","e","n"], Image: "joven"),
                 spanish(name: "viejo",chinese: "老人",answer: ["v","i","e","j","o"],select:["v","i","e","j","o"], Image: "viejo"),
                 spanish(name: "mujer",chinese: "女人",answer: ["m","u","j","e","r"],select:["m","u","j","e","r"], Image: "mujer"),
                 spanish(name: "viudo",chinese: "喪偶的",answer: ["v","i","u","d","o"],select:["v","i","u","d","o"], Image: "viudo"),
                 spanish(name: "llave",chinese: "鑰匙",answer: ["l","l","a","v","e"],select:["l","l","a","v","e"], Image: "llave"),
                 spanish(name: "gafas",chinese: "眼鏡",answer: ["g","a","f","a","s"],select:["g","a","f","a","s"], Image: "gafas"),
                 spanish(name: "amigo",chinese: "朋友",answer: ["a","m","i","g","o"],select:["a","m","i","g","o"], Image: "amigo"),
                 spanish(name: "comer",chinese: "喫午飯",answer: ["c","o","m","e","r"],select:["c","o","m","e","r"], Image: "comer"),
                 spanish(name: "huevo",chinese: "雞蛋",answer: ["h","u","e","v","o"],select:["h","u","e","v","o"], Image: "huevo"),
                 spanish(name: "fruta",chinese: "水果",answer: ["f","r","u","t","a"],select:["f","r","u","t","a"], Image: "fruta")
    ]
   
    func clearObject(){
        playerName = ""
        questionNum = 0
        correctNum = 0
        remainTime = 15
        isTimeUp = false
        secondsElapsed = 0
        frequency = 1.0
    }
}

struct spanish {
    var name: String
    var chinese: String
    var answer: [String]
    var select: [String]
    var Image: String
//    var position: [offs]
    
}



