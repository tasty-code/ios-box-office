import UIKit

extension UIImage {
    static func load(with movieImage: MovieImage,
                     completion: @escaping (UIImage?) -> Void) {
        guard let imageURLString = movieImage.documents.first?.imageURL,
              let imageURL = URL(string: imageURLString) else {
            print("URL error")
            return
        }
        
        if let cachedImage = CacheManager.shared.object(forKey: NSString(string: imageURLString)) {
            completion(cachedImage)
            return
        }
        
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: imageURL)
                guard let image = UIImage(data: imageData) else { return }
                CacheManager.shared.setObject(image, forKey: NSString(string: imageURLString))
                DispatchQueue.main.async {
                    completion(image)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
