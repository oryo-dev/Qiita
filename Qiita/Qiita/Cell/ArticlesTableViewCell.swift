//
//  ArticlesTableViewCell.swift
//  Qiita
//
//  Created by oryo on 2022/06/20.
//

import UIKit

protocol ToUserProtocol {
    func toUserProtocol(user: User)
}

class ArticlesTableViewCell: UITableViewCell {
    
    let separatorView = View()
    let leftView = View()
    let rightView = View()
    
    let profileImageView = ImageView(cornerRadius: 20)
    let tagsImageView = ImageView(image: UIImage(named: "tags")!)
    let lgtmImageView = ImageView(image: UIImage(named: "lgtm")!)
    
    let idNameLabel = Label(font: .systemFont(ofSize: 13), color: .black)
    let organizationLabel = Label(font: .systemFont(ofSize: 13), color: .black)
    let createdAtLabel = Label(font: .systemFont(ofSize: 12.5), color: .gray)
    let titleLabel = Label(font: .systemFont(ofSize: 17, weight: .bold), color: .black)
    let tagsLabel = Label(font: .systemFont(ofSize: 13), color: .black)
    let lgtmLabel = Label(font: .systemFont(ofSize: 13), color: .black)
    
    let showUserButton = Button(title: "ユーザーを見る")
    let openUrlButton = Button(title: "URLを開く")
    
    var delegate: ToUserProtocol?
    
    var article: Article? {
        didSet {
            if let article = article {
                profileImageView.image = getImage(url: article.user.profileImageUrl!)
                idNameLabel.text = article.user.name != "" ? "@\(article.user.id) (\(article.user.name!))" : "@\(article.user.id)"
                nilCheck(string: article.user.organization, label: organizationLabel)
                createdAtLabel.text = dateFormat(createdAt: article.createdAt)
                titleLabel.text = article.title
                tagsLabel.text = createTagsText(article: article)
                lgtmLabel.text = "\(article.likesCount)"
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(leftView)
        leftView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, width: 10)
        
        addSubview(rightView)
        rightView.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, width: 10)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftView.rightAnchor, width: 40, height: 40, topPadding: 10, leftPadding: 10)
        
        let idNameOrganizationStackView = UIStackView(arrangedSubviews: [idNameLabel, organizationLabel])
        idNameOrganizationStackView.axis = .vertical
        addSubview(idNameOrganizationStackView)
        idNameOrganizationStackView.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightView.leftAnchor, leftPadding: 10, rightPadding: 10)
        
        addSubview(createdAtLabel)
        createdAtLabel.anchor(top: idNameOrganizationStackView.bottomAnchor, left: idNameOrganizationStackView.leftAnchor, right: rightView.leftAnchor, topPadding: 2.5, rightPadding: 10)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: createdAtLabel.bottomAnchor, left: idNameOrganizationStackView.leftAnchor, right: rightView.leftAnchor, topPadding: 10, rightPadding: 10)
        
        addSubview(tagsImageView)
        tagsImageView.anchor(top: titleLabel.bottomAnchor, left: idNameOrganizationStackView.leftAnchor, topPadding: 10)
        
        addSubview(tagsLabel)
        tagsLabel.anchor(top: tagsImageView.topAnchor, left: tagsImageView.rightAnchor, right: rightView.leftAnchor, rightPadding: 10)
        
        addSubview(lgtmImageView)
        lgtmImageView.anchor(top: tagsLabel.bottomAnchor, left: idNameOrganizationStackView.leftAnchor, topPadding: 2.5)
        
        addSubview(lgtmLabel)
        lgtmLabel.anchor(left: lgtmImageView.rightAnchor, centerY: lgtmImageView.centerYAnchor, leftPadding: 10)
        
        showUserButton.addTarget(self, action: #selector(showUserButtonAction(_:)), for: .touchUpInside)
        addSubview(showUserButton)
        showUserButton.anchor(top: lgtmImageView.bottomAnchor, left: leftView.rightAnchor, right: centerXAnchor, topPadding: 30, leftPadding: 20, rightPadding: 20)
        
        openUrlButton.addTarget(self, action: #selector(openUrlButtonAction(_:)), for: .touchUpInside)
        addSubview(openUrlButton)
        openUrlButton.anchor(top: showUserButton.topAnchor, left: centerXAnchor, right: rightView.leftAnchor, leftPadding: 20, rightPadding: 20)
        
        addSubview(separatorView)
        separatorView.anchor(top: showUserButton.bottomAnchor, bottom: bottomAnchor, left: leftView.rightAnchor, right: rightView.leftAnchor, height: 10, topPadding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showUserButtonAction(_ sender: UIButton) {
        guard let article = article else { return }
        delegate?.toUserProtocol(user: article.user)
    }
    
    @objc func openUrlButtonAction(_ sender: UIButton) {
        guard let article = article else { return }
        let url = URL(string: article.url)!
        UIApplication.shared.open(url)
    }
    
    func dateFormat(createdAt: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss+Z"
        let date = dateFormatter.date(from: createdAt) ?? Date()
        dateFormatter.dateFormat = "yyyy'年'MM'月'dd'日'"
        return dateFormatter.string(from: date)
    }
    
    func createTagsText(article: Article) -> String {
        var tags = ""
        for tag in article.tags {
            if tag == article.tags.last {
                tags += tag.name
            } else {
                tags += "\(tag.name), "
            }
        }
        return tags
    }
}
