import Combine
import SwiftUI

struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel

    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }

    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 64, height: 64)
            .clipShape(Circle())
    }

    static var defaultImage = UIImage(systemName: "photo")!
}

class UrlImageModel: ObservableObject {
    var imageCache = ImageCache.getImageCache()

    @Published var image: UIImage?
    var urlString: String?

    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }

    func loadImage() {
        if loadImageFromCache() {
            return
        }

        loadImageFromUrl()
    }

    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }

        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }

        image = cacheImage
        return true
    }

    func loadImageFromUrl() {
        guard let urlString = urlString else {
            return
        }

        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let url = URL(string: encodedUrlString)

        let task = URLSession.shared.dataTask(with: url!, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }

    func getImageFromResponse(data: Data?, response _: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }

        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
        }
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()

    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }

    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
