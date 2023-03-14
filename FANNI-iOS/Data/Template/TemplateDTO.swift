//
//  TemplateDTO.swift
//  FANNI-iOS
//
//  Created by 송형욱 on 2023/03/09.
//

import Foundation

enum TemplateDTO {
    struct Request: Encodable {
        let page: Int
        let q: String
        
        public init(page: Int, q: String) {
            self.page = page
            self.q = q
        }
    }
    
    struct Response: Decodable {
        let totalCount: Int
        let incompleteResults: Bool
        let items: [ItemResponse]

        enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case incompleteResults = "incomplete_results"
            case items
        }
    }
}

extension TemplateDTO {
    struct ItemResponse: Decodable {
        let id: Int
        let name, fullName: String
        let owner: OwnerResponse
        let itemPrivate: Bool
        let htmlURL: String
        let itemDescription: String
        let fork: Bool
        let url: String
        let createdAt, updatedAt, pushedAt: String
        let size, stargazersCount, watchersCount: Int
        let forksCount, openIssuesCount: Int
        let score: Double

        enum CodingKeys: String, CodingKey {
            case id, name
            case fullName = "full_name"
            case owner
            case itemPrivate = "private"
            case htmlURL = "html_url"
            case itemDescription = "description"
            case fork, url
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case pushedAt = "pushed_at"
            case size
            case stargazersCount = "stargazers_count"
            case watchersCount = "watchers_count"
            case forksCount = "forks_count"
            case openIssuesCount = "open_issues_count"
            case score
        }
    }
    
    struct OwnerResponse: Decodable {
        let login: String
        let id: Int
        let avatarURL: String
        let gravatarID: String
        let url, receivedEventsURL: String
        let type: String

        enum CodingKeys: String, CodingKey {
            case login, id
            case avatarURL = "avatar_url"
            case gravatarID = "gravatar_id"
            case url
            case receivedEventsURL = "received_events_url"
            case type
        }
    }
}
