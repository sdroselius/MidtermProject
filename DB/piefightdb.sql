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
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `create_date` DATETIME NULL,
  `last_update` VARCHAR(45) NULL,
  `about_me` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
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
  `added_by_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pie_user1_idx` (`added_by_id` ASC) VISIBLE,
  CONSTRAINT `fk_pie_user1`
    FOREIGN KEY (`added_by_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `image_url` VARCHAR(2000) NULL,
  `prep_time_minutes` INT NULL,
  `cook_time_minutes` INT NULL,
  `ingredients` TEXT NULL,
  `instructions` TEXT NULL,
  `user_id` INT NOT NULL,
  `pie_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
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
  `create_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  `enabled` TINYINT NOT NULL,
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
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `create_date`, `last_update`, `about_me`, `image_url`) VALUES (1, 'admin', 'test', 1, 'ADMIN', 'Alex', 'Admin', '2023-03-03', '2023-03-03', 'I am the boss.', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `create_date`, `last_update`, `about_me`, `image_url`) VALUES (2, 'rob', 'test', 1, 'USER', 'Rob', 'Robbleston', '2023-03-03', '2023-03-03', 'Everyone needs a friend. Friends are the most valuable things in the world. Everyone wants to enjoy the good parts - but you have to build the framework first. These things happen automatically. All you have to do is just let them happen. It\'s so important to do something every day that will make you happy. We\'re trying to teach you a technique here and how to use it.\n\nEverything is happy if you choose to make it that way. Didn\'t you know you had that much power? You can move mountains. You can do anything. It\'s beautiful - and we haven\'t even done anything to it yet. I get carried away with this brush cleaning. This is the way you take out your flustrations.', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `create_date`, `last_update`, `about_me`, `image_url`) VALUES (3, 'gina', 'test', 1, 'USER', 'Gina', 'Giraffe', '2023-03-03', '2023-03-03', 'Sugar plum gummi bears pastry jelly gummi bears soufflé biscuit. Cake cheesecake croissant halvah fruitcake. Sugar plum pastry cotton candy marzipan dessert cupcake chupa chups. Powder carrot cake gingerbread candy canes marshmallow soufflé donut. Jujubes topping danish caramels gingerbread caramels. Apple pie wafer sesame snaps sweet roll bonbon chocolate pudding. Chupa chups muffin tart bonbon chocolate bar. Croissant lemon drops jujubes donut chocolate bar lollipop tootsie roll. Halvah carrot cake gummi bears brownie brownie liquorice. Dessert toffee icing pie cookie brownie. Bear claw carrot cake cake danish cake chocolate bar sweet. Biscuit cake soufflé cake chocolate bar cake. Tart tootsie roll dessert carrot cake gingerbread bonbon tart cake. Powder gummi bears carrot cake topping candy fruitcake.', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pie`
-- -----------------------------------------------------
START TRANSACTION;
USE `piefightdb`;
INSERT INTO `pie` (`id`, `name`, `image_url`, `description`, `added_by_id`, `create_date`, `last_update`, `enabled`) VALUES (1, 'Apple Pie', 'https://images.albertsons-media.com/is/image/ABS/960311063?$ng-ecom-pdp-desktop$&defaultImage=Not_Available', NULL, 1, '2022-02-02', '2022-02-02', 1);
INSERT INTO `pie` (`id`, `name`, `image_url`, `description`, `added_by_id`, `create_date`, `last_update`, `enabled`) VALUES (2, 'Strawberry Rhubarb Pie', 'https://goldbelly.imgix.net/uploads/showcase_media_asset/image/90724/rhubarb-pie.9516c50c471c8420823497f064f8cf2b.jpg?ixlib=react-9.9.0&ar=1%3A1&fit=crop&w=2048&auto=format', NULL, 1, '2022-02-02', '2022-02-02', 1);
INSERT INTO `pie` (`id`, `name`, `image_url`, `description`, `added_by_id`, `create_date`, `last_update`, `enabled`) VALUES (3, 'Key Lime Pie', 'https://i.etsystatic.com/53752336/r/il/f0583a/6204378289/il_1588xN.6204378289_48ps.jpg', NULL, 1, '2022-02-02', '2022-02-02', 1);
INSERT INTO `pie` (`id`, `name`, `image_url`, `description`, `added_by_id`, `create_date`, `last_update`, `enabled`) VALUES (4, 'Peach Cobbler', 'https://i.etsystatic.com/19742446/r/il/2a840f/5802025650/il_1588xN.5802025650_ei26.jpg', NULL, 1, '2022-02-02', '2022-02-02', 1);
INSERT INTO `pie` (`id`, `name`, `image_url`, `description`, `added_by_id`, `create_date`, `last_update`, `enabled`) VALUES (5, 'Cream Cheese Cake', 'https://assets.omahasteaks.com/transform/02c1fa30-bcce-465d-a59e-59015d619a97/d_cc_105a?io=transform:fill,width:1086,height:465,gravity:center', NULL, 2, '2022-02-02', '2022-02-02', 1);

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
INSERT INTO `pie_has_pie_type` (`pie_id`, `pie_type_id`) VALUES (3, 1);
INSERT INTO `pie_has_pie_type` (`pie_id`, `pie_type_id`) VALUES (3, 4);
INSERT INTO `pie_has_pie_type` (`pie_id`, `pie_type_id`) VALUES (2, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `piefightdb`;
INSERT INTO `recipe` (`id`, `name`, `description`, `image_url`, `prep_time_minutes`, `cook_time_minutes`, `ingredients`, `instructions`, `user_id`, `pie_id`, `create_date`, `last_update`, `enabled`) VALUES (1, 'Alton Brown\'s Apple Pie', 'I can finally say, after tinkering with my original recipe on and off for a decade, this is the apple pie I want when I want apple pie, a craving that rises constant in me from the first rattle of fall leaves. We\'ve upped the grains of paradise (see note below), traded out the apple cider for apple cider vinegar, and enhanced the texture by inviting liquid pectin to the party, easily found in most mega marts. ', 'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2008/2/4/0/EA1115_Super_Apple_Pie.jpg.rend.hgtvcom.1280.1280.suffix/1371585656805.webp', 150, 70, 'FOR THE CRUST\n2 3/4 cups all-purpose flour, plus extra for dusting\n1 teaspoon kosher salt\n1 tablespoon sugar\n12 tablespoons unsalted butter, cut into 1/2-inch pieces, chilled\n1/4 cup plus 2 teaspoons vegetable shortening, cut into 1/2-inch pieces, chilled\n7 tablespoons Laird\'s Applejack or apple brandy, such as calvados, chilled\nFOR THE FILLING\n4 1/2 pounds (8 large) apples, mix of Pink Lady, Honeycrisp, and Granny Smith\n1/2 cup plus 1 tablespoon sugar, divided\n1/4 cup tapioca flour\n2 tablespoons liquid pectin (we like Certo)\n1 tablespoon apple cider vinegar\n1/4 teaspoon kosher salt\n1 teaspoon freshly ground grains of paradise\nSpecialized Hardware\nFood processor\nDigital kitchen scale\n9 1/2\" x 2\" tart pan with removable bottom (a wonderful multitasker)', 'Crust Procedure:\nCombine the flour, salt, and sugar in the bowl of your food processor and pulse 3-4 times. Add the butter and pulse until texture looks mealy, 5-6 pulses. Then, add the shortening and pulse until incorporated, another 3-4 pulses. Remove the lid and drizzle in 5 tablespoons of the Applejack. Replace the lid and pulse 5 times. Add the remaining Applejack and pulse until the mixture begins to hold together and pull away from the sides of the bowl.\nDump the mixture onto a clean surface and squeeze together with your hands to form a smooth ball. Divide the ball in half and press each into a disk about 1-inch thick. Wrap each dough in plastic wrap and refrigerate for at least 1 hour. (You can refrigerate longer, even overnight, but the dough will have to sit at room temperature for 15 minutes to be malleable enough to roll.\nFilling Procedure:\nPeel, core, and slice the apples into 1/4-inch slices and move to a large mixing bowl. Add 1/4 cup of the sugar and toss with your hands to thoroughly coat. Set aside for 45 minutes, tossing halfway through, then transfer to a colander set over a large bowl and set aside to drain for 45 minutes.\nTransfer the accumulated juices (you should have about 1/4 cup) to a small saucepan and reduce over medium heat to 2 tablespoons, about 3 minutes. Set aside to cool.\nStir the remaining sugar into the apple slices along with the tapioca flour, liquid pectin, apple cider vinegar, salt, and grains of paradise. Set aside.\nAssembly Procedure:\nCrank your oven to 400℉ and move a rack to the lowest position.\nPlace a 12\" x 24\" piece of wax paper on a clean work surface and lightly dust with flour. Remove the dough disks from the refrigerator and allow them to come to room temperature, 15 minutes. Discard the plastic wrap from one and place the dough on the wax paper. Dust with a bit more flour and roll into a 12\" x 12\" circle. Carefully peel the wax paper off and place the dough into the tart pan, gently pressing it into the edges. (See the note on dough movement below).\nArrange the apples in the bottom of the pan in concentric circles starting around the edges, working toward the center, which will result in a slight mound shape. Pour any remaining liquid evenly over the apples.\nRoll out the second dough disk in the same manner as the first. Place this dough over the apples and seal the edges of the pie, trimming any excess dough. Make a few slits in the top of the crust with a paring knife to give steam a way out. Park the pie on a foil-lined sheet pan and brush the top of the crust with the reduced juice. Bake for 1 hour, 10 minutes.\nTransfer the pie to a cooling rack and rest for at least 4 hours before removing from the tart pan and slicing.\nNote regarding Grains of Paradise: Aframomum melegueta is a cousin of ginger and its seeds are known as \"grains of paradise.\" I have absolutely no idea why this spice is not more popular, because when crushed, the seeds deliver a spectacular complexity, a mingling of black pepper, lemon, cardamom, and something that reminds me of brown butter. Although GoP is welcomed on many a meat dish, it\'s on fruit that I really read the magic. This pie, is not this pie without this spice. You won\'t find it at the mega mart but it can be found online from sources such as spicehouse.com.\nNote on dough movement: I\'m really bad at moving doughs once they\'re rolled, and my hands run hot so here\'s how I roll...so to speak: After rolling out the dough, I slide a cookie sheet under it. I position the flat, removable bottom of the tart pan and center it on the dough. While holding the round in place, I flip the whole thing over, remove the cookie sheet, and peel the wax paper away, leaving the dough atop the round. (You can\'t see the round at this point because the dough is wider.) I then gently fold back the edges of the dough so that the edge of the round is revealed. I then slide the round off the counter and drop it into the tart pan. Finally, I unfold the edge of the dough and mold it into the sides of the pan. Make sense? I sure hope so.', 2, 1, '2024-06-06', '2024-06-06', 1);
INSERT INTO `recipe` (`id`, `name`, `description`, `image_url`, `prep_time_minutes`, `cook_time_minutes`, `ingredients`, `instructions`, `user_id`, `pie_id`, `create_date`, `last_update`, `enabled`) VALUES (2, 'Grammys Strawberry Rhubarb', NULL, 'https://houseofnasheats.com/wp-content/uploads/2021/11/Strawberry-Rhubarb-Pie-Square-1.jpg', NULL, NULL, NULL, NULL, 3, 2, '2024-06-06', '2024-06-06', 1);
INSERT INTO `recipe` (`id`, `name`, `description`, `image_url`, `prep_time_minutes`, `cook_time_minutes`, `ingredients`, `instructions`, `user_id`, `pie_id`, `create_date`, `last_update`, `enabled`) VALUES (3, 'Rob\'s Prizewinning Cheesecake', NULL, 'https://media.bergdorfgoodman.com/f_auto,q_auto:low,ar_5:7,c_fill,dpr_2.0,w_720/01/bg_3449901_100000_m', NULL, NULL, NULL, NULL, 2, 5, '2024-06-06', '2024-06-06', 1);
INSERT INTO `recipe` (`id`, `name`, `description`, `image_url`, `prep_time_minutes`, `cook_time_minutes`, `ingredients`, `instructions`, `user_id`, `pie_id`, `create_date`, `last_update`, `enabled`) VALUES (4, 'Marie Callendar Dutch Apple Pie', 'Easy', 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcThP_Q3aT0lhTQx87qnh0AzHYkzUJh2ksoL1GdNqSarK38KCbkkJGjdxIfx2EVInMrj7z_K_O4QgdLlB0Tab1nvEiIxutJg', 0, 30, 'Money', 'Stop by Safeway.  Buy pie. Follow instructions.', 3, 1, '2024-07-07', '2024-07-07', 1);

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
INSERT INTO `recipe_comment` (`id`, `content`, `create_date`, `user_id`, `recipe_id`, `in_reply_to_id`, `enabled`) VALUES (1, 'Warning: pie birds don\'t work', '2024-04-04', 2, 1, NULL, 1);
INSERT INTO `recipe_comment` (`id`, `content`, `create_date`, `user_id`, `recipe_id`, `in_reply_to_id`, `enabled`) VALUES (2, 'I agree', '2024-04-05', 1, 1, 1, 1);
INSERT INTO `recipe_comment` (`id`, `content`, `create_date`, `user_id`, `recipe_id`, `in_reply_to_id`, `enabled`) VALUES (3, 'I can\'t get the topping right', '2024-05-06', 3, 3, NULL, 1);

COMMIT;

