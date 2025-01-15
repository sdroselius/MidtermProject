-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema piefightdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `piefightdb` ;

-- -----------------------------------------------------
-- Schema piefightdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `piefightdb` DEFAULT CHARACTER SET utf8 ;
USE `piefightdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NULL,
  `role` VARCHAR(45) NULL,
  `create_date` DATETIME NULL,
  `last_update` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pie` ;

CREATE TABLE IF NOT EXISTS `pie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `image_url` VARCHAR(2000) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pie_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pie_type` ;

CREATE TABLE IF NOT EXISTS `pie_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pie_has_pie_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pie_has_pie_type` ;

CREATE TABLE IF NOT EXISTS `pie_has_pie_type` (
  `pie_id` INT NOT NULL,
  `pie_type_id` INT NOT NULL,
  PRIMARY KEY (`pie_id`, `pie_type_id`),
  INDEX `fk_pie_has_pie_type_pie_type1_idx` (`pie_type_id` ASC) VISIBLE,
  INDEX `fk_pie_has_pie_type_pie_idx` (`pie_id` ASC) VISIBLE,
  CONSTRAINT `fk_pie_has_pie_type_pie`
    FOREIGN KEY (`pie_id`)
    REFERENCES `pie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pie_has_pie_type_pie_type1`
    FOREIGN KEY (`pie_type_id`)
    REFERENCES `pie_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe` ;

CREATE TABLE IF NOT EXISTS `recipe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `prep_time_minutes` INT NULL,
  `cook_time_minutes` INT NULL,
  `ingredients` TEXT NULL,
  `instructions` TEXT NULL,
  `user_id` INT NOT NULL,
  `pie_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recipe_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_recipe_pie1_idx` (`pie_id` ASC) VISIBLE,
  CONSTRAINT `fk_recipe_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_pie1`
    FOREIGN KEY (`pie_id`)
    REFERENCES `pie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe_rating` ;

CREATE TABLE IF NOT EXISTS `recipe_rating` (
  `user_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  `rating` INT NULL,
  `remarks` TEXT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`user_id`, `recipe_id`),
  INDEX `fk_user_has_recipe_recipe1_idx` (`recipe_id` ASC) VISIBLE,
  INDEX `fk_user_has_recipe_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_recipe_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_recipe_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe_comment` ;

