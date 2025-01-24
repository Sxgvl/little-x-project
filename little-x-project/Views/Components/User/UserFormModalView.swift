//
//  UserFormModalView.swift
//  little-x-project
//
//  Created by Segal GBENOU on 23/01/2025.
//

import SwiftUI

struct UserFormModalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    @State private var username: String = ""
    @State private var profileImageURL: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // image
                if let url = URL(string: profileImageURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .padding()
                    } placeholder: {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                }
                
                //
                Form {
                    Section(header: Text("User Details")) {
                        TextField("Username", text: $username)
                        TextField("Profile Image URL", text: $profileImageURL)
                    }
                }
                .navigationBarTitle("Create User", displayMode: .inline)
                .navigationBarItems(
                    leading: Button("Cancel") {
                        dismiss()
                    },
                    trailing: Button("Create") {
                        createUser()
                        dismiss()
                    }
                )
            }
        }
    }
    
    private func createUser() {
        let newUser = User(context: context)
        newUser.userName = username
        newUser.profileImageURL = profileImageURL
        
        do {
            try context.save()
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
}

#Preview {
    UserFormModalView()
}
