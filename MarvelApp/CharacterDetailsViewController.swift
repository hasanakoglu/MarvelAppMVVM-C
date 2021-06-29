import UIKit

class CharacterDetailsViewController: UITableViewController {
    private let character: MarvelCharacter
    private var viewModel: CharacterDetailsViewModelProtocol
    private let userDefaults = UserDefaults.standard
    
    init(character: MarvelCharacter, viewModel: CharacterDetailsViewModelProtocol) {
        self.character = character
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = character.name
        navigationController?.navigationBar.prefersLargeTitles = false
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(CharacterDetailsTableViewCell.self, forCellReuseIdentifier: CharacterDetailsTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }
}

extension CharacterDetailsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailsTableViewCell.reuseIdentifier, for: indexPath) as? CharacterDetailsTableViewCell else { return UITableViewCell() }
        
        if viewModel.characterNames.contains(character.name) {
            cell.favouriteButton.isSelected = true
        }
        cell.update(with: character)
        cell.handler = { sender in
            if sender.isSelected {
                self.viewModel.addToFavourites(character: self.character)
            } else {
                self.viewModel.removeFromFavourites(character: self.character)
            }
            self.viewModel.saveDefaults()
        }
        return cell
    }
}
