//
//  MainViewController.swift
//  CollaboGame
//
//  Created by 순진이 on 2022/05/08.
//

import UIKit

import UIKit
//face.dashed.fill, bold.underline, brain.head.profile, film
class MainViewController: UIViewController {
    
    let model = [
        Model(gameTitle: "그 사람 누구니", imageName: "person.fill.questionmark", subTitle: "인물게임"),
        Model(gameTitle: "그 단어 뭐니", imageName: "bold.underline", subTitle: "초성게임"),
        Model(gameTitle: "그 말 뭐니", imageName: "brain.head.profile", subTitle: "신조어 게임"),
        Model(gameTitle: "그 영화 뭐니", imageName: "film", subTitle: "영화명대사게임"),
    ]
    
    var logoImageView = UIImageView()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let randomLottery = RandomLotteryButton(main: "이번주는 내가 1등", sub: "랜덤으로 로또 번호 뽑기")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = myColor.greenColor
        collectionView.backgroundColor = myColor.greenColor
    }

}

extension MainViewController {
    @objc func randomLotteryTapped(_ sender: UIButton) {
        let nextVC = RandomLotteryViewController()
        nextVC.navigationItem.title = "로또 번호 추첨"
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWitdh * (CVCell.cellColumns - 1)-60) / CVCell.cellColumns
        let size = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            navigationController?.pushViewController(PersonViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(InitialLetterViewController(), animated: true)
        case 2:
            navigationController?.pushViewController(NewSayingViewController(), animated: true)
        case 3:
            navigationController?.pushViewController(MovieViewController(), animated: true)
        default:
            break
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { fatalError() }
        cell.iconImageView.image = UIImage(systemName: model[indexPath.item].imageName)
        cell.gameTitle.text = model[indexPath.item].gameTitle
        cell.subTitle.text = model[indexPath.item].subTitle
        return cell
    }
}


//MARK: -UI
extension MainViewController {
    final private func configureUI() {
        configureCollectionView()
        addTarget()
        setConstraints()
        setDetail()
    }

    final private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    final private func addTarget() {
        randomLottery.addTarget(self, action: #selector(randomLotteryTapped(_:)), for: .touchUpInside)
    }
    
    final private func setDetail() {
        logoImageView.image = UIImage(named: "메인")
    }
    
    final private func setConstraints() {
        [collectionView, logoImageView, randomLottery].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: CVCell.screenWidth),
            
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            
            randomLottery.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            randomLottery.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            randomLottery.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130),
//            randomLottery.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -130)
            randomLottery.widthAnchor.constraint(equalToConstant: 280),
            randomLottery.heightAnchor.constraint(equalToConstant: 90)
        ])
        
    }
}
