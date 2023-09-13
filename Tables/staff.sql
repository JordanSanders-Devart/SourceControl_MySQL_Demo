CREATE TABLE `staff` (
  `staff_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address_id` SMALLINT UNSIGNED NOT NULL,
  `picture` BLOB DEFAULT NULL,
  `email` VARCHAR(50) DEFAULT NULL,
  `store_id` TINYINT UNSIGNED NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  `username` VARCHAR(16) NOT NULL,
  `password` VARCHAR(40) BINARY CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (staff_id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb4_0900_ai_ci;

ALTER TABLE `staff` 
  ADD INDEX idx_fk_store_id(store_id);

ALTER TABLE `staff` 
  ADD INDEX idx_fk_address_id(address_id);

ALTER TABLE `staff` 
  ADD CONSTRAINT `fk_staff_address` FOREIGN KEY (address_id)
    REFERENCES address(address_id) ON UPDATE CASCADE;

ALTER TABLE `staff` 
  ADD CONSTRAINT `fk_staff_store` FOREIGN KEY (store_id)
    REFERENCES store(store_id) ON UPDATE CASCADE;