//
//  MovieViewController.swift
//  CollaboGame
//
//  Created by 순진이 on 2022/05/08.
//

import UIKit

class MovieViewController: UIViewController {
    private let mainImageView = CustomImageView(label: "영화명대사")
    //private var mainLabel = CustomLabel(title: "대사로 영화 맞추기", size: 30)
    private let movieImageView = UIImageView()
    private var startButton = UIButton(type: .custom)
    private var rightAnswerButton = UIButton(type: .custom)
    
    var qAndAText = ""
    var year = 0
    var answerLabel = UILabel()
    
    
//    let startButton  = CustomButton(frame: .zero)

   
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "그 영화 뭐니"
        movieImageView.isHidden = true
        setUI()
    }
//MARK: - Data
    private func loadImage(imageUrl: String) {
        let urlString = imageUrl
        guard let url = URL(string: urlString) else { return }
        
        // 오래걸리는 작업을 동시성 처리 (다른 쓰레드에서 일시킴)
        DispatchQueue.global().async {
            // URL을 가지고 데이터를 만드는 메서드 (오래걸리는데 동기적인 실행)
            // (일반적으로 이미지를 가져올때 많이 사용)
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard urlString == url.absoluteString else { return }
            
            // 작업의 결과물을 이미로 표시 (메인큐)
            DispatchQueue.main.async {
                self.movieImageView.image = UIImage(data: data)
            }
        }
    }
}

//MARK: - Selector
extension MovieViewController {
//    @objc
//    func answerButton(_ sender: UIButton) {
//        if sender.currentImage == UIImage(named: "시작하기") {
//            print("성공")
//
//        }
//        if sender.currentTitle == "시작하기" {
//            qAndAText = MovieLine.shared.movieA.keys.randomElement() ?? ""
//            print(qAndAText)
//            startButton.setTitle("정답확인", for: .normal)
//            answerButton.setTitleColor(UIColor(red:0.98, green:0.96, blue:0.43, alpha:1.0), for: .normal)
//            mainLabel.text = MovieLine.shared.movieA[qAndAText]
//            mainLabel.backgroundColor = .clear
//            movieImageView.isHidden = true
//
//        } else if sender.currentTitle == "정답확인" {
//            answerLabel.textColor = UIColor(red:0.98, green:0.96, blue:0.43, alpha:1.0)
//            answerLabel.text = qAndAText
//
//            mainLabel.backgroundColor = .clear
//            mainLabel.textColor = .clear
//            answerButton.setTitle("다음문제", for: .normal)
//            movieImageView.isHidden = false
//            year = MovieLine.shared.yearMovie[qAndAText] ?? 2000
//
//
//            APIManager.shared.requestMovie(word: qAndAText, year: year) { response in
//                switch response {
//                case .success(let data):
//                    self.loadImage(imageUrl: data.items[0].image)
//                    print(data.items)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//            answerButton.setTitleColor(CustomColor.btnTextColor, for: .normal)
//        } else if sender.currentTitle == "다음문제" {
//
//            answerLabel.textColor = CustomColor.mainTextColor
//            answerLabel.text = "영화 명대사"
//
//            qAndAText = MovieLine.shared.movieA.keys.randomElement() ?? ""
//            //print(qAndAText)
//            mainLabel.backgroundColor = CustomColor.mainColor
//            mainLabel.textColor = CustomColor.mainTextColor
//            answerButton.setTitle("정답확인", for: .normal)
//            answerButton.setTitleColor(UIColor(red:0.98, green:0.96, blue:0.43, alpha:1.0), for: .normal)
//            mainLabel.text = MovieLine.shared.movieA[qAndAText]
//            movieImageView.isHidden = true
//            year = MovieLine.shared.yearMovie[qAndAText] ?? 2000
//
//            APIManager.shared.requestMovie(word: qAndAText, year: year) { response in
//                switch response {
//                case .success(let data):
//                    self.loadImage(imageUrl: data.items[0].image)
//                    print(data.items)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
}

//MARK: - UI
extension MovieViewController {
    func setUI() {
        setBasic()
        setLayout()
    }
    
    func setBasic() {
        startButton.setImage(ButtonImage.startImage, for: .normal)
        rightAnswerButton.setImage(ButtonImage.answerImage, for: .normal)
        movieImageView.image = UIImage(named: "이청아")
        
        answerLabel.text = "test"

        //startButton.addTarget(self, action: #selector(answerButton(_:)), for: .touchUpInside)
        answerLabel.numberOfLines = 0
        
        movieImageView.layer.cornerRadius = 3.0       //테두리가 라운드가 된다.
        //        movieImageView.layer.masksToBounds = true
        movieImageView.layer.borderColor = UIColor(red:0.98, green:0.96, blue:0.43, alpha:1.0).cgColor
        movieImageView.layer.borderWidth = 5.0 //테두리의 두께
        movieImageView.layer.masksToBounds = true //테두리의 배경을 투명하게
        
        //mainImageView.image = UIImage(named: "퀴즈배경")
        //mainImageView.contentMode = .scaleAspectFit
        
//        playButton.setImage(UIImage(named: "시작하기"), for: .normal)
        
        
    }

    func setLayout() {
        let stackView = UIStackView(arrangedSubviews: [startButton, rightAnswerButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        [mainImageView, stackView, movieImageView, answerLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            mainImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            mainImageView.heightAnchor.constraint(equalToConstant: 380),
            
            
            movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImageView.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 30),
            movieImageView.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 60),
            movieImageView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -60),
            movieImageView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: -30),
            
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
            answerLabel.heightAnchor.constraint(equalToConstant: 20),

            stackView.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.heightAnchor.constraint(equalToConstant: 70),
            rightAnswerButton.heightAnchor.constraint(equalToConstant: 70),
            
        ])
    }
    
}
