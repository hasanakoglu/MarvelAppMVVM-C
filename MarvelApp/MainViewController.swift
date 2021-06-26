import UIKit

class MainViewController: UIViewController {
    let tableViewController: UITableViewController = UITableViewController(style: .plain)
    var tableView: UITableView {
            return tableViewController.tableView
        }
    var viewModel: CharactersViewModelProtocol
    var userDefaults = UserDefaults.standard
    var coordinator: MainViewCoordinator?
    
    public init(viewModel: CharactersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Marvel"
        
        navigationController?.navigationBar.prefersLargeTitles = true

        setupTableView()
        
        self.userDefaults.setValue("\(self.viewModel.listOfCharacters.count)", forKey: "characterCount")

        viewModel.fetchCharacters {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(self.userDefaults.integer(forKey: "characterCount"))
            }
        }
    }
    
    func setupTableView() {
        addChild(tableViewController)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.register(CharacterImageCell.self, forCellReuseIdentifier: CharacterImageCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.listOfCharacters[indexPath.row]
        coordinator?.didSelect(character: character)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listOfCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterImageCell.identifier, for: indexPath) as! CharacterImageCell
        cell.accessoryType = .disclosureIndicator
        
        let characters = viewModel.listOfCharacters[indexPath.row]

//        viewModel.getImage(index: indexPath.row) { image in
//            self.viewModel.characterImages[characters.thumbnail.full] = image
//            cell.img.image = image
//        }
        
        cell.img.loadImageFromUrl(urlString: characters.thumbnail.full)
        cell.update(title: characters.name, image: cell.img)
        return cell
    }
}

