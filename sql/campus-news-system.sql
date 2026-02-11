/*
 Navicat Premium Dump SQL

 Source Server         : local2
 Source Server Type    : MySQL
 Source Server Version : 50743 (5.7.43-log)
 Source Host           : localhost:3306
 Source Schema         : campus-news-system

 Target Server Type    : MySQL
 Target Server Version : 50743 (5.7.43-log)
 File Encoding         : 65001

 Date: 24/08/2025 22:26:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for action_operation
-- ----------------------------
DROP TABLE IF EXISTS `action_operation`;
CREATE TABLE `action_operation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID，自增',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID，外键，关联的是用户表，标识哪个用户产生的行为记录',
  `news_id` int(11) NULL DEFAULT NULL COMMENT '新闻ID，外键，关联的是新闻表，标识哪篇新闻产生的行为操作',
  `type` int(2) NULL DEFAULT NULL COMMENT '行为类型（1：点赞行为；2：阅读行为；3：收藏行为；4：停留行为）',
  `times` bigint(20) NULL DEFAULT NULL COMMENT '停留时间（只有当行为操作是停留时才需要设置）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 243 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '行为操作实体' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of action_operation
-- ----------------------------
INSERT INTO `action_operation` VALUES (15, 62, 4, 1, NULL, '2025-08-20 17:31:26');
INSERT INTO `action_operation` VALUES (24, 62, 1, 2, NULL, '2025-06-20 17:36:49');
INSERT INTO `action_operation` VALUES (29, 62, 4, 2, NULL, '2025-08-20 17:37:49');
INSERT INTO `action_operation` VALUES (30, 62, 4, 2, NULL, '2025-08-20 17:37:58');
INSERT INTO `action_operation` VALUES (31, 62, 4, 2, NULL, '2025-08-20 17:56:17');
INSERT INTO `action_operation` VALUES (32, 62, 4, 2, NULL, '2025-08-20 17:56:53');
INSERT INTO `action_operation` VALUES (33, 62, 4, 2, NULL, '2025-08-20 17:57:16');
INSERT INTO `action_operation` VALUES (34, 62, 4, 2, NULL, '2025-08-20 17:57:30');
INSERT INTO `action_operation` VALUES (35, 62, 4, 2, NULL, '2025-08-20 17:57:34');
INSERT INTO `action_operation` VALUES (36, 62, 4, 2, NULL, '2025-08-20 17:57:56');
INSERT INTO `action_operation` VALUES (37, 62, 4, 2, NULL, '2025-08-20 17:59:01');
INSERT INTO `action_operation` VALUES (38, 62, 1, 2, NULL, '2025-08-20 17:59:35');
INSERT INTO `action_operation` VALUES (40, 62, 1, 2, NULL, '2025-08-20 17:59:41');
INSERT INTO `action_operation` VALUES (41, 62, 1, 2, NULL, '2025-08-20 17:59:46');
INSERT INTO `action_operation` VALUES (42, 62, 1, 2, NULL, '2025-08-20 18:00:16');
INSERT INTO `action_operation` VALUES (43, 62, 1, 2, NULL, '2025-08-20 18:00:17');
INSERT INTO `action_operation` VALUES (44, 62, 1, 2, NULL, '2025-08-20 18:00:19');
INSERT INTO `action_operation` VALUES (45, 62, 1, 2, NULL, '2025-08-20 18:00:22');
INSERT INTO `action_operation` VALUES (46, 62, 1, 2, NULL, '2025-08-20 18:00:24');
INSERT INTO `action_operation` VALUES (49, 62, 1, 1, NULL, '2025-08-20 18:00:31');
INSERT INTO `action_operation` VALUES (50, 62, 1, 2, NULL, '2025-08-20 18:04:24');
INSERT INTO `action_operation` VALUES (51, 62, 1, 2, NULL, '2025-08-20 18:09:57');
INSERT INTO `action_operation` VALUES (52, 62, 10, 2, NULL, '2025-08-21 14:59:00');
INSERT INTO `action_operation` VALUES (53, 62, 7, 2, NULL, '2025-08-21 14:59:08');
INSERT INTO `action_operation` VALUES (54, 62, 1, 2, NULL, '2025-08-21 15:07:24');
INSERT INTO `action_operation` VALUES (55, 62, 1, 2, NULL, '2025-08-21 15:08:05');
INSERT INTO `action_operation` VALUES (56, 62, 1, 2, NULL, '2025-08-21 15:10:14');
INSERT INTO `action_operation` VALUES (57, 62, 1, 2, NULL, '2025-08-21 15:12:11');
INSERT INTO `action_operation` VALUES (58, 62, 1, 2, NULL, '2025-08-21 15:12:59');
INSERT INTO `action_operation` VALUES (59, 62, 1, 2, NULL, '2025-08-21 15:13:05');
INSERT INTO `action_operation` VALUES (60, 62, 1, 2, NULL, '2025-08-21 15:13:09');
INSERT INTO `action_operation` VALUES (61, 62, 1, 2, NULL, '2025-08-21 15:13:17');
INSERT INTO `action_operation` VALUES (62, 62, 1, 2, NULL, '2025-08-21 15:13:19');
INSERT INTO `action_operation` VALUES (63, 62, 1, 2, NULL, '2025-08-21 15:13:35');
INSERT INTO `action_operation` VALUES (64, 62, 1, 2, NULL, '2025-08-21 15:13:37');
INSERT INTO `action_operation` VALUES (65, 62, 1, 2, NULL, '2025-08-21 15:13:39');
INSERT INTO `action_operation` VALUES (66, 62, 1, 2, NULL, '2025-08-21 15:13:41');
INSERT INTO `action_operation` VALUES (67, 62, 1, 2, NULL, '2025-08-21 15:14:14');
INSERT INTO `action_operation` VALUES (68, 62, 1, 2, NULL, '2025-08-21 15:14:20');
INSERT INTO `action_operation` VALUES (69, 62, 1, 2, NULL, '2025-08-21 15:14:25');
INSERT INTO `action_operation` VALUES (70, 62, 1, 2, NULL, '2025-08-21 15:14:29');
INSERT INTO `action_operation` VALUES (71, 62, 1, 2, NULL, '2025-08-21 15:14:32');
INSERT INTO `action_operation` VALUES (72, 62, 1, 2, NULL, '2025-08-21 15:14:47');
INSERT INTO `action_operation` VALUES (73, 62, 1, 2, NULL, '2025-08-21 15:15:07');
INSERT INTO `action_operation` VALUES (74, 62, 1, 4, 27562, '2025-08-21 15:15:15');
INSERT INTO `action_operation` VALUES (75, 62, 1, 4, 7789, '2025-08-21 15:15:15');
INSERT INTO `action_operation` VALUES (76, 62, 9, 2, NULL, '2025-08-21 15:15:23');
INSERT INTO `action_operation` VALUES (77, 62, 9, 4, 8508, '2025-08-21 15:15:32');
INSERT INTO `action_operation` VALUES (78, 62, 1, 2, NULL, '2025-08-21 16:26:21');
INSERT INTO `action_operation` VALUES (79, 62, 1, 4, 5227, '2025-08-21 16:26:26');
INSERT INTO `action_operation` VALUES (80, 62, 10, 2, NULL, '2025-08-21 16:41:09');
INSERT INTO `action_operation` VALUES (81, 62, 10, 4, 3050, '2025-08-21 16:41:12');
INSERT INTO `action_operation` VALUES (82, 62, 5, 2, NULL, '2025-08-21 16:48:03');
INSERT INTO `action_operation` VALUES (83, 62, 5, 4, 2254, '2025-08-21 16:48:06');
INSERT INTO `action_operation` VALUES (84, 62, 13, 2, NULL, '2025-08-21 16:49:06');
INSERT INTO `action_operation` VALUES (86, 62, 13, 4, 3495, '2025-08-21 16:49:09');
INSERT INTO `action_operation` VALUES (87, 62, 6, 2, NULL, '2025-08-21 16:57:40');
INSERT INTO `action_operation` VALUES (88, 62, 6, 4, 5598, '2025-08-21 16:57:46');
INSERT INTO `action_operation` VALUES (89, 62, 11, 2, NULL, '2025-08-21 17:00:26');
INSERT INTO `action_operation` VALUES (90, 62, 11, 1, NULL, '2025-08-21 17:00:39');
INSERT INTO `action_operation` VALUES (91, 62, 11, 4, 16951, '2025-08-21 17:00:43');
INSERT INTO `action_operation` VALUES (92, 62, 8, 2, NULL, '2025-08-21 17:05:51');
INSERT INTO `action_operation` VALUES (93, 62, 8, 4, 53730, '2025-08-21 17:06:44');
INSERT INTO `action_operation` VALUES (94, 62, 12, 2, NULL, '2025-08-22 14:11:46');
INSERT INTO `action_operation` VALUES (95, 62, 12, 4, 3351, '2025-08-22 14:11:49');
INSERT INTO `action_operation` VALUES (96, 62, 1, 2, NULL, '2025-08-22 14:30:57');
INSERT INTO `action_operation` VALUES (97, 62, 13, 2, NULL, '2025-08-22 14:31:02');
INSERT INTO `action_operation` VALUES (98, 62, 13, 4, 2301, '2025-08-22 14:31:05');
INSERT INTO `action_operation` VALUES (99, 62, 1, 4, 12715, '2025-08-22 14:31:09');
INSERT INTO `action_operation` VALUES (100, 62, 6, 2, NULL, '2025-08-22 14:31:15');
INSERT INTO `action_operation` VALUES (101, 62, 6, 3, NULL, '2025-08-22 14:31:16');
INSERT INTO `action_operation` VALUES (102, 62, 6, 2, NULL, '2025-08-22 14:31:18');
INSERT INTO `action_operation` VALUES (103, 62, 6, 4, 4272, '2025-08-22 14:31:22');
INSERT INTO `action_operation` VALUES (104, 62, 6, 4, 20103, '2025-08-22 14:31:35');
INSERT INTO `action_operation` VALUES (105, 62, 14, 2, NULL, '2025-08-22 14:31:38');
INSERT INTO `action_operation` VALUES (106, 62, 14, 3, NULL, '2025-08-22 14:31:40');
INSERT INTO `action_operation` VALUES (107, 62, 14, 4, 3072, '2025-08-22 14:31:41');
INSERT INTO `action_operation` VALUES (108, 62, 14, 2, NULL, '2025-08-22 14:31:47');
INSERT INTO `action_operation` VALUES (109, 62, 14, 4, 3213, '2025-08-22 14:31:50');
INSERT INTO `action_operation` VALUES (110, 62, 1, 2, NULL, '2025-08-24 14:29:27');
INSERT INTO `action_operation` VALUES (111, 62, 1, 4, -6511, '2025-08-24 14:29:31');
INSERT INTO `action_operation` VALUES (112, 62, 13, 2, NULL, '2025-08-24 14:43:10');
INSERT INTO `action_operation` VALUES (113, 62, 13, 4, 2583, '2025-08-24 14:43:13');
INSERT INTO `action_operation` VALUES (114, 62, 13, 2, NULL, '2025-08-24 14:46:05');
INSERT INTO `action_operation` VALUES (115, 62, 13, 4, 7262, '2025-08-24 14:46:12');
INSERT INTO `action_operation` VALUES (116, 62, 6, 2, NULL, '2025-08-24 14:50:39');
INSERT INTO `action_operation` VALUES (117, 62, 6, 4, 3010, '2025-08-24 14:50:42');
INSERT INTO `action_operation` VALUES (118, 1, 14, 2, NULL, '2025-08-24 19:59:28');
INSERT INTO `action_operation` VALUES (119, 1, 14, 2, NULL, '2025-08-24 20:01:02');
INSERT INTO `action_operation` VALUES (120, 1, 13, 2, NULL, '2025-08-24 20:01:32');
INSERT INTO `action_operation` VALUES (121, 1, 14, 2, NULL, '2025-08-24 20:01:57');
INSERT INTO `action_operation` VALUES (122, 1, 12, 2, NULL, '2025-08-24 20:02:01');
INSERT INTO `action_operation` VALUES (123, 1, 12, 4, 12738, '2025-08-24 20:02:14');
INSERT INTO `action_operation` VALUES (124, 1, 13, 2, NULL, '2025-08-24 20:02:19');
INSERT INTO `action_operation` VALUES (125, 1, 13, 4, 96893, '2025-08-24 20:03:56');
INSERT INTO `action_operation` VALUES (126, 1, 14, 2, NULL, '2025-08-24 20:12:49');
INSERT INTO `action_operation` VALUES (127, 1, 14, 4, 72541, '2025-08-24 20:14:02');
INSERT INTO `action_operation` VALUES (128, 1, 14, 2, NULL, '2025-08-24 20:14:04');
INSERT INTO `action_operation` VALUES (129, 1, 14, 4, 84459, '2025-08-24 20:15:28');
INSERT INTO `action_operation` VALUES (130, 1, 14, 2, NULL, '2025-08-24 20:36:42');
INSERT INTO `action_operation` VALUES (131, 1, 14, 4, 2277, '2025-08-24 20:36:44');
INSERT INTO `action_operation` VALUES (132, 62, 13, 4, 2240649, '2025-08-24 20:38:53');
INSERT INTO `action_operation` VALUES (133, 62, 14, 4, 2216024, '2025-08-24 20:38:53');
INSERT INTO `action_operation` VALUES (134, 62, 8, 2, NULL, '2025-08-24 21:07:33');
INSERT INTO `action_operation` VALUES (135, 62, 8, 3, NULL, '2025-08-24 21:07:35');
INSERT INTO `action_operation` VALUES (136, 62, 8, 4, 4245, '2025-08-24 21:07:37');
INSERT INTO `action_operation` VALUES (137, 62, 5, 2, NULL, '2025-08-24 21:07:39');
INSERT INTO `action_operation` VALUES (138, 62, 5, 1, NULL, '2025-08-24 21:07:40');
INSERT INTO `action_operation` VALUES (139, 62, 5, 4, 3003, '2025-08-24 21:07:42');
INSERT INTO `action_operation` VALUES (140, 62, 14, 2, NULL, '2025-08-24 21:09:49');
INSERT INTO `action_operation` VALUES (142, 62, 14, 4, 6343, '2025-08-24 21:09:55');
INSERT INTO `action_operation` VALUES (143, 62, 14, 2, NULL, '2025-08-24 21:10:42');
INSERT INTO `action_operation` VALUES (144, 62, 14, 2, NULL, '2025-08-24 21:11:28');
INSERT INTO `action_operation` VALUES (145, 62, 14, 2, NULL, '2025-08-24 21:11:33');
INSERT INTO `action_operation` VALUES (146, 62, 14, 2, NULL, '2025-08-24 21:11:39');
INSERT INTO `action_operation` VALUES (147, 62, 14, 2, NULL, '2025-08-24 21:11:51');
INSERT INTO `action_operation` VALUES (148, 62, 14, 2, NULL, '2025-08-24 21:12:36');
INSERT INTO `action_operation` VALUES (149, 62, 14, 4, 144004, '2025-08-24 21:13:52');
INSERT INTO `action_operation` VALUES (150, 62, 14, 4, 75630, '2025-08-24 21:13:52');
INSERT INTO `action_operation` VALUES (151, 62, 14, 4, 189637, '2025-08-24 21:13:52');
INSERT INTO `action_operation` VALUES (152, 62, 14, 4, 120840, '2025-08-24 21:13:52');
INSERT INTO `action_operation` VALUES (153, 62, 14, 4, 139221, '2025-08-24 21:13:52');
INSERT INTO `action_operation` VALUES (154, 62, 14, 4, 133321, '2025-08-24 21:13:52');
INSERT INTO `action_operation` VALUES (155, 62, 14, 2, NULL, '2025-08-24 21:13:54');
INSERT INTO `action_operation` VALUES (156, 62, 14, 4, 18924, '2025-08-24 21:14:13');
INSERT INTO `action_operation` VALUES (157, 62, 14, 2, NULL, '2025-08-24 21:14:14');
INSERT INTO `action_operation` VALUES (158, 62, 14, 4, 109215, '2025-08-24 21:16:03');
INSERT INTO `action_operation` VALUES (159, 62, 14, 2, NULL, '2025-08-24 21:16:03');
INSERT INTO `action_operation` VALUES (160, 62, 14, 4, 30561, '2025-08-24 21:16:34');
INSERT INTO `action_operation` VALUES (161, 62, 14, 2, NULL, '2025-08-24 21:16:34');
INSERT INTO `action_operation` VALUES (162, 62, 14, 4, 28007, '2025-08-24 21:17:02');
INSERT INTO `action_operation` VALUES (163, 62, 14, 2, NULL, '2025-08-24 21:17:02');
INSERT INTO `action_operation` VALUES (164, 62, 14, 2, NULL, '2025-08-24 21:17:50');
INSERT INTO `action_operation` VALUES (165, 62, 14, 2, NULL, '2025-08-24 21:18:28');
INSERT INTO `action_operation` VALUES (166, 62, 14, 2, NULL, '2025-08-24 21:18:40');
INSERT INTO `action_operation` VALUES (167, 62, 14, 2, NULL, '2025-08-24 21:18:50');
INSERT INTO `action_operation` VALUES (168, 62, 14, 2, NULL, '2025-08-24 21:19:00');
INSERT INTO `action_operation` VALUES (169, 62, 14, 2, NULL, '2025-08-24 21:19:08');
INSERT INTO `action_operation` VALUES (170, 62, NULL, 2, NULL, '2025-08-24 21:19:32');
INSERT INTO `action_operation` VALUES (171, 62, 14, 4, 151885, '2025-08-24 21:19:34');
INSERT INTO `action_operation` VALUES (172, 62, 14, 4, 103931, '2025-08-24 21:19:34');
INSERT INTO `action_operation` VALUES (173, 62, 14, 4, 66071, '2025-08-24 21:19:34');
INSERT INTO `action_operation` VALUES (174, 62, 14, 4, 53507, '2025-08-24 21:19:34');
INSERT INTO `action_operation` VALUES (175, 62, 14, 4, 43494, '2025-08-24 21:19:34');
INSERT INTO `action_operation` VALUES (176, 62, 14, 4, 33654, '2025-08-24 21:19:34');
INSERT INTO `action_operation` VALUES (177, 62, 14, 4, 25886, '2025-08-24 21:19:34');
INSERT INTO `action_operation` VALUES (178, 62, NULL, 2, NULL, '2025-08-24 21:19:34');
INSERT INTO `action_operation` VALUES (179, 62, 14, 2, NULL, '2025-08-24 21:20:01');
INSERT INTO `action_operation` VALUES (180, 62, 14, 4, 29824, '2025-08-24 21:20:04');
INSERT INTO `action_operation` VALUES (181, 62, 14, 4, 2772, '2025-08-24 21:20:04');
INSERT INTO `action_operation` VALUES (182, 62, 14, 2, NULL, '2025-08-24 21:20:04');
INSERT INTO `action_operation` VALUES (183, 62, 13, 2, NULL, '2025-08-24 21:20:07');
INSERT INTO `action_operation` VALUES (184, 62, 12, 2, NULL, '2025-08-24 21:20:09');
INSERT INTO `action_operation` VALUES (185, 62, 14, 2, NULL, '2025-08-24 21:20:11');
INSERT INTO `action_operation` VALUES (186, 62, 14, 2, NULL, '2025-08-24 21:20:44');
INSERT INTO `action_operation` VALUES (187, 62, 14, 4, 34623, '2025-08-24 21:20:46');
INSERT INTO `action_operation` VALUES (188, 62, 14, 4, 1668, '2025-08-24 21:20:46');
INSERT INTO `action_operation` VALUES (189, 62, 14, 2, NULL, '2025-08-24 21:20:46');
INSERT INTO `action_operation` VALUES (190, 62, 13, 2, NULL, '2025-08-24 21:20:47');
INSERT INTO `action_operation` VALUES (191, 62, 12, 2, NULL, '2025-08-24 21:20:50');
INSERT INTO `action_operation` VALUES (192, 62, 14, 2, NULL, '2025-08-24 21:20:51');
INSERT INTO `action_operation` VALUES (193, 62, 13, 2, NULL, '2025-08-24 21:20:53');
INSERT INTO `action_operation` VALUES (194, 62, 12, 2, NULL, '2025-08-24 21:20:59');
INSERT INTO `action_operation` VALUES (195, 62, 13, 2, NULL, '2025-08-24 21:21:02');
INSERT INTO `action_operation` VALUES (196, 1, 14, 2, NULL, '2025-08-24 21:21:49');
INSERT INTO `action_operation` VALUES (197, 1, 12, 2, NULL, '2025-08-24 21:21:57');
INSERT INTO `action_operation` VALUES (198, 1, 14, 2, NULL, '2025-08-24 21:22:01');
INSERT INTO `action_operation` VALUES (199, 1, 14, 3, NULL, '2025-08-24 21:22:04');
INSERT INTO `action_operation` VALUES (200, 62, 13, 4, 72931, '2025-08-24 21:22:15');
INSERT INTO `action_operation` VALUES (201, 62, 14, 2, NULL, '2025-08-24 21:22:19');
INSERT INTO `action_operation` VALUES (202, 62, 14, 1, NULL, '2025-08-24 21:22:26');
INSERT INTO `action_operation` VALUES (203, 62, 14, 4, 9857, '2025-08-24 21:22:29');
INSERT INTO `action_operation` VALUES (204, 62, 5, 2, NULL, '2025-08-24 21:22:37');
INSERT INTO `action_operation` VALUES (205, 62, 5, 3, NULL, '2025-08-24 21:22:40');
INSERT INTO `action_operation` VALUES (206, 62, 5, 4, 4482, '2025-08-24 21:22:42');
INSERT INTO `action_operation` VALUES (207, 62, 14, 2, NULL, '2025-08-24 21:48:54');
INSERT INTO `action_operation` VALUES (208, 62, 14, 2, NULL, '2025-08-24 21:49:38');
INSERT INTO `action_operation` VALUES (209, 62, 13, 2, NULL, '2025-08-24 21:53:21');
INSERT INTO `action_operation` VALUES (210, 62, 13, 4, 626992, '2025-08-24 22:03:48');
INSERT INTO `action_operation` VALUES (211, 62, 14, 4, 849811, '2025-08-24 22:03:48');
INSERT INTO `action_operation` VALUES (212, 62, 12, 2, NULL, '2025-08-24 22:09:15');
INSERT INTO `action_operation` VALUES (213, 62, 12, 4, 2111, '2025-08-24 22:09:17');
INSERT INTO `action_operation` VALUES (214, 62, 13, 2, NULL, '2025-08-24 22:09:18');
INSERT INTO `action_operation` VALUES (215, 62, 13, 4, 1051, '2025-08-24 22:09:19');
INSERT INTO `action_operation` VALUES (216, 62, 14, 2, NULL, '2025-08-24 22:09:20');
INSERT INTO `action_operation` VALUES (217, 62, 14, 4, 5286, '2025-08-24 22:09:26');
INSERT INTO `action_operation` VALUES (218, 62, 12, 2, NULL, '2025-08-24 22:09:28');
INSERT INTO `action_operation` VALUES (219, 62, 12, 3, NULL, '2025-08-24 22:09:45');
INSERT INTO `action_operation` VALUES (220, 62, 12, 1, NULL, '2025-08-24 22:09:50');
INSERT INTO `action_operation` VALUES (221, 62, 12, 4, 68854, '2025-08-24 22:10:37');
INSERT INTO `action_operation` VALUES (222, 62, 12, 2, NULL, '2025-08-24 22:10:37');
INSERT INTO `action_operation` VALUES (223, 62, 12, 2, NULL, '2025-08-24 22:10:41');
INSERT INTO `action_operation` VALUES (224, 62, 14, 2, NULL, '2025-08-24 22:10:43');
INSERT INTO `action_operation` VALUES (225, 62, 13, 2, NULL, '2025-08-24 22:10:46');
INSERT INTO `action_operation` VALUES (226, 62, 12, 2, NULL, '2025-08-24 22:10:50');
INSERT INTO `action_operation` VALUES (227, 62, 12, 4, 16559, '2025-08-24 22:11:06');
INSERT INTO `action_operation` VALUES (228, 62, 4, 2, NULL, '2025-08-24 22:12:09');
INSERT INTO `action_operation` VALUES (230, 62, 4, 2, NULL, '2025-08-24 22:12:16');
INSERT INTO `action_operation` VALUES (231, 62, 4, 4, 26403, '2025-08-24 22:12:42');
INSERT INTO `action_operation` VALUES (232, 62, 4, 4, 34317, '2025-08-24 22:12:43');
INSERT INTO `action_operation` VALUES (233, 62, 10, 2, NULL, '2025-08-24 22:13:03');
INSERT INTO `action_operation` VALUES (234, 62, 10, 4, 2267, '2025-08-24 22:13:06');
INSERT INTO `action_operation` VALUES (235, 62, 8, 2, NULL, '2025-08-24 22:13:26');
INSERT INTO `action_operation` VALUES (236, 62, 8, 4, 1721, '2025-08-24 22:13:27');
INSERT INTO `action_operation` VALUES (237, 1, 14, 2, NULL, '2025-08-24 22:18:00');
INSERT INTO `action_operation` VALUES (238, 1, 14, 4, 4191, '2025-08-24 22:18:04');
INSERT INTO `action_operation` VALUES (239, 1, 14, 2, NULL, '2025-08-24 22:19:46');
INSERT INTO `action_operation` VALUES (240, 1, 14, 4, 7532, '2025-08-24 22:19:53');
INSERT INTO `action_operation` VALUES (241, 1, 14, 2, NULL, '2025-08-24 22:22:16');
INSERT INTO `action_operation` VALUES (242, 1, 14, 4, 9603, '2025-08-24 22:22:26');

-- ----------------------------
-- Table structure for evaluations
-- ----------------------------
DROP TABLE IF EXISTS `evaluations`;
CREATE TABLE `evaluations`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父级评论ID',
  `commenter_id` int(11) NULL DEFAULT NULL COMMENT '评论者ID',
  `replier_id` int(11) NULL DEFAULT NULL COMMENT '回复者ID',
  `content_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '内容类型',
  `content_id` int(11) NULL DEFAULT NULL COMMENT '内容ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '评论内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of evaluations
-- ----------------------------
INSERT INTO `evaluations` VALUES (1, NULL, 62, NULL, 'NEWS', 1, '涵盖心血管、代谢、运动等多个健康', '2025-08-18 16:42:49');
INSERT INTO `evaluations` VALUES (2, 1, 62, NULL, 'NEWS', 1, '、代谢、运动等多个健康维度，满足基础健康监测场景\n\n涵盖心血管、代谢、运动等多个健康维度，满足基础健康', '2025-08-18 16:43:35');
INSERT INTO `evaluations` VALUES (3, NULL, 62, NULL, 'NEWS', 11, '实至名归！', '2025-08-21 17:00:37');
INSERT INTO `evaluations` VALUES (4, NULL, 62, NULL, 'NEWS', 8, '申报材料需真实有效，如有伪造、虚报情况', '2025-08-21 17:06:35');
INSERT INTO `evaluations` VALUES (5, NULL, 62, NULL, 'NEWS', 14, '全” 理念，采用光伏供电系统', '2025-08-24 21:16:47');
INSERT INTO `evaluations` VALUES (6, NULL, 62, NULL, 'NEWS', 13, '信息、材料科学等 6 个学科的实验教学区，将为师生提供更优质的科研实践平台，助力学校人才培养与科研创新再上新', '2025-08-24 21:20:57');
INSERT INTO `evaluations` VALUES (7, NULL, 1, NULL, 'NEWS', 14, '堂吃饭，排队要 20 多分钟，现在提前在小程序下单，到食堂就能直接取餐，省了不少时间。” 计算机学院的王同学拿着刚取到的餐品说。后勤管理处负责人表示，食堂改造后还会定期开展 “菜品满', '2025-08-24 21:22:09');

-- ----------------------------
-- Table structure for evaluations_upvote
-- ----------------------------
DROP TABLE IF EXISTS `evaluations_upvote`;
CREATE TABLE `evaluations_upvote`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论点赞表ID',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `evaluations_id` int(11) NULL DEFAULT NULL COMMENT '点赞ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of evaluations_upvote
-- ----------------------------
INSERT INTO `evaluations_upvote` VALUES (1, 62, 1);
INSERT INTO `evaluations_upvote` VALUES (2, 62, 2);

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID，自增',
  `news_type_id` int(11) NULL DEFAULT NULL COMMENT '新闻类别ID，外键，在后端枚举类里面定义',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '新闻标题',
  `summary` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '摘要',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '封面',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '内容',
  `is_show` tinyint(1) NULL DEFAULT NULL COMMENT '是否展示（1：展示；0：不展示）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '校园新闻信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, 2, '涵盖心血管、代谢、运动个健康维度，满足基础健康监测场景', '代谢、运动等多个健康维度，满足基础健康监测场景涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景', '/api/v1.0/campus-news-api/file/getFile?fileName=1755322259608cover4.png', '<p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p><p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p><p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p><p><img src=\"/api/v1.0/campus-news-api/file/getFile?fileName=175532232024214.jpg\" alt=\"/api/v1.0/campus-news-api/file/getFile?fileName=175532232024214.jpg\" data-href=\"/api/v1.0/campus-news-api/file/getFile?fileName=175532232024214.jpg\" style=\"width: 50%;\"/></p><p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p><p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p><p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p><p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p>', 1, '2025-08-16 13:32:04');
INSERT INTO `news` VALUES (4, 3, '【重磅消息】测试数据', '代谢、运动等多个健康维度，满足基础健康监测场景涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景', '/api/v1.0/campus-news-api/file/getFile?fileName=175550407071212.jpg', '<p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p><p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p><p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p><p><img src=\"/api/v1.0/campus-news-api/file/getFile?fileName=175532232024214.jpg\" alt=\"/api/v1.0/campus-news-api/file/getFile?fileName=175532232024214.jpg\" data-href=\"/api/v1.0/campus-news-api/file/getFile?fileName=175532232024214.jpg\" style=\"width: 100%;\"/> </p><p><br></p><p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p><p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p><p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p><p>涵盖心血管、代谢、运动等多个健康维度，满足基础健康监测场景</p>', 1, '2025-08-18 16:01:16');
INSERT INTO `news` VALUES (5, 5, '筑牢校园安全防线，这份 “守护指南” 请查收！', '安全，是校园生活的 “基石”，关乎每一位师生的日常出行、学习与生活。从教室到宿舍，从食堂到操场，看似熟悉的校园场景里，藏着需要我们共同留意的安全细节。为了让安全意识融入校园的每一个角落，这份涵盖多场景的校园安全提示，邀您一起学习、共同践行。', '/api/v1.0/campus-news-api/file/getFile?fileName=1755757912165Snipaste_2025-08-21_14-28-44.png', '<p>安全，是校园生活的 “基石”，关乎每一位师生的日常出行、学习与生活。从教室到宿舍，从食堂到操场，看似熟悉的校园场景里，藏着需要我们共同留意的安全细节。为了让安全意识融入校园的每一个角落，这份涵盖多场景的校园安全提示，邀您一起学习、共同践行。</p><h2 style=\"text-align: start;\">一、“防患未然”：校园日常安全要记牢</h2><p>教室与实验室是学习科研的主阵地，也是安全防护的重点区域。离开教室前，请务必检查门窗是否锁好，个人电子设备、书本等物品是否随身携带，避免财物遗失；进入实验室操作时，需严格遵守老师指导，不随意触碰危险试剂或仪器，实验结束后及时清理台面、关闭电源与水源，不给安全隐患留机会。<br></p><p>宿舍是师生的 “第二个家”，用电安全尤其关键。请坚决杜绝 “飞线充电”“大功率电器违规使用” 等行为，充电宝、手机等设备充电时避免长时间覆盖杂物，离开宿舍前拔掉所有非必要电源；同时，不存放易燃易爆物品，定期整理宿舍内务，保持消防通道畅通，牢记 “小火快逃、浓烟关门” 的逃生常识。</p><h2 style=\"text-align: start;\">二、“警惕陷阱”：校园反诈与网络安全别忽视</h2><p>随着网络的普及，校园诈骗手段也在不断翻新。近期，“虚假兼职”“冒充电商客服退款”“伪造助学金申请” 等骗局频发，骗子常以 “低投入高回报”“紧急处理” 为诱饵，诱导师生泄露个人信息或转账。在此提醒：凡是要求 “先交押金”“提供银行卡密码” 的兼职，凡是自称 “官方” 却通过私人账号联系的退款，凡是陌生链接要求填写身份证、手机号的操作，都要多留一个心眼，及时向学校保卫处或辅导员核实，避免财产损失。<br></p><p>网络社交与信息发布同样需要谨慎。不在校园群、朋友圈等平台随意透露个人住址、课表、行程等隐私信息；不随意点击不明来源的链接，不下载非官方渠道的 APP，防止手机被植入恶意软件；遇到网络谣言或不良信息时，不传播、不扩散，可通过学校官方渠道举报，共同维护清朗的校园网络环境。</p><h2 style=\"text-align: start;\">三、“暖心守护”：公益行动让安全更有温度</h2><p>校园安全不仅需要 “个人警惕”，更需要 “集体守护”。学校保卫处联合学生会近期发起 “校园安全志愿巡查” 活动，招募师生志愿者在课间、晚自习后等重点时段，对校园主干道、偏僻角落进行安全巡查，及时劝阻不文明行为、排查安全隐患；同时，在宿舍楼下、教学楼大厅设置 “安全意见箱”，欢迎大家提出安全改进建议，让每一份关注都能转化为校园安全的 “加固剂”。<br></p><p>此外，学校心理健康中心与保卫处将定期开展 “安全与心理” 主题讲座，邀请民警、心理老师现场讲解反诈技巧、应急避险方法，帮助大家在提升安全意识的同时，学会调节焦虑情绪，以更从容的心态面对校园生活。<br></p><p>安全无小事，责任在人心。校园的平安与和谐，需要每一位师生的参与和守护。让我们从现在做起，把安全知识记在心中、落在行动上，共同打造一个 “放心、安心、暖心” 的校园环境，让学习更安心，让生活更舒心！</p>', 1, '2025-08-21 14:31:54');
INSERT INTO `news` VALUES (6, 5, '校园防火：这些 “隐形火源”，请你我共同排查！', '随着秋冬季节来临，天干物燥，火灾隐患风险增加，为守护校园安全，我们需一起揪出那些容易被忽视的 “隐形火源”，筑牢校园防火屏障。', '/api/v1.0/campus-news-api/file/getFile?fileName=1755757978294Snipaste_2025-08-21_14-28-23.png', '<p>“隐患险于明火，防范胜于救灾”，校园里的防火安全，从来不是一句口号，而是藏在每一次随手关闭电源、每一次规范存放物品的细节里。随着秋冬季节来临，天干物燥，火灾隐患风险增加，为守护校园安全，我们需一起揪出那些容易被忽视的 “隐形火源”，筑牢校园防火屏障。<br></p><p>教室、图书馆等公共区域，是防火排查的 “第一站”。课间休息或放学后，常有同学因匆忙离开，忘记关闭投影仪、电脑等设备电源，长时间通电的电器不仅耗电，还可能因线路老化引发短路；部分同学习惯在教室插座上同时连接多个插线板，“多头用电” 易导致线路过载，埋下火灾隐患。在此提醒：离开公共区域前，务必花 10 秒检查电器电源是否关闭，插线板使用不超过 2 个串联，不私拉乱接电线。<br></p><p>宿舍作为师生休息的私密空间，防火要求更需严格遵守。有些同学为图方便，将充电宝放在枕头旁充电，或用衣物覆盖正在充电的手机，一旦设备过热引发自燃，后果不堪设想；还有同学在宿舍使用电火锅、电暖器等大功率电器，这类设备远超宿舍电路承载负荷，极易引发线路起火。学校早已明确规定禁止宿舍使用大功率电器，这不仅是制度要求，更是对自己和他人安全的负责 —— 请记住，“不违规用电” 是宿舍防火的 “第一道防线”。<br></p><p>除了用电安全，易燃易爆物品的存放也需格外留意。部分同学喜欢在宿舍存放香水、发胶等喷雾类物品，这类物品属于易燃品，遇高温或明火可能引发爆炸；实验室的酒精、汽油等试剂，需严格按照老师要求存放在专用储物柜，不私自带出实验室或存放在个人抽屉。同时，每位师生都应熟悉校园消防设施位置，牢记 “小火用灭火器、大火先逃生” 的原则：发现初期火情，可使用就近的灭火器扑灭（使用前需确认灭火器在有效期内）；若火势蔓延，立即用湿毛巾捂住口鼻，沿着疏散指示标志弯腰逃生，切勿乘坐电梯。<br></p><p>校园防火，没有 “旁观者”，只有 “参与者”。近期，学校保卫处将组织 “校园防火公益巡查” 活动，志愿者们会在教学楼、宿舍区开展防火知识宣传与隐患排查，也欢迎同学们加入 —— 发现未关闭的电源、违规存放的易燃品，可随时联系保卫处（电话：XXX-XXXXXXX）。让我们从 “随手关电源”“不违规用电” 的小事做起，用共同的行动，守护校园的平安与温暖。</p>', 1, '2025-08-21 14:33:00');
INSERT INTO `news` VALUES (7, 5, '拒绝校园欺凌，用 “温暖” 守护每一颗心', '为让反欺凌意识深入人心，学校学生会近期将开展 “反校园欺凌公益周” 活动', '/api/v1.0/campus-news-api/file/getFile?fileName=1755758023904Snipaste_2025-08-21_14-29-09.png', '<p>“同学之间的玩笑，怎么就成了欺凌？”“看到有人被孤立，我该上前帮忙吗？” 在校园生活中，有些看似 “小事” 的言行，可能已触碰校园欺凌的边界；有些被忽视的 “沉默”，可能让受欺凌者陷入更深的无助。校园安全不仅是身体的平安，更包括心理的健康 —— 拒绝校园欺凌，需要每一位师生放下 “旁观者” 心态，用理解、勇敢与温暖，为同学筑起一道 “守护墙”。<br></p><p>首先，我们要认清：哪些行为属于校园欺凌？并非只有肢体冲突才是欺凌，故意给同学起侮辱性绰号、在班级群里散布他人隐私、联合其他同学孤立某个人、强迫同学做不愿意做的事（如代写作业、交出零花钱）等，都属于校园欺凌的范畴。这些行为看似 “没动手”，却会给受欺凌者带来长期的心理伤害，甚至影响其学习与生活。在此呼吁：当发现身边有同学被起恶意绰号、被孤立时，不要跟风参与，也不要保持沉默 —— 一句 “这样不对” 的提醒，一次主动邀请受孤立同学加入活动的举动，都能成为打破欺凌的 “微光”。<br></p><p>其次，面对欺凌，“勇敢说不” 与 “及时求助” 同样重要。如果自己遭遇欺凌，不要因害怕而隐瞒，可第一时间向班主任、辅导员或家长说明情况，也可通过学校 “心理健康热线”（电话：XXX-XXXXXXX）寻求帮助；若看到他人遭遇欺凌，不要因担心 “惹麻烦” 而退缩，可悄悄用手机记录证据（注意保护自身安全），随后向学校保卫处或德育处反映，让欺凌行为及时被制止。学校始终坚持 “零容忍” 态度对待校园欺凌，会对欺凌者进行批评教育与行为矫正，同时为受欺凌者提供心理疏导，确保每一位同学都能在安全的环境中成长。</p><p>为让反欺凌意识深入人心，学校学生会近期将开展 “反校园欺凌公益周” 活动：校园广场会设置 “反欺凌签名墙”，邀请师生写下对 “友善校园” 的期待；心理社团将组织 “同伴互助” 主题班会，通过情景剧、案例分享等形式，教大家识别欺凌、应对欺凌；此外，学校还会发放《反校园欺凌手册》，详细介绍应对方法与求助渠道。</p><p>校园是学习知识、收获友谊的地方，不该有欺凌的阴影。每一位同学都是校园的 “主人”，当我们对欺凌行为说 “不”，对受困同学伸援手，就能让友善成为校园的 “主旋律”。愿我们都能做 “温暖的守护者”，让每一颗心都能在校园里自由、快乐地跳动。</p>', 1, '2025-08-21 14:33:45');
INSERT INTO `news` VALUES (8, 1, '关于 2024-2025 学年优秀学生奖学金评选工作的通知', '为表彰先进、树立榜样，激励广大学生勤奋学习、积极进取，根据《XX 大学校园奖学金管理办法》及本学期教学工作安排，现将 2024-2025 学年第二学期优秀学生奖学金评选工作有关事项通知如下', '/api/v1.0/campus-news-api/file/getFile?fileName=1755758170832Snipaste_2025-08-21_14-36-04.png', '<p>各学院、全体在校学生：</p><p>为表彰先进、树立榜样，激励广大学生勤奋学习、积极进取，根据《XX 大学校园奖学金管理办法》及本学期教学工作安排，现将 2024-2025 学年第二学期优秀学生奖学金评选工作有关事项通知如下：</p><h2 style=\"text-align: start;\">一、评选对象</h2><p>2022 级、2023 级、2024 级全日制本科生（含专升本学生），2023 级、2024 级全日制研究生（休学、保留学籍及受纪律处分期间学生除外）。</p><h2 style=\"text-align: start;\">二、评选条件</h2><ol><li style=\"text-align: start;\"><span style=\"font-size: 16px;\"><strong>思想道德</strong></span>：拥护中国共产党的领导，遵守国家法律法规及学校规章制度，本学期无迟到、早退、旷课记录，未受任何纪律处分；</li><li style=\"text-align: start;\"><span style=\"font-size: 16px;\"><strong>学业成绩</strong></span>：本科生本学期平均绩点不低于 3.2（满分 5.0），无不及格课程；研究生本学期课程成绩全部合格，科研成果符合对应奖学金要求（具体见附件）；</li><li style=\"text-align: start;\"><span style=\"font-size: 16px;\"><strong>综合表现</strong></span>：积极参与校园活动、志愿服务或学科竞赛，无违规使用电器、夜不归宿等不良行为，综合素质测评等级达 “良好” 及以上。</li></ol><h2 style=\"text-align: start;\">三、奖学金类别及标准</h2><table style=\"width: auto; text-align: left;\"><tbody><tr><th colspan=\"1\" rowspan=\"1\" width=\"auto\">奖学金类别</th><th colspan=\"1\" rowspan=\"1\" width=\"auto\">奖励标准</th><th colspan=\"1\" rowspan=\"1\" width=\"auto\">评选比例</th></tr><tr><td colspan=\"1\" rowspan=\"1\" width=\"auto\">一等奖学金</td><td colspan=\"1\" rowspan=\"1\" width=\"auto\">5000 元 / 人</td><td colspan=\"1\" rowspan=\"1\" width=\"auto\">年级总人数的 5%</td></tr><tr><td colspan=\"1\" rowspan=\"1\" width=\"auto\">二等奖学金</td><td colspan=\"1\" rowspan=\"1\" width=\"auto\">3000 元 / 人</td><td colspan=\"1\" rowspan=\"1\" width=\"auto\">年级总人数的 10%</td></tr><tr><td colspan=\"1\" rowspan=\"1\" width=\"auto\">三等奖学金</td><td colspan=\"1\" rowspan=\"1\" width=\"auto\">1500 元 / 人</td><td colspan=\"1\" rowspan=\"1\" width=\"auto\">年级总人数的 15%</td></tr></tbody></table><h2 style=\"text-align: start;\">四、评选流程</h2><ol><li style=\"text-align: start;\"><span style=\"font-size: 16px;\"><strong>个人申报（X 月 X 日 - X 月 X 日）</strong></span>：符合条件的学生登录 “校园服务平台 - 学生事务 - 奖学金申报” 板块，在线填写《优秀学生奖学金申报表》，上传成绩单、综合素质证明等材料；</li><li style=\"text-align: start;\"><span style=\"font-size: 16px;\"><strong>班级初审（X 月 X 日 - X 月 X 日）</strong></span>：以班级为单位，由班主任、班委及学生代表组成评审小组，审核申报材料真实性，确定班级推荐名单并公示 3 个工作日；</li><li style=\"text-align: start;\"><span style=\"font-size: 16px;\"><strong>学院复审（X 月 X 日 - X 月 X 日）</strong></span>：学院学生工作办公室对班级推荐名单进行复核，结合学业成绩、综合表现排序，确定学院拟获奖名单并公示 5 个工作日；</li><li style=\"text-align: start;\"><span style=\"font-size: 16px;\"><strong>学校终审（X 月 X 日 - X 月 X 日）</strong></span>：学生工作处汇总各学院拟获奖名单，联合教务处、研究生院核查后，在学校官网公示 7 个工作日，公示无异议后正式发文表彰。</li></ol><h2 style=\"text-align: start;\">五、注意事项</h2><ol><li style=\"text-align: start;\">申报材料需真实有效，如有伪造、虚报情况，一经查实取消评选资格，并按《校园学生违纪处分条例》处理；</li><li style=\"text-align: start;\">各学院需于 X 月 X 日前将学院复审名单及相关材料报送至学生工作处 203 办公室；</li><li style=\"text-align: start;\">咨询电话：学生工作处 XXX-XXXXXXX；研究生院 XXX-XXXXXXX；附件可在学校官网 “通知公告” 栏下载。</li><li style=\"text-align: start;\">希望各学院高度重视此次评选工作，严格按照要求组织申报与审核；也期待广大学生积极参与，以优秀为目标，在学业与综合素质上不断突破。</li><li style=\"text-align: start;\">XX 大学学生工作处<br>2025 年 X 月 X 日</li></ol><p><br></p>', 1, '2025-08-21 14:36:21');
INSERT INTO `news` VALUES (9, 2, '关于调整 2025 年暑假放假时间及假期校园管理安排的通知', '根据教育部关于高校假期安排的指导意见，结合学校本学期教学任务完成情况及下学期开学筹备工作需求，经学校党政联席会议研究决定，对 2025 年暑假放假时间及假期校园管理安排调整如下', '/api/v1.0/campus-news-api/file/getFile?fileName=1755758922690Snipaste_2025-08-21_14-29-26.png', '<p>各学院、各部门，全体师生：</p><p>根据教育部关于高校假期安排的指导意见，结合学校本学期教学任务完成情况及下学期开学筹备工作需求，经学校党政联席会议研究决定，对 2025 年暑假放假时间及假期校园管理安排调整如下，现予以通知：</p><h2 style=\"text-align: start;\">一、放假及开学时间</h2><ol><li style=\"text-align: start;\"><span style=\"font-size: 16px;\"><strong>学生放假时间</strong></span>：2025 年 7 月 15 日至 8 月 24 日，8 月 25 日、26 日返校报到，8 月 27 日正式上课；2022 级本科生因实习需求，可申请提前至 7 月 8 日离校（需由学院统一报备教务处）；</li><li style=\"text-align: start;\"><span style=\"font-size: 16px;\"><strong>教职工放假时间</strong></span>：7 月 20 日至 8 月 20 日，7 月 15 日至 19 日、8 月 21 日至 24 日为假期值班时间，具体值班安排由各部门自行制定并报学校办公室备案；</li><li style=\"text-align: start;\"><span style=\"font-size: 16px;\"><strong>新生报到时间</strong></span>：2025 级本科生、研究生报到时间为 9 月 1 日、2 日，9 月 3 日至 9 月 16 日开展新生军训及入学教育。</li></ol><h2 style=\"text-align: start;\">二、假期校园管理安排</h2><h3 style=\"text-align: start;\">（一）学生离校与留校管理</h3><ol><li style=\"text-align: start;\">离校学生需在 7 月 14 日前登录 “校园服务平台 - 宿舍管理 - 假期离校登记” 板块，填写离校时间、目的地、联系方式及返校计划；离校前需整理宿舍内务，关闭门窗、电源、水源，将贵重物品随身携带或妥善存放；</li><li style=\"text-align: start;\">因科研、实习、家庭困难等原因需留校的学生，需于 7 月 5 日前向学院提交《假期留校申请表》，学院审核后统一报送学生工作处（本科生）、研究生院（研究生）审批；留校学生需签订《假期留校安全承诺书》，严格遵守 “每晚 23:00 前返校、不擅自留宿校外人员” 等规定；</li><li style=\"text-align: start;\">留校学生住宿统一调整至 XX 宿舍楼（本科生）、XX 宿舍楼（研究生），7 月 14 日至 15 日完成宿舍搬迁，原宿舍将进行假期维修改造。</li></ol><h3 style=\"text-align: start;\">（二）校园安全与后勤保障</h3><ol><li style=\"text-align: start;\">假期校园实行 “封闭管理”，校门开放时间为 6:00-23:00，校外人员需提前通过 “XX 大学访客预约平台” 申请，经被访单位或个人确认后，持有效证件入校；学生返校时需刷校园卡或身份证核验身份；</li><li style=\"text-align: start;\">后勤管理处将保留 XX 食堂（一层）、XX 食堂（二层）提供餐饮服务，开放时间为早餐 7:00-9:00、午餐 11:00-13:00、晚餐 17:00-19:00；校园超市、校医院（急诊）正常开放，校医院门诊时间调整为每周一、三、五 9:00-11:30；</li><li style=\"text-align: start;\">保卫处将加强校园巡逻，重点关注宿舍区、实验室、图书馆等区域安全；实验室假期开放需由指导教师提前报备科研处，严格落实 “双人双锁”“危险品管控” 等制度，杜绝安全隐患。</li></ol><h3 style=\"text-align: start;\">（三）教学与科研工作安排</h3><ol><li style=\"text-align: start;\">图书馆假期开放时间为每周二、四、六 9:00-16:00，仅开放一层自习区及二层图书借阅区，电子资源可通过校园网或 VPN 正常访问；</li><li style=\"text-align: start;\">各学院需安排专人负责假期学生实习、科研指导工作，定期与学生沟通，掌握学生动态；如有暑期实践、学科竞赛等活动，需提前向教务处、团委报备安全预案。</li></ol><h2 style=\"text-align: start;\">三、工作要求</h2><ol><li style=\"text-align: start;\">各部门需在 7 月 10 日前完成假期值班安排、安全隐患排查工作，将值班表报送学校办公室；</li><li style=\"text-align: start;\">学生工作处、研究生院需建立假期学生联系机制，遇紧急情况第一时间处置并上报；</li><li style=\"text-align: start;\">全体师生假期期间需遵守交通规则、做好防暑降温，避免前往高风险地区；开学前 7 天内有发热、咳嗽等症状的师生，需及时向学校医务室报备。</li><li style=\"text-align: start;\">假期时间调整给大家带来的不便，敬请谅解。希望全体师生合理安排假期生活，确保度过一个安全、充实的暑假。</li><li style=\"text-align: start;\">XX 大学学校办公室<br>2025 年 X 月 X 日</li></ol>', 1, '2025-08-21 14:48:44');
INSERT INTO `news` VALUES (10, 3, '青春逐梦，赛场扬威！我校第二十届田径运动会圆满落幕', '秋阳正好，微风不燥。10 月 26 日至 27 日，我校第二十届田径运动会在体育场隆重举行，全校 28 个学院的 3000 余名运动员齐聚赛场，在为期两天的赛事中展现青春风采，共筑运动盛宴', '/api/v1.0/campus-news-api/file/getFile?fileName=1755759120897Snipaste_2025-08-21_14-51-19.png', '<p>秋阳正好，微风不燥。10 月 26 日至 27 日，我校第二十届田径运动会在体育场隆重举行，全校 28 个学院的 3000 余名运动员齐聚赛场，在为期两天的赛事中展现青春风采，共筑运动盛宴。</p><p>开幕式上，各学院方阵迈着整齐的步伐依次入场：国旗护卫队英姿飒爽，手持校旗的队员昂首挺胸；“航天主题” 方阵带着自制的火箭模型，展现科研热情；“传统文化” 方阵身着汉服、手持宫灯，尽显文化韵味。校长在致辞中提到：“运动会不仅是速度与力量的比拼，更是团结与意志的展现，希望同学们在赛场上收获健康、收获友谊，把运动精神融入学习生活。”</p><p>比赛现场，精彩不断。100 米短跑赛道上，运动员们如离弦之箭，起跑、加速、冲刺，观众席上的呐喊声此起彼伏；跳高赛场上，人文学院的李同学一次次挑战更高高度，最终以 1.75 米的成绩打破校运会纪录；4×400 米接力赛中，各学院代表队默契配合，交接棒的瞬间紧张又刺激，化学与材料学院代表队凭借稳定发挥摘得桂冠。除了竞技项目，趣味运动项目 “集体跳长绳”“同心协力跑” 也吸引了众多师生参与，大家手拉手、齐迈步，在欢声笑语中感受团队协作的快乐。</p><p>闭幕式上，组委会公布了比赛成绩：体育学院以总分 286 分获得团体第一名，机械工程学院、计算机学院分获二、三名；另有 12 个学院获评 “精神文明代表队”，89 名运动员获得 “优秀运动员” 称号。校党委书记为获奖队伍颁奖时强调：“希望全体师生以运动会为契机，养成坚持锻炼的好习惯，让‘每天锻炼一小时，健康工作五十年’的理念深入人心。”</p><p>此次运动会不仅为师生提供了展示自我的平台，更凝聚了校园向心力。赛场上的汗水与掌声，将成为同学们青春记忆里最鲜活的篇章。</p>', 1, '2025-08-21 14:52:03');
INSERT INTO `news` VALUES (11, 3, '以歌传情，以声筑梦！我校第十届校园歌手大赛决赛圆满举办', '“青春的舞台，等你来唱！”11 月 8 日晚，我校大礼堂座无虚席，第十届 “校园歌手大赛” 决赛在此精彩上演。经过初赛、复赛的层层选拔，12 名来自不同学院的选手脱颖而出，用歌声传递青春态度，为现场师生带来一场视听盛宴。', '/api/v1.0/campus-news-api/file/getFile?fileName=1755759202429Snipaste_2025-08-21_14-52-46.png', '<p>“青春的舞台，等你来唱！”11 月 8 日晚，我校大礼堂座无虚席，第十届 “校园歌手大赛” 决赛在此精彩上演。经过初赛、复赛的层层选拔，12 名来自不同学院的选手脱颖而出，用歌声传递青春态度，为现场师生带来一场视听盛宴。</p><p>决赛分为 “初露锋芒”“合作竞演”“巅峰对决” 三个环节。在 “初露锋芒” 环节，选手们各显神通：<strong>来自音乐学院的张同学以一首原创歌曲《校园的路》打动全场，吉他弹唱间满是对校园生活的眷恋；经济管理学院的王同学用浑厚的嗓音演绎经典老歌《我的未来不是梦》，引发台下大合唱</strong>；外国语学院的刘同学则以双语演唱《Lemon Tree》，轻快的节奏带动全场气氛。</p><p>“合作竞演” 环节更添看点。12 名选手两两组队，带来风格各异的表演：一组选手选择民谣合唱《成都》，温柔的和声让现场满是温情；另一组选手则挑战摇滚曲风，演唱《追梦赤子心》，高亢的歌声点燃全场热情，台下观众挥舞着荧光棒，跟着节奏摇摆。评委老师点评时称赞：“选手们不仅唱功扎实，更能通过合作展现默契，让歌曲有了新的生命力。”</p><p>最终，<strong>经过专业评委打分与现场观众投票，音乐学院张同学凭借原创歌曲与稳定发挥斩获一等奖；经济管理学院王同学、外国语学院刘同学分获二等奖；另有 3 名选手获得 “最佳台风奖”“最具人气奖” 等单项奖。大赛结束后，获得一等奖的张同学说：“从初赛到决赛，每一次演唱都是成长，感谢学校给我们提供这样的平台，让爱好唱歌的我们能被看见。”</strong></p><p>校园歌手大赛是我校 “校园文化艺术节” 的品牌活动，至今已举办十届。它不仅为学生提供了展现音乐才华的舞台，更丰富了校园文化生活，让青春的声音在校园里久久回荡。</p>', 1, '2025-08-21 14:53:49');
INSERT INTO `news` VALUES (12, 3, '传承文化根脉，共赏非遗魅力！ “非遗进校园” 主题活动', '为让师生近距离感受非物质文化遗产的独特魅力，11 月 15 日，我校联合市文化馆举办 “非遗进校园” 主题活动，邀请剪纸、糖画、传统扎染、面塑 4 项非遗技艺的传承人走进校园，开展展示、教学与互动体验，吸引了近千名师生参与。', '/api/v1.0/campus-news-api/file/getFile?fileName=1755759284582Snipaste_2025-08-21_14-54-30.png', '<p>为让师生近距离感受非物质文化遗产的独特魅力，11 月 15 日，我校联合市文化馆举办 “非遗进校园” 主题活动，邀请剪纸、糖画、传统扎染、面塑 4 项非遗技艺的传承人走进校园，开展展示、教学与互动体验，吸引了近千名师生参与。</p><p>活动现场设在校园广场，<strong>4 个非遗体验区前早早排起了长队。剪纸体验区里，非遗传承人李师傅手持剪刀，短短几分钟就剪出了 “校徽”“喜鹊登梅” 等图案，他一边演示一边讲解：“剪纸要先构图，再下剪刀，讲究‘稳、准、快’，大家可以从简单的对称图案练起。”</strong> 同学们听得认真，拿起剪刀尝试剪 “五角星”“小花朵”，虽然手法略显生涩，但成就感满满。</p><p>糖画体验区最受小朋友（教职工子女）欢迎。传承人王师傅将融化的糖稀舀在石板上，手腕轻转，很快就画出了 “小兔子”“小老虎”“孙悟空” 等造型，再插上竹签，一个个晶莹剔透的糖画就完成了。“太神奇了！糖稀居然能画出这么可爱的图案！” 一年级的小朋友拿着糖画，兴奋地向妈妈展示。</p><p>传统扎染与面塑体验区同样热闹。扎染传承人教同学们用 “捆扎法” 制作方巾，大家将白布对折、捆绑，再浸入染料中，等待打开的 “惊喜”；面塑传承人则教大家捏 “校园吉祥物”，揉、搓、捏、压之间，一个个憨态可掬的 “小狮子”（我校吉祥物）就诞生了。来自美术学院的陈同学说：“以前只在课本上见过非遗，今天亲手体验才知道，每一项技艺都藏着老艺人的心血，这种文化太珍贵了。”</p><p>活动最后，学校为 4 位非遗传承人颁发 “校园文化导师” 聘书，计划今后定期开展 “非遗课堂”，将剪纸、扎染等技艺纳入选修课。校团委负责人表示：“‘非遗进校园’不仅是一次体验活动，更是文化传承的开始。我们希望通过这样的活动，让更多同学了解非遗、喜欢非遗，成为传统文化的守护者与传播者。”</p>', 1, '2025-08-21 14:55:20');
INSERT INTO `news` VALUES (13, 4, '新实验楼正式启用！我校科研教学硬件设施再升级', '9 月 1 日，伴随着新学期开学的脚步，我校新建的 “工科实验楼” 正式投入使用', '/api/v1.0/campus-news-api/file/getFile?fileName=1755759415740Snipaste_2025-08-21_14-56-21.png', '<p>9 月 1 日，伴随着新学期开学的脚步，我校新建的 “工科实验楼” 正式投入使用。这座集教学、科研、实践于一体的现代化实验楼，总建筑面积达 1.2 万平方米，涵盖机械工程、电子信息、材料科学等 6 个学科的实验教学区，将为师生提供更优质的科研实践平台，助力学校人才培养与科研创新再上新台阶。</p><p>新实验楼的建设充分考虑学科需求与实用性：一层至三层为基础实验教学区，配备 56 间标准化实验室，每间实验室均安装智能通风系统、紧急喷淋装置及多媒体教学设备，可满足 2000 余名学生同时开展实验课程；四层至五层为科研创新区，设有 12 个 “产学研合作实验室”，其中 “智能装备研发实验室”“新型材料测试实验室” 引入了扫描电子显微镜、高精度传感器等先进设备，设备总值超 3000 万元，为教师开展高水平科研项目、学生参与学科竞赛提供硬件支撑；六层为学生创新工坊，划分出 “3D 打印区”“机器人调试区”“电路设计区”，学生可自主申请使用场地与设备，开展科创项目研发。</p><p>“以前做材料测试需要预约校外实验室，来回要花大半天，现在在新实验楼里就能完成，效率高多了！” 材料科学与工程学院的张老师拿着刚出的测试数据，难掩兴奋。电子信息工程专业的李同学也表示：“创新工坊的 3D 打印机太实用了，我们小组的机器人竞赛项目，终于不用再跑校外工作室了，在学校就能完成零件打印和调试。”</p><p>据基建处负责人介绍，新实验楼从规划到建成历时 2 年，建设过程中严格遵循 “绿色、智能、安全” 理念，采用光伏供电系统、雨水回收系统，获评 “省级绿色建筑示范项目”；同时，楼内设置智能安防系统，实验室入口采用人脸识别，设备使用记录实时上传至管理平台，确保实验安全与设备高效利用。</p><p>新实验楼的启用，是我校推进 “双一流” 建设的重要举措。未来，学校将继续优化科研教学设施，为师生搭建更广阔的发展平台，助力培养更多高素质创新型人才。</p>', 1, '2025-08-21 14:56:58');
INSERT INTO `news` VALUES (14, 4, '校园食堂 “焕新”！营养、便捷、暖心服务升级', '“食堂环境变亮了，菜品也更丰富了！” 新学期开学后，我校第一食堂、第三食堂的改造升级完成，全新的就餐环境、多样化的菜品选择、智能化的服务设施，让师生纷纷点赞，成为校园里的 “热门打卡地”', '/api/v1.0/campus-news-api/file/getFile?fileName=1755759485341Snipaste_2025-08-21_14-57-28.png', '<p>“食堂环境变亮了，菜品也更丰富了！” 新学期开学后，我校第一食堂、第三食堂的改造升级完成，全新的就餐环境、多样化的菜品选择、智能化的服务设施，让师生纷纷点赞，成为校园里的 “热门打卡地”。</p><p>此次食堂改造聚焦师生需求，从 “环境、菜品、服务” 三方面发力：在环境改造上，打破传统食堂 “排排坐” 的布局，增设 “休闲卡座区”“单人食小桌区”“家庭聚餐圆桌区”，墙面绘制校园风景手绘，悬挂绿植装饰，灯光采用暖黄色调，营造温馨舒适的就餐氛围；同时，食堂全面更新通风系统与排烟设备，安装智能温控装置，解决了以往 “夏天闷热、油烟重” 的问题。</p><p>菜品升级是此次改造的重点。各食堂根据师生口味调研结果，新增多个特色窗口：第一食堂推出 “轻食减脂餐” 窗口，提供低油低盐的沙拉、杂粮饭、鸡胸肉套餐，满足健身与减脂需求；第三食堂开设 “地方风味档口”，引入重庆小面、陕西凉皮、广东肠粉等特色美食，让师生不出校园就能品尝各地风味；此外，所有食堂均增设 “营养套餐区”，标注每道菜品的热量、蛋白质、膳食纤维含量，搭配 “一荤两素一汤” 的标准套餐，方便师生合理搭配饮食。</p><p>智能化服务让就餐更便捷。食堂入口处安装 “智能结算台”，师生挑选菜品后，将餐盘放在结算台即可自动识别菜品价格，支持校园卡、微信、支付宝三种支付方式，结算时间缩短至 3 秒以内，有效减少排队时长；同时，食堂上线 “线上预约点餐” 小程序，师生可提前 1 小时下单，选择 “到店取餐” 或 “送餐到楼”（限教学区、宿舍区），解决了 “课间就餐高峰期排队久”“赶课没时间吃饭” 的问题。</p><p>“以前课间去食堂吃饭，排队要 20 多分钟，现在提前在小程序下单，到食堂就能直接取餐，省了不少时间。” 计算机学院的王同学拿着刚取到的餐品说。后勤管理处负责人表示，食堂改造后还会定期开展 “菜品满意度调研”，根据师生反馈调整菜品与服务，同时加强食品安全管理，食材采购、加工过程全程可追溯，让师生吃得放心、吃得舒心。</p><p>校园食堂不仅是就餐场所，更是师生交流的重要空间。此次 “焕新” 升级，既提升了服务质量，也让食堂成为传递校园温暖的 “窗口”。</p>', 0, '2025-08-21 14:58:07');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID，自增',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '公告内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '公告信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (3, '关于校园信息系统升级维护的公告', '<p>全体师生：</p><p>为提升校园信息系统稳定性与服务效率，信息化建设办公室计划于 2025 年 X 月 X 日（周六）00:00-06:00 对校园统一认证系统、教务管理系统、一卡通服务系统进行升级维护。现将有关事项公告如下：</p><h2 style=\"text-align: start;\">一、维护时间</h2><p>2025 年 X 月 X 日 00:00-06:00（共 6 小时），若提前完成维护，系统将提前开放；若遇特殊情况需延长维护时间，将通过校园官网、“校园服务” 公众号实时通知。</p><h2 style=\"text-align: start;\">二、受影响系统</h2><ol><li style=\"text-align: start;\">校园统一认证平台（含登录教务系统、科研系统、财务系统的账号验证功能）；</li><li style=\"text-align: start;\">教务管理系统（选课、成绩查询、课表查看等功能暂停）；</li><li style=\"text-align: start;\">一卡通服务系统（食堂消费、门禁刷卡、图书馆借阅等线下功能正常，线上充值、消费记录查询功能暂停）；</li><li style=\"text-align: start;\">校园 VPN 服务（维护期间无法通过 VPN 访问校内资源）。</li></ol><h2 style=\"text-align: start;\">三、注意事项</h2><ol><li style=\"text-align: start;\">请师生提前做好准备：需选课、查询成绩的同学请在维护前完成操作；需线上充值一卡通的师生请提前充值，避免影响日常消费；</li><li style=\"text-align: start;\">维护期间，若有紧急教学、科研需求，可联系信息化建设办公室应急专线（电话：XXX-XXXXXXX，邮箱：itsupport@xx.edu.cn）；</li><li style=\"text-align: start;\">系统恢复后，建议师生重新登录各平台，若遇到登录异常、数据显示错误等问题，可通过 “校园服务平台 - 故障报修” 板块提交反馈，工作人员将在 2 小时内响应处理。</li><li style=\"text-align: start;\">此次升级旨在优化系统性能、修复已知问题，期间给大家带来的不便，敬请谅解。感谢全体师生的理解与配合！</li><li style=\"text-align: start;\">XX 大学信息化建设办公室<br>2025 年 X 月 X 日</li></ol>', '2025-08-21 15:34:21');
INSERT INTO `notice` VALUES (4, '关于 2025 年秋季学期教材征订的公告', '<p>各学院、全体 2022 级、2023 级、2024 级本科生及研究生：</p><p>为保障 2025 年秋季学期教学工作有序开展，确保教材及时发放，现将教材征订工作有关事项公告如下：</p><h2 style=\"text-align: start;\">一、征订时间</h2><ol><li style=\"text-align: start;\">学生自主征订：2025 年 X 月 X 日 9:00-X 月 X 日 17:00（逾期系统将关闭征订通道，无法补订）；</li><li style=\"text-align: start;\">学院汇总核对：2025 年 X 月 X 日 - X 月 X 日（各学院需完成本学院学生征订数据审核，确保无错订、漏订）。</li></ol><h2 style=\"text-align: start;\">二、征订方式</h2><ol><li style=\"text-align: start;\">登录 “校园服务平台 - 教学服务 - 教材征订” 板块，进入个人教材征订页面；</li><li style=\"text-align: start;\">系统将自动显示本学期所学课程对应的推荐教材（含书名、作者、ISBN 号、定价），学生可根据需求选择 “订购” 或 “不订购”（不订购需在备注栏说明原因，如自行购买、使用旧教材等）；</li><li style=\"text-align: start;\">确认征订清单后，在线缴纳教材费用（支持校园一卡通、微信、支付宝支付），缴费成功即完成征订。</li></ol><h2 style=\"text-align: start;\">三、注意事项</h2><ol><li style=\"text-align: start;\">教材征订以 “自愿原则” 为基础，推荐教材由任课教师根据教学大纲选定，确保内容贴合课程需求，建议优先订购；</li><li style=\"text-align: start;\">若发现系统显示的课程与教材不匹配（如漏显示教材、教材信息错误），需在 X 月 X 日前联系所在学院教学秘书反馈，由学院统一协调修正；</li><li style=\"text-align: start;\">秋季学期教材发放时间为 2025 年 X 月 X 日 - X 月 X 日（开学前 3 天），学生需凭校园卡到指定地点（本科生：XX 教学楼一层大厅，研究生：XX 研究生院楼 101 室）领取；</li><li style=\"text-align: start;\">教材费用按实际定价收取，无额外手续费；若需退换教材，需在领取教材后 7 个工作日内，凭教材、缴费凭证到教材管理中心办理（教材需保持未拆封、无污渍、无破损）。</li><li style=\"text-align: start;\">请各学院高度重视教材征订工作，及时通知到每一位学生；全体学生务必在规定时间内完成征订，避免影响新学期课程学习。</li><li style=\"text-align: start;\">XX 大学教务处<br>XX 大学教材管理中心<br>2025 年 X 月 X 日</li></ol>', '2025-08-21 15:34:46');
INSERT INTO `notice` VALUES (5, '关于开展 2025 年度校园安全隐患排查整治工作的公告', '<p>各部门、各学院，全体师生：</p><p>为切实消除校园安全隐患，保障师生生命财产安全与校园稳定，根据上级主管部门关于校园安全工作的部署要求，学校决定开展 2025 年度校园安全隐患排查整治工作。现将有关事项公告如下：</p><h2 style=\"text-align: start;\">一、排查整治时间</h2><ol><li style=\"text-align: start;\">自查阶段：2025 年 X 月 X 日 - X 月 X 日（各部门、学院及师生自主排查）；</li><li style=\"text-align: start;\">集中检查阶段：2025 年 X 月 X 日 - X 月 X 日（学校安全工作领导小组组织专项检查）；</li><li style=\"text-align: start;\">整改阶段：2025 年 X 月 X 日 - X 月 X 日（针对排查出的隐患限期整改）。</li></ol><h2 style=\"text-align: start;\">二、排查范围及重点</h2><ol><li style=\"text-align: start;\">消防安全：教学楼、实验室、宿舍、食堂等区域的消防设施（灭火器、消火栓、应急灯、疏散指示标志）是否完好有效；消防通道是否畅通；违规用电（如私拉乱接电线、使用大功率电器）、违规存放易燃易爆物品等问题；</li><li style=\"text-align: start;\">设施安全：校园建筑物外墙、门窗、楼梯扶手是否存在松动、脱落风险；运动场地器材（如篮球场篮板、健身器材）是否损坏；电梯、锅炉等特种设备是否按期年检；</li><li style=\"text-align: start;\">实验室安全：危险化学品（如易燃易爆、有毒有害试剂）的存储、使用、废弃处理是否符合规范；实验设备是否定期维护；实验室应急预案是否完善；</li><li style=\"text-align: start;\">食品安全：食堂食材采购渠道是否合规；食品加工、储存过程是否符合卫生标准；餐具消毒是否到位；</li><li style=\"text-align: start;\">其他安全：校园监控设备是否正常运行；校门口、宿舍区等重点区域安保措施是否落实；网络安全漏洞、校园欺凌隐患等。</li></ol><h2 style=\"text-align: start;\">三、参与方式</h2><ol><li style=\"text-align: start;\">部门 / 学院自查：各单位需成立专项排查小组，对照排查重点逐项检查，填写《校园安全隐患自查表》，于 X 月 X 日前报送至学校安全保卫处；</li><li style=\"text-align: start;\">师生反馈：全体师生可通过以下渠道反馈安全隐患：</li><li style=\"text-align: start;\">集中检查配合：集中检查期间，各单位需安排专人配合检查小组工作，如实提供相关资料，协助排查隐患。</li></ol><h2 style=\"text-align: start;\">四、工作要求</h2><ol><li style=\"text-align: start;\">各部门、学院需高度重视此次排查整治工作，主要负责人为第一责任人，确保排查无死角、无遗漏；</li><li style=\"text-align: start;\">对排查出的隐患，能立即整改的需当场整改；无法立即整改的，需制定整改方案，明确整改时限、责任人及保障措施，并报学校安全保卫处备案；</li><li style=\"text-align: start;\">学校将对隐患整改情况进行跟踪督查，对逾期未整改或整改不到位的单位，将予以通报批评；因隐患排查不到位、整改不及时引发安全事故的，将依规追究相关责任人责任。</li><li style=\"text-align: start;\">安全无小事，责任大于天。请全体师生积极参与校园安全隐患排查工作，共同营造安全、稳定、和谐的校园环境。</li><li style=\"text-align: start;\">XX 大学安全保卫处<br>2025 年 X 月 X 日</li></ol>', '2025-08-21 15:35:12');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户密码',
  `avatar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '用户头像',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `role` int(11) NULL DEFAULT NULL COMMENT '用户角色',
  `gender` tinyint(1) NULL DEFAULT NULL COMMENT '性别：1-女；2-男；',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `create_time` datetime NULL DEFAULT NULL COMMENT '用户注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'B站「程序员辰星」原创出品', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/campus-news-api/file/getFile?fileName=1755246512978Snipaste_2025-05-20_15-13-00.png', '5567643@qq.com', 1, 2, '1990-06-05', '16766666666', '2024-10-19 12:53:05');
INSERT INTO `user` VALUES (59, 'lrenzhenjiuhao', '李春然', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/campus-news-api/file/getFile?fileName=17560430190814.png', '123342@qq.com', 2, 1, '1985-07-11', '17687665323', '2025-05-28 17:54:48');
INSERT INTO `user` VALUES (60, 'zhouzhiruo', '周芷若', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/campus-news-api/file/getFile?fileName=1756043010812Snipaste_2025-05-20_15-13-54.png', '23124231@qq.com', 1, 1, '1991-07-11', '16576666666', '2025-05-28 18:06:43');
INSERT INTO `user` VALUES (61, 'guihua', '桂花', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/campus-news-api/file/getFile?fileName=17560430009688.png', '14324@qq.com', 2, 1, NULL, NULL, '2025-05-29 14:13:04');
INSERT INTO `user` VALUES (62, 'zhaomin', 'B站【程序员辰星】原创出品', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/campus-news-api/file/getFile?fileName=1756044818102Snipaste_2025-05-08_21-39-19.png', NULL, 2, 1, NULL, NULL, '2025-05-29 15:39:59');
INSERT INTO `user` VALUES (63, 'zhangsan2', '追风筝的人', '14e1b600b1fd579f47433b88e8d85291', '/api/v1.0/campus-news-api/file/getFile?fileName=17560429897976.png', '432432@qq.com', 2, 2, '1996-07-17', '17687442010', '2025-05-29 15:41:04');

SET FOREIGN_KEY_CHECKS = 1;
