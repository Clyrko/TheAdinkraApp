class FTUXTourItemProvider {
    var home: FTUXTourCardView.UiModel {
        .init(
            icon: .named("icon-tab-25-home"),
            title: "Home",
            description: "Here is your home",
            pageIndex: 1,
            totalPageCount: 4
        )
    }
    
    var store: FTUXTourCardView.UiModel {
        .init(
            icon: .named("icon-tab-25-store"),
            title: "Store",
            description: "Here is your store",
            pageIndex: 2,
            totalPageCount: 4
        )
    }
    
    var favorites: FTUXTourCardView.UiModel {
        .init(
            icon: .named("icon-tab-25-favorites"),
            title: "Favorites",
            description: "Here are your favorites",
            pageIndex: 3,
            totalPageCount: 4
        )
    }
    
    var settings: FTUXTourCardView.UiModel {
        .init(
            icon: .named("icon-tab-25-settings"),
            title: "Settings",
            description: "Here are your settings",
            pageIndex: 4,
            totalPageCount: 4
        )
    }
}
