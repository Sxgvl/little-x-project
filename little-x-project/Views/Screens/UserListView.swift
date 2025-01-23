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
                            isSelected: false
                        )
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
    UserListView()
}
