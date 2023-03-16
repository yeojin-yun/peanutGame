//
//  NewSayingViewController.swift
//  CollaboGame
//
//  Created by 순진이 on 2022/05/08.
//

import UIKit

final class NewSayingViewController: UIViewController {
    
    private var mainImageView = CustomImageView(label: "신조어")
    private var answerLabel = CustomLabel(title: "", size: 25)
    //var newSayingLabel = CustomLabel(title: "신조어 맞추기", size: 30)
    private var startButton = UIButton(type: .custom)
    private var rightAnswerButton = UIButton(type: .custom)
    private let progressBar = CustomProgressBar()
    private var timerLabel = UILabel()
    
    private var timer = Timer()
    private var secondRemaining: Int = 0
    
    private let limitTime = 10 // 게임 시간 = 타이머 시간
    
    private var currentQuestion = ""
    private var currentAnswer = ""
    
    private var answerArray: [String] = []
    private var wrongAnswerArray: [String] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "그 말 뭐니"
        setUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
}

//MARK: - Selector
extension NewSayingViewController {
    @objc func buttonTapped(_ sender: UIButton) {
        
        switch sender.currentImage {
        case ButtonImage.startImage:
            startButton.setImage(ButtonImage.nextQuestionImage, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            timerLabel.isHidden = true
            progressBar.isHidden = false
            answerLabel.isHidden = true
            getRandomNewSaying()
            mainImageView.quizTitle.text = currentQuestion
            rightAnswerButton.isEnabled = true
            answerArray.append(currentAnswer)
        case ButtonImage.nextQuestionImage:
            getRandomNewSaying()
            answerArray.append(currentAnswer)
            mainImageView.quizTitle.text = currentQuestion
            answerLabel.isHidden = true
            //timer.invalidate()
            rightAnswerButton.isEnabled = true
        case ButtonImage.answerImage:
            answerLabel.isHidden = false
            answerLabel.text = currentQuestion
            mainImageView.quizTitle.text = currentAnswer
            wrongAnswerArray.append(currentAnswer)
        default:
            break
        }
    }
    
    
    @objc func update() {
        if secondRemaining < limitTime {
            secondRemaining += 1
            let percentage = Float(secondRemaining) / Float(limitTime)
            progressBar.setProgress(Float(percentage), animated: true)
            print(secondRemaining)
        } else {
            showAlert()
            timer.invalidate()
        }
    }
}

// MARK: - Function
extension NewSayingViewController {
    func getRandomNewSaying() {
        guard let randomQuestion = NewSaying.shared.newSayingA.keys.randomElement() else { return }
        currentQuestion = randomQuestion
        currentAnswer = NewSaying.shared.newSayingA[randomQuestion] ?? "낄 때 끼고 빠질 때 빠져라"
    }
    
    func showAlert() {
        print("alert")
        let alert = UIAlertController(title: "게임 끝!", message: "결과를 확인하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "결과보기", style: .default) { [weak self] _ in
            self?.reset()
            self?.showResult()
        }
        let cancelAction = UIAlertAction(title: "다시하기", style: .cancel) { [weak self] _ in
            self?.reset()
            self?.answerArray = []
            self?.wrongAnswerArray = []
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func reset() {
        self.timer.invalidate()
        self.mainImageView.quizTitle.text = "신조어"
        self.secondRemaining = 0
        self.progressBar.progress = 0.0
        self.answerLabel.text = ""
        self.startButton.setImage(ButtonImage.startImage, for: .normal)
        self.progressBar.isHidden = true
        self.timerLabel.isHidden = false
    }
    
    func showResult() {
        let answerCount = (self.answerArray.count ?? 0) - (self.wrongAnswerArray.count ?? 0)
        let alert = UIAlertController(title: "결과", message: "전체 \(self.answerArray.count)개 문제 중\n\(answerCount)개 정답", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "결과에 승복", style: .default) { _ in
            self.answerArray = []
            self.wrongAnswerArray = []
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
//MARK: - UI
extension NewSayingViewController {
    func setUI() {
        setBasic()
        setAddTarget()
        setLayout()
    }
    
    func setAddTarget() {
        startButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        rightAnswerButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    func setBasic() {
        answerLabel.font = UIFont.Pretandard(type: .Light, size: 20)
        progressBar.isHidden = true
        timerLabel.text = "제한 시간: 30초"
        startButton.setImage(ButtonImage.startImage, for: .normal)
        rightAnswerButton.setImage(ButtonImage.answerImage, for: .normal)
    }
    
    func setLayout() {
        let stackView = UIStackView(arrangedSubviews: [startButton, rightAnswerButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        [mainImageView, timerLabel, stackView, progressBar, answerLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            answerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            answerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            answerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            answerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            answerLabel.heightAnchor.constraint(equalToConstant: 30),
            
            mainImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainImageView.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 20),
            mainImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 320),
            
            
            timerLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 30),
            timerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            progressBar.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 30),
            progressBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            
            stackView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),  stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            
            startButton.heightAnchor.constraint(equalToConstant: 60),
            rightAnswerButton.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
}
