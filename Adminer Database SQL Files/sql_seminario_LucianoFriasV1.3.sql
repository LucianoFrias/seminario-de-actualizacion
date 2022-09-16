-- Adminer 4.8.1 MySQL 8.0.29 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DELIMITER ;;

DROP PROCEDURE IF EXISTS `addUserToGroup`;;
CREATE PROCEDURE `addUserToGroup`(IN `id_user` tinyint, IN `id_target_group` tinyint)
INSERT INTO group_member(id_user,id_group) VALUES( id_user, id_target_group );;

DROP PROCEDURE IF EXISTS `changeUserGroup`;;
CREATE PROCEDURE `changeUserGroup`(IN `id` int(11), IN `new_group_id` int(3))
UPDATE group_member SET id_group = new_group_id  WHERE id = id_user;;

DROP PROCEDURE IF EXISTS `changeUserPassword`;;
CREATE PROCEDURE `changeUserPassword`(IN `user_id` int(11), IN `new_password` varchar(45))
UPDATE user SET password = new_password WHERE id = user_id;;

DROP PROCEDURE IF EXISTS `createUser`;;
CREATE PROCEDURE `createUser`(IN `name` varchar(45), IN `password` varchar(45))
BEGIN
    DECLARE id_user INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    START TRANSACTION;
        INSERT INTO user(name,password) VALUES( name , password );

        SET id_user = LAST_INSERT_ID();

        CALL addUserToGroup(id_user, 3);
    COMMIT;
END;;

DROP PROCEDURE IF EXISTS `deleteUser`;;
CREATE PROCEDURE `deleteUser`(IN `id` int(11))
DELETE FROM user WHERE id = user.id;;

DROP PROCEDURE IF EXISTS `readAllGroupMembers`;;
CREATE PROCEDURE `readAllGroupMembers`()
SELECT * from group_member;;

DROP PROCEDURE IF EXISTS `readAllUsers`;;
CREATE PROCEDURE `readAllUsers`()
SELECT * FROM user;;

DROP PROCEDURE IF EXISTS `readUser`;;
CREATE PROCEDURE `readUser`(IN `id` int(11))
SELECT *
FROM user
WHERE id = user.id;;

DROP PROCEDURE IF EXISTS `removeUserFromGroup`;;
CREATE PROCEDURE `removeUserFromGroup`(IN `id` int(11))
DELETE FROM group_member WHERE group_member.id_user = id;;

DROP PROCEDURE IF EXISTS `validateUser`;;
CREATE PROCEDURE `validateUser`(IN `username` varchar(45), IN `password` varchar(45))
SELECT name, id from user WHERE user.name = username AND user.password = password;;

DELIMITER ;

DROP TABLE IF EXISTS `action`;
CREATE TABLE `action` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `group_accesses`;
CREATE TABLE `group_accesses` (
  `id_group` int NOT NULL,
  `id_action` int NOT NULL,
  KEY `id_group` (`id_group`),
  KEY `id_action` (`id_action`),
  CONSTRAINT `group_accesses_ibfk_5` FOREIGN KEY (`id_group`) REFERENCES `group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `group_accesses_ibfk_6` FOREIGN KEY (`id_action`) REFERENCES `action` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `group_member`;
CREATE TABLE `group_member` (
  `id_user` int NOT NULL,
  `id_group` int NOT NULL,
  KEY `id_user` (`id_user`),
  KEY `id_group` (`id_group`),
  CONSTRAINT `group_member_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `group_member_ibfk_4` FOREIGN KEY (`id_group`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `user_information`;
CREATE TABLE `user_information` (
  `user_id` int NOT NULL,
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_information_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `user_session`;
CREATE TABLE `user_session` (
  `id` int NOT NULL,
  `token` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `expires` datetime NOT NULL,
  `id_user` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_user` (`id_user`),
  UNIQUE KEY `token` (`token`),
  CONSTRAINT `user_session_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


-- 2022-09-16 22:20:03
