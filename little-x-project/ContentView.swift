//
//  ContentView.swift
//  little-x-project
//
//  Created by Segal GBENOU on 19/01/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @State var selectedUser: User? // L'utilisateur sélectionné
    @State private var isShowingUserList = false
    @State private var isShowingAddPost = false
    
    @FetchRequest(
        entity: Post.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Post.title, ascending: true)]
    ) private var allPosts: FetchedResults<Post>
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = selectedUser {
                    let userPosts = allPosts.filter { $0.author == user }
                    
                    if userPosts.isEmpty {
                        Text("No posts available for this user.")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .offset(x: -45, y: -300)
                    } else {
                        List(userPosts, id: \.self) { post in
                            PostCellView(
                                post: post,
                                currentUser: selectedUser,
                                onLikeToggle: {
                                    toggleLike(for: post)
                                }
                            )
                        }.listStyle(.plain)
                    }
                } else {
                    Text("No user selected, please choose one.")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .offset(x: -45, y: -300)
                }
            }
            .navigationBarTitle("Posts Thread")
            .navigationBarItems(trailing:
                                    Button(
                                        action: {
                                            isShowingUserList = true
                                        },
                                        label: {
                                            Image(systemName: "person.crop.circle.badge.plus")
                                                .font(.title2)
                                        }
                                    )
            )
            .sheet(isPresented: $isShowingUserList) {
                UserListView(selectedUser: $selectedUser)
                    .environment(\.managedObjectContext, context)
            }
            //
            .overlay(alignment: .bottomTrailing) {
                Button (
                    action: {
                        isShowingAddPost = true
                    },
                    label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(selectedUser != nil ? Color.blue : Color.gray)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                )
                .padding()
                .disabled(selectedUser == nil)
                .sheet(isPresented: $isShowingAddPost) {
                    if let selectedUser = selectedUser {
                        PostFormModalView(selectedUser: selectedUser)
                            .environment(\.managedObjectContext, context)
                    }
                }
                .offset(x: 50, y: 330)
            }
        }
    }
    
    // 
    private func toggleLike(for post: Post) {
        guard let currentUser = selectedUser else { return }
        
        if let like = post.likes?.first(where: { ($0 as? Like)?.user == currentUser }) as? Like {
            // Supprimer le like
            context.delete(like)
        } else {
            // Ajouter un like
            let newLike = Like(context: context)
            newLike.user = currentUser
            newLike.date = Date()
            post.likes = post.likes?.adding(newLike) as NSSet? ?? NSSet(object: newLike)
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to toggle like: \(error.localizedDescription)")
        }
    }
}

#Preview {
    let context = DataController.preview.container.viewContext
    ContentView()
        .environment(\.managedObjectContext, context)
}
