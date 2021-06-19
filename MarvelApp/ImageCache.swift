import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func loadImageFromUrl(urlString: String)  {
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let jsonData = data {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: jsonData) {
                        imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                        self.image = imageToCache
                    }
                }
            }
        }.resume()
    }
}

extension Date {
    func getDateString(from date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        df.locale = Locale.current
        df.dateFormat = ""
        let newDate = df.string(from: date)
        return newDate
    }
}
