//
//  RssItemTableViewCell.swift
//  ImageOfTheDay
//
//  Created by Idan Israel on 17/04/2023.
//

import UIKit
import Kingfisher

class RssItemTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var rssTitle: UILabel!
    @IBOutlet weak var rssDescription: UITextView!
    @IBOutlet weak var rssPublishDate: UILabel!
    @IBOutlet weak var rssImage: UIImageView! {
        didSet {
            rssImage.layer.cornerRadius = 15.0
        }
    }
    @IBOutlet weak var mainStackView: UIStackView!
    
    // MARK: - Init
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 15.0
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    // MARK: - Public Functions
    
    func configure(with presentable: RSSItem) {
        
        rssTitle.text = presentable.title
        rssDescription.text = presentable.description
        rssPublishDate.text = "Publish Date: \(presentable.pubDate)"
        
        guard let imageUrl = URL(string: presentable.enclosure) else { return }
       
        let resource = ImageResource(downloadURL: imageUrl)
        rssImage.kf.indicatorType = .custom(indicator: CustomActivityIndicator())
        rssImage.kf.setImage(
            with: resource,
            placeholder: nil,
            options: [
                .processor(DownsamplingImageProcessor(size: CGSize(width: frame.width / 2, height: frame.height / 2))),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
    }
}
