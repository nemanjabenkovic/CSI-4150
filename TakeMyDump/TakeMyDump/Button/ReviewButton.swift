//
//  ReviewButton.swift
//  TakeMyDump
//
//  Created by 신민규 on 12/9/24.
//

import UIKit

final class ReviewButton: UIButton {
    private var label: UILabel = {
        let label = UILabel()
        
        label.text = "리뷰쓰기"
        label.font = UIFont(name: "S-CoreDream-4Regular", size: 10)
        label.textColor = .white
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUp() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 8
        backgroundColor = .orange
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 39),
            label.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
}
