DELIMITER $$

CREATE FUNCTION `inventory_in_stock`(p_inventory_id int)
  RETURNS TINYINT(1)
  READS SQL DATA
BEGIN
  DECLARE v_rentals int;
  DECLARE v_out int;




  SELECT
    COUNT(*) INTO v_rentals
  FROM rental
  WHERE inventory_id = p_inventory_id;

  IF v_rentals = 0 THEN
    RETURN TRUE;
  END IF;

  SELECT
    COUNT(rental_id) INTO v_out
  FROM inventory
    LEFT JOIN rental USING (inventory_id)
  WHERE inventory.inventory_id = p_inventory_id
  AND rental.return_date IS NULL;

  IF v_out > 0 THEN
    RETURN FALSE;
  ELSE
    RETURN TRUE;
  END IF;
END
$$

DELIMITER ;