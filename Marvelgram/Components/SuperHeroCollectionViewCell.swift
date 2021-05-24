//
//  SuperHeroCollectionViewCell.swift
//  Marvelgram
//
//  Created by Нариман on 02.05.2021.
//

import UIKit
import SDWebImage

class SuperHeroCollectionViewCell: UICollectionViewCell {

    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: imageView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
        ])
    }

    func setImage(url: String, active: Bool) {
        imageView.sd_setImage(
            with: URL(string: url),
            placeholderImage: nil
        )
        if active {
            imageView.alpha = 1
        } else {
            imageView.alpha = 0.3
        }
    }

}
