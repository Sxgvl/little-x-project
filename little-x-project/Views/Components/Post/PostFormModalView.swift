//
//  UserPostFormModalView.swift
//  little-x-project
//
//  Created by Segal GBENOU on 23/01/2025.
//

import SwiftUI

struct PostFormModalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    @State private var title: String = ""
    @State private var content: String = ""
    let selectedUser: User
    
    var body: some View {
        NavigationStack {
            //
            Form {
                //
                Section(header: Text("Post Details")) {
                    //
                    TextField("Title", text: $title)
                    //
                    TextEditor(text: $content)
                        .font(.system(size: 14))
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray, lineWidth: 0.2)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        )
                        .frame(height: 120)
                    
//                    Picker("Select User", selection: $selectedUser) {
//                        ForEach(users, id: \.self) { user in
//                            Text(user.userName ?? "Unknown").tag(user as User?)
//                        }
//                    }
                }
            }
            .navigationBarTitle("Create Post", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Post") {
                    createPost()
                    dismiss()
                }
            )
        }
    }
    
    // 
    private func createPost() {
        let post = Post(context: context)
        post.title = title
        post.content = content
        post.author = selectedUser

        // TODO : L'ajout des likes pourrait se faire plus tard
//        post.likes = []

        do {
            try context.save()
        } catch {
            print("Failed to save post: \(error.localizedDescription)")
        }
    }
}

#Preview {
    let context = DataController.preview.container.viewContext
    
    return PostFormModalView(selectedUser: User(context: context))
        .environment(\.managedObjectContext, context)
}
