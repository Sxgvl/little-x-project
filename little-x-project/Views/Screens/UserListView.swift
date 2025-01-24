//
//  UserListView.swift
//  little-x-project
//
//  Created by Segal GBENOU on 23/01/2025.
//

import SwiftUI

struct UserListView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<User>
    
    @State private var isShowingCreateUserModal = false
    @Binding var selectedUser: User?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    if let username = user.userName {
                        UserProfileCellView(
                            user: UserModel(
                                userName: username,
                                follows: [],
                                profileImageURL: URL(string: user.profileImageURL ?? "")
                            ),
                            isSelected: user == selectedUser
                        ).onTapGesture {
                            selectedUser = user
                        }
                    } else {
                        Text("Invalid User")
                    }
                }
            }
            .navigationBarTitle("Users")
            .navigationBarItems(trailing: Button("Add") {
                isShowingCreateUserModal.toggle()
            })
            .sheet(isPresented: $isShowingCreateUserModal) {
                UserFormModalView()
                    .environment(\.managedObjectContext, context)
            }
        }
    }
}

#Preview {
    let context = DataController.preview.container.viewContext
        let user = User(context: context)
        user.userName = "John Doe"
        user.profileImageURL = ""

        return UserListView(selectedUser: .constant(user))
            .environment(\.managedObjectContext, context)
}
