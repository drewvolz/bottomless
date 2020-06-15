import Foundation

struct App {
    private struct Domains {
        struct Bottomless {
            static let Base = "https://app.bottomless.com"
        }
    }

    private struct Routes {
        static let Api = "/api"
    }

    private static let ApiURL = Domains.Bottomless.Base + Routes.Api

    struct api {
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

//        static var me: String {
//            return ApiURL + "/users/me"
//        }
//
//        static var cleanData: String {
//            return ApiURL + "/users/clean-data"
//        }
//
//        static var referrals: String {
//            return ApiURL + "/users/referrals"
//        }
//
//        static var credits: String {
//            return ApiURL + "/users/credits"
//        }
//
//        static var records: String {
//            return ApiURL + "/stats/records"
//        }
//
//        static var future: String {
//            return ApiURL + "/orders/future"
//        }
//
//        static var scaleStatus: String {
//            return ApiURL + "/scales/status"
//        }
//
//        static var openShop: String {
//            return ApiURL + "/open-shop"
//        }
//
//        static var products: String {
//            return ApiURL + "/products"
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
