import UIKit

class CharacterDetailsTableViewCell: UITableViewCell {
    private let nameLabel: UILabel = UILabel()
    private let characterImageView: UIImageView = UIImageView()
    private let button = UIButton()
    private var characterDescriptionURL: URL?
    private let descriptionLabel: UILabel = UILabel()
    
    static let reuseIdentifier = "CharacterDetails"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(characterImageView)
        contentView.addSubview(button)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        descriptionLabel.numberOfLines = 0
        characterImageView.contentMode = .scaleAspectFit
        button.setTitle("Website", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        characterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40.0).isActive = true
        characterImageView.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 30.0).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0).isActive = true
        
        button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50.0).isActive = true
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func update(with character: MarvelCharacter) {
        nameLabel.text = character.name
        descriptionLabel.text = character.description == "" ? "No Description" : character.description
        characterDescriptionURL = character.websiteURL
        characterImageView.loadImageFromUrl(urlString: character.thumbnail.full)
        updateConstraints()
    }
    
    @objc func buttonTapped() {
        guard let url = characterDescriptionURL else { return }
        UIApplication.shared.open(url)
    }
}
