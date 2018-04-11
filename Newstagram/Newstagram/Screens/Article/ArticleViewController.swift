//
//  ArticleViewController.swift
//  Newstagram
//
//  Created by Grzegorz Surma on 29/03/2018.
//  Copyright © 2018 Grzegorz Surma. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

final class ArticleViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var article: Article!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = URL(string: article.urlToImage)
        imageView.kf.setImage(with: url,
                              placeholder: #imageLiteral(resourceName: "Placeholder"),
                              options: nil,
                              progressBlock: nil,
                              completionHandler: nil)
        
        titleLabel.text = article.title
        descriptionLabel.text = article.description ?? ""
        
        var authorAndTimestampString = ""
        if let author = article.author as String? {
            authorAndTimestampString = "By " + author
        }
        if let timestamp = article.publishedAt as String? {
            if !authorAndTimestampString.isEmpty {
                authorAndTimestampString += " on "
            }
            authorAndTimestampString += convertDateFormatter(date: timestamp)
        }
        timestampLabel.text = authorAndTimestampString
        
        if let source = article.source as Source? {
            title = source.name
        }
    }
    
    @IBAction func readFullArticleAction(_ sender: Any) {
        if let url = URL(string: article.url) as URL? {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }
}
