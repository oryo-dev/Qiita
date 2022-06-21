//
//  UserViewController.swift
//  Qiita
//
//  Created by oryo on 2022/06/20.
//

import UIKit

class UserViewController: UIViewController {
    
    var spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }()
    
    let profileImageView = ImageView(cornerRadius: 75)
    
    let organizationLabel = Label(font: .systemFont(ofSize: 20), color: .gray)
    let locationLabel = Label(font: .systemFont(ofSize: 20), color: .gray)
    let itemsCountLabel = Label(font: .systemFont(ofSize: 17), color: .gray)
    let articleLabel = Label(font: .systemFont(ofSize: 17), color: .gray)
    let followeesCountLabel = Label(font: .systemFont(ofSize: 17), color: .gray)
    let followLabel = Label(font: .systemFont(ofSize: 17), color: .gray)
    let followersLabel = Label(font: .systemFont(ofSize: 17), color: .gray)
    let followerLabel = Label(font: .systemFont(ofSize: 17), color: .gray)
    let descriptionLabel = Label(font: .systemFont(ofSize: 17), color: .black)
    
    let facebookButton = Button(title: "facebook", tag: 1)
    let githubButton = Button(title: "github", tag: 2)
    let linkedinButton = Button(title: "linkedin", tag: 3)
    let twitterButton = Button(title: "twitter", tag: 4)
    let websiteButton = Button(title: "website", tag: 5)
    
    var user: User? {
        didSet {
            if let user = user {
                profileImageView.image = getImage(url: user.profileImageUrl!)
                nilCheck(string: user.location, label: locationLabel)
                nilCheck(string: user.organization, label: organizationLabel)
                itemsCountLabel.text = "\(user.itemsCount)"
                followeesCountLabel.text = "\(user.followeesCount)"
                followersLabel.text = "\(user.followersCount)"
                nilCheck(string: user.description, label: descriptionLabel)
                nilCheck(string: user.facebookId, button: facebookButton)
                nilCheck(string: user.githubLoginName, button: githubButton)
                nilCheck(string: user.linkedinId, button: linkedinButton)
                nilCheck(string: user.twitterScreenName, button: twitterButton)
                nilCheck(string: user.websiteUrl, button: websiteButton)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = user else { return }
        
        if user.name != "" {
            title = "@\(user.id) (\(user.name!))"
        } else {
            title = "@\(user.id)"
        }
        
        view.backgroundColor = .white
        
        view.addSubview(profileImageView)
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, centerX: view.centerXAnchor, width: 150, height: 150, topPadding: 20)
        
        articleLabel.text = "記事"
        followLabel.text = "フォロー"
        followerLabel.text = "フォロワー"
        
        let followeesCountStackView = UIStackView(arrangedSubviews: [followeesCountLabel, followLabel])
        followeesCountStackView.axis = .vertical
        followeesCountStackView.alignment = .center
        view.addSubview(followeesCountStackView)
        followeesCountStackView.anchor(top: profileImageView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
        
        let itemsCountStackView = UIStackView(arrangedSubviews: [itemsCountLabel, articleLabel])
        itemsCountStackView.axis = .vertical
        itemsCountStackView.alignment = .center
        view.addSubview(itemsCountStackView)
        itemsCountStackView.anchor(top: followeesCountStackView.topAnchor, right: followeesCountStackView.leftAnchor, rightPadding: 50)
        
        let followersStackView = UIStackView(arrangedSubviews: [followersLabel, followerLabel])
        followersStackView.axis = .vertical
        followersStackView.alignment = .center
        view.addSubview(followersStackView)
        followersStackView.anchor(top: followeesCountStackView.topAnchor, left: followeesCountStackView.rightAnchor, leftPadding: 50)

        facebookButton.addTarget(self, action: #selector(openUrlButtonAction(_:)), for: .touchUpInside)
        githubButton.addTarget(self, action: #selector(openUrlButtonAction(_:)), for: .touchUpInside)
        linkedinButton.addTarget(self, action: #selector(openUrlButtonAction(_:)), for: .touchUpInside)
        twitterButton.addTarget(self, action: #selector(openUrlButtonAction(_:)), for: .touchUpInside)
        websiteButton.addTarget(self, action: #selector(openUrlButtonAction(_:)), for: .touchUpInside)
        
        let userStackView = UIStackView(arrangedSubviews: [descriptionLabel, locationLabel, organizationLabel, facebookButton, githubButton, linkedinButton, twitterButton, websiteButton, spacerView])
        userStackView.axis = .vertical
        userStackView.alignment = .center
        userStackView.spacing = 15
        view.addSubview(userStackView)
        userStackView.anchor(top: followeesCountStackView.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: 20, leftPadding: 20, rightPadding: 20)
    }
    
    @objc func openUrlButtonAction(_ sender: UIButton) {
        var urlString = ""
        switch sender.tag {
        case 1:
            urlString = "https://facebook.com/\(unwrap(url: user?.facebookId))"
        case 2:
            urlString = "https://github.com/\(unwrap(url: user?.githubLoginName))"
        case 3:
            urlString = "https://www.linkedin.com/in/\(unwrap(url: user?.linkedinId))"
        case 4:
            urlString = "https://twitter.com/\(unwrap(url: user?.twitterScreenName))"
        case 5:
            urlString = unwrap(url: user?.websiteUrl)
        default:
            return
        }
        let url = URL(string: urlString)!
        UIApplication.shared.open(url)
    }
    
    func unwrap(url: String?) -> String {
        if let url = url {
            return url
        }
        return ""
    }
}
