//
//  ProfileView.swift
//  Study-iOS14-sample
//
//  Created by DouKing on 2020/6/30.
//

import SwiftUI

struct ProfileView: View {
    var name: String

    var body: some View {
        ProfileRepresent(name: name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(name: "John")
    }
}
