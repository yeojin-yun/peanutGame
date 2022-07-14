//
//  CustomView.swift
//  CollaboGame
//
//  Created by 순진이 on 2022/07/12.
//

import UIKit

class StackView: UIView {
    let topLine = UIView()
    let typeLabel = UILabel()
    let choiceButton = UIButton(type: .system)
    let firstNumber = UILabel()
    let secondNumber = UILabel()
    let thirdNumber = UILabel()
    let forthNumber = UILabel()
    let fifthNumber = UILabel()
    let bottomLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setDetail()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDetail() {
        [typeLabel, firstNumber, secondNumber, thirdNumber, forthNumber, fifthNumber].forEach {
            $0.font = UIFont.Pretandard(type: .Regular, size: 20)
            typeLabel.font = UIFont.Pretandard(type: .Bold, size: 20)
            $0.textAlignment = .center
        }
        
        [choiceButton].forEach {
            $0.titleLabel?.font = UIFont.Pretandard(type: .Regular, size: 20)
            $0.setTitle("자동", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .black
        }
        
        [topLine, bottomLine].forEach {
            $0.backgroundColor = myColor.greenColor
        }
    }
    
    func setLayout() {
        let stack = UIStackView(arrangedSubviews: [typeLabel, choiceButton, firstNumber, secondNumber, thirdNumber, forthNumber, fifthNumber])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        [stack, topLine, bottomLine].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            topLine.heightAnchor.constraint(equalToConstant: 2),
            topLine.bottomAnchor.constraint(equalTo: stack.topAnchor),
            topLine.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: stack.trailingAnchor),

            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            bottomLine.heightAnchor.constraint(equalToConstant: 2),
            bottomLine.topAnchor.constraint(equalTo: stack.bottomAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
        ])
    }
}

class RandomLotteryButton: UIButton {
    let gameTitle = UILabel()
    let subTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDetail()
        setLayout()
    }
    
    init(main: String, sub: String) {
        super.init(frame: .zero)
        gameTitle.text = main
        subTitle.text = sub
        setLayout()
        setDetail()
    }
    
    
    func setLayout() {
        [gameTitle, subTitle].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            gameTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            gameTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            gameTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gameTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            subTitle.topAnchor.constraint(equalTo: gameTitle.bottomAnchor, constant: 5),
            subTitle.leadingAnchor.constraint(equalTo: gameTitle.leadingAnchor),
            subTitle.trailingAnchor.constraint(equalTo: gameTitle.trailingAnchor),
            subTitle.centerXAnchor.constraint(equalTo: gameTitle.centerXAnchor)
        ])
    }
    
    func setDetail() {
        self.backgroundColor = myColor.yellow
        self.layer.borderWidth = 5
        self.layer.borderColor = myColor.deepYellow.cgColor
        self.layer.masksToBounds = true
        [gameTitle].forEach {
            $0.textColor = .white
            $0.font = UIFont.Pretandard(type: .Bold, size: 20)
            $0.textAlignment = .center
            $0.textColor = .white
        }
        [subTitle].forEach {
            $0.textColor = myColor.deepBlue
            $0.font = UIFont.Pretandard(type: .Regular, size: 18)
            $0.textAlignment = .center
            $0.textColor = .black
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
