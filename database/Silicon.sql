SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
CREATE SCHEMA IF NOT EXISTS `Silicon` ;
USE `mydb` ;
USE `Silicon` ;

-- -----------------------------------------------------
-- Table `Silicon`.`ST_USER_GROUP`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Silicon`.`ST_USER_GROUP` ;

CREATE  TABLE IF NOT EXISTS `Silicon`.`ST_USER_GROUP` (
  `USER_GROUP_ID` VARCHAR(32) NOT NULL ,
  `USER_GROUP_NAME` VARCHAR(32) NOT NULL ,
  `CREATE_TIME` DATETIME NOT NULL ,
  `UPDATE_TIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`USER_GROUP_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Silicon`.`ST_USER_INFO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Silicon`.`ST_USER_INFO` ;

CREATE  TABLE IF NOT EXISTS `Silicon`.`ST_USER_INFO` (
  `USER_INFO_ID` VARCHAR(32) NOT NULL ,
  `USER_NAME` VARCHAR(32) NOT NULL ,
  `LOGIN_NAME` VARCHAR(32) NOT NULL ,
  `LOGIN_PASS` VARCHAR(32) NOT NULL ,
  `USER_PHONE` VARCHAR(32) NOT NULL ,
  `USER_EMAIL` VARCHAR(32) NOT NULL ,
  `USER_ADDRESS` VARCHAR(100) NOT NULL ,
  `CREATE_TIME` DATETIME NOT NULL ,
  `UPDATE_TIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`USER_INFO_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Silicon`.`ST_USER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Silicon`.`ST_USER` ;

CREATE  TABLE IF NOT EXISTS `Silicon`.`ST_USER` (
  `USER_ID` VARCHAR(32) NOT NULL ,
  `LOGIN_NAME` VARCHAR(32) NOT NULL ,
  `LOGIN_PASS` VARCHAR(32) NOT NULL ,
  `CREATE_TIME` DATETIME NOT NULL ,
  `UPDATE_TIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `ST_USER_INFO_USER_ID` VARCHAR(32) NOT NULL ,
  `ST_USER_GROUP_USER_ID` VARCHAR(32) NOT NULL ,
  PRIMARY KEY (`USER_ID`) ,
  INDEX `fk_ST_USER_ST_USER_INFO1_idx` (`ST_USER_INFO_USER_ID` ASC) ,
  INDEX `fk_ST_USER_ST_USER_GROUP1_idx` (`ST_USER_GROUP_USER_ID` ASC) ,
  CONSTRAINT `fk_ST_USER_ST_USER_INFO1`
    FOREIGN KEY (`ST_USER_INFO_USER_ID` )
    REFERENCES `Silicon`.`ST_USER_INFO` (`USER_INFO_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ST_USER_ST_USER_GROUP1`
    FOREIGN KEY (`ST_USER_GROUP_USER_ID` )
    REFERENCES `Silicon`.`ST_USER_GROUP` (`USER_GROUP_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Silicon`.`ST_CATEGORY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Silicon`.`ST_CATEGORY` ;

CREATE  TABLE IF NOT EXISTS `Silicon`.`ST_CATEGORY` (
  `CATEGORY_ID` VARCHAR(32) NOT NULL ,
  `CATEGORY_NAME` VARCHAR(32) NOT NULL ,
  `CREATE_TIME` DATETIME NOT NULL ,
  `UPDATE_TIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`CATEGORY_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Silicon`.`ST_ORDER_INFO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Silicon`.`ST_ORDER_INFO` ;

CREATE  TABLE IF NOT EXISTS `Silicon`.`ST_ORDER_INFO` (
  `ORDER_INFO_ID` VARCHAR(32) NOT NULL ,
  `GOODS_ID` VARCHAR(32) NOT NULL ,
  `SUM` INT NOT NULL ,
  `PRICE` INT NOT NULL ,
  `CREATE_TIME` DATETIME NOT NULL ,
  `UPDATE_TIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`ORDER_INFO_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Silicon`.`ST_SUBCATEGORY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Silicon`.`ST_SUBCATEGORY` ;

CREATE  TABLE IF NOT EXISTS `Silicon`.`ST_SUBCATEGORY` (
  `ID` VARCHAR(32) NOT NULL ,
  `SUCATEGORY_NAME` VARCHAR(32) NOT NULL ,
  `CREATE_TIME` DATETIME NOT NULL ,
  `UPDATE_TIME` DATETIME NOT NULL ,
  `ST_CATEGORY_CATEGORY_ID` VARCHAR(32) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_ST_SUBCATEGORY_ST_CATEGORY1_idx` (`ST_CATEGORY_CATEGORY_ID` ASC) ,
  CONSTRAINT `fk_ST_SUBCATEGORY_ST_CATEGORY1`
    FOREIGN KEY (`ST_CATEGORY_CATEGORY_ID` )
    REFERENCES `Silicon`.`ST_CATEGORY` (`CATEGORY_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Silicon`.`ST_GOODS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Silicon`.`ST_GOODS` ;

CREATE  TABLE IF NOT EXISTS `Silicon`.`ST_GOODS` (
  `GOODS_ID` VARCHAR(32) NOT NULL ,
  `TITLE` VARCHAR(128) NOT NULL ,
  `SUMMARY` VARCHAR(256) NOT NULL ,
  `PRICE` INT NOT NULL ,
  `PHOTO_URL` VARCHAR(256) NOT NULL ,
  `CREATE_TIME` DATETIME NOT NULL ,
  `UPDATE_TIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `ST_ORDER_INFO_GOODS_ID` VARCHAR(32) NOT NULL ,
  `ST_CATEGORY_GOOD_ID` VARCHAR(32) NOT NULL ,
  `ST_SUBCATEGORY_ID` VARCHAR(32) NOT NULL ,
  PRIMARY KEY (`GOODS_ID`) ,
  INDEX `fk_ST_GOODS_ST_ORDER_INFO1_idx` (`ST_ORDER_INFO_GOODS_ID` ASC) ,
  INDEX `fk_ST_GOODS_ST_CATEGORY1_idx` (`ST_CATEGORY_GOOD_ID` ASC) ,
  INDEX `fk_ST_GOODS_ST_SUBCATEGORY1_idx` (`ST_SUBCATEGORY_ID` ASC) ,
  CONSTRAINT `fk_ST_GOODS_ST_ORDER_INFO1`
    FOREIGN KEY (`ST_ORDER_INFO_GOODS_ID` )
    REFERENCES `Silicon`.`ST_ORDER_INFO` (`ORDER_INFO_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ST_GOODS_ST_CATEGORY1`
    FOREIGN KEY (`ST_CATEGORY_GOOD_ID` )
    REFERENCES `Silicon`.`ST_CATEGORY` (`CATEGORY_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ST_GOODS_ST_SUBCATEGORY1`
    FOREIGN KEY (`ST_SUBCATEGORY_ID` )
    REFERENCES `Silicon`.`ST_SUBCATEGORY` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Silicon`.`ST_ORDER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Silicon`.`ST_ORDER` ;

CREATE  TABLE IF NOT EXISTS `Silicon`.`ST_ORDER` (
  `ORDER_ID` VARCHAR(32) NOT NULL ,
  `USER_ID` VARCHAR(32) NOT NULL ,
  `DATE_TIME` DATETIME NOT NULL ,
  `TOTAL_PRICE` INT NOT NULL ,
  `CREATE_TIME` DATETIME NOT NULL ,
  `UPDATE_TIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `ST_USER_ORDER_ID` VARCHAR(32) NOT NULL ,
  `ST_CATEGORY_CATEGORY_ID` VARCHAR(32) NOT NULL ,
  `ST_ORDER_INFO_ORDER_INFO_ID` VARCHAR(32) NOT NULL ,
  `ST_USER_USER_ID` VARCHAR(32) NOT NULL ,
  PRIMARY KEY (`ORDER_ID`) ,
  INDEX `fk_ST_ORDER_ST_CATEGORY1_idx` (`ST_CATEGORY_CATEGORY_ID` ASC) ,
  INDEX `fk_ST_ORDER_ST_ORDER_INFO1_idx` (`ST_ORDER_INFO_ORDER_INFO_ID` ASC) ,
  INDEX `fk_ST_ORDER_ST_USER1_idx` (`ST_USER_USER_ID` ASC) ,
  CONSTRAINT `fk_ST_ORDER_ST_CATEGORY1`
    FOREIGN KEY (`ST_CATEGORY_CATEGORY_ID` )
    REFERENCES `Silicon`.`ST_CATEGORY` (`CATEGORY_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ST_ORDER_ST_ORDER_INFO1`
    FOREIGN KEY (`ST_ORDER_INFO_ORDER_INFO_ID` )
    REFERENCES `Silicon`.`ST_ORDER_INFO` (`ORDER_INFO_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ST_ORDER_ST_USER1`
    FOREIGN KEY (`ST_USER_USER_ID` )
    REFERENCES `Silicon`.`ST_USER` (`USER_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
