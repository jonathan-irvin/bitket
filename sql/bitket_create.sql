SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `bitket` DEFAULT CHARACTER SET utf8 ;
USE `bitket` ;

-- -----------------------------------------------------
-- Table `bitket`.`bk_customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bitket`.`bk_customers` ;

CREATE  TABLE IF NOT EXISTS `bitket`.`bk_customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT ,
  `firstname` VARCHAR(20) NULL DEFAULT NULL ,
  `lastname` VARCHAR(20) NULL DEFAULT NULL ,
  `address` VARCHAR(50) NULL DEFAULT NULL ,
  `address2` VARCHAR(50) NULL DEFAULT NULL ,
  `city` VARCHAR(20) NULL DEFAULT NULL ,
  `state` VARCHAR(2) NULL DEFAULT NULL ,
  `zip` VARCHAR(10) NULL DEFAULT NULL ,
  `phone_main` VARCHAR(20) NULL DEFAULT NULL ,
  `phone_alt` VARCHAR(20) NULL DEFAULT NULL ,
  `created` TIMESTAMP NULL DEFAULT NULL ,
  `updated` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`customer_id`) );


-- -----------------------------------------------------
-- Table `bitket`.`bk_statuses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bitket`.`bk_statuses` ;

CREATE  TABLE IF NOT EXISTS `bitket`.`bk_statuses` (
  `status_id` INT NOT NULL ,
  `name` VARCHAR(45) NULL DEFAULT NULL ,
  `description` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`status_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bitket`.`bk_priorities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bitket`.`bk_priorities` ;

CREATE  TABLE IF NOT EXISTS `bitket`.`bk_priorities` (
  `priority_id` INT NOT NULL ,
  `name` VARCHAR(45) NULL DEFAULT NULL ,
  `description` VARCHAR(45) NULL DEFAULT NULL ,
  `sla` INT NULL DEFAULT NULL ,
  PRIMARY KEY (`priority_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bitket`.`bk_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bitket`.`bk_users` ;

CREATE  TABLE IF NOT EXISTS `bitket`.`bk_users` (
  `user_id` INT NOT NULL ,
  `name` VARCHAR(45) NULL DEFAULT NULL ,
  `email` VARCHAR(45) NULL DEFAULT NULL ,
  `phone` VARCHAR(45) NULL DEFAULT NULL ,
  `created` TIMESTAMP NULL DEFAULT NULL ,
  `updated` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`user_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bitket`.`bk_tickets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bitket`.`bk_tickets` ;

CREATE  TABLE IF NOT EXISTS `bitket`.`bk_tickets` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT ,
  `customer_id` INT NULL DEFAULT NULL ,
  `status_id` INT NULL DEFAULT NULL ,
  `priority_id` INT NULL DEFAULT NULL ,
  `created_by` INT NULL DEFAULT NULL ,
  `assigned_to` INT NULL DEFAULT NULL ,
  `created` TIMESTAMP NULL DEFAULT NULL ,
  `updated` TIMESTAMP NULL DEFAULT NULL ,
  `deadline` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`ticket_id`) ,
  INDEX `bk_ticket_fk1` (`customer_id` ASC) ,
  INDEX `bk_ticket_fk3_idx` (`status_id` ASC) ,
  INDEX `bk_ticket_fk4_idx` (`priority_id` ASC) ,
  INDEX `bk_ticket_fk5_idx` (`created_by` ASC) ,
  INDEX `bk_ticket_fk6_idx` (`assigned_to` ASC) ,
  CONSTRAINT `bk_ticket_fk1`
    FOREIGN KEY (`customer_id` )
    REFERENCES `bitket`.`bk_customers` (`customer_id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `bk_ticket_fk3`
    FOREIGN KEY (`status_id` )
    REFERENCES `bitket`.`bk_statuses` (`status_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bk_ticket_fk4`
    FOREIGN KEY (`priority_id` )
    REFERENCES `bitket`.`bk_priorities` (`priority_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bk_ticket_fk5`
    FOREIGN KEY (`created_by` )
    REFERENCES `bitket`.`bk_users` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bk_ticket_fk6`
    FOREIGN KEY (`assigned_to` )
    REFERENCES `bitket`.`bk_users` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `bitket`.`bk_events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bitket`.`bk_events` ;

CREATE  TABLE IF NOT EXISTS `bitket`.`bk_events` (
  `event_id` INT NOT NULL AUTO_INCREMENT ,
  `ticket_id` INT NULL DEFAULT NULL ,
  `message` TEXT(65535) NULL DEFAULT NULL ,
  `timestamp` TIMESTAMP NOT NULL ,
  PRIMARY KEY (`event_id`) ,
  INDEX `bk_events_fk1` (`ticket_id` ASC) ,
  CONSTRAINT `bk_events_fk1`
    FOREIGN KEY (`ticket_id` )
    REFERENCES `bitket`.`bk_tickets` (`ticket_id` ));


-- -----------------------------------------------------
-- Table `bitket`.`bk_computers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bitket`.`bk_computers` ;

CREATE  TABLE IF NOT EXISTS `bitket`.`bk_computers` (
  `computer_id` INT NOT NULL ,
  `customer_id` INT NULL DEFAULT NULL ,
  `ticket_id` INT NULL DEFAULT NULL ,
  `brand` VARCHAR(45) NULL DEFAULT NULL ,
  `make` VARCHAR(45) NULL DEFAULT NULL ,
  `model` VARCHAR(45) NULL DEFAULT NULL ,
  `product_key` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`computer_id`) ,
  INDEX `fk_bk_computers_1_idx` (`ticket_id` ASC) ,
  INDEX `fk_bk_computers_2_idx` (`customer_id` ASC) ,
  CONSTRAINT `fk_bk_computers_1`
    FOREIGN KEY (`ticket_id` )
    REFERENCES `bitket`.`bk_tickets` (`ticket_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bk_computers_2`
    FOREIGN KEY (`customer_id` )
    REFERENCES `bitket`.`bk_customers` (`customer_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bitket`.`bk_options`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bitket`.`bk_options` ;

CREATE  TABLE IF NOT EXISTS `bitket`.`bk_options` (
  `options_id` INT NOT NULL ,
  `options_name` VARCHAR(45) NULL DEFAULT NULL ,
  `options_value` LONGTEXT NULL DEFAULT NULL ,
  `auto_load` TINYINT(1) NULL DEFAULT NULL ,
  PRIMARY KEY (`options_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bitket`.`bk_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bitket`.`bk_types` ;

CREATE  TABLE IF NOT EXISTS `bitket`.`bk_types` (
  `type_id` INT NOT NULL ,
  `name` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`type_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bitket`.`bk_assets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bitket`.`bk_assets` ;

CREATE  TABLE IF NOT EXISTS `bitket`.`bk_assets` (
  `asset_id` INT NOT NULL ,
  `ticket_id` INT NULL DEFAULT NULL ,
  `type_id` INT NULL DEFAULT NULL ,
  PRIMARY KEY (`asset_id`) ,
  INDEX `fk_assets_2_idx` (`ticket_id` ASC) ,
  INDEX `fk_bk_assets_1_idx` (`type_id` ASC) ,
  CONSTRAINT `fk_assets_2`
    FOREIGN KEY (`ticket_id` )
    REFERENCES `bitket`.`bk_tickets` (`ticket_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bk_assets_1`
    FOREIGN KEY (`type_id` )
    REFERENCES `bitket`.`bk_types` (`type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `bitket` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
