
# Projet Flash SQL - Power of Memory

 Ce dépôt contient la partie 2 du "Projet Flash" réalisé dans le cadre de notre formation à la Coding Factory[cite: 18]. L'objectif était de concevoir la base de données MySQL et de rédiger l'ensemble des requêtes SQL nécessaires pour une application web de jeu.

**Équipe :**
* Emma
* Tristan
* Quentin

---

## 📖 À propos du projet

 Cette étape du projet était exclusivement centrée sur le **Back-end SQL**[cite: 7].  Nous avons créé toutes les requêtes qui serviront de base à la partie PHP de l'application[cite: 8, 9].

 L'application simulée est une plateforme de jeu, incluant le jeu "Power of Memory"[cite: 43], et dotée de fonctionnalités sociales comme un chat, une messagerie privée et un tableau des scores.

## 💻 Technologies utilisées

*  **MySQL** : Pour la création de la base de données [cite: 19] et l'écriture des requêtes.

---

## 🗃️ Structure de la base de données

 La base de données a été structurée pour répondre à l'ensemble des besoins fonctionnels[cite: 21]. Les tables principales sont :

*  **`Utilisateur`** : Stocke les informations d'authentification et de profil des joueurs (email, pseudo, mot de passe hashé, etc.) [cite: 23-29].
*  **`Jeu`** : Référence les jeux disponibles (pour ce projet, uniquement "Power Of Memory") [cite: 43-45].
*  **`Score`** : Enregistre toutes les parties jouées, avec la difficulté, le score, et l'identifiant du joueur et du jeu [cite: 30-36].
*  **`Message`** : Contient tous les messages du chat général de la plateforme [cite: 37-42].
*  **`Messages_prives`** : Gère les échanges privés entre deux utilisateurs, avec un statut de lecture [cite: 210-219].

---

## 🚀 Fonctionnalités couvertes

 Toutes les requêtes sont commentées et regroupées dans un unique fichier `.sql`[cite: 10]. Elles couvrent les fonctionnalités (User Stories) suivantes :

### 1. Initialisation de la BDD
*  **Création des tables** : Mise en place de la structure complète avec clés primaires et étrangères[cite: 19, 48].
*  **Jeu de données** : Insertion de données de test pour chaque table (`Utilisateur`, `Score`, `Message`, `Jeu`) afin de permettre des tests fonctionnels [cite: 53-61].

### 2. Gestion des utilisateurs (Authentification)
*  **Inscription** : Ajout d'un nouvel utilisateur avec un email et un pseudo uniques[cite: 65, 68, 69].
*  **Connexion** : Vérification des identifiants (email et mot de passe hashé) pour la connexion[cite: 101, 106].
*  **Mise à jour** : Requêtes pour modifier le mot de passe [cite: 83]  ou l'adresse email d'un utilisateur[cite: 92].

### 3. Gestion du jeu et des scores
*  **Enregistrement d'un score** : Insertion d'un nouveau score à la fin d'une partie[cite: 163].
*  **Affichage du tableau des scores** : Requête complexe pour lister les scores en joignant les tables `Utilisateur`, `Score` et `Jeu`[cite: 116, 117].
*  **Filtrage des scores** : Le tableau des scores peut être filtré par nom de jeu et/ou par difficulté [cite: 132-134].
*  **Recherche par pseudo** : Une recherche "LIKE" pour trouver tous les scores d'un joueur en fonction d'une partie de son pseudo[cite: 142, 146].

### 4. Chat général
*  **Envoi de message** : Insertion d'un nouveau message dans le chat global[cite: 172, 175].
*  **Affichage du chat** : Récupération des messages des dernières 24 heures [cite: 196] , triés par ordre chronologique [cite: 187] , avec le pseudo de l'expéditeur [cite: 196]  et une colonne "isSender" pour identifier les messages de l'utilisateur connecté[cite: 193, 197].

### 5. Messagerie privée
*  **Envoi d'un message privé** : Création d'un message entre un expéditeur et un destinataire[cite: 236].
*  **Liste des conversations** : Affichage du dernier message de chaque conversation impliquant l'utilisateur connecté[cite: 245, 251].
*  **Affichage d'une conversation** : Récupération de l'historique complet des messages entre deux utilisateurs, trié par date[cite: 275, 282].

### 6. Statistiques
*  **Stats globales** : Génération d'un tableau de statistiques (Top 3 joueurs, total parties) par mois pour une année donnée (ex: 2025)[cite: 309, 313, 314].
*  **Stats par joueur** : Génération de statistiques (total parties, score moyen) par mois pour un joueur spécifique[cite: 319, 325].