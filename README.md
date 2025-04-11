📱 News App

Une application Flutter qui affiche les derniers articles du journal WSJ via l'API de NewsAPI.org.

🔧 Fonctionnalités

Affichage des articles du Wall Street Journal (WSJ)

Mise en cache locale avec Hive

Architecture propre avec BLoC

Interface moderne inspirée de Dribbble

🚀 Démarrer le projet

1. Cloner le repo et accéder au dossier
   https://github.com/IT-workers713/newapptest.git
   cd news_app
2. Installer les dépendances
   flutter pub get
3. flutter run

🧪 Configuration requise

NewsAPI

Aller sur https://newsapi.org

Créer un compte gratuitement

Récupérer votre clef API personnelle

Remplacer la valeur dans :
static const String _apiKey = 'VOTRE_API_KEY';


📦 Dépendances principales

dependencies:
flutter_bloc: ^8.1.2
hive: ^2.2.3
hive_flutter: ^1.1.0
http: ^0.13.5
intl: ^0.18.1
flutter_screenutil: ^5.5.4

📁 Structure du projet

lib/
├── data/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── bloc/
│   └── pages/
├── injection.dart
└── main.dart

✅ Bonnes pratiques incluses

Architecture DDD (Domain-Driven Design)

Séparation claire des couches

Gestion de l'état avec BLoC

Responsive UI avec ScreenUtil