-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pettinderdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pettinderdb` ;

-- -----------------------------------------------------
-- Schema pettinderdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pettinderdb` DEFAULT CHARACTER SET utf8 ;
USE `pettinderdb` ;

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
  `last_update` DATETIME NULL,
  `about_me` TEXT NULL,
  `profile_image_url` VARCHAR(2000) CHARACTER SET 'utf8' NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pet_type` ;

CREATE TABLE IF NOT EXISTS `pet_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pet` ;

CREATE TABLE IF NOT EXISTS `pet` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `date_of_birth` DATE NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  `breed` VARCHAR(45) NULL,
  `pet_type_id` INT NOT NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pet_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_pet_pet_type1_idx` (`pet_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_pet_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_pet_type1`
    FOREIGN KEY (`pet_type_id`)
    REFERENCES `pet_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pet_image` ;

CREATE TABLE IF NOT EXISTS `pet_image` (
  `id` INT NOT NULL,
  `image_url` VARCHAR(2000) NULL,
  `caption` VARCHAR(5000) NULL,
  `create_date` DATETIME NULL,
  `pet_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pet_image_pet1_idx` (`pet_id` ASC) VISIBLE,
  CONSTRAINT `fk_pet_image_pet1`
    FOREIGN KEY (`pet_id`)
    REFERENCES `pet` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS pettinderuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'pettinderuser'@'localhost' IDENTIFIED BY 'pettinderuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'pettinderuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `pettinderdb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `create_date`, `last_update`, `about_me`, `profile_image_url`) VALUES (1, 'admin', 'test', 1, 'ADMIN', NULL, NULL, '2024-08-26', '2024-08-26', NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `create_date`, `last_update`, `about_me`, `profile_image_url`) VALUES (2, 'rob', 'test', 1, NULL, 'Rob', 'Roberson', '2024-08-26', '2024-08-26', NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `first_name`, `last_name`, `create_date`, `last_update`, `about_me`, `profile_image_url`) VALUES (3, 'barb', 'test', 1, NULL, 'Barb', 'Dobbs', '2024-08-26', '2024-08-26', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pet_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `pettinderdb`;
INSERT INTO `pet_type` (`id`, `name`, `description`, `image_url`) VALUES (1, 'Dog', NULL, NULL);
INSERT INTO `pet_type` (`id`, `name`, `description`, `image_url`) VALUES (2, 'Cat', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pet`
-- -----------------------------------------------------
START TRANSACTION;
USE `pettinderdb`;
INSERT INTO `pet` (`id`, `user_id`, `name`, `date_of_birth`, `description`, `image_url`, `breed`, `pet_type_id`, `enabled`) VALUES (1, 2, 'Kitsu', '2001-02-02', NULL, 'https://www.dogbreedslist.info/uploads/dog-pictures/finnish-spitz-2.jpg', 'Chow mix', 1, 0);
INSERT INTO `pet` (`id`, `user_id`, `name`, `date_of_birth`, `description`, `image_url`, `breed`, `pet_type_id`, `enabled`) VALUES (2, 2, 'Ada', '2009-11-02', NULL, 'https://lh3.googleusercontent.com/pw/AP1GczPc-Zw9J80p_Rqmx-8-kFLZ5aKv4VMab-2wZ5jo8vZ9fQ1_u9ifEd3Me7MrlYWdgSRc8s6NdpcT-vDW1X9Y73CKbSPlrwJpTsUtheJVpvrAvLDjvVAXFXS0GRtMiPGsM5O2oMEwYsAkNYWqrKvl4usV=w898-h1596-s-no-gm?authuser=0', 'Australian Shepherd', 1, 1);
INSERT INTO `pet` (`id`, `user_id`, `name`, `date_of_birth`, `description`, `image_url`, `breed`, `pet_type_id`, `enabled`) VALUES (3, 3, 'FIdo', '2020-02-02', NULL, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTD_2xVbyL6tCGo74u6tC1sYNEYc9AmxdIw5A&s', 'Mutt', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pet_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `pettinderdb`;
INSERT INTO `pet_image` (`id`, `image_url`, `caption`, `create_date`, `pet_id`) VALUES (1, 'https://lh3.googleusercontent.com/pw/AP1GczPCXKsSqDeszXoKUlhbMf5T2JHRNPo81Ce-UzweBD1z0rlXphTM2I0SKeOQxM4qXE_JOct3PriVNdPcKAtn0_0j07HvQns2-GX3dI5_BxEzv_hdaWy7ME_1FVA47o3-bZqySCyafCQTVPInt6DaHsND=w2112-h1186-s-no-gm?authuser=0', NULL, '2020-02-20', 2);
INSERT INTO `pet_image` (`id`, `image_url`, `caption`, `create_date`, `pet_id`) VALUES (2, 'https://lh3.googleusercontent.com/pw/AP1GczPhfWHkwLqBfBzwjnL688YwuQyBR00166hwR9QRK1sx9snTtH62GLuakTGNlyAu7FFIbGfPzDTYS8_9AiYLOXKQ3AFonNFB5Gb78WqAzBdPA0IALEN7kHkQCiwyAmTdkk2vZGBuF1uUgJaXaAboGh-dfCkfaAiwUEYoroi4KlDeqzCJpnDP0mJElwkhvokIgb-9r0W5cG7niAtHBrAtDAddY0P8Ofid4PWeec3QpzS39BzaIl88amTfdIYmDgJWwTTA6rv1g216RsumLUJAJ_6ebh1tYAwkXpg1L2jzkHYAL2stg9M-B_KAqhXRW9wvG4Tx-Kx615x_iHihaSeH-9x6UDAFefiWPvlR_G3zL6iu9jiDC9H_xYK-KqFrWDxOLLlBkXQix-UMu2N50UbwzLVeFqaraYDQnb9POb5Stzh2PfvtqwdK72wOTojyeSHoPbwObjzqWTqZR1-f59HHfgsGagpyJVCTZkFwMt3-UaewZ1mN9L7VSOlLDVxjD-s58MhF4IMwWX6Nkky5kJX1gDZNhbQANSHdAhAUzjlPmKoKzJX6UhHgplrynFIozMZ2pByYXAOZpxK6vER82WYhlvYLGkQe4epQvXI_8nfJXIMaYgTqi0mNjPcB1Uiebt6E3k3Fhy8dWUmlr8okiDbV5nzOLK7q0pxigew9v_fieVCFI-oMovtQfVUVWuCMyzS6BxEde5xSiH3Joj0x1Zb9PLKKsspe9j_eCOMsZI-w49RqCXCER3Byg1z9OgZM6fRt-qM8uhrqttW0C4Z5k1scd7cmuV9UmgZWyWUAPCsiEE0JYDSJ06elI7k8HClFyJnmxOYBdEQanxghQnMGaie5Gktq1Tf4dCdMfcXFNXU_v_xWdit4IBDCNg5gq6Lbh8JkBqt8PWn5EP_RawvIUq0X9CR9FZ8SbI6nxzd5CgZKEpZtX2LPPRZwIdDuVcoQiEgtYaw4JCyubqZjbF0UMMsSMmVeEQ-g5cr_2nVql55CM_IIIM2hQnPMfZ2f5LjmaGkaqE7VsA7uK7WJL1C-zmHkx6HcLgIG1ixl_bKyoS1_Phq6Jt4qoot1XVvxow', NULL, '2020-02-20', 2);
INSERT INTO `pet_image` (`id`, `image_url`, `caption`, `create_date`, `pet_id`) VALUES (3, 'https://lh3.googleusercontent.com/pw/AP1GczML4_FCXvcMcOu1XIgYPqDlSPj-9f-tx0J5zpgFCdLvAmKzMwUXBFZ0Fuw9WHfinPQyaLZjjQEGwnavT3S1LDWCMxG5cYvWKi6rJdDdXJDyE4JzWxlQdOO6TbRdHltjOsz3eJSrDkzy_YBxDzJYXT7d42OWCM7gwKvMimActCZRCx2tmpJRHfJzf_FdDpGyt-4jPRBZkM9twUTRCk-0N-XSomXM4lQrD-AZpiYlSbeJHqNTJt4-HKYos6B2plrKOX2xnichWMuOlX2I5W3epV4kY3c3Ou3d0f0iPQcJoUGJeLVRIkhTJAaUxucEacB1qopCXnPkBkG9ZBDCZVMWlj2tNh6eJ69PrnuYu7ybGhQwwCH8rllcZ7OJNzd6PseiK-UehV0XPsemljPHtVJV5NKNjosF_p-JUuJ0d0ClZH5gPGYtq7uJtO0aiQykKOu3sM7iDIj81RrWujWFo6iH-gmGkzlPoSndOg0Ag7Iu59Rg9qyOcCv9MwHAPPI7-AsTFNBEuKIiNE5iyvTv0ajqWBOtmt7bvIG5mYhnigh-drspwcrPTGsWhW8bOdJMx-P0U4bbz0CB0D0d7SVWqiKwK8Xy4BEoUpo3VKQ3tQ-f4grNo7UlIRoD41-xy2cieRvKEROoaCbsdv9hAlrBCFG6YnCLa4-Wd860T7w7mlJ0CccOoqJxRy4gQKbKqQ-zuFqkRb3LgtuhyavcfFppMslaH-I4-WGo_5bv0hePqVdaOzJVkWdqri-f7V36k6R6AM_mscDortJ56rTzNccHl3gHaw_8OAqz-6DFfTzfuPbuYay-BRIW4xxqunEAnvcgUDIf98JAK9FM8SYQ2aP-YMwASt6JXlVRlRyZ3HdQuOIc_JwDE3ZhiQbU7C6ofesX-9a8EIo0xhFw7KaZnOEm9saZHxqMf9WSOlIXpSMiew64lL1-4jv2BilCAaODNqbw6o_2RMcIJXTjEp4fpj_HkqKNOsYLxokAa7oZ_JRH5oyj3Gsn5uWZ2MeEmgvjq6_DsqwCne9EfRXXwtc7DDpsC1BtHooc40MfMnhdcdLuezdQVVIEUf8xQjsfDE71Yw', NULL, '2020-02-20', 2);

COMMIT;

