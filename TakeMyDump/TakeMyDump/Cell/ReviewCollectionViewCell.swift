//
//  ReviewCollectionViewCell.swift
//  TakeMyDump
//
//  Created by 신민규 on 12/9/24.
//

import UIKit
import Cosmos

final class ReviewCollectionViewCell: UICollectionViewCell {
    static let id = "ReviewCollectionViewCell"
    
    var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 200
        
        return view
    }()
    
    var profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "S-CoreDream-4Regular", size: 12)
        label.textColor = .black
        
        return label
    }()
    
    var profileCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "S-CoreDream-4Regular", size: 10)
        label.textColor = .gray
        
        return label
    }()
    
    var ratingView: CosmosView = {
        var view = CosmosView()
        view.rating = 0
        view.settings.updateOnTouch = false
        view.settings.starSize = 10
        view.settings.starMargin = 2
        view.settings.filledColor = UIColor.orange
        view.settings.emptyBorderColor = UIColor.orange
        view.settings.filledBorderColor = UIColor.orange
        
        return view
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "S-CoreDream-4Regular", size: 12)
        label.textColor = .black
        
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "S-CoreDream-4Regular", size: 10)
        label.textColor = .gray
        
        return label
    }()
    
    lazy var profileInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileNameLabel, profileCountLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, profileInfoStackView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in HotPlaceCollectionViewCell")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [profileStackView, ratingView, contentLabel, dateLabel].forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            
            profileStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            profileStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            ratingView.topAnchor.constraint(equalTo: profileStackView.bottomAnchor, constant: 8),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            ratingView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            
            contentLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(id: nil, count: nil, date: nil, rating: nil, content: nil)
    }
    
    func prepare(id: String?, count: Int?, date: String?, rating: Double?, content: String?) {
        self.profileNameLabel.text = id
        self.profileCountLabel.text = "리뷰 \(count)"
        self.ratingView.rating = rating ?? 0
        self.contentLabel.text = content
        self.dateLabel.text = date
    }
}
