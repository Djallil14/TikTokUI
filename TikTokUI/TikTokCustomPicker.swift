//
//  TikTokCustomPicker.swift
//  TikTokUI
//
//  Created by Djallil on 2023-01-27.
//

import SwiftUI

struct TikTokCustomPicker: View {
    @Binding var selectedCategory: Category
    var body: some View {
        HStack {
            Spacer()
            HStack {
                ForEach(Category.allCases, id: \.self) { category in
                    VStack {
                        Text(category.title)
                            .font(.headline)
                            .padding()
                            .underline(selectedCategory == category)
                            .onTapGesture {
                                withAnimation {
                                    selectedCategory = category
                                }
                            }
                    }
                }
            }
            .padding(.leading)
            Spacer()
            Button(action:{}) {
                Image(systemName: "magnifyingglass")
                    .bold()
                    .imageScale(.large)
                    .padding(.trailing)
            }
            .buttonStyle(.plain)
        }
    }
}

struct TikTokCustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        TikTokCustomPicker(selectedCategory: .constant(.following))
    }
}
