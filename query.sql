### how to recursively get all elements of a product?
### 1) use meta table (easy way, not regarded)
### 2) use PROCEDURE because recoursion forbidden in MySQL for function/trigger.
###	PS: recursion is limited <1000

#USE your_db_name;

DELIMITER $$
DROP PROCEDURE IF EXISTS `get_children`;
CREATE PROCEDURE `get_children`(IN PNAME text)
READS SQL DATA
BEGIN
  /* We'll save data in "child_name" variable */
  DECLARE child_name text;
  /* handler declaration*/
  DECLARE eol BOOLEAN;
  /* cursor declaration */
  DECLARE csr CURSOR FOR SELECT c.name FROM bind b 
    LEFT JOIN catalog c ON b.child_id = c.id
    LEFT JOIN(SELECT c.name AS subname, b.id FROM bind b, catalog c WHERE c.id= b.parent_id) AS s ON s.id = b.id
    WHERE s.subname = PNAME AND b.child_id IS NOT NULL;
  /* QUIT HANDLER*/
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET eol = TRUE;
  /* set limit */
  SET max_sp_recursion_depth=1000;
  /* open cursor */
  OPEN csr;
  /* extract data */
    my_loop: LOOP
        FETCH csr INTO child_name;
        IF eol 
            THEN
            /* close cursor */
            CLOSE csr;
            LEAVE my_loop;
        ELSE
            CALL get_children(child_name);
        END IF;

        SELECT child_name;

    END LOOP my_loop;
END $$

CALL get_children('product_1');
