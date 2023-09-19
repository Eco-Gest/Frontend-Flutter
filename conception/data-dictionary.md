
# DICTIONNAIRE DES DONNEES   


| user                     |              |                                     |             |
| ------------------------ | ------------ | ----------------------------------- | ----------- |
| Champ                    | Type         | Spécificités                        | Description |
| id                       | INTEGER      | PRIMARY KEY, NOT NULL               | L’identifiant de l'utilisateur       |
| badge_id                 | INTEGER      | NOT NULL, DEFAULT 1, FOREIGN KEY    | Le badge de l'utilisateur            |
| email                    | VARCHAR(64)  | NOT NULL                            | L'email de l'utilisateur             |
| password                 | VARCHAR(64)  | NOT NULL                            | Le mot de passe de l'utilisateur (crypté)    |
| username                 | VARCHAR(64)  | NULL                                | Le pseudo de l'utilisateur           |
| image                    | VARCHAR(128) | NULL                                | L'url de l'image de l'utilisateur             |
| birthdate                | DATETIME     | NULL                                | La date de naissance de l'utilisateur|
| biography                | TEXT         | NULL                                | Le texte de présentation de l'utilisateur|
| position                 | VARCHAR(64)  | NULL                                |  L'emplacement (ville, pays) de l'utilisateur |
| is_private               | BOOLEAN      | NOT NULL, DEFAULT FALSE             | La visibilité du profil |
| created_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Date de création de l'utilisateur |
| updated_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Date de mise à jour de l'utilisateur |

| category                 |              |                                     |             |
| ------------------------ | ------------ | ----------------------------------- | ----------- |
| Champ                    | Type         | Spécificités                        | Description |
| id                       | INTEGER      | PRIMARY KEY, NOT NULL               | L’identifiant de la catégorie |
| title                    | DATETIME     | NULL                                | Le titre de la de la catégorie |
| image                    | VARCHAR(128) | NULL                                | L'url de l'image de la catégorie |
| created_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Date de création de la catégorie |
| updated_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Date de mise à jour de la catégorie  |

| post                     |              |                                     |             |
| ------------------------ | ------------ | ----------------------------------- | ----------- |
| Champ                    | Type         | Spécificités                        | Description |
| id                       | INTEGER      | PRIMARY KEY, NOT NULL               | L'identifiant de la publication|
| category_id              | INTEGER      | NOT NULL, FOREIGN KEY               | L'identifiant de la catégorie de la publication|
| author_id                | INTEGER      | NOT NULL, FOREIGN KEY               | L'identifiant de l'auteur de la publication |
| tag                      | TEXT [ ]     | NULL                                | Les mots-clés de la publication |
| like                     | INTEGER [ ]  | NULL                                | Le nombre d'intéractions "j'aime" de la publication|
| title                    | VARCHAR(64)  | NULL                                | Le titre de la publication |
| description              | TEXT         | NULL                                | La description de la publication |
| image                    | VARCHAR(128) | NULL                                | L'url de l'image de la publication |
| position                 | BOOLEAN      | NULL                                | L'emplacement (ville, pays) pour la publication|
| type                     | ENUM         | NOT NULL                            | Le type de publication challenge ou défi |
| level                    | ENUM         | NOT NULL                            | Le niveau de difficulté du challenge, défi |
| start_date               | DATE         | NULL                                | La date de début du challenge |
| end_date                 | DATE         | NULL                                | La date de fin du challenge  |
| created_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | La date de creation de |
| updated_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | La date de mise à jour de |

| comment                  |              |                                     |             |
| ------------------------ | ------------ | ----------------------------------- | ----------- |
| Champ                    | Type         | Spécificités                        | Description |
| id                       | INTEGER      | PRIMARY KEY, NOT NULL               | L'identifiant du commentaire |
| author_id                | INTEGER      | NOT NULL, FOREIGN KEY               | L'identifiant de l'auteur du commentaire |
| post_id                  | INTEGER      | NOT NULL, FOREIGN KEY               | L'identifiant de la publication du commentaire  |
| content                  | TEXT         | NULL                                | Le contenu du commentaire |
| created_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | La date de creation du commentaire |
| updated_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | La date de mise à jour du commentaire |

| reward                   |              |                                     |             |
| ------------------------ | ------------ | ----------------------------------- | ----------- |
| Champ                    | Type         | Spécificités                        | Description |
| id                       | INTEGER      | PRIMARY KEY, NOT NULL               | L'identifiant de la récompense |
| title                    | VARCHAR(64)  | NULL                                | Le nom du trophée ou du badge |
| image                    | VARCHAR(128) | NULL                                | L'url de l'image du trophée ou du badge |
| type                     | ENUM         | NOT NULL                            | Le type de récompense badge ou trophee |
| point                    | INTEGER      | NULL                                | Le nombre de point seuil pour obtenir la récompense |
| created_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | La date de creation de la récompense |
| updated_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | La date de mise à jour de la récompense |

| notification             |              |                                     |             |
| ------------------------ | ------------ | ----------------------------------- | ----------- |
| Champ                    | Type         | Spécificités                        | Description |
| id                       | INTEGER      | PRIMARY KEY, NOT NULL               | L'identifiant de la notification |
| title                    | VARCHAR(64)  | NULL                                | Le titre de la notification |
| content                  | TEXT         | NULL                                | Le contenu de la notification |
| created_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | La date de creation de la notification |
| updated_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | La date de mise à jour de la notification |
