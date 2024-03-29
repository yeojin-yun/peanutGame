//
//  Person.swift
//  CollaboGame
//
//  Created by 순진이 on 2022/05/19.
//

import Foundation
import UIKit
class Person {
    static let shared = Person()
    private init() {}
    
    var questionArray: [String] = []
    var wrongAnswerArray: [String] = []
    
    var answer: String = ""

    let person = [
        "강부자", "문채원", "김고은", "제시", "김다미", "김연경", "김숙", "앤 해서웨이", "산드라 블록", "윤여정", "이영지", "이성경", "탕웨이", "스칼렛 요한슨", "샤를리즈 테론", "엄지원", "라미란", "전소민", "한소희", "정호연", "이하늬", "김하늘", "황신혜", "진지희", "려원", "레이첼 맥아담스", "김세정", "신봉선", "김아중", "박슬기", "신세경", "박나래", "이은형", "박진주", "박경혜", "한효주", "한고은", "박은빈", "김희선", "이보영", "유인나", "전도연", "고아라", "수애", "이다희", "김유정", "김나영", "박미선", "이지혜", "에일리", "엄정화", "현아", "선미", "사나", "쯔위", "전소미", "슬기", "안유진", "소연", "갤 가돗", "제니", "원빈", "강호동", "서수남", "이종석", "이민호", "박명수", "지석진", "강남", "손흥민", "모건 프리먼", "윤석열", "하정우", "허경영", "안철수", "전현무", "허성태", "임원희", "정만식", "안내상", "조 바이든", "조셉 고든 래빗", "베네딕트 컴버배치", "제이슨 스타뎀", "제이크 질렌할", "문세윤", "모건 프리먼", "크리스찬 베일", "이명박", "티모시 샬라메", "휴 잭맨", "로버트 다우니 주니어", "조진웅", "마동석", "붐", "신동엽", "이선균", "김종국", "톰 하디", "김지석", "이승기", "조정석", "드웨인 존슨", "류승룡", "이병헌", "김원효"]

    func getRandomPerson() {
        answer = person.randomElement() ?? "김고은"
    }
    
    func appendElements(elements: String) {
        questionArray.append(elements)
    }
    
    func removeElements(elements: String) {
        wrongAnswerArray.append(elements)
    }
}
