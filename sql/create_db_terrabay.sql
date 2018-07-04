-- MySQL Script generated by MySQL Workbench
-- Sun Jul  1 14:30:01 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema db_terrabay
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_terrabay` ;

-- -----------------------------------------------------
-- Schema db_terrabay
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_terrabay` DEFAULT CHARACTER SET latin1 ;
USE `db_terrabay` ;

-- -----------------------------------------------------
-- Table `db_terrabay`.`species`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_terrabay`.`species` ;

CREATE TABLE IF NOT EXISTS `db_terrabay`.`species` (
  `id_specie` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_specie`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_terrabay`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_terrabay`.`users` ;

CREATE TABLE IF NOT EXISTS `db_terrabay`.`users` (
  `id_user` INT(11) NOT NULL AUTO_INCREMENT,
  `pseudo` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `note` DECIMAL(2,1) NOT NULL DEFAULT '2.5',
  `vote_nbr` INT(11) NULL DEFAULT 1,
  `password` VARCHAR(45) NOT NULL,
  `balance` DECIMAL(65,2) NOT NULL DEFAULT '2500.00',
  `status` ENUM('user', 'admin') NOT NULL DEFAULT 'user',
  `photo_path` VARCHAR(100) NULL,
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
KEY_BLOCK_SIZE = 1;


-- -----------------------------------------------------
-- Table `db_terrabay`.`articles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_terrabay`.`articles` ;

CREATE TABLE IF NOT EXISTS `db_terrabay`.`articles` (
  `id_article` INT(11) NOT NULL AUTO_INCREMENT,
  `id_specie` INT(11) NULL DEFAULT NULL,
  `id_user` INT(11) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `unit_price` DECIMAL(65,2) NOT NULL,
  `stock` INT(11) NOT NULL,
  `gender` ENUM('0', '1', '2') NULL DEFAULT NULL,
  `diet` ENUM('vegie', 'carnivorous', 'omnivorous') NOT NULL,
  `weight` DECIMAL(7,2) NULL DEFAULT NULL,
  `size` DECIMAL(5,2) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `age` INT(11) NULL DEFAULT NULL,
  `status` ENUM('available', 'unavailable', 'bid') NOT NULL,
  `photo_path` VARCHAR(100) NULL,
  PRIMARY KEY (`id_article`),
  CONSTRAINT `articles_ibfk_1`
    FOREIGN KEY (`id_specie`)
    REFERENCES `db_terrabay`.`species` (`id_specie`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `articles_ibfk_2`
    FOREIGN KEY (`id_user`)
    REFERENCES `db_terrabay`.`users` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `specie_idx` ON `db_terrabay`.`articles` (`id_specie` ASC);

CREATE INDEX `user_idx` ON `db_terrabay`.`articles` (`id_user` ASC);


-- -----------------------------------------------------
-- Table `db_terrabay`.`transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_terrabay`.`transactions` ;

CREATE TABLE IF NOT EXISTS `db_terrabay`.`transactions` (
  `id_transaction` INT(11) NOT NULL AUTO_INCREMENT,
  `id_buyer` INT(11) NOT NULL,
  `id_seller` INT(11) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id_transaction`),
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`id_buyer`)
    REFERENCES `db_terrabay`.`users` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_2`
    FOREIGN KEY (`id_seller`)
    REFERENCES `db_terrabay`.`users` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `buyer_idx` ON `db_terrabay`.`transactions` (`id_buyer` ASC);

CREATE INDEX `seller_idx` ON `db_terrabay`.`transactions` (`id_seller` ASC);


-- -----------------------------------------------------
-- Table `db_terrabay`.`transactions_lines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_terrabay`.`transactions_lines` ;

CREATE TABLE IF NOT EXISTS `db_terrabay`.`transactions_lines` (
  `id_transaction_line` INT(11) NOT NULL AUTO_INCREMENT,
  `id_transaction` INT(11) NOT NULL,
  `id_article` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `vote_token` INT(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_transaction_line`),
  CONSTRAINT `orders_lines_ibfk_1`
    FOREIGN KEY (`id_transaction`)
    REFERENCES `db_terrabay`.`transactions` (`id_transaction`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `orders_lines_ibfk_2`
    FOREIGN KEY (`id_article`)
    REFERENCES `db_terrabay`.`articles` (`id_article`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `order_idx` ON `db_terrabay`.`transactions_lines` (`id_transaction` ASC);

CREATE INDEX `article_idx` ON `db_terrabay`.`transactions_lines` (`id_article` ASC);


-- -----------------------------------------------------
-- Table `db_terrabay`.`discounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_terrabay`.`discounts` ;

CREATE TABLE IF NOT EXISTS `db_terrabay`.`discounts` (
  `id_discount` INT NOT NULL AUTO_INCREMENT,
  `id_article` INT NOT NULL,
  `status` ENUM('0', '1') NOT NULL,
  `date_start` DATETIME NOT NULL,
  `date_end` DATETIME NOT NULL,
  `init_price` DECIMAL(65,2) NOT NULL,
  `disc_price` DECIMAL(65,2) NOT NULL,
  PRIMARY KEY (`id_discount`),
  CONSTRAINT `id_article`
    FOREIGN KEY (`id_article`)
    REFERENCES `db_terrabay`.`articles` (`id_article`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `id_article_idx` ON `db_terrabay`.`discounts` (`id_article` ASC);


-- -----------------------------------------------------
-- Table `db_terrabay`.`bids`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_terrabay`.`bids` ;

CREATE TABLE IF NOT EXISTS `db_terrabay`.`bids` (
  `id_bi` INT NOT NULL AUTO_INCREMENT,
  `id_article` INT NOT NULL,
  `id_bidder` INT NULL,
  `status` ENUM('active', 'inactive') NOT NULL,
  `date_start` DATETIME NOT NULL,
  `date_end` DATETIME NOT NULL,
  `init_price` DECIMAL(65,2) NOT NULL,
  `end_price` DECIMAL(65,2) NOT NULL,
  PRIMARY KEY (`id_bi`),
  CONSTRAINT `id_article0`
    FOREIGN KEY (`id_article`)
    REFERENCES `db_terrabay`.`articles` (`id_article`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_user`
    FOREIGN KEY (`id_bidder`)
    REFERENCES `db_terrabay`.`users` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `id_article_idx` ON `db_terrabay`.`bids` (`id_article` ASC);

CREATE INDEX `id_user_idx` ON `db_terrabay`.`bids` (`id_bidder` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `db_terrabay`.`species`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_terrabay`;
INSERT INTO `db_terrabay`.`species` (`id_specie`, `name`) VALUES (1, 'Felines');
INSERT INTO `db_terrabay`.`species` (`id_specie`, `name`) VALUES (2, 'Canides');
INSERT INTO `db_terrabay`.`species` (`id_specie`, `name`) VALUES (3, 'Ursides');
INSERT INTO `db_terrabay`.`species` (`id_specie`, `name`) VALUES (4, 'Birds');
INSERT INTO `db_terrabay`.`species` (`id_specie`, `name`) VALUES (5, 'Camelids');
INSERT INTO `db_terrabay`.`species` (`id_specie`, `name`) VALUES (6, 'Reptiles');
INSERT INTO `db_terrabay`.`species` (`id_specie`, `name`) VALUES (7, 'Fishes');
INSERT INTO `db_terrabay`.`species` (`id_specie`, `name`) VALUES (8, 'Mammals');
INSERT INTO `db_terrabay`.`species` (`id_specie`, `name`) VALUES (9, 'Rondent');
INSERT INTO `db_terrabay`.`species` (`id_specie`, `name`) VALUES (10, 'Arthropod');
COMMIT;


-- -----------------------------------------------------
-- Data for table `db_terrabay`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_terrabay`;
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (1, 'Feral', 'oui.non@gmail.com', 'Thomas', 'Cousin', 2.5, 1, 'YlhE', 50000, 'admin', NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (2, 'Tylan', 'unmail@gmail.com', 'JeanRene', 'Bovin', 2.5, 1, 'Ylhe', 99999, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (3, 'ScrubLord', 'scrub.lord@gmail.com', 'Theodule', 'Joulax', 2.5, 1, 'Ylhe', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (4, 'aze', 'mister.aze@gmail.com', 'Mister', 'Aze',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (5, 'r1', 'r1@gmail.com', 'Mister', 'r1',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (6, 'tb0', 'thibault@gmail.com', 'Mister', 'Tb0',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (7, 'rick', 'rick@gmail.com', 'Pat', 'Rick',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (8, 'fred', 'fred@gmail.com', 'Fredd', 'All',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (9, 'jessy', 'jessy@gmail.com', 'Jessy', 'Loupialnaw',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (10, 'jocelyne', 'fred@gmail.com', 'Mister', 'Fred',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (11, 'spacefarmer', 'fred@gmail.com', 'Mister', 'Fred',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (12, 'planetarium-andromeda', 'fred@gmail.com', 'Mister', 'Fred',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (13, 'planetarium-aldebaran', 'aldebaran@gmail.com', 'Mister', 'Ministor',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (14, 'dylan', 'dylan@gmail.com', 'Dylan', 'Aerzal',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (15, 'jo', 'fred@gmail.com', 'All', 'Fred',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (16, 'finder', 'fred@gmail.com', 'Kat', 'Find',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (17, 'grinder', 'fred@gmail.com', 'Jean', 'Grind',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (18, 'superman', 'fred@gmail.com', 'Klark', 'Kent',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (19, 'hoobs', 'fred@gmail.com', 'Boo', 'hoobs',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (20, 'hobbit', 'fred@gmail.com', 'Jouflu', 'Hobbit',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (21, 'smurf', 'fred@gmail.com', 'Jouflu', 'Hobbit',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (22, 'kouz', 'fred@gmail.com', 'Jouflu', 'Hobbit',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (23, 'vial', 'fred@gmail.com', 'Jouflu', 'Hobbit',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (24, 'nigga', 'fred@gmail.com', 'Jouflu', 'Hobbit',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (25, 'joe', 'fred@gmail.com', 'Jouflu', 'Hobbit',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (26, 'sergent', 'fred@gmail.com', 'Jouflu', 'Hobbit',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (27, 'vladimir', 'fred@gmail.com', 'Jouflu', 'Hobbit',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (28, 'thierry', 'fred@gmail.com', 'Jouflu', 'Hobbit',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (29, 'xor', 'fred@gmail.com', 'Jouflu', 'Hobbit',4, 1, 'TFdI', 100, DEFAULT, NULL);
INSERT INTO `db_terrabay`.`users` (`id_user`, `pseudo`, `email`, `firstname`, `name`, `note`, `vote_nbr`, `password`, `balance`, `status`, `photo_path`) VALUES (30, 'thor', 'fred@gmail.com', 'Jouflu', 'Hobbit',4, 1, 'TFdI', 100, DEFAULT, NULL);
COMMIT;


-- -----------------------------------------------------
-- Data for table `db_terrabay`.`articles`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_terrabay`;
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (1, 1, 1, 'Cat', 25, 99999, '0', 'carnivorous', 2, 0.5, 'Dark brown', 2, 'available', '../model/resources/cat1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (2, 2, 1, 'Boxer', 50, 2, '1', 'carnivorous', 5, 0.7, 'Light brown', 2, 'available', '../model/resources/dog1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (3, 3, 2, 'Brown bear', 1500, 3, '1', 'omnivorous', 600, 1.5, 'Brown', 5, 'available', '../model/resources/bear.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (4, 3, 2, 'White bear', 10000, 2, '0', 'carnivorous', 3, 0.5, 'White', 3, 'available', '../model/resources/bear2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (5, 3, 3, 'Baby bear', 50000, 2, '0', 'carnivorous', 3, 0.5, 'Brown', 3, 'available', '../model/resources/bear1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (6, 2, 3, 'Dog', 1000, 2, '0', 'carnivorous', 3, 0.5, 'White,brown,black', 600, 'available', '../model/resources/dog.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (7, 2, 4, 'Fox', 1000, 2, '0', 'carnivorous', 3, 0.5, 'Red', 3, 'available', '../model/resources/fox1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (8, 1, 5, 'Baby Cat', 25000, 2, '0', 'carnivorous', 3, 0.5, 'White', 600, 'available', '../model/resources/cat.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (9, 2, 6, 'Baby bear', 100000, 2, '0', 'carnivorous', 3, 0.5, 'Red', 3, 'available', '../model/resources/bear3.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (10, 5, 7, 'Dust Camel', 100, 2, '0', 'vegi', 3, 0.5, 'Beige', 8, 'available', '../model/resources/camel1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (11, 5, 7, 'Field Camel', 500, 2, '0', 'vegi', 3, 0.5, 'Brown', 18, 'available', '../model/resources/camel.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (12, 5, 8, 'Dust Camel', 2000, 2, '0', 'vegi', 3, 0.5, 'Brown', 13, 'available', '../model/resources/camel2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (13, 1, 9, 'Big Cat', 100000, 2, '0', 'carnivorous', 3, 0.5, 'White', 25, 'available', '../model/resources/cat2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (14, 4, 10, 'Chicken', 1000, 2, '0', 'vegi', 3, 0.5, 'Red', 45, 'available', '../model/resources/chicken.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (15, 4, 10, 'Chicken Carnivorous', 1000, 2, '1', 'carnivorous', 3, 0.5, 'Red', 30, 'available', '../model/resources/chicken1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (16, 4, 10, 'Chicken', 1000, 2, '0', 'vegi', 3, 0.5, 'Red', 12, 'available', '../model/resources/chicken2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (17, 6, 10, 'Crocodile', 231000, 2, '0', 'carnivorous', 3, 0.5, 'Green', 3, 'available', '../model/resources/crocodile.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (18, 6, 11, 'Crocodile', 9000, 2, '0', 'carnivorous', 3, 0.5, 'Green', 8, 'available', '../model/resources/crocodile1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (19, 6, 11, 'Crocodile', 5000, 2, '0', 'carnivorous', 3, 0.5, 'Green', 156, 'available', '../model/resources/crocodile2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (20, 2, 12, 'Dog', 600, 2, '0', 'carnivorous', 3, 0.5, 'Red', 398, 'available', '../model/resources/dog.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (21, 2, 12, 'Dog', 1000, 2, '0', 'carnivorous', 3, 0.5, 'Red', 13, 'available', '../model/resources/dog2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (22, 4, 13, 'Eagle', 1000, 2000, '1', 'carnivorous', 3, 0.5, 'Black', 12, 'available', '../model/resources/eagle.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (23, 4, 13, 'Eagle', 1000, 100, '1', 'carnivorous', 3, 0.5, 'Brown', 15, 'available', '../model/resources/eagle1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (24, 4, 14, 'Eagle', 1000, 2, '0', 'carnivorous', 3, 0.5, 'Black', 13, 'available', '../model/resources/eagle2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (25, 1, 15, 'Fennec', 10000, 2, '0', 'carnivorous', 3, 0.5, 'Red', 3, 'available', '../model/resources/fennec.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (26, 1, 15, 'Fennec', 11500, 2, '2', 'carnivorous', 3, 0.5, 'Red', 9, 'available', '../model/resources/fennec1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (27, 1, 15, 'Fennec', 22000, 2, '1', 'carnivorous', 3, 0.5, 'Red', 13, 'available', '../model/resources/fennec2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (28, 7, 16, 'Red fish', 50, 2, '0', 'vegi', 3, 0.5, 'Red', 9, 'available', '../model/resources/fish.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (29, 7, 17, 'Blue fish', 100, 2, '0', 'vegi', 3, 0.5, 'Blue', 6, 'available', '../model/resources/fish1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (30, 7, 18, 'Lion head', 10000000, 2, '0', 'vegi', 3, 0.5, 'White,Orange', 1, 'available', '../model/resources/fish3.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (31, 7, 18, 'Yellow fish', 1000, 2, '0', 'vegi', 3, 0.5, 'Yellow', 2, 'available', '../model/resources/fish2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (32, 2, 19, 'Snow Fox', 10000, 2, '1', 'carnivorous', 3, 0.5, 'Red', 6, 'available', '../model/resources/fox.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (33, 1, 19, 'Snow Fox', 100000, 7560, '2', 'carnivorous', 3, 0.5, 'Red', 4, 'available', '../model/resources/fox2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (34, 8, 20, 'Goat', 1000, 2, '0', 'vegi', 3, 0.5, 'White', 3, 'available', '../model/resources/goat.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (35, 8, 20, 'Goat', 1000, 2, '0', 'vegi', 3, 0.5, 'Grey', 100, 'available', '../model/resources/goat1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (36, 8, 20, 'Baby Goat', 1000, 2, '0', 'vegi', 3, 0.5, 'White', 300, 'available', '../model/resources/goat2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (37, 1, 20, 'Lion', 10500, 200, '0', 'carnivorous', 3, 0.5, 'Red', 5, 'available', '../model/resources/lion.png');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (38, 1, 20, 'Lion', 1065, 245, '0', 'carnivorous', 3, 0.5, 'Red', 10, 'available', '../model/resources/lion1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (39, 1, 20, 'Lion', 1150, 450, '0', 'carnivorous', 3, 0.5, 'Red', 15, 'available', '../model/resources/lion2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (40, 1, 20, 'Lioness', 1052, 220, '1', 'carnivorous', 3, 0.5, 'Red', 15, 'available', '../model/resources/lioness.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (41, 1, 20, 'Lioness', 1650, 652, '1', 'carnivorous', 3, 0.5, 'Red', 10, 'available', '../model/resources/lioness1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (42, 1, 20, 'Lioness', 1250, 782, '1', 'carnivorous', 3, 0.5, 'Red', 5, 'available', '../model/resources/lioness2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (43, 8, 21, 'Baby Monkey', 1000, 2, '0', 'vegi', 3, 0.5, 'Brown', 3, 'available', '../model/resources/monkey.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (44, 8, 21, 'Monkey', 1000, 2, '1', 'vegi', 3, 0.5, 'Brown', 13, 'available', '../model/resources/monkey1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (45, 8, 21, 'Monkey', 1000, 2, '0', 'vegi', 3, 0.5, 'Brown', 12, 'available', '../model/resources/monkey2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (46, 4, 22, 'Parrot Green', 5000, 2, '0', 'vegi', 3, 0.5, 'Green', 3, 'available', '../model/resources/parrot.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (47, 4, 22, 'Parrot Blue', 7000, 2, '1', 'vegi', 3, 0.5, 'Blue', 6, 'available', '../model/resources/parrot1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (48, 4, 22, 'Parrot Red', 9000, 2, '0', 'vegi', 3, 0.5, 'Red', 8, 'available', '../model/resources/parrot2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (49, 8, 23, 'Pig', 1000, 2, '1', 'carnivorous', 3, 0.5, 'Pink', 3, 'available', '../model/resources/pig.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (50, 8, 23, 'Pig', 5000, 2, '0', 'carnivorous', 3, 0.5, 'Pink', 3, 'available', '../model/resources/pig1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (51, 8, 23, 'Pig', 3000, 2, '0', 'carnivorous', 3, 0.5, 'Pink', 3, 'available', '../model/resources/pig2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (52, 4, 24, 'Pigeon', 50, 2, '0', 'carnivorous', 3, 0.5, 'Black', 3, 'available', '../model/resources/pigeon.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (53, 4, 24, 'Pigeon', 100, 2, '0', 'carnivorous', 3, 0.5, 'Black', 3, 'available', '../model/resources/pigeon1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (54, 4, 24, 'Pigeon', 50, 2, '0', 'carnivorous', 3, 0.5, 'Black', 3, 'available', '../model/resources/pigeon2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (55, 9, 25, 'White Rabbit', 1000, 2, '0', 'carnivorous', 3, 0.5, 'White', 3, 'available', '../model/resources/rabbit.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (56, 9, 25, 'Red Rabbit', 1000, 2, '0', 'carnivorous', 3, 0.5, 'Red', 3, 'available', '../model/resources/rabbit1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (57, 9, 25, 'Brown Rabbit', 1000, 2, '0', 'carnivorous', 3, 0.5, 'Brown', 3, 'available', '../model/resources/rabbit2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (58, 10, 26, 'Scorpion', 1000, 2, '0', 'carnivorous', 3, 0.5, 'Black', 3, 'available', '../model/resources/scorpion.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (59, 10, 26, 'Scorpion', 1000, 2, '0', 'carnivorous', 3, 0.5, 'Orange,Black', 3, 'available', '../model/resources/scorpion1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (60, 10, 26, 'Scorpion', 1000, 2, '0', 'carnivorous', 3, 0.5, 'Orange,Black', 3, 'available', '../model/resources/scorpion2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (61, 7, 27, 'Shark', 1000, 2, '0', 'carnivorous', 3, 0.5, 'Black', 3, 'available', '../model/resources/shark.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (62, 7, 27, 'Shark', 1000, 2, '0', 'carnivorous', 3, 0.5, 'White', 3, 'available', '../model/resources/shark1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (63, 7, 27, 'Shark', 1000, 2, '0', 'carnivorous', 3, 0.5, 'White', 3, 'available', '../model/resources/shark2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (64, 4, 28, 'Sparrow', 1000, 2, '0', 'carnivorous', 3, 0.5, 'Brown', 3, 'available', '../model/resources/sparrow.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (65, 4, 28, 'Sparrow', 1000, 2, '0', 'carnivorous', 3, 0.5, 'Brown', 3, 'available', '../model/resources/sparrow1.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (66, 4, 28, 'Sparrow', 1000, 2, '0', 'carnivorous', 3, 0.5, 'Brown', 3, 'available', '../model/resources/sparrow2.jpg');
INSERT INTO `db_terrabay`.`articles` (`id_article`, `id_specie`, `id_user`, `description`, `unit_price`, `stock`, `gender`, `diet`, `weight`, `size`, `color`, `age`, `status`, `photo_path`) VALUES (68, 8, 29, 'Fat Giraffe', 99999, 2, '0', 'carnivorous', 3, 0.5, 'Brown', 18, 'available', '../model/resources/fat_giraffe.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_terrabay`.`discounts`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_terrabay`;
INSERT INTO `db_terrabay`.`discounts` (`id_discount`, `id_article`, `status`, `date_start`, `date_end`, `init_price`, `disc_price`) VALUES (1, 2, '0', 'current_time', 'current_time + interval 1 hour', 150.00, 200.00);

COMMIT;
