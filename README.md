# RailMap

## Description

RailMap est un projet personnel concrétisant mes premiers 6 mois d'apprentissage en conception et développement d'applications mobiles. Cette application a été développée entièrement en SwiftUI.
RailMap permet une nouvelle façon de suivre les voyages en train.
RailMap est un tracker de voyage en train. Elle permet de voyager sans stress, de prévoir les retards et d'obtenir des mises à jour instantanées.

[ PROJET EN COURS DE DEVELOPPEMENT ]

## Captures d'écran


![Simulator Screenshot - iPhone 14 Pro - 2023-09-08 at 16 18 20](https://github.com/Jezzatator/RailMap/assets/84284069/6d8ee4c8-67bd-4dbb-a326-57667d574853)

![image](https://github.com/Jezzatator/RailMap/assets/84284069/83549546-e08a-4bf4-9da2-356f40c33a30)


## Cahier des charges 

- Utilisation de l'API Navitia
- Utilisation de OSM/OpenRailwayMap
- Utilisation de MapKit pour rendu des trajets
- Creration d'un package pour isoler le module de rendu des données géographiques
- Creation API RailMap avec Vapor et interface web
- Creation de websocket entre app mobile et API pour gerer les MAJ de perturbation et annonces de voies

- Automatisation des Unit Test avec GitHub Action et YAML - en pause car non prise en charge de Xcode 15 et iOS 17 par Github Action 


## Environment

![Badge](https://img.shields.io/badge/iOS-iOS_17.0-brightgreen)

![Badge](https://img.shields.io/badge/Xcode-Xcode_15.0-blue)


## Instalation

Pour installer cette application iOS depuis le projet Xcode, suivez ces étapes simples :

1 - Cloner le Référentiel (Repository)
Tout d'abord, clonez ce référentiel sur votre machine locale en utilisant la commande suivante dans votre terminal :

git clone https://github.com/Jezzatator/RailMap.git

2 - Ouvrir le Projet Xcode
Ouvrez Xcode sur votre Mac.

3 - Ouvrir le Projet
Dans Xcode, sélectionnez "Fichier" (File) > "Ouvrir" (Open) et naviguez jusqu'au dossier où vous avez cloné ce référentiel. Ouvrez le fichier .xcodeproj du projet.

4 - Configurer l'Environnement de Développement
Assurez-vous que vous avez sélectionné un simulateur ou un appareil iOS comme cible de déploiement en haut de la fenêtre Xcode.

5 - Build et Exécution
Appuyez sur le bouton "Exécuter" (Run) dans Xcode (l'icône de flèche verte) pour compiler le projet et lancer l'application sur le simulateur ou l'appareil iOS sélectionné.

6 - Profitez de l'Application
Une fois la compilation terminée, l'application devrait s'ouvrir automatiquement sur le simulateur ou l'appareil iOS. Vous pouvez maintenant utiliser l'application et explorer ses fonctionnalités.

C'est tout ! Vous avez maintenant installé et exécuté l'application iOS à partir du projet Xcode avec succès.

## Licence

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

Copyright (c) 2023 Jérémie P 

## Auteur

Jérémie Patot
