
# DICTIONNAIRE DES DONNEES   


| user                     |              |                                     |             |
| ------------------------ | ------------ | ----------------------------------- | ----------- |
| Champ                    | Type         | Spécificités                        | Description |
| id                       | INTEGER      | PRIMARY KEY, NOT NULL               |             |
| badge_id                 | INTEGER      | NOT NULL, DEFAULT 1, FOREIGN KEY    |             |
| email                    | VARCHAR(64)  | NOT NULL                            |             |
| password                 | VARCHAR(64)  | NOT NULL                            |             |
| username                 | VARCHAR(64)  | NULL                                |             |
| image                    | VARCHAR(128) | NULL                                |             |
| birthdate                | DATETIME     | NULL                                |             |
| biography                | TEXT         | NULL                                |             |
| position                 | VARCHAR(64)  | NULL                                |             |
| is_private               | BOOLEAN      | NOT NULL, DEFAULT FALSE             |             |
| created_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP |             |
| updated_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP |             |

| category                 |              |                                     |             |
| ------------------------ | ------------ | ----------------------------------- | ----------- |
| Champ                    | Type         | Spécificités                        | Description |
| id                       | INTEGER      | PRIMARY KEY, NOT NULL               |             |
| title                    | DATETIME     | NULL                                |             |
| image                    | VARCHAR(128) | NULL                                |             |
| created_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP |             |
| updated_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP |             |

| post                     |              |                                     |             |
| ------------------------ | ------------ | ----------------------------------- | ----------- |
| Champ                    | Type         | Spécificités                        | Description |
| id                       | INTEGER      | PRIMARY KEY, NOT NULL               |             |
| category_id              | INTEGER      | NOT NULL, FOREIGN KEY               |             |
| author_id                | INTEGER      | NOT NULL, FOREIGN KEY               |             |
| tag                      | TEXT [ ]     | NULL                                |             |
| like                     | INTEGER [ ]  | NULL                                |             |
| title                    | DATETIME     | NULL                                |             |
| description              | TEXT         | NULL                                |             |
| image                    | VARCHAR(128) | NULL                                |             |
| position                 | BOOLEAN      | NULL                                |             |
| start_date               | DATE         | NULL                                |             |
| end_date                 | DATE         | NULL                                |             |
| created_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP |             |
| updated_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP |             |

| comment                  |              |                                     |             |
| ------------------------ | ------------ | ----------------------------------- | ----------- |
| Champ                    | Type         | Spécificités                        | Description |
| id                       | INTEGER      | PRIMARY KEY, NOT NULL               |             |
| author_id                | INTEGER      | NOT NULL, FOREIGN KEY               |             |
| post_id                  | INTEGER      | NOT NULL, FOREIGN KEY               |             |
| content                  | TEXT         | NULL                                |             |
| created_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP |             |
| updated_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP |             |

| reward                   |              |                                     |             |
| ------------------------ | ------------ | ----------------------------------- | ----------- |
| Champ                    | Type         | Spécificités                        | Description |
| id                       | INTEGER      | PRIMARY KEY, NOT NULL               |             |
| title                    | VARCHAR(64)  | NULL                                |             |
| image                    | VARCHAR(128) | NULL                                |             |
| type                     | ENUM         | NOT NULL                            |             |
| point                    | INTEGER      | NULL                                |             |
| created_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP |             |
| updated_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP |             |

| notification             |              |                                     |             |
| ------------------------ | ------------ | ----------------------------------- | ----------- |
| Champ                    | Type         | Spécificités                        | Description |
| id                       | INTEGER      | PRIMARY KEY, NOT NULL               |             |
| title                    | VARCHAR(64)  | NULL                                |             |
| content                  | TEXT         | NULL                                |             |
| created_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP |             |
| updated_at               | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP |             |
