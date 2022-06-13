import UIKit

class TabBarItemProvider {
    var home: BaseTabBarItem {
        .init(
            title: "Home",
            image: .named("icon-tab-25-home").withTintColor(.systemGray),
            selectedImage: .named("icon-tab-25-home"))
    }
    
    var store: BaseTabBarItem {
        .init(
            title: "Store",
            image: .named("icon-tab-25-store").withTintColor(.systemGray),
            selectedImage: .named("icon-tab-25-store")
        )
    }
    
    var favorites: BaseTabBarItem {
        .init(
            title: "Favorites",
            image: .named("icon-tab-25-favorites").withTintColor(.systemGray),
            selectedImage: .named("icon-tab-25-favorites")
        )
    }
    
    var settings: BaseTabBarItem {
        .init(
            title: "Settings",
            image: .named("icon-tab-25-settings").withTintColor(.systemGray),
            selectedImage: .named("icon-tab-25-settings")
        )
    }
}
