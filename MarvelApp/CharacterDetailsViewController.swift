import UIKit

class CharacterDetailsViewController: UIViewController {
    let titleLabel: UILabel = UILabel()

    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        setupViews()
        
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
