-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema zootinderdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `zootinderdb` ;

-- -----------------------------------------------------
-- Schema zootinderdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zootinderdb` DEFAULT CHARACTER SET utf8 ;
USE `zootinderdb` ;

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
  `image_url` VARCHAR(2000) NULL,
  `about_me` TEXT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `species`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `species` ;

CREATE TABLE IF NOT EXISTS `species` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `common_name` VARCHAR(100) NULL,
  `genus` VARCHAR(45) NULL,
  `species` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zoo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `zoo` ;

CREATE TABLE IF NOT EXISTS `zoo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  `street` VARCHAR(100) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `postal_code` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_zoo_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_zoo_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `animal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `animal` ;

CREATE TABLE IF NOT EXISTS `animal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `species_id` INT NOT NULL,
  `zoo_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `date_of_birth` DATE NULL,
  `biography` TEXT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_animal_species_idx` (`species_id` ASC) VISIBLE,
  INDEX `fk_animal_zoo1_idx` (`zoo_id` ASC) VISIBLE,
  CONSTRAINT `fk_animal_species`
    FOREIGN KEY (`species_id`)
    REFERENCES `species` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_animal_zoo1`
    FOREIGN KEY (`zoo_id`)
    REFERENCES `zoo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS zootinderuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'zootinderuser'@'localhost' IDENTIFIED BY 'zootinderuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'zootinderuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `zootinderdb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `about_me`, `create_date`, `last_update`) VALUES (1, 'admin', 'test', 1, 'ADMIN', NULL, NULL, NULL, NULL, '2025-03-03', '2025-03-03');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `about_me`, `create_date`, `last_update`) VALUES (2, 'denzoo', 'test', 1, NULL, 'Dennie', 'Vernon', 'https://m.media-amazon.com/images/M/MV5BMTYwOTgwODcxNV5BMl5BanBnXkFtZTcwMTQwOTE2NQ@@._V1_.jpg', 'Blah blah blah.', '2025-04-04', '2025-04-04');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `about_me`, `create_date`, `last_update`) VALUES (3, 'cheyenne', 'test', 1, NULL, 'Shay', 'Monty', 'https://www.okczoo.org/assets/2294/67216844_1083217375399591_6576565743108751360_n.jpg', NULL, '2025-05-05', '2025-05-05');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `image_url`, `about_me`, `create_date`, `last_update`) VALUES (4, 'wilder', 'test', 1, NULL, 'Annie', 'Sanctum', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrT2D2w3LkS1wH7E6ENhlrhCFOBiSNUM9E3Q&s', NULL, '2025-05-05', '2025-05-05');

COMMIT;


-- -----------------------------------------------------
-- Data for table `species`
-- -----------------------------------------------------
START TRANSACTION;
USE `zootinderdb`;
INSERT INTO `species` (`id`, `common_name`, `genus`, `species`, `description`, `image_url`) VALUES (1, 'Giraffe', 'Giraffa', 'camelopardus', 'The giraffe is a large African hoofed mammal belonging to the genus Giraffa. It is the tallest living terrestrial animal and the largest ruminant on Earth. Traditionally, giraffes have been thought of as one species, Giraffa camelopardalis, with nine subspecies. Most recently, researchers proposed dividing them into four extant species due to new research into their mitochondrial and nuclear DNA, and individual species can be distinguished by their fur coat patterns. Six valid extinct species of Giraffa from Africa and Pakistan are known from the fossil record.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Giraffe_Mikumi_National_Park.jpg/500px-Giraffe_Mikumi_National_Park.jpg');
INSERT INTO `species` (`id`, `common_name`, `genus`, `species`, `description`, `image_url`) VALUES (2, 'Llama', 'Llama', 'glama', 'Llamas are social animals and live with others as a herd. Their wool is soft and contains only a small amount of lanolin.[2] Llamas can learn simple tasks after a few repetitions. When using a pack, they can carry about 25 to 30% of their body weight for 8 to 13 km (5–8 miles).[3] The name llama (also historically spelled \"lama\" or \"glama\") was adopted by European settlers from native Peruvians.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Llamas%2C_Vernagt-Stausee%2C_Italy.jpg/500px-Llamas%2C_Vernagt-Stausee%2C_Italy.jpg');
INSERT INTO `species` (`id`, `common_name`, `genus`, `species`, `description`, `image_url`) VALUES (3, 'Wolf', 'Canis', 'lupus', 'The wolf (Canis lupus;[b] pl.: wolves), also known as the grey wolf or gray wolf, is a canine native to Eurasia and North America. More than thirty subspecies of Canis lupus have been recognized, including the dog and dingo, though grey wolves, as popularly understood, only comprise naturally-occurring wild subspecies. The wolf is the largest wild extant member of the family Canidae, and is further distinguished from other Canis species by its less pointed ears and muzzle, as well as a shorter torso and a longer tail. The wolf is nonetheless related closely enough to smaller Canis species, such as the coyote and the golden jackal, to produce fertile hybrids with them. The wolf\'s fur is usually mottled white, brown, grey, and black, although subspecies in the arctic region may be nearly all white.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Eurasian_wolf_2.jpg/500px-Eurasian_wolf_2.jpg');
INSERT INTO `species` (`id`, `common_name`, `genus`, `species`, `description`, `image_url`) VALUES (4, 'Zebra', 'Equus', 'zebra', 'Zebras are primarily grazers and can subsist on lower-quality vegetation. They are preyed on mainly by lions, and typically flee when threatened but also bite and kick. Zebra species differ in social behaviour, with plains and mountain zebra living in stable harems consisting of an adult male or stallion, several adult females or mares, and their young or foals; while Grévy\'s zebra live alone or in loosely associated herds. In harem-holding species, adult females mate only with their harem stallion, while male Grévy\'s zebras establish territories which attract females and the species is polygynandrous. Zebras communicate with various vocalisations, body postures and facial expressions. Social grooming strengthens social bonds in plains and mountain zebras.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Plains_Zebra_Equus_quagga_cropped.jpg/500px-Plains_Zebra_Equus_quagga_cropped.jpg');
INSERT INTO `species` (`id`, `common_name`, `genus`, `species`, `description`, `image_url`) VALUES (5, 'Hippopotamus', 'Hippopotamus', 'amphibius', 'After elephants and rhinoceroses, the hippopotamus is the next largest land mammal. It is also the largest extant land artiodactyl. Despite their physical resemblance to pigs and other terrestrial even-toed ungulates, the closest living relatives of the hippopotamids are cetaceans (whales, dolphins, porpoises, etc.), from which they diverged about 55 million years ago. Hippos are recognisable for their barrel-shaped torsos, wide-opening mouths with large canine tusks, nearly hairless bodies, pillar-like legs, and large size: adults average 1,500 kg (3,300 lb) for bulls (males) and 1,300 kg (2,900 lb) for cows (females).', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Portrait_Hippopotamus_in_the_water.jpg/500px-Portrait_Hippopotamus_in_the_water.jpg');
INSERT INTO `species` (`id`, `common_name`, `genus`, `species`, `description`, `image_url`) VALUES (6, 'Lion', 'Panthera', 'leo', 'The lion (Panthera leo) is a large cat of the genus Panthera, native to Sub-Saharan Africa and India. It has a muscular, broad-chested body; a short, rounded head; round ears; and a dark, hairy tuft at the tip of its tail. It is sexually dimorphic; adult male lions are larger than females and have a prominent mane. It is a social species, forming groups called prides. A lion\'s pride consists of a few adult males, related females, and cubs. Groups of female lions usually hunt together, preying mostly on medium-sized and large ungulates. The lion is an apex and keystone predator.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/020_The_lion_king_Snyggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/500px-020_The_lion_king_Snyggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `zoo`
-- -----------------------------------------------------
START TRANSACTION;
USE `zootinderdb`;
INSERT INTO `zoo` (`id`, `name`, `description`, `image_url`, `street`, `city`, `state`, `postal_code`, `country`, `user_id`) VALUES (1, 'Denver Zoo', 'Denver Zoo Conservation Alliance is an 80-acre (32 ha) nonprofit zoological garden and conservation organization located in City Park of Denver, Colorado, United States. Founded in 1896, it is operated by the Denver Zoological Foundation and funded in part by the Scientific and Cultural Facilities District (SCFD). Its other sources of funding are ticket sales and private donations. It is the most visited paid attraction in Denver.[6][7]\n\nDenver Zoo was started with the donation of an orphaned American black bear. With the construction of Bear Mountain, it became the first zoo in the United States to use naturalistic zoo enclosures rather than cages with bars. It expanded on this concept with Primate Panorama, featuring huge mesh tents and open areas for apes and monkeys, and with Predator Ridge, which has three separate areas through which animals are rotated so that their overlapping scents provide environmental enrichment. ', 'https://denverzoo.org/wp-content/themes/urbi-child/assets/logos/HeaderLogo_New.svg', '2300 Steele Street ', 'Denver', 'CO', '80205', 'US', 2);
INSERT INTO `zoo` (`id`, `name`, `description`, `image_url`, `street`, `city`, `state`, `postal_code`, `country`, `user_id`) VALUES (2, 'Cheyenne Mountain Zoo', 'The Cheyenne Mountain Zoo is a zoological park located southwest of downtown Colorado Springs, Colorado, on Cheyenne Mountain in the United States. At an elevation of 6,714 feet (2,046 m) above sea level, it is the highest zoo in the country. The zoo covers 140 acres (57 ha), 40 of which are in use. The zoo houses more than 750 animals, representing nearly 170 different species, with more than 30 endangered species. The zoo was ranked the #2 best zoo in North America in 2025 by USA Today. It is accredited by the Association of Zoos and Aquariums.', 'https://upload.wikimedia.org/wikipedia/en/7/7c/Cheyenne_Mountain_Zoo_logo.png', '4250 Cheyenne Mountain Zoo Rd.', 'Colorado Springs', 'CO', '80906', 'US', 3);
INSERT INTO `zoo` (`id`, `name`, `description`, `image_url`, `street`, `city`, `state`, `postal_code`, `country`, `user_id`) VALUES (3, 'The Wild Animal Sanctuary', 'The Wild Animal Sanctuary is a 33,000-acre (13,000 ha) animal sanctuary in Keenesburg, Colorado, United States. The sanctuary specializes in rescuing and caring for large predators which are being ill-treated, for which their owners can no longer care, or which might otherwise be euthanized.[3] It is a 501(c)(3) nonprofit organization and a state and federally licensed zoological facility.\n\nCreated in 1980, The Wild Animal Sanctuary is situated on grassland northeast of Denver, and has helped over 1,000 animals since it first opened. By early 2022, home to more than 550 animals, and 192 staff and volunteers to take care, the group announced the purchase of a major addition, a 9,004-acre ranch near Springfield, Colorado.', 'https://upload.wikimedia.org/wikipedia/en/f/f6/Wild_Animal_Sanctuary_logo.png', '2999 County Road 53', 'Keenesburg', 'CO', '80643', 'US', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `animal`
-- -----------------------------------------------------
START TRANSACTION;
USE `zootinderdb`;
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (1, 2, 3, 'Aztec', NULL, 'Rescue Organization Transfer - Aztec, a young male Timber Wolf, was found roaming around the woods near Cleveland, Ohio so a local Husky Rescue decided to take him. Since Aztec is a Wolf, the rescue knew they couldn’t adopt him out so they needed to find a Sanctuary for him. While temporarily living at the rescue, he bonded with a young Arctic Wolf named Fidget, who was also waiting to find a permanent home. TWAS did not want to separate them and agreed to rescue the pair and provide them a lifelong home so they will never be abandoned again.', NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (2, 2, 3, 'Macey', NULL, 'USDA-mandated Relinquishment - Female Wolf, Macey, was one of 24 animals suffering from declining care at an animal rescue facility in Spearfish, South Dakota.  Accepting both domestic and exotic animals, the facility began to suffer from overcrowding and mismanagement.  As a result, the USDA stepped in when many of the exotic animals, including Tigers, a Lion, other Wolves and Bears, showed signs of being undernourished.  Because the facility’s director was initially unwilling to surrender the animals, the USDA was prepared to legally confiscate the affected animals.  However, at the last minute the director acquiesced and the animals were surrendered to The Wild Animal Sanctuary.  Macey can now look forward to living out the rest of her life with plenty of food to eat, living in a Wolf pack and having acres and acres of room to roam!', NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (3, 2, 3, 'Kiko', NULL, 'Owner Surrender – Female Wolf, Kiko, was acquired by a family in Denver who wanted a Wolf as a pet.  However, by only six-months of age Kiko’s lack of domestication and ability to escape was becoming a major problem for her owners.  Realizing that Kiko could never be a pet and fearing more escapes, her owners contacted The Wild Animal Sanctuary, which was more than happy to give Kiko a lifetime home of wild open spaces and living in a Wolf-pack where she belongs.', NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (4, 2, 3, 'Ajack', NULL, 'Safari Park Surrender--Male Arctic Wolf, Ajack, was born at the drive-thru Parc Safari located near Montreal, Canada.  After about\n\n3 ½ years, the facility determined it was no longer able to provide the best home possible for Ajack and his litter-mate sister, Sijack.  At such time The Wild Animal Sanctuary was contacted about taking-in these two Wolves and a male Lion in a similar situation.  The Sanctuary agreed to provide a lifelong home for all of them, and after a cross-country trek these Canadian residents became United States citizens!  Ajack and Sijack now enjoy life in a large-acreage, natural habitat near other Wolves and may eventually form the nucleus of a larger Wolf pack as time goes on.', NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (5, 2, 3, 'Sijack', NULL, ' Safari Park Surrender--Female Arctic Wolf, Sijack, was born at the drive-thru Parc Safari located near Montreal, Canada.  After about 3 ½ years, the facility determined it was no longer able to provide the best home possible for Sijack and her litter-mate brother, Ajack.  At such time The Wild Animal Sanctuary was contacted about taking-in these two Wolves and a male Lion in a similar situation.  The Sanctuary agreed to provide a lifelong home for all of them, and after a cross-country trek these Canadian residents became United States citizens!  Sijack and Ajack now enjoy life in a large-acreage, natural habitat near other Wolves and may eventually form the nucleus of a larger Wolf pack as time goes on.', NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (6, 2, 3, 'Wind Walker', NULL, 'California Facility Closure--Male Wolf, Wind Walker, was one of twelve Wolves that were given a new life by The Wild Animal Sanctuary after living for a short time at a rescue facility near Los Angeles, which had previously rescued Wind Walker and fourteen other Wolves from a Minnesota fur farm in August 2018.  Due to a number of setbacks at the facility, in mid-2019 the California Department of Fish and Wildlife assumed care of all the facility’s animals.  Upon finding no other placement options for the Wolves, the Sanctuary was asked to provide a home for Wind Walker and eleven other Wolves.  Naturally, the Sanctuary agreed so now Wind Walker and all the others can live out their lives in natural habitats and never have to worry about where they will live again!', NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (7, 1, 1, 'BB', NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (8, 1, 1, 'Jasiri', NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (9, 1, 1, 'Thorn', NULL, 'After an incredible 444-day pregnancy, first-time parents BB and Jasiri welcomed a male reticulated giraffe calf on March 7, 2025. Born at 5’11” and weighing around 170 pounds, this gentle giant has been a wonderful addition to our herd and his Endangered species. He spends his days bonding with mom, exploring with “uncle” Dobby and getting to know his new home. If you’re lucky, you may spot him outdoors for short periods of time (weather permitting) or cozying up with mom indoors.  ', NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (10, 1, 1, 'Dobby', NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (11, 6, 1, 'Simba', NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (12, 6, 1, 'Leo', NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (13, 5, 2, 'Zambezi', NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (14, 5, 2, 'Biko', NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (15, 5, 2, 'Omo', '2021-07-21', NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (16, 4, 1, 'Stripey', NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (17, 6, 3, 'Rio', NULL, 'Private Forfeiture - Male White Lion, Rio, was shipped from the United States to the Island of Guam when he was just a cub in order to be used in a hotel magic show.  Rio, along with two African Servals, were used as exotic props in the show and were kept in small cages on the rooftop of the hotel for more than 5 years.  Thankfully, when the COVID-19 pandemic negatively affected the island’s tourism, the hotel was forced to close.  Suddenly, Rio and his companions were no longer useful to their owners, so they allowed our Sanctuary to step in and rescue them.  Rio now enjoys a wonderful life with two beautiful female Lions in a 20-acre habitat.\n\n', NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (18, 6, 3, 'Leo II', NULL, ' Court Ordered Confiscation - Male Lion cub, Leo II, along with his siblings and two Grizzly Bears and fourteen other Lions, Tigers were rescued from a pay-to-play-with-cubs operation in Indiana that was cited for   dozens of violations of the Animal Welfare and Endangered Species Acts.  Separated from their mother at birth, Leo II and his brother and sister were sent to the notorious “Tiger King” facility located in Wynnewood, Oklahoma where they suffered extensive abuse and neglect.  Thankfully multiple court orders allowed the animals to be removed from these terrible facilities and sent to The Wild Animal Sanctuary where they now roam in large natural habitats and live completely free from human exploitation!', NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (19, 6, 3, 'Lacey', NULL, ' Private Forfeiture —A private owner near Dayton, Ohio was originally keeping a male Lion and female Lion in a horse trailer.  An animal welfare agency convinced the owners to give the animals to TWAS, but when the female Lion became pregnant (no contraception had been enacted for either animal) and the inevitable set of cubs was born - three in all – the owners changed their minds and decided to keep all five Lions.  The owners were immediately forced to step in and move the Lion family out of the horse trailer, to keep the babies from getting crushed by the adults in such cramped quarters.  Over the next year, the animal welfare agency continued working tirelessly to get the Lions released, but the owners refused.  Then another tragedy befell the Lion family…the adult male was electrocuted in a horrible accident.  To make the situation even more dire, one of the cubs died from malnutrition and the other two cubs were in imminent danger of the same demise.  With the fate of the remaining mother Lion and her two cubs hanging in the balance, the animal welfare agency who had been working on the case all along, made a final push to get the Lions released.  The owners, at long last, agreed.  For mom Lacie, and cubs Sampson and Tabitha, it was the best day of their lives! Since TWAS had long since agreed to take the animals, our rescue team went to Ohio in spring to, at long last, rescue the Lions. ', NULL, NULL);
INSERT INTO `animal` (`id`, `species_id`, `zoo_id`, `name`, `date_of_birth`, `biography`, `create_date`, `last_update`) VALUES (20, 6, 3, 'Tabitha', NULL, ' Private Forfeiture —A private owner near Dayton, Ohio was originally keeping a male Lion and female Lion in a horse trailer.  An animal welfare agency convinced the owners to give the animals to TWAS, but when the female Lion became pregnant (no contraception had been enacted for either animal) and the inevitable set of cubs was born - three in all – the owners changed their minds and decided to keep all five Lions.  The owners were immediately forced to step in and move the Lion family out of the horse trailer, to keep the babies from getting crushed by the adults in such cramped quarters.  Over the next year, the animal welfare agency continued working tirelessly to get the Lions released, but the owners refused.  Then another tragedy befell the Lion family…the adult male was electrocuted in a horrible accident.  To make the situation even more dire, one of the cubs died from malnutrition and the other two cubs were in imminent danger of the same demise.  With the fate of the remaining mother Lion and her two cubs hanging in the balance, the animal welfare agency who had been working on the case all along, made a final push to get the Lions released.  The owners, at long last, agreed.  For mom Lacie, and cubs Sampson and Tabitha, it was the best day of their lives! Since TWAS had long since agreed to take the animals, our rescue team went to Ohio in spring to, at long last, rescue the Lions. ', NULL, NULL);

COMMIT;

