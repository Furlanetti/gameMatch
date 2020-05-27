-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema gamematch
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gamematch
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gamematch` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `gamematch` ;

-- -----------------------------------------------------
-- Table `gamematch`.`modalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamematch`.`modalidade` (
    `modalidade_id` INT NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(100) NOT NULL,
    `ativo` TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`modalidade_id`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `gamematch`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamematch`.`usuario` (
    `usuario_id` INT NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(100) NOT NULL,
    `foto` VARCHAR(255) NULL,
    `descricao` TEXT NULL,
    `data_nascimento` DATE NULL,
    `genero` CHAR(1) NULL,
    `altura` DECIMAL(5) NULL,
    `ativo` TINYINT(1) NOT NULL DEFAULT 1,
    `latitude` VARCHAR(10) NOT NULL,
    `longitude` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`usuario_id`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `gamematch`.`partida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamematch`.`partida` (
    `partida_id` INT NOT NULL AUTO_INCREMENT,
    `horario` VARCHAR(5) NULL,
    `data` DATE NULL,
    `qtd_participantes` INT NOT NULL DEFAULT 2,
    `modalidade_id` INT NOT NULL,
    `usuario_id` INT NOT NULL,
    PRIMARY KEY (`partida_id`),
    INDEX `fk_partida_modalidade1_idx` (`modalidade_id` ASC),
    INDEX `fk_partida_usuario1_idx` (`usuario_id` ASC),
    CONSTRAINT `fk_partida_modalidade1`
        FOREIGN KEY (`modalidade_id`)
        REFERENCES `gamematch`.`modalidade` (`modalidade_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_partida_usuario1`
        FOREIGN KEY (`usuario_id`)
        REFERENCES `gamematch`.`usuario` (`usuario_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `gamematch`.`convite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamematch`.`convite` (
    `convite_id` INT NOT NULL AUTO_INCREMENT,
    `datetime_envio` DATETIME NULL,
    `datetime_recebimento` DATETIME NULL,
    `datetime_resposta` DATETIME NULL,
    `resposta` TINYINT(1) NULL,
    `usuario_id` INT NOT NULL,
    `partida_id` INT NOT NULL,
    PRIMARY KEY (`convite_id`),
    INDEX `fk_convite_usuario_idx` (`usuario_id` ASC),
    INDEX `fk_convite_partida1_idx` (`partida_id` ASC),
    CONSTRAINT `fk_convite_usuario`
        FOREIGN KEY (`usuario_id`)
        REFERENCES `gamematch`.`usuario` (`usuario_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_convite_partida1`
        FOREIGN KEY (`partida_id`)
        REFERENCES `gamematch`.`partida` (`partida_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `gamematch`.`modalidade_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamematch`.`modalidade_usuario` (
    `modalidade_usuario_id` INT NOT NULL AUTO_INCREMENT,
    `modalidade_id` INT NOT NULL,
    `usuario_id` INT NOT NULL,
    PRIMARY KEY (`modalidade_usuario_id`),
    INDEX `fk_modalidade_has_usuario_usuario1_idx` (`usuario_id` ASC),
    INDEX `fk_modalidade_has_usuario_modalidade1_idx` (`modalidade_id` ASC),
    CONSTRAINT `fk_modalidade_has_usuario_modalidade1`
        FOREIGN KEY (`modalidade_id`)
        REFERENCES `gamematch`.`modalidade` (`modalidade_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_modalidade_has_usuario_usuario1`
        FOREIGN KEY (`usuario_id`)
        REFERENCES `gamematch`.`usuario` (`usuario_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `gamematch`.`partida_usuario_negado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamematch`.`partida_usuario_negado` (
    `partida_usuario_id` INT NOT NULL AUTO_INCREMENT,
    `partida_id` INT NOT NULL,
    `usuario_id` INT NOT NULL,
    PRIMARY KEY (`partida_usuario_id`),
    INDEX `fk_partida_has_usuario_usuario1_idx` (`usuario_id` ASC),
    INDEX `fk_partida_has_usuario_partida1_idx` (`partida_id` ASC),
    CONSTRAINT `fk_partida_has_usuario_partida1`
        FOREIGN KEY (`partida_id`)
        REFERENCES `gamematch`.`partida` (`partida_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_partida_has_usuario_usuario1`
        FOREIGN KEY (`usuario_id`)
        REFERENCES `gamematch`.`usuario` (`usuario_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `gamematch`.`periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamematch`.`periodo` (
    `periodo_id` INT NOT NULL AUTO_INCREMENT,
    `titulo` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`periodo_id`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `gamematch`.`usuario_periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamematch`.`usuario_periodo` (
    `usuario_periodo_id` INT NOT NULL AUTO_INCREMENT,
    `usuario_id` INT NOT NULL,
    `periodo_id` INT NOT NULL,
    PRIMARY KEY (`usuario_periodo_id`),
    INDEX `fk_usuario_has_periodo_periodo1_idx` (`periodo_id` ASC),
    INDEX `fk_usuario_has_periodo_usuario1_idx` (`usuario_id` ASC),
    CONSTRAINT `fk_usuario_has_periodo_usuario1`
        FOREIGN KEY (`usuario_id`)
        REFERENCES `gamematch`.`usuario` (`usuario_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_usuario_has_periodo_periodo1`
        FOREIGN KEY (`periodo_id`)
        REFERENCES `gamematch`.`periodo` (`periodo_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;