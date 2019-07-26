//
//  AirticleCell.swift
//  NYTimesAirticles
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi All rights reserved.
//

import UIKit

class AirticleCell: UITableViewCell, CellConfigurable {
    
    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
        
    }()
    
    lazy var byLine: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "AmericanTypewriter", size: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
        
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInitialView()
        setupConstraints()
    }
    
    func setup(viewModel: RowViewModel?) {
        guard let viewModel = viewModel else { return }
        
//        var imageURL = ""
        if let firstMedia = viewModel.media.first, firstMedia.metaData.count > 0 {
//            imageURL  = firstMedia.metaData[1].url
            self.coverImageView.imageFromUrl(firstMedia.metaData[1].url)

        }
//        self.coverImageView.af_setImage(
//            withURL: URL(string: imageURL)!
//        )
        
        self.title.text = viewModel.title
        self.byLine.text = viewModel.byLine
        self.dateLabel.text = "🗓 " + viewModel.publishedDate
        
        setNeedsLayout()
    }
    
    private func setupInitialView() {
        self.selectionStyle = .none
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).withPriority(priority: .defaultLow),
            coverImageView.widthAnchor.constraint(equalToConstant: 60),
            coverImageView.heightAnchor.constraint(equalToConstant: 60),
            
            title.topAnchor.constraint(equalTo: coverImageView.topAnchor),
            title.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 10),
            title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            byLine.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            byLine.leftAnchor.constraint(equalTo: title.leftAnchor),
            byLine.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            byLine.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -5)
            ])
        
        byLine.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
    }
    
}
