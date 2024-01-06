**Rapport de Projet - Carnet de Voyages**
**Audran MASSACRY**

**Étape 1 : Initialisation du Projet**

La première phase du projet a consisté à mettre en place l'infrastructure de l'application, notamment la création de l'application, des modèles User et Trip, ainsi que l'établissement d'une relation one-to-many entre ces deux entités. Les actions clés ont été réalisées à l'aide de commandes Rails.

1.1 **Création de l'Application et des Modèles**

L'application a été créée avec la commande :

`rails new Le_Carnet_de_Voyages -c tailwind -d postgresql`

Cette commande a non seulement initié l'application, mais a également intégré le framework CSS Tailwind et choisi PostgreSQL comme système de gestion de base de données.

Les modèles User et Trip ont été créés ensuite avec les commandes respectives :

`rails g model User nom:string email:string`
`rails g model Trip destination:string description:text date_debut:date date_fin:date`

Ces commandes ont généré les fichiers nécessaires pour les modèles, définissant les attributs tels que le nom et l'email pour User, et destination, description, date de début et de fin pour Trip.

1.2 **Établissement de la Relation One-to-Many**

Pour établir une relation one-to-many entre User et Trip, une référence (clé étrangère) a été ajoutée dans le modèle Trip à l'aide des commandes :

`rails generate migration AddIdUserToTrips user:references`
`rails db:migrate`

Ces commandes ont créé une migration pour ajouter une référence à User dans le modèle Trip, et ont migré la base de données pour appliquer ces changements. En complément, la déclaration `has_many :trips` a été ajoutée dans le modèle User (`user.rb`) pour formaliser la relation.

**Étape 2 : Génération des Routes et des Contrôleurs**

2.1 **Génération des Routes**

Les routes nécessaires au projet ont été générées en ajoutant les lignes suivantes dans le fichier `routes.rb` :

`resources :users`
`resources :trips`

Ces lignes ont configuré les routes RESTful pour les modèles User et Trip, facilitant ainsi l'accès aux différentes actions nécessaires.

2.2 **Génération des Contrôleurs**

Les contrôleurs pour les deux modèles ont été générés avec les commandes :

`rails generate controller Users`
`rails generate controller Trips`

Cette étape a été cruciale pour mettre en place la logique de contrôle nécessaire à la gestion des utilisateurs et des voyages.

2.3 **Structure des Contrôleurs**

Les contrôleurs suivent une structure similaire pour les deux modèles. Le filtre `before_action` est utilisé pour exécuter la méthode privée (`set_user` pour le contrôleur User) avant toute autre action. Cela garantit la disponibilité de la variable d'instance `@user` pour les actions concernées.

Les principales actions incluses dans chaque contrôleur sont les suivantes :

- **Index**: Récupère toutes les données et les assigne à une variable d'instance pour l'affichage global.
- **Show**: Affiche les détails liés à un identifiant spécifique, généralement défini dans l'URL.
- **New**: Associé à la création d'un nouvel utilisateur ou voyage, avec l'initialisation d'une nouvelle instance de l'objet associé au modèle.
- **Create**: Crée une nouvelle donnée en utilisant les paramètres de la méthode privée (`user_params` dans le contrôleur User). En cas de succès, une redirection vers la page de l'action `show` est effectuée.
- **Edit**: Affiche le formulaire de modification des détails d'un utilisateur ou d'un voyage.
- **Update**: Réalise une opération similaire à `create` mais permet la modification des données existantes.
- **Destroy**: Permet la suppression d'un groupe de données. En cas de réussite, la redirection se fait vers la page index.

**Pages du projet**

Quatre pages principales ont été créées pour permettre l'affichage global (`index.html.erb`), l'affichage détaillé (`show.html.erb`), la création (`new.html.erb`), et la modification (`edit.html.erb`) des données.

**_Formulaire_**

Afin d'éviter d'écrire deux fois le même code pour les formulaires, j'ai ajouté le fichier `_form.html.erb`. Cette façon de faire me permet de créer un formulaire unique que j'appelle sur les fichier `edit.html.erb` et `new.html.erb`.

Dans le fichier `_form.html.erb`, je génère un formulaire rails en l'associant à un modèle. Le paramètre `local: true` signifie que le formulaire sera soumis sans rechargement de page.

Dans le cas du formulaire pour le modèle User :
`<%= form_with(model: @user, local: true) do |form| %>`

Afin d'avoir le formulaire le plus complet, j'ai ajouté un système d'erreurs qui affiche l'ensemble des erreurs sous forme de liste. Cela permet ainsi d'aiguiller plus facilement l'utilisateur sur les erreurs qu'il a commis.

Le formulaire des voyages possède un champ select peuplé par les utilisateurs. Il permet d'attribuer un voyage à un utilisateur. Le code est donné par :
`<%= form.collection_select :user_id, User.all, :id, :nom, prompt: "Sélectionnez un utilisateur" %>`

**_Action sur les pages d'affichage_**

Sur l'ensemble des pages, 3 actions peuvent être trouvées :

- un bouton sous forme d'ancre `<a>` avec une redirection vers la page `show.html.erb` (dans le cas du modèle User : `<%= link_to 'Voir', user_path(user), class: 'btn btn-primary' %>`)
- un bouton de suppression sous forme de formulaire POST (dans le cas du modèle User : `<%= button_to "Supprimer", { controller: :users, action: 'destroy', id: user.id }, method: :delete, data: { confirm: 'Êtes-vous sûr?' }, class: 'btn btn-danger' %>`).
- un bouton d'annulation dans les pages de formulaire pour revenir à la page précédente (dans le cas du modèle User : `<%= link_to 'Annuler', users_path, class: 'btn btn-danger' %>`).

Le bouton de suppression dispose d'une boite de dialogue pour confirmer la suppression (donné par le code `data: { confirm: 'Êtes-vous sûr?' }`). Le but est alors de prévenir l'utilisateur qu'il est sur le point d'effectuer une action irréversible. Néanmoins, malgré des recherches sur internet, je n'ai pas su faire fonctionner l'ensemble pour l'afficher.

**_Style_**

Le style du projet a été fait sur le fichier `users.css`. L'application du style sur l'ensemble du pojet se fait via le fichier `application.html.erb` avec le code suivant :
`<%= stylesheet_link_tag 'application', 'users', media: 'all', 'data-turbolinks-track': 'reload' %>`

**Conclusion**

Pendant ce projet, j'ai pu découvrir une partie de ce que propose le framework Rails. Avec une syntaxe assez simple, Rails permet un développement fluide avec une facilité de compréhension. Il favorise ainsi la création de composants réutilisables (comme c'est le cas avec les formulaires). Sa configuration rapide permet aussi de se concentrer principalement sur le développement des fonctionnalités. Sa ressemblance avec d'autres langages de programmation m'a également permis d'avancer rapidement dans le développement du projet.
