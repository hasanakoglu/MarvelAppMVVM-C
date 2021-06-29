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
            guard let data = data else { return }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.characterImages[characters.thumbnail.full] = image
                    completion(image)
                }
            }
        }.resume()
    }
}
