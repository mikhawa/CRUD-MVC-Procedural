-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema crud_mvc_procedural
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `crud_mvc_procedural` ;

-- -----------------------------------------------------
-- Schema crud_mvc_procedural
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `crud_mvc_procedural` DEFAULT CHARACTER SET utf8mb4  ;
USE `crud_mvc_procedural` ;

-- -----------------------------------------------------
-- Table `crud_mvc_procedural`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `crud_mvc_procedural`.`user` ;

CREATE TABLE IF NOT EXISTS `crud_mvc_procedural`.`user` (
  `iduser` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(60) NOT NULL COMMENT 'pour se connecter',
  `username` VARCHAR(120) NOT NULL COMMENT 'nom d\'affichage',
  `userpwd` VARCHAR(300) NOT NULL COMMENT 'mot de passe hashé avec password_hash',
  `usermail` VARCHAR(150) NOT NULL COMMENT 'email pour confirmer l\'inscription, envoyer des info etc...',
  `uniqid` VARCHAR(255) NOT NULL COMMENT 'Identifiant unique créé avec uniqid(\'mvc\', true); pour les liens dans les mails',
  `active` TINYINT UNSIGNED NULL DEFAULT 1 COMMENT '0 -> inactif\n1 -> actif\n2 -> banni\n3 -> en attente de validation du mail',
  `dateinscription` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'datetime d\'inscription',
  PRIMARY KEY (`iduser`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `login_UNIQUE` ON `crud_mvc_procedural`.`user` (`login` ASC) ;

CREATE UNIQUE INDEX `usermail_UNIQUE` ON `crud_mvc_procedural`.`user` (`usermail` ASC) ;


-- -----------------------------------------------------
-- Table `crud_mvc_procedural`.`article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `crud_mvc_procedural`.`article` ;

CREATE TABLE IF NOT EXISTS `crud_mvc_procedural`.`article` (
  `idarticle` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(160) NOT NULL COMMENT 'titre',
  `slug` VARCHAR(165) NOT NULL COMMENT 'titre transformé en slug unique',
  `articletext` TEXT NOT NULL COMMENT 'article',
  `articledatecreated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'date de création de la première version de l\'article',
  `articlepublished` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '0 -> en attente\n1 -> publié\n2 -> désactivé',
  `articledatepublished` DATETIME NULL COMMENT 'date de publication',
  `user_iduser` INT UNSIGNED NOT NULL COMMENT 'clef étrangère, un article ne peut avoir qu\'un auteur',
  PRIMARY KEY (`idarticle`),
  CONSTRAINT `fk_article_user`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `crud_mvc_procedural`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `slug_UNIQUE` ON `crud_mvc_procedural`.`article` (`slug` ASC) ;

CREATE INDEX `fk_article_user_idx` ON `crud_mvc_procedural`.`article` (`user_iduser` ASC) ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
