//
//  TikTokTabBarView.swift
//  TikTokUI
//
//  Created by Djallil on 2023-01-27.
//

import SwiftUI
enum TabBarItems: String, CaseIterable {
    case home
    case new
    case pluslogo
    case inbox
    case profile
    
    var title: String {
        if self != .pluslogo {
            return self.rawValue.capitalized
        } else {
            return ""
        }
    }

    var icon: String {
        switch self {
        case .home:
            return "house"
        case .new:
            return "person.2"
        case .pluslogo:
            return "tiktokplus"
        case .inbox:
            return "arrow.down.message"
        case .profile:
            return "person"
        }
    }
    
    var selectedIcon: String{
        switch self {
        case .home:
            return "house.fill"
        case .new:
            return "person.2.fill"
        case .pluslogo:
            return "tiktokplus"
        case .inbox:
            return "arrow.down.message.fill"
        case .profile:
            return "person.fill"
        }
    }
}
struct TikTokTabBarView: View {
    @Binding var selectedTab: TabBarItems
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            ForEach(TabBarItems.allCases, id:\.self) {tab in
                Button(action:{
                    withAnimation {
                        selectedTab = tab
                    }
                }) {
                    HStack{
                        Spacer()
                        VStack {
                            Spacer()
                            tabIconFor(tab)
                            if tab != .pluslogo {
                                Text(tab.title)
                                    .font(.caption)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.4)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }.buttonStyle(.plain)
            }
            Spacer()
        }
        .background(Color.white)
    }
    @ViewBuilder
    private func tabIconFor(_ tab: TabBarItems) -> some View {
        if tab == .pluslogo {
            Image(tab.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 44, height: 44, alignment: .center)
        } else {
            if tab == selectedTab {
                Image(systemName: tab.selectedIcon)
            } else {
                Image(systemName: tab.icon)
            }
        }
    }
}

struct TikTokTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TikTokTabBarView(selectedTab: .constant(.home))
    }
}
