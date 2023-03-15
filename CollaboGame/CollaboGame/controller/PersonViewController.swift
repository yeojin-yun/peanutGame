//
//  PersonViewController.swift
//  CollaboGame
//
//  Created by 순진이 on 2022/05/08.
//

import UIKit

class PersonViewController: UIViewController {
    
    private let hintLabel = UILabel()
    private let hintButton = UIButton(type: .custom)
    
    
    private var mainImageView = CustomImageView(label: "인물 맞추기")
    private let startButton = UIButton(type: .custom)
    private let rightAnswerButton = UIButton(type: .custom)
    private let timerLabel = UILabel()
    private let progressBar = CustomProgressBar()
    //private let rightAnswerBtn = CustomPassButton(title: "정답확인")
    
    private var timer = Timer()
    private var secondRemaining: Int = 0
    private let limitTime = 30 // 게임 시간 = 타이머 시간


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "그 사람 누구니"
        view.backgroundColor = UIColor.white
        configureUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
}

extension PersonViewController {
    @objc func hintButtonTapped(_ sender: UIButton) {
        hintLabel.text = Person.shared.getRandomPerson().getInitialLetter()
    }
    
    @objc func startBtnTapped(_ sender: UIButton) {
        switch sender.currentImage {
        case ButtonImage.startImage:
            sender.setImage(ButtonImage.nextQuestionImage, for: .normal)
            mainImageView.image = UIImage(named: Person.shared.getRandomPerson())
            mainImageView.layer.borderWidth = 2
            hintLabel.text = "힌트가 필요할 때"
            mainImageView.quizTitle.text = ""
            timerLabel.isHidden = true
            progressBar.isHidden = false
            hintButton.setImage(ButtonImage.hintImage, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            Person.shared.appendElements(elements: Person.shared.getRandomPerson())
            
            
        case ButtonImage.nextQuestionImage:
            mainImageView.image = UIImage(named: Person.shared.getRandomPerson())
            mainImageView.layer.borderWidth = 2
            hintButton.setImage(ButtonImage.hintImage, for: .normal)
            hintLabel.text = "힌트가 필요할 때"
            mainImageView.quizTitle.text = ""
            timerLabel.isHidden = true
            progressBar.isHidden = false
            Person.shared.appendElements()
        default:
            break
        }
    }
    
    @objc func answerBtnTapped(_ sender: UIButton) {
        mainImageView.image = UIImage(named: "메인배경")
        mainImageView.quizTitle.text = Person.shared.getRandomPerson()
        Person.shared.removeElements()
    }
    
    
    @objc func update() {
        if secondRemaining < limitTime {
            secondRemaining += 1
            let percentage = Float(secondRemaining) / Float(limitTime)
            progressBar.setProgress(Float(percentage), animated: true)
            print(secondRemaining)
        } else {
            timer.invalidate()
            showAlert()
        }
    }
}

//MARK: -Function
extension PersonViewController {
    func showAlert() {
        print("alert")
        let alert = UIAlertController(title: "게임 끝!", message: "게임을 다시 하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "결과보기", style: .default) { [weak self] _ in
            self?.reset()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { [weak self] _ in
            self?.reset()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func reset() {
        self.timer.invalidate()
        self.mainImageView.layer.borderWidth = 0
        self.startButton.setImage(ButtonImage.startImage, for: .normal)
        self.mainImageView.quizTitle.text = "인물 맞추기"
        self.mainImageView.image = UIImage(named: "퀴즈배경")
        self.secondRemaining = 0
        self.progressBar.progress = 0.0
        self.progressBar.isHidden = true
        self.timerLabel.isHidden = false
        self.hintLabel.text = ""
        self.hintButton.setImage(nil, for: .normal)
    }
    
    func showResult() {
        let alert = UIAlertController(title: "결과", message: "", preferredStyle: .alert)
    }
}

//MARK: -UI
extension PersonViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        [hintLabel].forEach {
            $0.text = ""
            $0.font = UIFont.Pretandard(type: .Light, size: 20)
            $0.textAlignment = .center
        }
        
        progressBar.isHidden = true
        timerLabel.text = "제한 시간: 30초"
        timerLabel.textColor = .black
        timerLabel.textAlignment = .center
        
        startButton.setImage(ButtonImage.startImage, for: .normal)
        rightAnswerButton.setImage(ButtonImage.answerImage, for: .normal)

    }
    final private func addTarget() {
        startButton.addTarget(self, action: #selector(startBtnTapped(_:)), for: .touchUpInside)
        hintButton.addTarget(self, action: #selector(hintButtonTapped(_:)), for: .touchUpInside)
        rightAnswerButton.addTarget(self, action: #selector(answerBtnTapped(_:)), for: .touchUpInside)
    }

    final private func setConstraints() {
        let hintStack = UIStackView(arrangedSubviews: [hintLabel, hintButton])
        hintStack.axis = .horizontal
        hintStack.spacing = 5
        
        let buttonStack = UIStackView(arrangedSubviews: [startButton, rightAnswerButton])
        buttonStack.axis = .vertical
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 10
        
        
        [hintStack, mainImageView, timerLabel, progressBar, buttonStack].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            hintStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            hintStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            hintStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            hintStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            hintStack.heightAnchor.constraint(equalToConstant: 50),
            
            hintButton.widthAnchor.constraint(equalToConstant: 80),
            
            mainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainImageView.topAnchor.constraint(equalTo: hintStack.bottomAnchor, constant: 10),
            mainImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            mainImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            mainImageView.heightAnchor.constraint(equalToConstant: 350),
            
            timerLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 20),
            timerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            timerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            timerLabel.heightAnchor.constraint(equalToConstant: 20),
            
            progressBar.topAnchor.constraint(equalTo: timerLabel.topAnchor),
            progressBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            progressBar.leadingAnchor.constraint(equalTo: timerLabel.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: timerLabel.trailingAnchor),

            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 15),
            buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            buttonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

