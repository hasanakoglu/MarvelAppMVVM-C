import Foundation

struct CharacterResponseModel: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let characters: [MarvelCharacter]
    
    enum CodingKeys: String, CodingKey {
        case characters = "results"
    }
}

struct MarvelCharacter: Codable, Equatable {
    let name, description: String
    let thumbnail: Thumbnail
    let urls: [MarvelURL]
}

struct Thumbnail: Codable, Equatable {
    let path: String
    let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    
    var full: String {
        return path + "." + thumbnailExtension.rawValue
    }
}

enum Extension: String, Codable {
    case jpg = "jpg"
}

struct MarvelURL: Codable, Equatable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

extension MarvelCharacter {
    var imageURL: URL? {
        let urlString = String("\(thumbnail.path).\(thumbnail.thumbnailExtension.rawValue)")
        return URL(string: urlString)
    }
    
    var websiteURL: URL? {
        let websiteURL = urls.filter { $0.type == .detail }
        guard let urlString = websiteURL.first?.url else { return nil }
        return URL(string: urlString)
    }
}
