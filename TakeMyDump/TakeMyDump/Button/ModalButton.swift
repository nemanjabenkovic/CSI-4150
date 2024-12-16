//
//  ModalButton.swift
//  TakeMyDump
//
//  Created by 신민규 on 12/9/24.
//

import UIKit

final class ModalButton: UIButton {
    private var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "S-CoreDream-6Bold", size: 20)
        label.textColor = .orange
        
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
        backgroundColor = .white
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func setName(name: String) {
        self.label.text = name
    }
}
