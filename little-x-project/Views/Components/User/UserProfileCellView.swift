//
//  UserProfileCellView.swift
//  little-x-project
//
//  Created by Segal GBENOU on 23/01/2025.
//

import SwiftUI

struct UserProfileCellView: View {
    let user: UserModel
    let isSelected: Bool
    
    var gradient: AngularGradient {
        AngularGradient(
            gradient: Gradient(colors: [.red, .pink, .purple, .yellow, .red]),
            center: .center
        )
    }
    
    @Environment(\.managedObjectContext) var context
    @State private var showingDeleteAlert = false
    
    var body: some View {
        VStack {
            AsyncImage(url: user.profileImageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 70, height: 70)
            .overlay(
                Circle()
                    .strokeBorder(
                        isSelected ? AnyShapeStyle(gradient) : AnyShapeStyle(Color(white: 0.9)),
                        lineWidth: 3
                    )
            )
            
            Text(user.userName)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding()
    }
    
//    private func deleteUser() {
//        // Suppression de l'utilisateur dans CoreData
//        context.delete(user)
//        
//        do {
//            try context.save()
//        } catch {
//            print("Failed to delete user: \(error.localizedDescription)")
//        }
//    }
}

#Preview {
    UserProfileCellView(
        user: UserModel(
            userName: "Autumn G.",
            follows: [],
            profileImageURL: URL(string: "https://unsplash.com/fr/photos/femme-souriant-portant-une-couronne-de-fleurs-vTL_qy03D1I?utm_content=creditShareLink&utm_medium=referral&utm_source=unsplash")
        ),
        isSelected: true
    )
}
