import Foundation

protocol CharacterRequestProtocol {
    func fetchCharacters(completion: @escaping(Result<[MarvelCharacter], CharacterError>) -> Void)
}

class CharacterRequest: CharacterRequestProtocol {
    func fetchCharacters(completion: @escaping (Result<[MarvelCharacter], CharacterError>) -> ()) {
        let urlString = API.charactersURL
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let jsonData = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CharacterResponseModel.self, from: jsonData)
                let characters = response.data.characters
                completion(.success(characters))
            } catch {
                completion(.failure(.jsonError))
            }
        }.resume()
    }
}

