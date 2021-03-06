//
//  Constant.swift
//  CollaboGame
//
//  Created by 순진이 on 2022/05/25.
//

import UIKit
// 컬렉션뷰 구성을 위한 설정

public struct CVCell {
    static let spacingWitdh: CGFloat = 3
    static let cellColumns: CGFloat = 2
    static let screenWidth: CGFloat = UIScreen.main.bounds.width * 0.7
    private init() {}
}

public struct ButtonImage {
    static let startImage = UIImage(named: "시작하기_초록")
    static let nextQuestionImage = UIImage(named: "다음문제_초록")
    static let answerImage = UIImage(named: "정답확인_노랑")
    static let hintImage = UIImage(named: "힌트버튼")
}
