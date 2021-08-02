//
//  Constants.swift
//  Bottomless
//
//  Created by Drew Volz on 4/18/21.
//  Copyright © 2021 Drew Volz. All rights reserved.
//

import Foundation

struct Keys {
    // Testing and accessibility IDs
    static let UITesting = "--uitesting"

    enum Tabs {
        static let Orders = "Orders"
        static let Scale = "Scale"
        static let Referrals = "Free Bag"
        static let Search = "Search"
        static let Settings = "Settings"
    }

    enum Orders {
        static let List = "OrdersListIdentifier"

        static let UpNextHeader = "OrdersUpNext"
        static let InProgressHeader = "OrdersInProgress"
        static let PastHeader = "OrdersPast"
    }

    enum Scale {
        static let List = "ScaleListIdentifier"

        static let Summary = "ScaleSummary"
        static let Weight = "ScaleWeight"
        static let Consumption = "ScaleConsumption"
    }

    enum Referrals {
        static let List = "ReferralsListIdentifier"

        static let Credits = "ReferralsCredits"
        static let Link = "ReferralsLink"
        static let About = "ReferralsAbout"
    }

    enum Search {
        static let List = "SearchListIdentifier"
        static let SearchBar = "SearchBarIdentifier"
        static let SortByMenu = "SearchSortByMenuIdentifier"

        enum Filter {
            static let Alphabetical = "AlphabeticalIdentifer"
            static let Likes = "LikesIdentifier"
            static let Recent = "RecentlyAddedIdentifer"
            static let Roaster = "RoasterIdentifier"
        }
    }
}
