//
//  ArticleTableViewCell.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation
import UIKit
import MaterialComponents

protocol ArticleTableViewCelllDelegate: class {
    func cellDidTap(_ cell: ArticleTableViewCell)
}

class ArticleTableViewCell: UITableViewCell {
    
    //MARK: - Public Properties
    
    public weak var delegate: ArticleTableViewCelllDelegate?
    
    //MARK: - Private Properties
    
    private let card: MDCCard = {
        let card: MDCCard = MDCCard(frame: CGRect.zero)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.cornerRadius = 10.0
        card.setShadowElevation(ShadowElevation.appBar, for: UIControl.State.normal)
        return card
    }()
    
    private let imageIcon: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let infoView: UIView = {
        let view: UIView = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.bold)
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.black
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.regular)
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.black
        return label
    }()
    
    private let sectionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.regular)
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.black
        return label
    }()
    
    private let publishDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.regular)
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.black
        return label
    }()
    
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureView()
    }
    
    //MARK: - Layout
    
    private func configureView() {
        self.selectionStyle = .none
        self.configureCard()
        self.configureIconView()
        self.configureInfoView()
        self.configureTitleLabel()
        self.configureAuthorLabel()
        self.configureSectionLabel()
        self.configurePublishDateLabel()
    }
    
    private func configureCard() {
        self.contentView.addSubview(self.card)
        self.card.top(withView: self.contentView, constant: 10.0)
        self.card.bottom(withView: self.contentView, constant: -10.0)
        self.card.leading(withView: self.contentView, constant: 10.0)
        self.card.trailing(withView: self.contentView, constant: -10.0)
        self.card.addTarget(self, action: #selector(tapCard), for: UIControl.Event.touchUpInside)
    }
    
    private func configureIconView() {
        self.card.addSubview(self.imageIcon)
        self.imageIcon.top(withView: self.card)
        self.imageIcon.leading(withView: self.card)
        self.imageIcon.trailing(withView: self.card)
        self.imageIcon.aspectRatio()
    }
    
    private func configureInfoView() {
        self.card.addSubview(self.infoView)
        self.infoView.top(toBottom: self.imageIcon, fromView: self.card, constant: 10.0)
        self.infoView.bottom(withView: self.card, constant: 0.0)
        self.infoView.leading(withView: self.card, constant: 10.0)
        self.infoView.trailing(withView: self.card, constant: -10.0)
    }
    
    private func configureTitleLabel() {
        self.infoView.addSubview(self.titleLabel)
        self.titleLabel.top(withView: self.infoView, constant: 10.0)
        self.titleLabel.leading(withView: self.infoView, constant: 0.0)
        self.titleLabel.trailing(withView: self.infoView, constant: 0.0)
    }
    
    private func configureAuthorLabel() {
        self.infoView.addSubview(self.authorLabel)
        self.authorLabel.top(toBottom: self.titleLabel, fromView: self.infoView, constant: 10.0)
        self.authorLabel.leading(withView: self.infoView, constant: 0.0)
        self.authorLabel.trailing(withView: self.infoView, constant: -0.0)
    }
    
    private func configureSectionLabel() {
        self.infoView.addSubview(self.sectionLabel)
        self.sectionLabel.top(toBottom: self.authorLabel, fromView: self.infoView, constant: 10.0)
        self.sectionLabel.leading(withView: self.infoView, constant: 0.0)
        self.sectionLabel.trailing(withView: self.infoView, constant: -0.0)
    }
    
    private func configurePublishDateLabel() {
        self.infoView.addSubview(self.publishDateLabel)
        self.publishDateLabel.top(toBottom: self.sectionLabel, fromView: self.infoView, constant: 10.0)
        self.publishDateLabel.bottom(withView: self.infoView, constant: -10.0)
        self.publishDateLabel.leading(withView: self.infoView, constant: 0.0)
        self.publishDateLabel.trailing(withView: self.infoView, constant: -0.0)
    }
    
    //MARK: - Public Methods
    
    public func configure(with article: ArticleEntity) {
        self.imageIcon.loadArticleImage(article.media?.first?.metadata.first?.url ?? "")
        self.titleLabel.text = article.title
        self.authorLabel.text = article.author
        self.sectionLabel.text = article.section
        self.publishDateLabel.text = article.publishedDate
    }
    
    //MARK: - Events
    
    @objc private func tapCard() {
        self.delegate?.cellDidTap(self)
    }
}
