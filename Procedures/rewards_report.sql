DELIMITER $$

CREATE PROCEDURE `rewards_report`(IN min_monthly_purchases tinyint UNSIGNED
, IN min_dollar_amount_purchased decimal(10, 2) UNSIGNED
, OUT count_rewardees int)
  READS SQL DATA
  COMMENT 'Provides a customizable report on best customers'
proc:
  BEGIN

    DECLARE last_month_start date;
    DECLARE last_month_end date;


    IF min_monthly_purchases = 0 THEN
      SELECT
        'Minimum monthly purchases parameter must be > 0';
      LEAVE proc;
    END IF;
    IF min_dollar_amount_purchased = 0.00 THEN
      SELECT
        'Minimum monthly dollar amount purchased parameter must be > $0.00';
      LEAVE proc;
    END IF;


    SET last_month_start = DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH);
    SET last_month_start = STR_TO_DATE(CONCAT(YEAR(last_month_start), '-', MONTH(last_month_start), '-01'), '%Y-%m-%d');
    SET last_month_end = LAST_DAY(last_month_start);


    CREATE TEMPORARY TABLE tmpCustomer (
      customer_id smallint UNSIGNED NOT NULL PRIMARY KEY
    );


    INSERT INTO tmpCustomer (customer_id)
      SELECT
        p.customer_id
      FROM payment AS p
      WHERE DATE(p.payment_date) BETWEEN last_month_start AND last_month_end
      GROUP BY customer_id
      HAVING SUM(p.amount) > min_dollar_amount_purchased
      AND COUNT(customer_id) > min_monthly_purchases;


    SELECT
      COUNT(*)
    FROM tmpCustomer INTO count_rewardees;


    SELECT
      c.*
    FROM tmpCustomer AS t
      INNER JOIN customer AS c
        ON t.customer_id = c.customer_id;


    DROP TABLE tmpCustomer;
  END
$$

DELIMITER ;