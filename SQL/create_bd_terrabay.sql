-- MySQL Script generated by MySQL Workbench
-- Sat May 26 22:32:15 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bdd_TerraBay
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bdd_TerraBay` ;

-- -----------------------------------------------------
-- Schema bdd_TerraBay
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdd_TerraBay` DEFAULT CHARACTER SET utf8 ;
USE `bdd_TerraBay` ;

-- -----------------------------------------------------
-- Table `bdd_TerraBay`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bdd_TerraBay`.`users` ;

CREATE TABLE IF NOT EXISTS `bdd_TerraBay`.`users` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `pseudo` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `note` DECIMAL(2,1) NOT NULL DEFAULT 2.5,
  `password` VARCHAR(45) NOT NULL,
  `balance` DECIMAL(65,2) NOT NULL DEFAULT 2500,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd_TerraBay`.`species`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bdd_TerraBay`.`species` ;

CREATE TABLE IF NOT EXISTS `bdd_TerraBay`.`species` (
  `id_specie` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_specie`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd_TerraBay`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bdd_TerraBay`.`orders` ;

CREATE TABLE IF NOT EXISTS `bdd_TerraBay`.`orders` (
  `id_order` INT NOT NULL AUTO_INCREMENT,
  `id_buyer` INT NOT NULL,
  `id_seller` INT NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id_order`),
  INDEX `buyer_idx` (`id_buyer` ASC),
  INDEX `seller_idx` (`id_seller` ASC),
  CONSTRAINT `buyer`
    FOREIGN KEY (`id_buyer`)
    REFERENCES `bdd_TerraBay`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `seller`
    FOREIGN KEY (`id_seller`)
    REFERENCES `bdd_TerraBay`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd_TerraBay`.`articles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bdd_TerraBay`.`articles` ;

CREATE TABLE IF NOT EXISTS `bdd_TerraBay`.`articles` (
  `id_article` INT NOT NULL AUTO_INCREMENT,
  `id_specie` INT NULL,
  `id_user` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `unit_price` DECIMAL(65,2) NOT NULL,
  `stock` INT NOT NULL,
  `gender` ENUM('0', '1', '2') NULL,
  `diet` ENUM('vegie', 'carnivorous', 'omnivorous') NOT NULL,
  `weight` DECIMAL(7,2) NULL,
  `size` DECIMAL(5,2) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  PRIMARY KEY (`id_article`),
  INDEX `specie_idx` (`id_specie` ASC),
  INDEX `user_idx` (`id_user` ASC),
  CONSTRAINT `specie`
    FOREIGN KEY (`id_specie`)
    REFERENCES `bdd_TerraBay`.`species` (`id_specie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user`
    FOREIGN KEY (`id_user`)
    REFERENCES `bdd_TerraBay`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdd_TerraBay`.`orders_lines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bdd_TerraBay`.`orders_lines` ;

CREATE TABLE IF NOT EXISTS `bdd_TerraBay`.`orders_lines` (
  `id_order_line` INT NOT NULL AUTO_INCREMENT,
  `id_order` INT NOT NULL,
  `id_article` INT NOT NULL,
  `quantity` INT NOT NULL,
  `total_price` DECIMAL(65,2) NOT NULL,
  PRIMARY KEY (`id_order_line`),
  INDEX `order_idx` (`id_order` ASC),
  INDEX `article_idx` (`id_article` ASC),
  CONSTRAINT `order`
    FOREIGN KEY (`id_order`)
    REFERENCES `bdd_TerraBay`.`orders` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `article`
    FOREIGN KEY (`id_article`)
    REFERENCES `bdd_TerraBay`.`articles` (`id_article`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;