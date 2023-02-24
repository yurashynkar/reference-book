//
//  ViewController.swift
//  reference_book
//
//  Created by юра шинкар on 21.01.23.
//

import UIKit

class ContainerViewController: UIViewController {

    enum MenuState {
        case opened
        case closed
    }

    private var menuState: MenuState = .closed

    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    lazy var infoVC1 = InfoBaseViewController()
    lazy var infoVC2 = InfoBaseViewController()
    lazy var infoVC3 = InfoBaseViewController()
    lazy var infoVC4
    = InfoBaseViewController()
    lazy var infoVC5 = InfoBaseViewController()
    lazy var infoVC6 = InfoGraficsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVC()
        overrideUserInterfaceStyle = .light

        
    }

    private func addChildVC() {
        // Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)

        //Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    

}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
        homeVC.view.subviews.forEach { view in
            if view is UIImageView {
                return
            }
            view.removeFromSuperview()
        }
        homeVC.children.last?.removeFromParent()
        
    }
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            // open it
            UIView.animate(
                withDuration: 0,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut
            ) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
        case .opened:
            // closed it
            UIView.animate(
                withDuration: 0,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut
            ) {
                self.navVC?.view.frame.origin.x = 0

            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}
extension ContainerViewController: MenuViewControllerDelegate {
    
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu(completion: nil)
        switch menuItem {
        case .home:
            self.resetToHome()
        case .doc:
            self.addInfo1()
        case .res:
            self.addInfo2()
        case .base:
            self.addInfo3()
        case .normativ:
            self.addInfo4()
        case .sxrz:
            self.addInfo5()
        case .grafics:
            self.addInfo6()
        }
    }
    
    func resetToHome() {
        infoVC1.view.removeFromSuperview()
        infoVC1.didMove(toParent: nil)
        homeVC.title = "Справочник МЧС"
        
    }
    func addInfo1() {
        let vc1 = infoVC1
        let optionsMenu1 = InfoDocViewController.MenuOptions1.allCases.map {
            Options(
                name: $0.rawValue,
                imageBaseName: $0.imageDocName,
                docName: $0.docName
            )
        }
        vc1.setOptions(optionsMenu1)
        homeVC.addChild(vc1)
        homeVC.view.addSubview(vc1.view)
        vc1.view.frame = view.frame
        vc1.didMove(toParent: homeVC)
        homeVC.title = vc1.title
    }
    func addInfo2() {
        let vc2 = infoVC2
        let optionsMenu2 = InfoResponsibilitiesViewController.MenuOptions3.allCases.map {
            Options(
                name: $0.rawValue,
                imageBaseName: $0.imageResName,
                docName: $0.resName
            )
        }
        vc2.setOptions(optionsMenu2)
        homeVC.addChild(vc2)
        homeVC.view.addSubview(vc2.view)
        vc2.view.frame = view.frame
        vc2.didMove(toParent: homeVC)
        homeVC.title = vc2.title
    }
    func addInfo3() {
        let vc3 = infoVC3
        let optionsMenu3 = MenuOptions3.allCases.map {
            Options(
                name: $0.rawValue,
                imageBaseName: $0.imageBaseName,
                docName: $0.docName
            )
        }
        infoVC3.setOptions(optionsMenu3)
        homeVC.addChild(vc3)
        homeVC.view.addSubview(vc3.view)
        vc3.view.frame = view.frame
        vc3.didMove(toParent: homeVC)
        homeVC.title = vc3.title
    }
    func addInfo4() {
        let vc4 = infoVC4
        let optionsMenu7 = InfoNormativViewController.MenuOptionsNormativ.allCases.map {
            Options(
                name: $0.rawValue,
                imageBaseName: $0.imageNormativName,
                docName: $0.NormativName
            )
        }
        infoVC4.setOptions(optionsMenu7)
        homeVC.addChild(vc4)
        homeVC.view.addSubview(vc4.view)
        vc4.view.frame = view.frame
        vc4.didMove(toParent: homeVC)
        homeVC.title = vc4.title
    }
        func addInfo5() {
            let vc5 = infoVC5
            let optionsMenu6 = InfoCHRZViewController.MenuOptions6.allCases.map {
                Options(
                    name: $0.rawValue,
                    imageBaseName: $0.imageCHRZName,
                    docName: $0.chrzName
                )
            }
            infoVC5.setOptions(optionsMenu6)
            homeVC.addChild(vc5)
            homeVC.view.addSubview(vc5.view)
            vc5.view.frame = view.frame
            vc5.didMove(toParent: homeVC)
            homeVC.title = vc5.title
        }
        func addInfo6() {
            let vc6 = infoVC6
            
            homeVC.addChild(vc6)
            homeVC.view.addSubview(vc6.view)
            vc6.view.frame = view.frame
            vc6.didMove(toParent: homeVC)
            homeVC.title = vc6.title
        }
    }
