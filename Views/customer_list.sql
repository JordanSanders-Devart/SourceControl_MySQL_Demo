CREATE VIEW `customer_list`
AS
	SELECT
	  `cu`.`customer_id` AS `ID`,
	  CONCAT(`cu`.`first_name`, _utf8mb4 ' ', `cu`.`last_name`) AS `name`,
	  `a`.`address` AS `address`,
	  `a`.`postal_code` AS `zip code`,
	  `a`.`phone` AS `phone`,
	  `city`.`city` AS `city`,
	  `country`.`country` AS `country`,
	  IF(`cu`.`active`, _utf8mb4 'active', _utf8mb4 '') AS `notes`,
	  `cu`.`store_id` AS `SID`
	FROM (((`customer` `cu`
	  JOIN `address` `a`
	    ON ((`cu`.`address_id` = `a`.`address_id`)))
	  JOIN `city`
	    ON ((`a`.`city_id` = `city`.`city_id`)))
	  JOIN `country`
	    ON ((`city`.`country_id` = `country`.`country_id`)));