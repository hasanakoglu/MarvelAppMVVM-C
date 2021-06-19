import Foundation
import UIKit

final class CharacterImageCell: UITableViewCell {
    static let identifier: String = "cell"
    var nameLabel: UILabel = UILabel()
    var img: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func update(title: String?, image: UIImageView?) {
        nameLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        contentView.addSubview(img)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        
        nameLabel.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
