### how to recursively get all elements of a product?
### 1) use meta table (easy way, not regarded)
### 2) use PROCEDURE because recoursion forbidden in MySQL for function/trigger.
###	PS: recursion is limited <1000

CREATE TABLE catalog (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(50) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX UK_catalog_id (id)
)


INSERT INTO catalog(id, name) VALUES
(1, 'build_1');
INSERT INTO catalog(id, name) VALUES
(2, 'part_1');
INSERT INTO catalog(id, name) VALUES
(3, 'roduct_1');
INSERT INTO catalog(id, name) VALUES
(4, 'roduct_2');
INSERT INTO catalog(id, name) VALUES
(5, 'part_2');
INSERT INTO catalog(id, name) VALUES
(6, 'part_3');

### bind table is the catalog's tree relationship table

CREATE TABLE bind (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  child_id int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_bind_catalog_id FOREIGN KEY (parent_id)
  REFERENCES catalog (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_bind_catalog_id2 FOREIGN KEY (child_id)
  REFERENCES catalog (id) ON DELETE NO ACTION ON UPDATE NO ACTION
)

INSERT INTO bind(id, parent_id, child_id) VALUES
(1, 3, 1);
INSERT INTO bind(id, parent_id, child_id) VALUES
(2, 1, 2);
INSERT INTO bind(id, parent_id, child_id) VALUES
(3, 1, 5);
INSERT INTO bind(id, parent_id, child_id) VALUES
(4, 4, 6);
INSERT INTO bind(id, parent_id, child_id) VALUES
(5, 4, 5);
