-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3307
-- Généré le : dim. 01 juin 2025 à 15:35
-- Version du serveur : 11.5.2-MariaDB
-- Version de PHP : 8.3.14

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de données : `crud_mvc_procedural`
--
DROP DATABASE IF EXISTS `crud_mvc_procedural`;
CREATE DATABASE IF NOT EXISTS `crud_mvc_procedural` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `crud_mvc_procedural`;

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
                                         `idarticle` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                                         `title` varchar(160) NOT NULL COMMENT 'titre',
                                         `slug` varchar(165) NOT NULL COMMENT 'titre transformé en slug unique',
                                         `articletext` text NOT NULL COMMENT 'article',
                                         `articledatecreated` datetime DEFAULT current_timestamp() COMMENT 'date de création de la première version de l''article',
                                         `articlepublished` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0 -> en attente\n1 -> publié\n2 -> désactivé',
                                         `articledatepublished` datetime DEFAULT NULL COMMENT 'date de publication',
                                         `user_iduser` int(10) UNSIGNED NOT NULL COMMENT 'clef étrangère, un article ne peut avoir qu''un auteur',
                                         PRIMARY KEY (`idarticle`),
                                         UNIQUE KEY `slug_UNIQUE` (`slug`),
                                         KEY `fk_article_user_idx` (`user_iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
                                      `iduser` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                                      `login` varchar(60) NOT NULL COMMENT 'pour se connecter',
                                      `username` varchar(120) NOT NULL COMMENT 'nom d''affichage',
                                      `userpwd` varchar(300) NOT NULL COMMENT 'mot de passe hashé avec password_hash',
                                      `usermail` varchar(150) NOT NULL COMMENT 'email pour confirmer l''inscription, envoyer des info etc...',
                                      `uniqid` varchar(255) NOT NULL COMMENT 'Identifiant unique créé avec uniqid(''mvc'', true); pour les liens dans les mails',
                                      `active` tinyint(3) UNSIGNED DEFAULT 1 COMMENT '0 -> inactif\n1 -> actif\n2 -> banni\n3 -> en attente de validation du mail',
                                      `dateinscription` datetime DEFAULT current_timestamp() COMMENT 'datetime d''inscription',
                                      PRIMARY KEY (`iduser`),
                                      UNIQUE KEY `login_UNIQUE` (`login`),
                                      UNIQUE KEY `usermail_UNIQUE` (`usermail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `article`
--
ALTER TABLE `article`
    ADD CONSTRAINT `fk_article_user` FOREIGN KEY (`user_iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;
