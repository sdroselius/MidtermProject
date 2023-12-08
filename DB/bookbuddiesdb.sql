
DROP DATABASE IF EXISTS bookbuddiesdb;
CREATE DATABASE IF NOT EXISTS bookbuddiesdb;

USE bookbuddiesdb;

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(45) NOT NULL,
  password VARCHAR(45) NOT NULL,
  enabled TINYINT,
  role VARCHAR(45)
);

DROP USER IF EXISTS bookworm@localhost;
CREATE USER IF NOT EXISTS bookworm@localhost IDENTIFIED BY 'bookworm';
GRANT SELECT,INSERT,UPDATE,DELETE ON bookbuddiesdb.* TO bookworm@localhost;

INSERT INTO user (id, username, password, enabled, role) VALUES (1, 'admin', 'test',1,'ADMIN');
