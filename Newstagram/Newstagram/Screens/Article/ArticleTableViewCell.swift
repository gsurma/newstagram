//
//  ArticleTableViewCell.swift
//  Newstagram
//
//  Created by Grzegorz Surma on 29/03/2018.
//  Copyright © 2018 Grzegorz Surma. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

final class ArticleTableViewCell: SPParallaxTableViewCell {
    
    var backgroundImageView: UIImageView!
    var separatorView: UIView!
    var titleLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func setArticle(_ article: Article) {
        titleLabel.text = article.title
        
        let url = URL(string: article.urlToImage)
        backgroundImageView.kf.setImage(with: url,
                                        placeholder: #imageLiteral(resourceName: "Placeholder"),
                                        options: nil,
                                        progressBlock: nil,
                                        completionHandler: nil)
    }
    
    private func commonInit() {
        backgroundImageView = UIImageView.init()
        backgroundImageView.contentMode = .scaleAspectFill
        self.parallaxViews.append(backgroundImageView)
        self.addSubview(backgroundImageView)
        
        separatorView = UIView.init()
        separatorView.backgroundColor = UIColor.white
        self.addSubview(separatorView)
        
        titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        titleLabel.addShadow(blurRadius: 1, widthOffset: 1, heightOffset: 1, opacity: 0.75)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.left
        self.addSubview(titleLabel)
        
        SPConstraintsAssistent.setMarginConstraint(titleLabel, superVuew: self, bottom: 20, leading: 20, trailing: 20)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundImageView.frame = CGRect.init(
            x: 0,
            y: self.backgroundImageView.frame.origin.y,
            width: self.bounds.width,
            height: self.bounds.height + self.parallaxSize
        )
        
        self.separatorView.frame = CGRect.init(
            x: 0,
            y: self.frame.height - 2,
            width: self.frame.width,
            height: 2
        )
    }
}
