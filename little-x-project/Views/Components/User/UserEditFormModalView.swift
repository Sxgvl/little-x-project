//
//  UserEditFormModalView.swift
//  little-x-project
//
//  Created by Segal GBENOU on 24/01/2025.
//

import SwiftUI

struct UserEditFormModalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    @State private var username: String = ""
    @State private var profileImageURL: String = ""
    let user: User
    
    var body: some View {
        NavigationView {
            VStack {
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
                
                Form {
                    Section(header: Text("User Details")) {
                        TextField("Username", text: $username)
                        TextField("Profile Image URL", text: $profileImageURL)
                    }
                }
                .navigationBarTitle("Edit User", displayMode: .inline)
                .navigationBarItems(
                    leading: Button("Cancel") {
                        dismiss()
                    },
                    trailing: Button("Save") {
                        saveChanges()
                        dismiss()
                    }
                )
            }
        }
        .onAppear {
            // Initialisation des valeurs dans le formulaire
            username = user.userName ?? ""
            profileImageURL = user.profileImageURL ?? ""
        }
    }
    
    //
    private func saveChanges() {
        user.userName = username
        user.profileImageURL = profileImageURL
        
        do {
            try context.save()
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
}

#Preview {
    let context = DataController.preview.container.viewContext
    let user = User(context: context)
    
    UserEditFormModalView(user: user)
        .environment(\.managedObjectContext, context)
}
