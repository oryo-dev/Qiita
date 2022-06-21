//
//  Article.swift
//  Qiita
//
//  Created by oryo on 2022/06/20.
//

import Foundation

struct Article: Decodable {
    
    let createdAt: String
    let likesCount: Int
    let tags: [Tag]
    let title: String
    let url: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case likesCount = "likes_count"
        case tags
        case title
        case url
        case user
    }
}

struct Tag: Decodable, Equatable {
    
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct User: Decodable {
    
    let description: String?
    let facebookId: String?
    let followeesCount: Int
    let followersCount: Int
    let githubLoginName: String?
    let id: String
    let itemsCount: Int
    let linkedinId: String?
    let location: String?
    let name: String?
    let organization: String?
    let profileImageUrl: String?
    let twitterScreenName: String?
    let websiteUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case description
        case facebookId = "facebook_id"
        case followeesCount = "followees_count"
        case followersCount = "followers_count"
        case githubLoginName = "github_login_name"
        case id
        case itemsCount = "items_count"
        case linkedinId = "linkedin_id"
        case location
        case name
        case organization
        case profileImageUrl = "profile_image_url"
        case twitterScreenName = "twitter_screen_name"
        case websiteUrl = "website_url"
    }
}
