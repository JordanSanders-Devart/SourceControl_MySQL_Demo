DELIMITER $$

CREATE TRIGGER `del_film`
	AFTER DELETE
	ON film
	FOR EACH ROW
BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END
$$

DELIMITER ;