/*
 Navicat Premium Dump SQL

 Source Server         : yzw
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : club_management

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 21/10/2025 20:39:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '活动标题',
  `club_id` int NOT NULL COMMENT '所属社团',
  `start_time` datetime NOT NULL COMMENT '活动开始时间',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '活动地点',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '1-正常,0-取消',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_activity_club`(`club_id` ASC) USING BTREE,
  CONSTRAINT `fk_activity_club` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for activity_signup
-- ----------------------------
DROP TABLE IF EXISTS `activity_signup`;
CREATE TABLE `activity_signup`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `activity_id` int NOT NULL,
  `signup_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '报名备注',
  `approved` tinyint(1) NULL DEFAULT NULL COMMENT '审批状态：1-通过，0-拒绝，NULL-待审批',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_activity_user`(`activity_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `fk_as_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_as_activity` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_as_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for club
-- ----------------------------
DROP TABLE IF EXISTS `club`;
CREATE TABLE `club`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '社团id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '社团名字',
  `category` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类别：体育/文艺/...',
  `intro` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '社团简介',
  `founder_id` int NOT NULL COMMENT '创建人id(关联user表)',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1-正常，2-解散',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cover_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name` ASC) USING BTREE,
  INDEX `fk_founder`(`founder_id` ASC) USING BTREE,
  CONSTRAINT `fk_founder` FOREIGN KEY (`founder_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for club_apply
-- ----------------------------
DROP TABLE IF EXISTS `club_apply`;
CREATE TABLE `club_apply`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `club_id` int NOT NULL,
  `user_id` int NOT NULL,
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '申请理由',
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending' COMMENT '申请状态',
  `apply_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
  `review_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_club_user_apply`(`club_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `fk_ca_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_ca_club` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_ca_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for club_member
-- ----------------------------
DROP TABLE IF EXISTS `club_member`;
CREATE TABLE `club_member`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `club_id` int NOT NULL,
  `user_id` int NOT NULL,
  `join_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_club_user`(`club_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `fk_cm_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_cm_club` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cm_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fund
-- ----------------------------
DROP TABLE IF EXISTS `fund`;
CREATE TABLE `fund`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '经费记录ID',
  `club_id` int NOT NULL COMMENT '所属社团ID（关联club表）',
  `type` tinyint(1) NOT NULL COMMENT '类型：1-收入，2-支出',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额（保留2位小数）',
  `source_or_purpose` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '来源/用途（收入填来源，支出填用途）',
  `operator_id` int NOT NULL COMMENT '操作人ID（关联user表，通常为社团管理员）',
  `proof_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '凭证说明（如：2024.05.20发票编号12345/转账截图已存档）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录时间',
  `fund_date` date NULL DEFAULT NULL COMMENT '经费日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_fund_club`(`club_id` ASC) USING BTREE,
  INDEX `fk_fund_operator`(`operator_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  CONSTRAINT `fk_fund_club` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_fund_operator` FOREIGN KEY (`operator_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1-学生，2-社团管理员',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `student_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学号（学生专属）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `student_id`(`student_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
