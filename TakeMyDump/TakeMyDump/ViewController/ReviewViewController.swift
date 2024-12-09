//
//  ReviewViewController.swift
//  TakeMyDump
//
//  Created by 신민규 on 12/8/24.
//

import UIKit
import Cosmos

final class ReviewViewController: UIViewController, UICollectionViewDelegate {
    var locationTitle: String?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var toiletImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.image = UIImage(named: "sampleImage")
        
        return view
    }()
    
    private lazy var sampleCosmosView: CosmosView = {
        var view = CosmosView()
        view.rating = 3.7
        view.text = "(162)"
        view.settings.updateOnTouch = false
        view.settings.starSize = 30
        view.settings.starMargin = 3
        view.settings.filledColor = UIColor.orange
        view.settings.emptyBorderColor = UIColor.orange
        view.settings.filledBorderColor = UIColor.orange
        view.settings.fillMode = .precise
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "S-CoreDream-6Bold", size: 18)
        label.textColor = .black
        
        /// Mock
        label.text = "대우월드타운상가"
        
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "S-CoreDream-4Regular", size: 12)
        label.textColor = .gray
        
        ///Mock
        label.text = "300m 이내(3분)"
        
        return label
    }()
    
    private lazy var reviewButton: ReviewButton = {
        let button = ReviewButton()
        
        button.addTarget(self, action: #selector(reviewButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var reviewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 120)
        layout.scrollDirection = .vertical
        
        return layout
    }()
    
    private lazy var reviewCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.reviewLayout)
        
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        view.clipsToBounds = true
        view.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: "ReviewCollectionViewCell")
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    /// Mock Data
    let mockReviews: [[String: Any]] = [
        ["id": "김철수", "count": 5, "date": "2024-12-08", "rating": 4.5, "content": "화장실이 깔끔하고 위치도 좋아요. 다시 이용하고 싶어요!"],
        ["id": "박영희", "count": 3, "date": "2024-12-07", "rating": 3.0, "content": "생각보다 청결하지 않았지만 이용은 무난했습니다."],
        ["id": "이민수", "count": 10, "date": "2024-12-06", "rating": 5.0, "content": "이 정도로 잘 관리된 화장실은 처음이에요. 강력 추천!"],
        ["id": "최수정", "count": 2, "date": "2024-12-05", "rating": 2.5, "content": "위치는 좋지만 시설이 오래돼서 별로였습니다."],
        ["id": "홍길동", "count": 8, "date": "2024-12-04", "rating": 4.0, "content": "화장지도 넉넉하고 전반적으로 만족스러웠습니다."],
        ["id": "강다영", "count": 7, "date": "2024-12-03", "rating": 3.5, "content": "크기는 작지만 청결도가 괜찮아서 좋았습니다."],
        ["id": "윤재훈", "count": 6, "date": "2024-12-02", "rating": 4.8, "content": "깔끔하고 접근성이 뛰어납니다. 재방문 의사 100%!"],
        ["id": "신지우", "count": 4, "date": "2024-12-01", "rating": 2.0, "content": "화장실 냄새가 많이 나서 이용이 불편했어요."],
        ["id": "한예슬", "count": 9, "date": "2024-11-30", "rating": 3.8, "content": "조명도 밝고 깔끔한 편이었지만 사람이 너무 많았어요."],
        ["id": "조민준", "count": 1, "date": "2024-11-29", "rating": 1.5, "content": "정말 최악이었습니다. 다시는 이용하고 싶지 않아요."]
    ]
    
}

extension ReviewViewController {
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, sampleCosmosView, distanceLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        
        [toiletImageView, stackView, reviewButton].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [containerView, reviewCollectionView].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // containerView의 제약 조건
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            // toiletImageView의 제약 조건
            toiletImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            toiletImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            toiletImageView.widthAnchor.constraint(equalToConstant: 140),
            toiletImageView.heightAnchor.constraint(equalToConstant: 140),
            
            // stackView의 제약 조건
            stackView.centerYAnchor.constraint(equalTo: toiletImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: toiletImageView.trailingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            // reviewButton의 제약 조건
            reviewButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            reviewButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            reviewButton.widthAnchor.constraint(equalToConstant: 55),
            reviewButton.heightAnchor.constraint(equalToConstant: 20),
            
            // containerView의 하단 제약 조건
            containerView.bottomAnchor.constraint(equalTo: reviewButton.bottomAnchor, constant: 10),
            
            // reviewCollectionView의 제약 조건
            reviewCollectionView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            reviewCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            reviewCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            reviewCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension ReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockReviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.id, for: indexPath) as? ReviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let review = mockReviews[indexPath.item]
        let id = review["id"] as? String
        let count = review["count"] as? Int
        let date = review["date"] as? String
        let rating = review["rating"] as? Double
        let content = review["content"] as? String
        
        cell.prepare(id: id, count: count ?? 0, date: date, rating: rating, content: content)
        
        return cell
    }
}

extension ReviewViewController {
    @objc func reviewButtonTapped() {
        let wrvc = WriteReviewViewController()
        wrvc.modalPresentationStyle = .pageSheet
        wrvc.modalTransitionStyle = .coverVertical
        
        if let sheet = wrvc.sheetPresentationController {
            sheet.detents = [
                .medium()
            ]
            sheet.prefersGrabberVisible = false
        }
        self.present(wrvc, animated: true, completion: nil)
    }
}
