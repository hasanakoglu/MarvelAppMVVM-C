import Foundation
import UIKit

protocol CharactersViewModelProtocol {
    var listOfCharacters: [MarvelCharacter] { get set }
    var characterImages: [String: UIImage] { get set }
    func fetchCharacters(completion: @escaping () -> ()) 
    func getImage(index: Int, completion: @escaping (UIImage?) -> ())
}

class CharactersViewModel: CharactersViewModelProtocol {
    var listOfCharacters = [MarvelCharacter]()
    var characterImages = [String: UIImage]()
    let request: CharacterRequestProtocol
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared, request: CharacterRequestProtocol) {
        self.urlSession = urlSession
        self.request = request
    }
    
    func fetchCharacters(completion: @escaping () -> ()) {
        request.fetchCharacters { result in
            switch result {
            
            case .success(let characters):
                self.listOfCharacters = characters
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
    func getImage(index: Int, completion: @escaping (UIImage?) -> ()) {
        let characters = listOfCharacters[index]
        let urlString = characters.thumbnail.full
        guard let url = URL(string: urlString) else { return }
        urlSession.dataTask(with: url) { (data, _, _) in
//            guard let data = try? Data(contentsOf: url) else { return }
            guard let data = data else { return }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.characterImages[characters.thumbnail.full] = image
                    completion(image)
                }
            }
        }.resume()
    }
    
//    fileprivate func tokenRequest() {
//            if let url: URL = URL(string: "https://fcisqa.ice.ibmcloud.com/v1.0/endpoint/default/token/") {
//                let jsonDict: [String: Any] = ["grant_type": "password",
//                                "username": "balauk9@staging.com",
//                                "password": "Ford@123",
//                                "client_id": "4c5222c6-a814-4d76-b74e-7e4bd69e9b01"]
//                var request = URLRequest(url: url)
//                request.httpMethod = "post"
//                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//                request.addValue("Basic ZWFpLWNsaWVudDo=", forHTTPHeaderField: "Authorization")
//                request.addValue("Keep-Alive", forHTTPHeaderField: "Connection")
//                request.httpBody = jsonDict.percentEncoded()
//                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                    if let error = error {
//                        print("error:", error)
//                        return
//                    }
//                    do {  
//                        guard let data = data else { return }
//                        print(data)
//                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
//                        print("json:", json)
//                    } catch {
//                        print("error:", error)
//                    }
//                }
//                task.resume()
//            }
//        }
//
//}
//
//extension Dictionary {
//    func percentEncoded() -> Data? {
//        return map { key, value in
//            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//            return escapedKey + "=" + escapedValue
//        }
//        .joined(separator: "&")
//        .data(using: .utf8)
//    }
}
