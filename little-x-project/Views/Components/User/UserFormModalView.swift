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
    
    private func createUser() {
        _ = UserModel(
            userName: username,
            follows: [],
            profileImageURL: URL(string: profileImageURL)
        )
        
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
