//
//  WriteReviewViewController.swift
//  TakeMyDump
//
//  Created by 신민규 on 12/9/24.
//

import UIKit
import Cosmos

final class WriteReviewViewController: UIViewController {
    
    private lazy var ratingView: CosmosView = {
        let view = CosmosView()
        
        view.settings.updateOnTouch = true
        view.settings.fillMode = .half
        view.settings.starSize = 40
        view.settings.starMargin = 2
        view.settings.filledColor = UIColor.orange
        view.settings.emptyBorderColor = UIColor.orange
        view.settings.filledBorderColor = UIColor.orange
        view.rating = 0
        
        return view
    }()
    
    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        
        textView.font = UIFont(name: "S-CoreDream-4Regular", size: 14)
        textView.textColor = .lightGray
        textView.text = "리뷰를 작성해주세요"
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var backButton: ModalButton = {
        let button = ModalButton()
        
        button.setName(name: "취소")
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var addButton: ModalButton = {
        let button = ModalButton()
        
        button.setName(name: "등록")
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        self.view.backgroundColor = .white
        
        [ratingView, reviewTextView, backButton, addButton].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            backButton.widthAnchor.constraint(equalToConstant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            addButton.topAnchor.constraint(equalTo: backButton.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            
            
            ratingView.topAnchor.constraint(equalTo: self.addButton.bottomAnchor, constant: 20),
            ratingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            
            reviewTextView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 20),
            reviewTextView.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor),
            reviewTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            reviewTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

extension WriteReviewViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // 플레이스홀더 제거
        if textView.text == "리뷰를 작성해주세요" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // 플레이스홀더 복원
        if textView.text.isEmpty {
            textView.text = "리뷰를 작성해주세요"
            textView.textColor = .lightGray
        }
    }
}

extension WriteReviewViewController {
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addButtonTapped() {
        /// Review 작성 API
        self.dismiss(animated: true, completion: nil)
    }
}
