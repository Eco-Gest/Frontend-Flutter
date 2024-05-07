# ecogest_front

# lancer le projet
cd ecogest_front

# installer les dépendances

`flutter pub get`

## Créer le fichier .env

`cp .env.example .env`

# lancer le projet dans chrome 

`flutter run -d chrome`

# lancer le projet dans chrome en désactivant la sécurité

`flutter run -d chrome --web-browser-flag "--disable-web-security"`

# hot reload

r ou R

# API

dans lib\data\ecogest_api_data_source.dart vérifier l'url, exemple :

 `static const _baseUrl = 'http://localhost:8080/api';`

# Login


email : prenom@@ecogest.dev
password : voir le UserSeeder

 voir le UserSeeder

# build le projet pour production

`flutter build`

# installer une dépendance

`flutter pub add nom_du_package`

# installer toutes les dépendances
`flutter pub get`

# mettre à jour les dépendances
`flutter pub upgrade`

# mettre à jour flutter
`flutter upgrade`

# mettre à jour flutter et les dépendances

`flutter pub add nom_du_package`

# mettre à jour flutter et les dépendances

`flutter pub upgrade --major-versions`

# Lancer le projet sur chrome

`flutter run -d chrome`
