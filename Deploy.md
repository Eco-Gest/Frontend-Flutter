# Déploiement

Prérequis : 

- Tester l'application sur un émulateur android
- Signer l'application
- Configurer Firebase

[Documentation offcielle](https://docs.flutter.dev/deployment/android)

1) Etre sur une branche de release depuis develop à jour

2) Créer une numéro de version dans le `pubspec.yaml`

3) Générer un fichier .aab

```sh
flutter build appbundle --release
```

3) Sur Google console

- Créer une version sur la Google console
- Déposer le fichier .aab sur la Google console
