CREATE TABLE `store` (
  `store_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `manager_staff_id` TINYINT UNSIGNED NOT NULL,
  `address_id` SMALLINT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (store_id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb3,
COLLATE utf8mb4_0900_ai_ci;

ALTER TABLE `store` 
  ADD UNIQUE INDEX idx_unique_manager(manager_staff_id);

ALTER TABLE `store` 
  ADD INDEX idx_fk_address_id(address_id);

ALTER TABLE `store` 
  ADD CONSTRAINT `fk_store_address` FOREIGN KEY (address_id)
    REFERENCES address(address_id) ON UPDATE CASCADE;

ALTER TABLE `store` 
  ADD CONSTRAINT `fk_store_staff` FOREIGN KEY (manager_staff_id)
    REFERENCES staff(staff_id) ON UPDATE CASCADE;