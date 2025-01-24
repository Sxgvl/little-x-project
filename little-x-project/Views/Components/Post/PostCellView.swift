//
//  PostCellView.swift
//  little-x-project
//
//  Created by Segal GBENOU on 24/01/2025.
//

import SwiftUI

struct PostCellView: View {
    let post: Post
    let currentUser: User?
    let onLikeToggle: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Image de profil arrondie
            AsyncImage(url: URL(string: post.author?.profileImageURL ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 50, height: 50)
            
            // Titre et contenu
            VStack(alignment: .leading, spacing: 8) {
                Text(post.title ?? "Untitled")
                    .font(.headline)
                Text(post.content ?? "No content")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Bouton like
            VStack(spacing: 4) {
                Button(action: onLikeToggle) {
                    Image(systemName: isLikedByUser(post, currentUser) ? "heart.fill" : "heart")
                        .foregroundColor(isLikedByUser(post, currentUser) ? .red : .gray)
                        .font(.title3)
                }
                Text("\(post.likes?.count ?? 0)")
                    .font(.caption)
            }
        }
        .padding(8)
    }
    
    // Fonction pour vérifier si l'utilisateur a liké
    private func isLikedByUser(_ post: Post, _ user: User?) -> Bool {
        if let user = user, let likes = post.likes as? Set<Like> {
            return likes.contains { $0.user == user }
        }
        return false
    }
}

#Preview {
    let user = User(context: DataController.preview.container.viewContext)
    user.userName = "Autumn Goodman"
    user.profileImageURL = "https://unsplash.com/fr/photos/femme-souriant-portant-une-couronne-de-fleurs-vTL_qy03D1I?utm_content=creditShareLink&utm_medium=referral&utm_source=unsplash"

    let post = Post(context: DataController.preview.container.viewContext)
    post.title = "Beautiful Sunset"
    post.content = "I saw the most beautiful sunset today. Here's what I captured."
    post.author = user
    post.likes = []

    return PostCellView(
        post: post,
        currentUser: user,
        onLikeToggle: {
            print("Like button tapped")
        }
    )
}
