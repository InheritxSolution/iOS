//
//  Highlight.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import Foundation

// MARK: - Highlight Model
public struct Highlight: Codable {
    public let currentPageIndex: Int?
    public let isNextPage: String?
    public let nextPageIndex: Int?
    public let posts: [HighlightPost]?
    public let totalItems: Int?
    public let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPageIndex = "current_page_index"
        case isNextPage = "is_next_page"
        case nextPageIndex = "next_page_index"
        case posts
        case totalItems = "total_items"
        case totalPages = "total_pages"
    }
}

// MARK: - HighlightPost
public struct HighlightPost: Codable {
    public let categoryId: String?
    public let categoryName: String?
    public let comment: HighlightComment?
    public let editedImage: String?
    public let editedVideo: String?
    public let highlightDate: String?
    public let id: String?
    public let isRead: String?
    public let like: HighlightLike?
    public let originalImage: String?
    public let originalVideo: String?
    public let postText: String?
    public let tagged: HighlightTag?
    public let totalViews: String?
    public let user: HighlightUser?
    public let arrStoryPost: [StoryPost]?
    public let postCount: String?
    public let userId: String?
    public let videoThumb: String?
    public let postType: PostType?
    public let likeStatus: LikeStatus?
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case categoryName = "category_name"
        case comment
        case editedImage = "edited_image"
        case editedVideo = "edited_video"
        case highlightDate = "highlight_date"
        case id
        case isRead
        case like
        case originalImage = "original_image"
        case originalVideo = "original_video"
        case postText = "post_text"
        case postType = "post_type"
        case tagged
        case totalViews = "total_views"
        case user
        case arrStoryPost = "story_post"
        case postCount = "post_count"
        case userId = "user_id"
        case videoThumb = "video_thumb"
        case likeStatus = "isLike"
    }
}

// MARK: - Supporting Models
public struct HighlightUser: Codable {
    public let firstName: String?
    public let lastName: String?
    public let userId: String?
    public let userImage: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userId = "user_id"
        case userImage = "user_image"
    }
}

public struct HighlightLike: Codable {
    public let message: String?
    public let totalLikes: String?
}

public struct HighlightComment: Codable {
    public let message: String?
    public let totalComments: String?
}

public struct HighlightTag: Codable {
    public let message: String?
    public let totalTagged: String?
}

public struct StoryPost: Codable {
    public let id: String?
    public let postText: String?
    public let originalImage: String?
    public let editedImage: String?
    public let originalVideo: String?
    public let editedVideo: String?
    public let videoThumb: String?
    public let postType: PostType?
    
    enum CodingKeys: String, CodingKey {
        case id
        case postText = "post_text"
        case originalImage = "original_image"
        case editedImage = "edited_image"
        case originalVideo = "original_video"
        case editedVideo = "edited_video"
        case videoThumb = "video_thumb"
        case postType = "post_type"
    }
}

// MARK: - Enums
public enum PostType: String, Codable {
    case image
    case text
    case video
}

public enum LikeStatus: String, Codable {
    case none
    case like
    case dislike
}
