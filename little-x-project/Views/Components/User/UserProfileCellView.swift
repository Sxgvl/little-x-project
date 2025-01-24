//
//  UserProfileCellView.swift
//  little-x-project
//
//  Created by Segal GBENOU on 23/01/2025.
//

import SwiftUI

struct UserProfileCellView: View {
    let user: User
    let isSelected: Bool
    
    var gradient: AngularGradient {
        AngularGradient(
            gradient: Gradient(colors: [.red, .pink, .purple, .yellow, .red]),
            center: .center
        )
    }
    
    @Environment(\.managedObjectContext) var context
    
    private var profileImageURL: URL? {
        guard let urlString = user.profileImageURL else { return nil }
        return URL(string: urlString)
    }
    
    @State private var showingEditModal = false
    @State private var isShowingContentView = false
    
    let onSelect: () -> Void
    
    var body: some View {
        HStack {
            // Image de profil sécurisée
            AsyncImage(url: profileImageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 50, height: 50)
            .overlay(
                Circle()
                    .strokeBorder(
                        isSelected ? AnyShapeStyle(gradient) : AnyShapeStyle(Color(white: 0.9)),
                        lineWidth: 3
                    )
            )
            
            // Nom d'utilisateur sécurisé
            Text(user.userName ?? "Unknown User")
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            // Menu des actions si l'utilisateur est sélectionné
            if isSelected {
                Menu {
                    Button("Voir les posts") {
                        isShowingContentView = true
                        onSelect()
                    }
                    Button("Modifier") {
                        showingEditModal = true
                    }
                    Button(role: .destructive) {
                        deleteUser()
                    } label: {
                        Label("Supprimer", systemImage: "trash")
                    }
                    Button("Annuler", role: .cancel) {}
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
    }
    
    
    private func deleteUser() {
        context.delete(user)
        do {
            try context.save()
        } catch {
            print("Failed to delete user: \(error.localizedDescription)")
        }
    }
}

#Preview {
    let previewUser = User(context: DataController.preview.container.viewContext)
    previewUser.userName = "John Doe"
    previewUser.profileImageURL = "https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"
    
    return UserProfileCellView(
        user: previewUser,
        isSelected: true,
        onSelect: {}
    )
}

//#Preview {
//    UserProfileCellView(
//        user: User(), // Remplace par un objet Core Data User valide pour la prévisualisation
//        isSelected: true,
//        onSelect: {}
//    )
//}
