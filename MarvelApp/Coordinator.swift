import Foundation
import UIKit

protocol Coordinator {
    func start()
    func didSelect(character: MarvelCharacter)
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CharactersViewModel(request: CharacterRequest())
        let vc = MainViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func didSelect(character: MarvelCharacter) {
        let detailsVC = CharacterDetailsViewController(character: character)
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
