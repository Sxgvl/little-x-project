//
//  ContentView.swift
//  little-x-project
//
//  Created by Segal GBENOU on 19/01/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @State private var selectedUser: User? // L'utilisateur sélectionné
    @State private var isShowingUserList = false
    @State private var isShowingAddPost = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if let user = selectedUser, let posts = user.posts?.allObjects as? [Post], !posts.isEmpty {
                    List(posts, id: \.self) { post in
                        VStack(alignment: .leading) {
                            Text(post.title ?? "Untitled")
                                .font(.headline)
                            Text(post.content ?? "No content")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                } else {
                    Text(selectedUser == nil
                         ? "No user selected, please choose one."
                         : "No posts available for this user.")
                    .font(.callout)
                    .foregroundColor(.gray)
                }
            }
            .navigationBarTitle("Posts Thread")
            .navigationBarItems(trailing: Button(action: {
                isShowingUserList = true
            }) {
                Image(systemName: "person.crop.circle.badge.plus")
                    .font(.title2)
            })
            .sheet(isPresented: $isShowingUserList) {
                UserListView(selectedUser: $selectedUser)
                    .environment(\.managedObjectContext, context)
            }
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
                    if let user = selectedUser {
                        UserPostFormModalView()
                            .environment(\.managedObjectContext, context)
                    }
                }
            }
            
        }
    }
}

#Preview {
    let context = DataController.preview.container.viewContext
    ContentView()
        .environment(\.managedObjectContext, context)
}
