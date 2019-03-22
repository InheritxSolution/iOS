//
//  Highlight.swift
//
//  Copyright © 2019 Inheritx. All rights reserved.
//
/*
 Highlight is model class, used for pass API response to viewController and local database.
 */
import UIKit

class Highlight:Codable {
    
    var currentPageIndex : Int?
    var isNextPage : String?
    var nextPageIndex : Int?
    var posts : [HighlightPost]?
    var totalItems : Int?
    var totalPages : Int?
    
    enum CodingKeys:String,CodingKey {
        case currentPageIndex = "current_page_index"
        case isNextPage = "is_next_page"
        case nextPageIndex = "next_page_index"
        case posts
        case totalItems = "total_items"
        case totalPages = "total_pages"
    }

}

class HighlightPost:Codable {
    
    var categoryId : String?
    var categoryName : String?
    var comment : HighlightComment?
    var editedImage : String?
    var editedVideo : String?
    var highlightDate : String?
    var id : String?
    var isRead : String?
    var like : HighlightLike?
    var originalImage : String?
    var originalVideo : String?
    var postText : String?
    var tagged : HighlightTag?
    var totalViews : String?
    var user : HighlightUser?
    var arrStoryPost : [StoryPost]?
    var postcount : String?
    var userId : String?
    var videoThumb : String?
    var postTypeEnum : PostTypeEnum?
    var postLikeDislikeEnum : PostLikeDislikeEnum?
    
    enum CodingKeys:String,CodingKey {
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
        case postTypeEnum = "post_type"
        case tagged
        case totalViews = "total_views"
        case user
        case arrStoryPost = "story_post"
        case postcount = "post_count"
        case userId = "user_id"
        case videoThumb = "video_thumb"
        case postLikeDislikeEnum = "isLike"
    }
}
class HighlightUser:Codable {
    
    var firstName : String?
    var lastName : String?
    var userId : String?
    var userImage : String?
    
    enum CodingKeys:String,CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userId = "user_id"
        case userImage = "user_image"
    }
    
}
class HighlightLike:Codable {
    var message : String?
    var totalLikes : String?
    
    enum CodingKeys:String,CodingKey {
        case message
        case totalLikes
    }
}
class HighlightComment:Codable {
    var message : String?
    var totalComments : String?
    
    enum CodingKeys:String,CodingKey {
        case message
        case totalComments
    }
}
class HighlightTag:Codable {
    var message : String?
    var totalTagged : String?

    enum CodingKeys:String,CodingKey {
        case message
        case totalTagged
    }
}
class LikeDislike:Codable {
    
    var postLikeDislikeEnum:PostLikeDislikeEnum?
    var postid : String?
    var totalLikes:String?
    var userid:String?
    var message:String?
    
    enum CodingKeys:String,CodingKey {
        case postLikeDislikeEnum = "likebyme"
        case postid = "post_id"
        case totalLikes = "total_likes"
        case userid = "user_id"
        case message
    }
}
class StoryPost:Codable {
    
    var id:String?
    var posttext : String?
    var originalimage:String?
    var editedimage:String?
    var originalvideo:String?
    var editedvideo:String?
    var videothumb:String?
    var postTypeEnum : PostTypeEnum?
    
    enum CodingKeys:String,CodingKey {
        case id = "id"
        case posttext = "post_text"
        case originalimage = "original_image"
        case editedimage = "edited_image"
        case originalvideo = "original_video"
        case editedvideo = "edited_video"
        case videothumb = "video_thumb"
        case postTypeEnum = "post_type"
    }
}
enum PostTypeEnum : String, Codable {
    case image
    case text
    case video
}
enum PostLikeDislikeEnum:String,Codable {
    case nnone = "none"
    case like
    case dislike
}
