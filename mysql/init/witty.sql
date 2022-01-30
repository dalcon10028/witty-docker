-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema daelim_witty
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema daelim_witty
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `daelim_witty` DEFAULT CHARACTER SET utf8 ;
USE `daelim_witty` ;

-- -----------------------------------------------------
-- Table `daelim_witty`.`witty_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `daelim_witty`.`witty_user` (
  `user_id` VARCHAR(100) NOT NULL,
  `user_email` VARCHAR(100) NOT NULL,
  `user_department` VARCHAR(100) NOT NULL,
  `user_password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `daelim_witty`.`witty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `daelim_witty`.`witty` (
  `content` VARCHAR(200) NOT NULL,
  `witty_created_date` DATETIME NOT NULL,
  `witty_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`witty_id`),
  INDEX `fk_witty_witty_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_witty_witty_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `daelim_witty`.`witty_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `daelim_witty`.`witty_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `daelim_witty`.`witty_comment` (
  `witty_comment_id` INT NOT NULL AUTO_INCREMENT,
  `witty_comment_content` VARCHAR(200) NOT NULL,
  `witty_comment_created_date` DATETIME NOT NULL,
  `user_id` VARCHAR(100) NOT NULL,
  `witty_id` INT NOT NULL,
  PRIMARY KEY (`witty_comment_id`),
  INDEX `fk_witty_comment_witty_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_witty_comment_witty1_idx` (`witty_id` ASC) VISIBLE,
  CONSTRAINT `fk_witty_comment_witty_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `daelim_witty`.`witty_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_witty_comment_witty1`
    FOREIGN KEY (`witty_id`)
    REFERENCES `daelim_witty`.`witty` (`witty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `daelim_witty`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `daelim_witty`.`tag` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `daelim_witty`.`witty_likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `daelim_witty`.`witty_likes` (
  `user_id` VARCHAR(100) NOT NULL,
  `witty_id` INT NOT NULL,
  INDEX `fk_witty_likes_witty_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_witty_likes_witty1_idx` (`witty_id` ASC) VISIBLE,
  PRIMARY KEY (`user_id`, `witty_id`),
  CONSTRAINT `fk_witty_likes_witty_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `daelim_witty`.`witty_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_witty_likes_witty1`
    FOREIGN KEY (`witty_id`)
    REFERENCES `daelim_witty`.`witty` (`witty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `daelim_witty`.`follow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `daelim_witty`.`follow` (
  `user_id` VARCHAR(100) NOT NULL,
  `follow_id` VARCHAR(100) NOT NULL,
  INDEX `fk_friends_witty_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_friends_witty_user2_idx` (`follow_id` ASC) VISIBLE,
  CONSTRAINT `fk_friends_witty_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `daelim_witty`.`witty_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_friends_witty_user2`
    FOREIGN KEY (`follow_id`)
    REFERENCES `daelim_witty`.`witty_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `daelim_witty`.`witty_comments_likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `daelim_witty`.`witty_comments_likes` (
  `user_id` VARCHAR(100) NOT NULL,
  `witty_comment_id` INT NOT NULL,
  INDEX `fk_witty_comments_likes_witty_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_witty_comments_likes_witty_comment1_idx` (`witty_comment_id` ASC) VISIBLE,
  PRIMARY KEY (`user_id`, `witty_comment_id`),
  CONSTRAINT `fk_witty_comments_likes_witty_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `daelim_witty`.`witty_user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_witty_comments_likes_witty_comment1`
    FOREIGN KEY (`witty_comment_id`)
    REFERENCES `daelim_witty`.`witty_comment` (`witty_comment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `daelim_witty`.`witty_tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `daelim_witty`.`witty_tag` (
  `witty_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  INDEX `fk_witty_tag_witty1_idx` (`witty_id` ASC) VISIBLE,
  INDEX `fk_witty_tag_tag1_idx` (`tag_id` ASC) VISIBLE,
  PRIMARY KEY (`witty_id`, `tag_id`),
  CONSTRAINT `fk_witty_tag_witty1`
    FOREIGN KEY (`witty_id`)
    REFERENCES `daelim_witty`.`witty` (`witty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_witty_tag_tag1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `daelim_witty`.`tag` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
