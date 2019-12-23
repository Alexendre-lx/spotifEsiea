##Alexendre OBLI
# Spotif'Esiea !


[![Build Status](https://github.com/Alexendre-lx/spotifEsiea.svg?branch=master)](https://github.com/Alexendre-lx/spotifEsiea)

Spotif'Esiea est mon projet d'application pour le module Developpement mobile.

# Les fonctionalités 
  - Menu de navigation de type Bottom Bar 
  - Liste de musiques récentes
  - Liste de recommandations 
  - Liste des playlists populaires
  - Recherche de musique par titre
  - Lecteur d'extraits de musique
  - Détail de la musique sélectionnée
  - Redirection vers l'application spotify

# Features !
  - Appel à un service API (spotifi API) O-Auth authentification
  - Parse des réponses JSON
  - Architecture MVC
  - Utlisation de RXSwift / RxCocoa
  - (Fragements)
  - Design
  - Clean Architecture

> Le but premier de la mise en oeuvre de cette application est de nous faire appréhender les condition de mise en oeuvre d'une application mobile ainsi que la consommation d'API Rest. 
Ainsi par le bais de cette aplication, j'ai pu aborder ces différentes problématiques. 
### Developpement
Dans un premier temps, mon developpment d'application s'était tourné vers un autre type d'application [Regal'app](https://github.com/Alexendre-lx/application_mobile.git). Cette application consommait une Api donc les appels journaliers étaient limités. Je me suis donc tourné vers un autre projet. 

Le projet actuel à pour but de reprendre le thème de spotify et d'en consommer les Api (ne nécessitants pas de connexion de l'utilisateur )

#Image de l'accueil de l'api#

Ainsi, en m'aidant de la documentation présente sur le site, il me fallait dans un premier temps faire en sorte que l'utilisateur puisse récuppérer un token d'accès valide pendant 1h et le stocker dans le téléphone. 
#Image de api.getToken()#

une fois ceci fait, il ne me restrait plus qu'a consommer mon api à ma guise.
#Image d'un token#


## Présentation de l'application

L'application se décompose en trois sections : 
    1. La page d'accueil :
        Cette page permet de visualiser les trois sous sections de cette page comprennant l affichage des dernière nouveautés, les morceaux conseillés et enfin les playlists du moment

#
    2. La page de recherche :
        Cette page permet de visualiser rechercher des morceaux par leur titre ou par l'interprète de la musique.
#
    3. La page de lecteur :
        Cette page permet de visualiser l'extrait en cours de lecture une fois qu'un extrait a été selectionné dans l'une des deux pages précédentes .

## Présentation technique de l'application

D'un point de vue technique, l'application se décompose en trois grandes sections : 
+ Le maincontroller (tabBar) qui encapsule l'ensemble de l'application
```swift
class MainControllerViewController: UITabBarController, UITabBarControllerDelegate {
    let api = apiLooker()
    let noNetworkView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
```
    + Les naviagations controllers qui encapsulent chacune des section
 ```swift
let item1 = ViewController()
            let firstVc = UINavigationController(rootViewController: item1)
            firstVc.navigationBar.barStyle = .blackTranslucent
            firstVc.navigationBar.topItem?.title = "Spotif'Esiea !"
            let icon1 = UITabBarItem(title: "home", image: UIImage.init(imageLiteralResourceName: "homeIcon"), tag: 0)
            item1.tabBarItem = icon1
            let item2 = SearchViewController()
            let secondVc = UINavigationController(rootViewController: item2)
 ```
    + Les TablesViewController qui controllent les tables view de recherche d'accueuil.
```swift
class ViewController: UITableViewController {
    var newReleasesData = Array<newReleases>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.tableView.register(customTableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.isEditing = false
        
        self.tableView.sectionHeaderHeight = 40
        self.tableView.estimatedSectionHeaderHeight = 40
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
```
    + Les collectionsViewController (réprésenté par le delegate et le datasource )qui régissent les collections de la page d'accueil.
```swift
class customTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
```
#Captures d'écran
