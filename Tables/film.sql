CREATE TABLE `film` (
  `film_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT DEFAULT NULL,
  `release_year` YEAR DEFAULT NULL,
  `language_id` TINYINT UNSIGNED NOT NULL,
  `original_language_id` TINYINT UNSIGNED DEFAULT NULL,
  `rental_duration` TINYINT UNSIGNED NOT NULL DEFAULT 3,
  `rental_rate` DECIMAL(4, 2) NOT NULL DEFAULT 4.99,
  `length` SMALLINT UNSIGNED DEFAULT NULL,
  `replacement_cost` DECIMAL(5, 2) NOT NULL DEFAULT 19.99,
  `rating` ENUM('G','PG','PG-13','R','NC-17') DEFAULT 'G',
  `special_features` SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (film_id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb4_0900_ai_ci;

ALTER TABLE `film` 
  ADD INDEX idx_title(title);

ALTER TABLE `film` 
  ADD INDEX idx_fk_language_id(language_id);

ALTER TABLE `film` 
  ADD INDEX idx_fk_original_language_id(original_language_id);

ALTER TABLE `film` 
  ADD CONSTRAINT `fk_film_language` FOREIGN KEY (language_id)
    REFERENCES language(language_id) ON UPDATE CASCADE;

ALTER TABLE `film` 
  ADD CONSTRAINT `fk_film_language_original` FOREIGN KEY (original_language_id)
    REFERENCES language(language_id) ON UPDATE CASCADE;