CREATE TABLE IF NOT EXISTS `recipe_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(45) NULL,
  `create_date` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recipe_comment_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_recipe_comment_recipe1_idx` (`recipe_id` ASC) VISIBLE,
  INDEX `fk_recipe_comment_recipe_comment1_idx` (`in_reply_to_id` ASC) VISIBLE,
  CONSTRAINT `fk_recipe_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_comment_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_comment_recipe_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `recipe_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS piefighter@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'piefighter'@'localhost' IDENTIFIED BY 'piefighter';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'piefighter'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `piefightdb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `create_date`, `last_update`) VALUES (1, 'admin', 'test', 1, 'ADMIN', '2023-03-03', '2023-03-03');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `create_date`, `last_update`) VALUES (2, 'rob', 'test', 1, NULL, '2023-03-03', '2023-03-03');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `create_date`, `last_update`) VALUES (3, 'gina', 'test', 1, NULL, '2023-03-03', '2023-03-03');

COMMIT;


-- -----------------------------------------------------
-- Data for table `pie`
-- -----------------------------------------------------
START TRANSACTION;
USE `piefightdb`;
INSERT INTO `pie` (`id`, `name`, `image_url`, `description`) VALUES (1, 'Apple Pie', NULL, NULL);
INSERT INTO `pie` (`id`, `name`, `image_url`, `description`) VALUES (2, 'Strawberry Rhubarb Pie', NULL, NULL);
INSERT INTO `pie` (`id`, `name`, `image_url`, `description`) VALUES (3, 'Key Lime Pie', NULL, NULL);
INSERT INTO `pie` (`id`, `name`, `image_url`, `description`) VALUES (4, 'Peach Cobbler', NULL, NULL);
INSERT INTO `pie` (`id`, `name`, `image_url`, `description`) VALUES (5, 'Cream Cheese Cake', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pie_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `piefightdb`;
INSERT INTO `pie_type` (`id`, `name`, `description`, `image_url`) VALUES (1, 'Fruit', NULL, NULL);
INSERT INTO `pie_type` (`id`, `name`, `description`, `image_url`) VALUES (2, 'Cream', NULL, NULL);
INSERT INTO `pie_type` (`id`, `name`, `description`, `image_url`) VALUES (3, 'Berry', NULL, NULL);
INSERT INTO `pie_type` (`id`, `name`, `description`, `image_url`) VALUES (4, 'Custard', NULL, NULL);
INSERT INTO `pie_type` (`id`, `name`, `description`, `image_url`) VALUES (5, 'Savory', NULL, NULL);
INSERT INTO `pie_type` (`id`, `name`, `description`, `image_url`) VALUES (6, 'Hand pie', NULL, NULL);
INSERT INTO `pie_type` (`id`, `name`, `description`, `image_url`) VALUES (7, 'Pot Pie', NULL, NULL);
INSERT INTO `pie_type` (`id`, `name`, `description`, `image_url`) VALUES (8, 'Quiche', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pie_has_pie_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `piefightdb`;
INSERT INTO `pie_has_pie_type` (`pie_id`, `pie_type_id`) VALUES (1, 1);
INSERT INTO `pie_has_pie_type` (`pie_id`, `pie_type_id`) VALUES (2, 1);
INSERT INTO `pie_has_pie_type` (`pie_id`, `pie_type_id`) VALUES (3, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `piefightdb`;
INSERT INTO `recipe` (`id`, `name`, `description`, `prep_time_minutes`, `cook_time_minutes`, `ingredients`, `instructions`, `user_id`, `pie_id`, `create_date`, `last_update`) VALUES (1, 'Alton Brown\'s Apple Pie', NULL, NULL, NULL, NULL, NULL, 2, 1, '2024-06-06', '2024-06-06');
INSERT INTO `recipe` (`id`, `name`, `description`, `prep_time_minutes`, `cook_time_minutes`, `ingredients`, `instructions`, `user_id`, `pie_id`, `create_date`, `last_update`) VALUES (2, 'Grammys Strawberry Rhubarb', NULL, NULL, NULL, NULL, NULL, 3, 2, '2024-06-06', '2024-06-06');
INSERT INTO `recipe` (`id`, `name`, `description`, `prep_time_minutes`, `cook_time_minutes`, `ingredients`, `instructions`, `user_id`, `pie_id`, `create_date`, `last_update`) VALUES (3, 'Rob\'s Prizewinning Cheesecake', NULL, NULL, NULL, NULL, NULL, 2, 5, '2024-06-06', '2024-06-06');

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `piefightdb`;
INSERT INTO `recipe_rating` (`user_id`, `recipe_id`, `rating`, `remarks`, `create_date`, `last_update`) VALUES (1, 1, 5, 'Awesome', NULL, NULL);
INSERT INTO `recipe_rating` (`user_id`, `recipe_id`, `rating`, `remarks`, `create_date`, `last_update`) VALUES (1, 2, 3, 'Don\'t like rhubarb', NULL, NULL);
INSERT INTO `recipe_rating` (`user_id`, `recipe_id`, `rating`, `remarks`, `create_date`, `last_update`) VALUES (2, 2, 5, 'Rhubarb rox!!!', NULL, NULL);
INSERT INTO `recipe_rating` (`user_id`, `recipe_id`, `rating`, `remarks`, `create_date`, `last_update`) VALUES (2, 1, 4, 'Nice', NULL, NULL);
INSERT INTO `recipe_rating` (`user_id`, `recipe_id`, `rating`, `remarks`, `create_date`, `last_update`) VALUES (3, 2, 5, 'Yum', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `piefightdb`;
INSERT INTO `recipe_comment` (`id`, `content`, `create_date`, `user_id`, `recipe_id`, `in_reply_to_id`) VALUES (1, 'Warning: pie birds don\'t work', '2024-04-04', 2, 1, NULL);
INSERT INTO `recipe_comment` (`id`, `content`, `create_date`, `user_id`, `recipe_id`, `in_reply_to_id`) VALUES (2, 'I agree', '2024-04-05', 1, 1, 1);
INSERT INTO `recipe_comment` (`id`, `content`, `create_date`, `user_id`, `recipe_id`, `in_reply_to_id`) VALUES (3, 'I can\'t get the topping right', '2024-05-06', 3, 3, NULL);

COMMIT;

