-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'users'
-- has_many: products, has_many: credits, belongs_to: address, belongs_to: identification
-- ---

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `nickname` MEDIUMTEXT NULL DEFAULT NULL,
  `email` MEDIUMTEXT NULL DEFAULT NULL,
  `birth` DATE NULL DEFAULT NULL,
  `password` INTEGER NULL DEFAULT NULL,
  `password-confirmation` INTEGER NULL DEFAULT NULL,
  `address_id` INTEGER NULL DEFAULT NULL,
  `identification_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'has_many: products, has_many: credits, belongs_to: address, ';

-- ---
-- Table 'products'
-- belongs_to: user, has_many: categories
-- ---

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` INTEGER NULL DEFAULT NULL,
  `price` INTEGER NULL DEFAULT NULL,
  `category_id` INTEGER NULL DEFAULT NULL,
  `content` MEDIUMTEXT NULL DEFAULT NULL,
  `condition` INTEGER NULL DEFAULT NULL,
  `delivery-fee` INTEGER NULL DEFAULT NULL,
  `send-from` MEDIUMTEXT NULL DEFAULT NULL,
  `delivery-date` INTEGER NULL DEFAULT NULL,
  `image` MEDIUMTEXT NULL DEFAULT NULL,
  `user_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'belongs_to: user, has_many: categories';

-- ---
-- Table 'credits'
-- belongs_to: user
-- ---

DROP TABLE IF EXISTS `credits`;

CREATE TABLE `credits` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `credit-number` INTEGER NULL DEFAULT NULL,
  `date-month` INTEGER NULL DEFAULT NULL,
  `date-year` INTEGER NULL DEFAULT NULL,
  `security-code` INTEGER NULL DEFAULT NULL,
  `user_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'belongs_to: user';

-- ---
-- Table 'addresses'
-- belongs_to: user
-- ---

DROP TABLE IF EXISTS `addresses`;

CREATE TABLE `addresses` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `family-name` MEDIUMTEXT NULL DEFAULT NULL,
  `first-name` MEDIUMTEXT NULL DEFAULT NULL,
  `family-name-kana` MEDIUMTEXT NULL DEFAULT NULL,
  `first-name-kana` MEDIUMTEXT NULL DEFAULT NULL,
  `post-code` INTEGER NULL DEFAULT NULL,
  `prefecture` MEDIUMTEXT NULL DEFAULT NULL,
  `city` MEDIUMTEXT NULL DEFAULT NULL,
  `address` MEDIUMTEXT NULL DEFAULT NULL,
  `building` MEDIUMTEXT NULL DEFAULT NULL,
  `telephone-number` INTEGER NULL DEFAULT NULL,
  `user_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'belongs_to: user';

-- ---
-- Table 'identifications'
-- belongs_to: user
-- ---

DROP TABLE IF EXISTS `identifications`;

CREATE TABLE `identifications` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `family-name` MEDIUMTEXT NULL DEFAULT NULL,
  `first-name` MEDIUMTEXT NULL DEFAULT NULL,
  `family-name-kana` MEDIUMTEXT NULL DEFAULT NULL,
  `first-name-kana` MEDIUMTEXT NULL DEFAULT NULL,
  `birth` DATE NULL DEFAULT NULL,
  `user_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'belongs_to: user';

-- ---
-- Table 'categories'
--
-- ---

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` MEDIUMTEXT NULL DEFAULT NULL,
  `product_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys
-- ---

ALTER TABLE `users` ADD FOREIGN KEY (address_id) REFERENCES `addresses` (`id`);
ALTER TABLE `users` ADD FOREIGN KEY (identification_id) REFERENCES `credits` (`id`);
ALTER TABLE `products` ADD FOREIGN KEY (category_id) REFERENCES `categories` (`id`);
ALTER TABLE `products` ADD FOREIGN KEY (user_id) REFERENCES `users` (`id`);
ALTER TABLE `credits` ADD FOREIGN KEY (user_id) REFERENCES `users` (`id`);
ALTER TABLE `addresses` ADD FOREIGN KEY (user_id) REFERENCES `users` (`id`);
ALTER TABLE `identifications` ADD FOREIGN KEY (user_id) REFERENCES `users` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `users` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `products` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `credits` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `addresses` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `identifications` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `categories` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `users` (`id`,`nickname`,`email`,`birth`,`password`,`password-confirmation`,`address_id`,`identification_id`) VALUES
-- ('','','','','','','','');
-- INSERT INTO `products` (`id`,`name`,`price`,`category_id`,`content`,`condition`,`delivery-fee`,`send-from`,`delivery-date`,`image`,`user_id`) VALUES
-- ('','','','','','','','','','','');
-- INSERT INTO `credits` (`id`,`credit-number`,`date-month`,`date-year`,`security-code`,`user_id`) VALUES
-- ('','','','','','');
-- INSERT INTO `addresses` (`id`,`family-name`,`first-name`,`family-name-kana`,`first-name-kana`,`post-code`,`prefecture`,`city`,`address`,`building`,`telephone-number`,`user_id`) VALUES
-- ('','','','','','','','','','','','');
-- INSERT INTO `identifications` (`id`,`family-name`,`first-name`,`family-name-kana`,`first-name-kana`,`birth`,`user_id`) VALUES
-- ('','','','','','','');
-- INSERT INTO `categories` (`id`,`name`,`product_id`) VALUES
-- ('','','');