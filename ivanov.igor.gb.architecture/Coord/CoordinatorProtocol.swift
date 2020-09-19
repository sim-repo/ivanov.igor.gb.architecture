import UIKit


protocol CoordinatorProtocol : class {
    var childCoordinators : [CoordinatorProtocol]? { get set }
    var navigationController: UINavigationController { get }
    var onRelease: (()->Void)? { get }
    init(navigationController: UINavigationController, params: Any?)
    
    func start(onRelease: (()->Void)?)
    
    func doForward(screenEnum: ScreenEnum, params: Any?)
    func doBack()
}

extension CoordinatorProtocol {

    func store(coordinator: CoordinatorProtocol) {
        childCoordinators?.append(coordinator)
    }

    func free(coordinator: CoordinatorProtocol) {
        guard let childs = childCoordinators else {return}
        childCoordinators = childs.filter { $0 !== coordinator }
    }
}

