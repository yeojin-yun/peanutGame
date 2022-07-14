//
//  RandomLotteryViewController.swift
//  CollaboGame
//
//  Created by 순진이 on 2022/07/12.
//

import UIKit

class RandomLotteryViewController: UIViewController {
    let infoLabel = UILabel()
    
    let firstView = StackView()
    let secondView = StackView()
    let thirdView = StackView()
    let forthView = StackView()
    let fifthView = StackView()
    
    let allButton = UIButton(type: .system)
    let resetButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
    @objc func firstBtnTapped(_ sender: UIButton) {
        [firstView].forEach {
            $0.firstNumber.text = "\(getRandom())"
            $0.secondNumber.text = "\(getRandom())"
            $0.thirdNumber.text = "\(getRandom())"
            $0.forthNumber.text = "\(getRandom())"
            $0.fifthNumber.text = "\(getRandom())"
        }
    }
    
    @objc func secondBtnTapped(_ sender: UIButton) {
        [secondView].forEach {
            $0.firstNumber.text = "\(getRandom())"
            $0.secondNumber.text = "\(getRandom())"
            $0.thirdNumber.text = "\(getRandom())"
            $0.forthNumber.text = "\(getRandom())"
            $0.fifthNumber.text = "\(getRandom())"
        }
    }
    
    @objc func thirdBtnTapped(_ sender: UIButton) {
        [thirdView].forEach {
            $0.firstNumber.text = "\(getRandom())"
            $0.secondNumber.text = "\(getRandom())"
            $0.thirdNumber.text = "\(getRandom())"
            $0.forthNumber.text = "\(getRandom())"
            $0.fifthNumber.text = "\(getRandom())"
        }
    }
    
    @objc func forthBtnTapped(_ sender: UIButton) {
        [forthView].forEach {
            $0.firstNumber.text = "\(getRandom())"
            $0.secondNumber.text = "\(getRandom())"
            $0.thirdNumber.text = "\(getRandom())"
            $0.forthNumber.text = "\(getRandom())"
            $0.fifthNumber.text = "\(getRandom())"
        }
    }
    
    @objc func fifthBtnTapped(_ sender: UIButton) {
        [fifthView].forEach {
            $0.firstNumber.text = "\(getRandom())"
            $0.secondNumber.text = "\(getRandom())"
            $0.thirdNumber.text = "\(getRandom())"
            $0.forthNumber.text = "\(getRandom())"
            $0.fifthNumber.text = "\(getRandom())"
        }
    }
    
    @objc func extraButtonTapped(_ sender: UIButton) {
        switch sender.currentTitle {
        case "전체 자동":
            firstBtnTapped(sender)
            secondBtnTapped(sender)
            thirdBtnTapped(sender)
            forthBtnTapped(sender)
            fifthBtnTapped(sender)
        case "초기화":
            setDetail()
        default:
            break
        }
    }
}

extension RandomLotteryViewController {
    final func setUI() {
        setLayout()
        setDetail()
        addTarget()
    }
    
    final func addTarget() {
        firstView.choiceButton.addTarget(self, action: #selector(firstBtnTapped(_:)), for: .touchUpInside)
        secondView.choiceButton.addTarget(self, action: #selector(secondBtnTapped(_:)), for: .touchUpInside)
        thirdView.choiceButton.addTarget(self, action: #selector(thirdBtnTapped(_:)), for: .touchUpInside)
        forthView.choiceButton.addTarget(self, action: #selector(forthBtnTapped(_:)), for: .touchUpInside)
        fifthView.choiceButton.addTarget(self, action: #selector(fifthBtnTapped(_:)), for: .touchUpInside)
        allButton.addTarget(self, action: #selector(extraButtonTapped(_:)), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(extraButtonTapped(_:)), for: .touchUpInside)
    }
    
    final func setDetail() {
        firstView.typeLabel.text = "A"
        firstView.firstNumber.text = "00"
        firstView.secondNumber.text = "00"
        firstView.thirdNumber.text = "00"
        firstView.forthNumber.text = "00"
        firstView.fifthNumber.text = "00"
        
        secondView.typeLabel.text = "B"
        secondView.firstNumber.text = "00"
        secondView.secondNumber.text = "00"
        secondView.thirdNumber.text = "00"
        secondView.forthNumber.text = "00"
        secondView.fifthNumber.text = "00"
        
        thirdView.typeLabel.text = "C"
        thirdView.firstNumber.text = "00"
        thirdView.secondNumber.text = "00"
        thirdView.thirdNumber.text = "00"
        thirdView.forthNumber.text = "00"
        thirdView.fifthNumber.text = "00"
        
        forthView.typeLabel.text = "D"
        forthView.firstNumber.text = "00"
        forthView.secondNumber.text = "00"
        forthView.thirdNumber.text = "00"
        forthView.forthNumber.text = "00"
        forthView.fifthNumber.text = "00"
        
        fifthView.typeLabel.text = "E"
        fifthView.firstNumber.text = "00"
        fifthView.secondNumber.text = "00"
        fifthView.thirdNumber.text = "00"
        fifthView.forthNumber.text = "00"
        fifthView.fifthNumber.text = "00"
        
        [infoLabel].forEach {
            $0.text = "1. '자동'을 누르면 한 줄씩 랜덤 번호가 나옵니다.\n2. 5줄을 전부 뽑고 싶을 땐, '전체 자동'을 누르세요."
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.textColor = .black
            $0.font = UIFont.Pretandard(type: .ExtraLight, size: 20)
        }
        
        [allButton, resetButton].forEach {
            allButton.setTitle("전체 자동", for: .normal)
            resetButton.setTitle("초기화", for: .normal)
            allButton.backgroundColor = myColor.greenColor
            resetButton.backgroundColor = .black
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont.Pretandard(type: .Bold, size: 20)
        }
    }
    
    func getRandom() -> Int {
        return Int.random(in: 1...45)
    }
    
    final func setLayout() {
        [firstView, secondView, thirdView, forthView, fifthView, infoLabel, allButton, resetButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            firstView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 30),
            firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            firstView.heightAnchor.constraint(equalToConstant: 60),

            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 10),
            secondView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor),
            secondView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor),
            secondView.heightAnchor.constraint(equalTo: firstView.heightAnchor),
            
            thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 10),
            thirdView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor),
            thirdView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor),
            thirdView.heightAnchor.constraint(equalTo: firstView.heightAnchor),
            
            forthView.topAnchor.constraint(equalTo: thirdView.bottomAnchor, constant: 10),
            forthView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor),
            forthView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor),
            forthView.heightAnchor.constraint(equalTo: firstView.heightAnchor),
            
            fifthView.topAnchor.constraint(equalTo: forthView.bottomAnchor, constant: 10),
            fifthView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor),
            fifthView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor),
            fifthView.heightAnchor.constraint(equalTo: firstView.heightAnchor),
            
            allButton.topAnchor.constraint(equalTo: fifthView.bottomAnchor, constant: 30),
            allButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            allButton.widthAnchor.constraint(equalToConstant: 100),
            
            resetButton.topAnchor.constraint(equalTo: allButton.bottomAnchor, constant: 10),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.widthAnchor.constraint(equalTo: allButton.widthAnchor)
            
        ])
    }
}
