//
//  PostDetailView.swift
//  Inheritx Solutions
//
//  Created by Inheritx on 02/05/26.
//  Copyright © 2026 Inheritx Solutions. All rights reserved.
//

import SwiftUI

/// A premium Post Detail view implemented in SwiftUI to demonstrate hybrid capabilities.
struct PostDetailView: View {
    
    let post: HighlightPost
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header with User Info
                HStack {
                    AsyncImage(url: URL(string: post.user?.userImage ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("\(post.user?.firstName ?? "") \(post.user?.lastName ?? "")")
                            .font(.headline)
                        Text(post.highlightDate ?? "Recently")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                
                // Post Content
                Text(post.postText ?? "")
                    .font(.body)
                    .padding(.horizontal)
                
                // Main Image
                if let imageUrl = post.originalImage, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                
                // Interaction Bar
                HStack(spacing: 20) {
                    Label(post.like?.totalLikes ?? "0", systemImage: "heart.fill")
                    Label(post.comment?.totalComments ?? "0", systemImage: "bubble.right")
                    Spacer()
                    Label(post.totalViews ?? "0", systemImage: "eye")
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
            }
        }
        .navigationTitle("Highlight Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview Provider
struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock data for preview
        NavigationView {
            PostDetailView(post: HighlightPost(categoryId: nil, categoryName: "Preview", comment: nil, editedImage: nil, editedVideo: nil, highlightDate: "2 May 2026", id: "1", isRead: nil, like: nil, originalImage: nil, originalVideo: nil, postText: "This is a premium SwiftUI detail view integrated into a UIKit project.", tagged: nil, totalViews: "1.2k", user: nil, arrStoryPost: nil, postCount: nil, userId: nil, videoThumb: nil, postType: .text, likeStatus: .none))
        }
    }
}
