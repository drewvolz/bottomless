import Foundation

struct Urls {
    private enum Domains {
        enum Bottomless {
            static let Base = "https://app.bottomless.com"
            static let ReferralBase = "https://www.bottomless.com"
            static let ShortReferralBase = "bottomless.com"
        }
    }

    private enum Routes {
        static let Api = "/api"
        static let Referral = "/referral"
    }

    static var Referral: String {
        return Domains.Bottomless.ReferralBase + Routes.Referral
    }

    static var ShortReferral: String {
        return Domains.Bottomless.ShortReferralBase + Routes.Referral
    }

    private static let ApiURL = Domains.Bottomless.Base + Routes.Api

    enum api {
        static var auth: String {
            return ApiURL + "/auth/login"
        }

        static var orders: String {
            return ApiURL + "/orders"
        }

        static var inTransition: String {
            return ApiURL + "/orders/in-transition"
        }

        static var my: String {
            return ApiURL + "/products/my"
        }

        static var records: String {
            return ApiURL + "/stats/records"
        }

        static var scaleStatus: String {
            return ApiURL + "/scales/status"
        }

        static var credits: String {
            return ApiURL + "/credits"
        }

        static var me: String {
            return ApiURL + "/users/me"
        }

        static var alerts: String {
            return ApiURL + "/users/text-alerts"
        }

        static var orderingStrategy: String {
            return ApiURL + "/users/ordering-aggression"
        }

        static var pauseAccount: String {
            return ApiURL + "/users/pause-account"
        }

        static var products: String {
            return ApiURL + "/products"
        }

        static var cleanData: String {
            return ApiURL + "/users/clean-data"
        }

//        static var referrals: String {
//            return ApiURL + "/users/referrals"
//        }
//
//        static var future: String {
//            return ApiURL + "/orders/future"
//        }
//
//        static var openShop: String {
//            return ApiURL + "/open-shop"
//        }
//
//        static var rotations: String {
//            return ApiURL + "/products"
//        }
//
//        static var lists: String {
//            return ApiURL + "/products"
//        }
//
//        static var attributes: String {
//            return ApiURL + "/products/attributes"
//        }
//
//        static var manifest: String {
//            return ApiURL + "/manifest"
//        }
    }
}
