import UIKit

class MainViewController: UIViewController {
    let tableViewController: UITableViewController = UITableViewController(style: .plain)
    var tableView: UITableView {
            return tableViewController.tableView
        }
    var viewModel: CharactersViewModelProtocol
    var userDefaults = UserDefaults.standard
    
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
        
        //did not know this - LOOK AGAIN
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
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        
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
        let characters = viewModel.listOfCharacters[indexPath.row]
        let vc = CharacterDetailsViewController()
        vc.titleLabel.text = characters.name
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listOfCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        
        //did not know this - LOOK AGAIN
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

