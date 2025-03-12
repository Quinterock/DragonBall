//
//  SceneDelegate.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 5/3/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let _ = (scene as? UIWindowScene) else { return }
        let networkModel = NetworkModel.shared
        
        // !!!!!NO ANIDEIS LAS PETICIONES EN LA PRACTICA!!!!
        // 1. Obtener el JWT llamando al login
        networkModel.login(
            user: "luisgqr1975@gmail.com",
            password: "abcdef"
        ) { result in
            switch result {
            case let .success(jwtToken):
                networkModel.getHeroes { result in
                    // 2. Una vez obtenido el token navegamos al listado de heroes
                    // Para representar los datos asincronos en la vista teneis que usar
                    // DispatchQueue.main.async
                    // Todo el contenido grafico que queramos representar, lo tenemos que enviar
                    // a la cola `main`
                    DispatchQueue.main.async {
                        // navigationController.setViewControllers([heroesTableViewController])
                        switch result {
                        case let .success(heroes):
                            // 3. Crear la instancia de HerosListTableViewController y pasar los héroes
                            let heroesListTableViewController = HerosListTableViewController()
                            heroesListTableViewController.heroes = heroes // Asignar los héroes obtenidos
                            
                            // 4. Navegar a la pantalla de héroes
                            self.window?.rootViewController?.navigationController?.pushViewController(heroesListTableViewController, animated: true)
                        case let .failure(error):
                            print("Error \(error)")
                        }
                    }
                    
                }
                
                
                // 3. En el listado de heroes, hacemos la peticion de get heroes
                // NO ANIDEIS ESTAS PETICIONES ASI EN LA PRACTICA
                
//                networkModel.getHeroes { result in
//                    switch result {
//                    case let .success(heroes):
//                        // 4. Imprimir todos los héroes obtenidos
//                        for hero in heroes {
//                            print("Hero: \(hero.name), Description: \(hero.description)")
//                        }
//                    case let .failure(error):
//                        print(error)
//                    }
//                }
            case let .failure(error):
                print(error)
            }
        }
        
        // MARK: - Crear Root View
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        
        let logInViewController = LogInViewController()
//        let logInViewController = HerosListTableViewController()
        let navigationController = UINavigationController(rootViewController: logInViewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}
//case let .success(heroes):
//    // 4. Actualizar el TableView/ CollectionView con el array de heroes
//    // Crear el snapshot
//    // Pasarle el snapshot al dataSource con apply
//    let goku = heroes.first(where: { $0.name == "Goku" })!
//    networkModel.getTransformations(for: goku) { result in
//        switch result {
//            case let .success(transformations):
//                print(transformations)
//            case let .failure(error):
//                print(error)
//        }
//    }
//case let .failure(error):
//    print(error)

//import UIKit

//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//    
//    var window: UIWindow?
//    
//    func scene(
//        _ scene: UIScene,
//        willConnectTo session: UISceneSession,
//        options connectionOptions: UIScene.ConnectionOptions
//    ) {
//        guard let _ = (scene as? UIWindowScene) else { return }
//        let networkModel = NetworkModel.shared
//        
//        // !!!!!NO ANIDEIS LAS PETICIONES EN LA PRACTICA!!!!
//        // 1. Obtener el JWT llamando al login
//        networkModel.login(
//            user: "luisgqr1975@gmail.com",
//            password: "abcdef"
//        ) { result in
//            switch result {
//            case let .success(jwtToken):
//                // 2. Una vez obtenido el token navegamos al listado de heroes
//                // Para representar los datos asincronos en la vista teneis que usar
//                // DispatchQueue.main.async
//                // Todo el contenido grafico que queramos representar, lo tenemos que enviar
//                // a la cola `main`
//                DispatchQueue.main.async {
//                    // navigationController.setViewControllers([heroesTableViewController])
//                }
//                // 3. En el listado de heroes, hacemos la peticion de get heroes
//                // NO ANIDEIS ESTAS PETICIONES ASI EN LA PRACTICA
//                networkModel.getHeroes { result in
//                    switch result {
//                    case let .success(heroes):
//                        // 4. Imprimir todos los héroes obtenidos
//                        for hero in heroes {
//                            print("Hero: \(hero.name), Description: \(hero.description)")
//                        }
//                    case let .failure(error):
//                        print(error)
//                    }
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
//        
//        // MARK: - Crear Root View
//        guard let scene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: scene)
//        
//        let logInViewController = LogInViewController()
//        let navigationController = UINavigationController(rootViewController: logInViewController)
//        
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
//        self.window = window
//    }
//}
