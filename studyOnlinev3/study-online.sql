/*
 Navicat Premium Data Transfer

 Source Server         : Isla
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : study-online

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 26/04/2023 20:20:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Login_Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录名',
  `Role_Id` int NULL DEFAULT NULL COMMENT '用户角色',
  `Password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录密码',
  `Real_Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `Phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `Login_Name`(`Login_Name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------

-- ----------------------------
-- Table structure for choise
-- ----------------------------
DROP TABLE IF EXISTS `choise`;
CREATE TABLE `choise`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `type_Id` int NULL DEFAULT NULL COMMENT '类型 1表示作物类别 ',
  `order_Id` int NULL DEFAULT NULL COMMENT '次序',
  `type_Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '选项表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of choise
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `User_Id` int NULL DEFAULT NULL COMMENT '用户',
  `Zan` int NULL DEFAULT 0 COMMENT '点赞数',
  `Time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '时间',
  `tree_id` int NULL DEFAULT NULL COMMENT '章节子节点id',
  `is_zan` int NULL DEFAULT 0 COMMENT '是否被点赞',
  `parent_id` int NULL DEFAULT NULL COMMENT '子节点',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, '受益匪浅', 3, 10, '2023-04-26 11:43:09', 12, 1, NULL);
INSERT INTO `comment` VALUES (2, '讲的不错！', 3, 15, '2023-04-23 16:22:27', 12, 0, NULL);
INSERT INTO `comment` VALUES (3, '还可以', 2, 2, '2023-04-26 11:43:10', 12, 0, 1);
INSERT INTO `comment` VALUES (4, '学习下一章去咯~', 3, 24, '2023-04-23 15:08:20', 12, 0, 2);
INSERT INTO `comment` VALUES (5, '很深刻', 2, 7, '2023-04-26 11:43:11', 12, 1, 1);
INSERT INTO `comment` VALUES (6, '不错不错！', 3, 3, '2023-04-23 16:14:37', 13, 1, NULL);
INSERT INTO `comment` VALUES (7, '额', 3, 3, '2023-04-23 15:08:45', 13, 1, 6);
INSERT INTO `comment` VALUES (8, '很好的课程', 2, 3, '2023-04-23 16:55:24', 13, 0, 6);
INSERT INTO `comment` VALUES (9, '很好的课程', 2, 1, '2023-04-23 19:34:05', 13, 1, NULL);
INSERT INTO `comment` VALUES (19, '不错', 3, 0, '2023-04-23 03:32:31', 19, 0, NULL);
INSERT INTO `comment` VALUES (20, '确实', 3, 0, '2023-04-23 03:32:33', 19, 0, NULL);
INSERT INTO `comment` VALUES (21, '真好啊', 3, 0, '2023-04-23 03:32:35', 19, 0, NULL);
INSERT INTO `comment` VALUES (22, '这', 3, 0, '2023-04-23 03:32:36', 14, 0, NULL);
INSERT INTO `comment` VALUES (25, '434', 3, 0, '2023-04-23 03:44:05', 13, 0, NULL);
INSERT INTO `comment` VALUES (26, '我认为你说的不对', 3, 1, '2023-04-23 16:55:26', 13, 1, 9);
INSERT INTO `comment` VALUES (27, '你是真傻逼', 3, 0, '2023-04-23 19:34:03', 13, 0, 9);
INSERT INTO `comment` VALUES (28, '可以', 3, 0, '2023-04-26 11:42:37', 12, 0, NULL);
INSERT INTO `comment` VALUES (29, '怎么会', 3, 0, '2023-04-26 19:57:36', 12, 0, NULL);
INSERT INTO `comment` VALUES (30, '发布', 3, 0, '2023-04-26 19:58:47', 12, 0, NULL);
INSERT INTO `comment` VALUES (31, '回复', 3, 1, '2023-04-26 19:58:54', 12, 1, 30);

-- ----------------------------
-- Table structure for hot_category
-- ----------------------------
DROP TABLE IF EXISTS `hot_category`;
CREATE TABLE `hot_category`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '热门课程id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '热门课程名字',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1012 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hot_category
-- ----------------------------
INSERT INTO `hot_category` VALUES (1001, '热门好课');
INSERT INTO `hot_category` VALUES (1002, '研究生课');
INSERT INTO `hot_category` VALUES (1003, '职业教育');
INSERT INTO `hot_category` VALUES (1004, '计算机');
INSERT INTO `hot_category` VALUES (1005, '经济管理');
INSERT INTO `hot_category` VALUES (1006, '文史哲');
INSERT INTO `hot_category` VALUES (1007, '医药卫生');
INSERT INTO `hot_category` VALUES (1008, '外语');
INSERT INTO `hot_category` VALUES (1009, '工学');
INSERT INTO `hot_category` VALUES (1010, '理学');
INSERT INTO `hot_category` VALUES (1011, '艺术设计');

-- ----------------------------
-- Table structure for lesson
-- ----------------------------
DROP TABLE IF EXISTS `lesson`;
CREATE TABLE `lesson`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `L_Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '课程名称',
  `Lesson_Type_Id` int NULL DEFAULT NULL COMMENT '分类',
  `User_Id` int NULL DEFAULT NULL COMMENT '上传用户',
  `Teacher` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '讲授教师',
  `School` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学校',
  `Time` datetime NULL DEFAULT NULL COMMENT '上传时间',
  `Img` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面',
  `Dian_Ji` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '点击量',
  `Zan` int NULL DEFAULT NULL COMMENT '点赞数',
  `Remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '简介',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lesson
-- ----------------------------
INSERT INTO `lesson` VALUES (1, '清华大学实验室安全课程-机电安全', 1001, NULL, NULL, '清华大学', NULL, '\r\nhttps://study-onlne.oss-cn-nanjing.aliyuncs.com/h1.jpg', '243', NULL, '帮助学习者识别实验室物理性危险源，提升事故应急能力。');
INSERT INTO `lesson` VALUES (3, '智慧医疗创新体验', 1001, NULL, NULL, '清华大学', NULL, '\r\nhttps://study-onlne.oss-cn-nanjing.aliyuncs.com/h2.jpg', '550', NULL, '走进智慧医疗，解锁人工智能医疗技术的奥秘！');
INSERT INTO `lesson` VALUES (4, '营销管理：数字时代的营销江湖', 1001, NULL, NULL, '安徽大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/h3.jpg', '1万+', NULL, '一起携手踏入这网络时代瞬息万变的营销世界！');
INSERT INTO `lesson` VALUES (5, '阳明学概论', 1001, NULL, NULL, '贵州大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/h4.jpg', '3万+', NULL, '管窥中国文化发展脉络和特质，了解王阳明的传奇生平。');
INSERT INTO `lesson` VALUES (6, '电工电子技术', 1001, NULL, NULL, '合肥工业大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/h5.jpg', '266', NULL, '感受电路之美，培养工程素养');
INSERT INTO `lesson` VALUES (7, '误差理论与数据处理', 1001, NULL, NULL, '合肥工业大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/h6.jpg', '189', NULL, '储备测控系统的基本知识与技能');
INSERT INTO `lesson` VALUES (8, '时尚买手训练营', 1001, NULL, NULL, '北京服装学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/h7.jpg', '1万+', NULL, '时尚买手在国内外发展迅速，是服装设计、时尚管理、国际贸易、商');
INSERT INTO `lesson` VALUES (9, '高等数学导览', 1001, NULL, NULL, '首都师范大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/h8.jpg', '122', NULL, '我们经常听数学老师说“我现在讲的是思路，你们写答案的时候要反');
INSERT INTO `lesson` VALUES (10, '高分子合成材料学', 1002, NULL, NULL, '北京理工大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/y1.jpg', '3315', NULL, '加深理解高分子合成材料领域的新理论、新技术和新方法');
INSERT INTO `lesson` VALUES (11, '现代优化方法（英文）', 1002, NULL, NULL, '北京理工大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/y2.jpg', '3672', NULL, '介绍优化方法如何应用于实际问题求解');
INSERT INTO `lesson` VALUES (12, '偏微分方程', 1002, NULL, NULL, '首都师范大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/y3.jpg', '454', NULL, '数学学科的重要学科基础课程');
INSERT INTO `lesson` VALUES (13, '马克思主义哲学专题研究', 1002, NULL, NULL, '首都师范大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/y4.jpg', '407', NULL, ' “三大时期”“五大批判”经纬交织，纵横捭阖');
INSERT INTO `lesson` VALUES (14, '流行病学原理与方法', 1002, NULL, NULL, '吉林大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/y5.jpg', '62', NULL, '着重于开阔学生科研视野，拓宽其解决问题的思路和专业知识储备');
INSERT INTO `lesson` VALUES (15, '高级免疫学理论与技术', 1002, NULL, NULL, '吉林大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/y6.jpg', '295', NULL, '生命科学和医学领域中一门基础性、前沿性和支柱性学科');
INSERT INTO `lesson` VALUES (16, '水工程伦理', 1002, NULL, NULL, '哈尔滨工业大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/y7.jpg', '5095', NULL, '提升工程伦理素养，尊重自然规律，实现永续发展');
INSERT INTO `lesson` VALUES (17, '动物生殖生理学', 1002, NULL, NULL, '东北农业大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/y8.jpg', '15', NULL, '研究动物的生殖系统功能及其调控规律的一门科学');
INSERT INTO `lesson` VALUES (18, '机器学习初步', 1004, NULL, NULL, '南京大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/j1.jpg', '2万+', NULL, '“西瓜书”作者亲自解读，带你走进机器学习');
INSERT INTO `lesson` VALUES (19, '分布式数据系统应用实战-进阶', 1004, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/j2.jpg', '372', NULL, '敲开大数据实战的第一块砖');
INSERT INTO `lesson` VALUES (20, '机器人虚拟仿真技术及应用', 1004, NULL, NULL, '重庆工程职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/j3.jpg', '1209', NULL, '掌握工业机器人离线编程与生产线虚拟仿真技术');
INSERT INTO `lesson` VALUES (21, '走进人工智能（人工智能概论）', 1004, NULL, NULL, '陕西职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/j4.jpg', '856', NULL, '通过生活感知无处不在的人工智能。');
INSERT INTO `lesson` VALUES (22, '计算机安全', 1004, NULL, NULL, '华南理工大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/j5.jpg', '1833', NULL, '计算机安全综合实践能力培养');
INSERT INTO `lesson` VALUES (23, '计算机网络', 1004, NULL, NULL, '安徽新华学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/j6.jpg', '1129', NULL, '“破译”计算机网络之奥秘，探秘这“熟悉的陌生人”\r\n');
INSERT INTO `lesson` VALUES (24, 'Unity 3D基础', 1004, NULL, NULL, '济宁学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/j7.jpg', '667', NULL, '本课程针对Unity初学者的特点和需求，本着“起点低，终点高');
INSERT INTO `lesson` VALUES (25, '计算机信息技术基础\r\n计算机信息技术基础', 1004, NULL, NULL, '巴音郭楞职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/j8.jpg', '678', NULL, '本课程使学生掌握计算机的基础应用技能，具有运用计算机获取信息');
INSERT INTO `lesson` VALUES (26, '钢筋混凝土与砌体结构', 1003, NULL, NULL, '陕西工业职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/z1.jpg', '3万+', NULL, '钢筋混凝土与砌体结构课程是土建类专业进行岗位能力培养的一门专');
INSERT INTO `lesson` VALUES (27, '安装概预算', 1003, NULL, NULL, '陕西工业职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/z2.jpg', '3万+', NULL, '安装概预算课程是工程造价专业开设的专业核心课程，重点培养学生');
INSERT INTO `lesson` VALUES (28, '建筑结构', 1003, NULL, NULL, '滨州职业学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/z3.jpg', '3372', NULL, '古往今来，光阴飞逝，时间在风起云涌的历史中穿梭，却始终眷恋着');
INSERT INTO `lesson` VALUES (29, '瑜伽启蒙', 1003, NULL, NULL, '滨州职业学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/z4.jpg', '3288', NULL, '瑜伽学科如天空般广阔，我们旨在做您瑜伽路上的启蒙者，指引您沿');
INSERT INTO `lesson` VALUES (30, '证券投资理论与实务', 1003, NULL, NULL, '上海中侨职业技术大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/z5.jpg', '1079', NULL, '让学生全面了解证券市场，了解各种金融工具。');
INSERT INTO `lesson` VALUES (31, '药物检测技术', 1003, NULL, NULL, '陕西能源职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/z6.jpg', '1万+', NULL, '为学生从事质量检测和管理的相关技术工作奠定基础。');
INSERT INTO `lesson` VALUES (32, '钢结构制作与安装', 1003, NULL, NULL, '内蒙古建筑职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/z7.jpg', '5007', NULL, '简要介绍钢结构的加工制作工艺流程及钢结构安装施工工艺。');
INSERT INTO `lesson` VALUES (33, '液压与气动技术', 1003, NULL, NULL, '咸阳职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/z8.jpg', '2249', NULL, '让我们一起进入液压与气动的奇妙世界吧！');
INSERT INTO `lesson` VALUES (34, '公共事物治理概论', 1005, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/g1.jpg', '767', NULL, '阐释公共事物研究国际前沿以及本土化思考。');
INSERT INTO `lesson` VALUES (35, '金融交易导论--原理、机制与实务', 1005, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/g2.jpg', '2630', NULL, '从金融交易的角度出发，对金融交易的原理、机制和实务进行阐述\r\n');
INSERT INTO `lesson` VALUES (36, '财务报表分析逻辑与技巧', 1005, NULL, NULL, '中国石油大学（北京）', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/g3.jpg', '5万+', NULL, '系统介绍了财务报表分析的逻辑框架和方法技巧。');
INSERT INTO `lesson` VALUES (37, '市场营销理论与实务', 1005, NULL, NULL, '安徽商贸职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/g4.jpg', '863', NULL, '助你了解和掌握营销这种能力。');
INSERT INTO `lesson` VALUES (38, '西方经济学', 1005, NULL, NULL, '铜仁学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/g5.jpg', '2万+', NULL, '传递经济学的智慧，激发学习经济学的兴趣');
INSERT INTO `lesson` VALUES (39, '公共管理', 1005, NULL, NULL, '重庆科技学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/g6.jpg', '7262', NULL, '关注公共福祉，实现公共利益！');
INSERT INTO `lesson` VALUES (40, '民法总论', 1005, NULL, NULL, '北京理工大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/g7.jpg', '2864', NULL, '民为邦本，本固邦宁。 民法是社会主体享有自由的权利宪章。 民');
INSERT INTO `lesson` VALUES (41, '大学生创新创业', 1005, NULL, NULL, '巴音郭楞职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/g8.jpg', '546', NULL, '本课程为面向全院所有专业学生开设的公共基础课程，通过本课程的');
INSERT INTO `lesson` VALUES (42, '模态逻辑及其应用', 1006, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/s1.jpg', '933', NULL, '一起学习模态逻辑中的时态逻辑、认知逻辑和动态社会认知逻辑等');
INSERT INTO `lesson` VALUES (43, '职业伦理', 1006, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/s2.jpg', '1万+', NULL, '带你成长为一名负责任创新、积极心理行动的职业伦理“实践家”。');
INSERT INTO `lesson` VALUES (44, '环境行为学', 1006, NULL, NULL, '厦门大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/s3.jpg', '424', NULL, '从科学实证的视角引导学生对“环境、空间与人”的关系进行思考。');
INSERT INTO `lesson` VALUES (45, '楚国历史与文化', 1006, NULL, NULL, '湖北大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/s4.jpg', '1万+', NULL, '弘扬和传承优秀传统文化。');
INSERT INTO `lesson` VALUES (46, '探秘《说文解字》中的古代文化', 1006, NULL, NULL, '岭南师范学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/s5.jpg', '2万+', NULL, '探究《说文解字》蕴含的中国古代文化奥秘');
INSERT INTO `lesson` VALUES (47, '昆虫文化', 1006, NULL, NULL, '安徽农业大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/s6.jpg', '2万+', NULL, '探索神秘的昆虫世界');
INSERT INTO `lesson` VALUES (48, '大学生24式太极拳教程', 1006, NULL, NULL, '北京理工大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/s7.jpg', '5556', NULL, '你了解孩子吗？ 他/她从小到大发生了哪些变化？ 这些变化有规');
INSERT INTO `lesson` VALUES (49, '外国文学', 1006, NULL, NULL, '济宁学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/s8.jpg', '299', NULL, '文学的世界，像浩瀚神秘的大海，更像深邃无垠的天空。在璀璨的天');
INSERT INTO `lesson` VALUES (50, '人体胚胎学——系统发生', 1007, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/w1.jpg', '2万+', NULL, '丰富知识体系、提高综合素质');
INSERT INTO `lesson` VALUES (51, '组织学', 1007, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/w2.jpg', '2万+', NULL, '远离疾病，从探索组织细胞开始');
INSERT INTO `lesson` VALUES (52, '智能医学发展前沿', 1007, NULL, NULL, '天津大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/w3.jpg', '3万+', NULL, '智能医学，拥抱美好未来！');
INSERT INTO `lesson` VALUES (53, '中医妇科学', 1007, NULL, NULL, '重庆三峡医药高等专科学校', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/w4.jpg', '3394', NULL, '运用中医中药，护佑女性健康！');
INSERT INTO `lesson` VALUES (54, '医患沟通与调适', 1007, NULL, NULL, '广州医科大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/w5.jpg', '8983', NULL, '多一点沟通，少一份报怨，多一点理解，少一桩纠纷');
INSERT INTO `lesson` VALUES (55, '断层解剖学', 1007, NULL, NULL, '大理大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/w6.jpg', '9725', NULL, '没有断层解剖学就没有现代医学');
INSERT INTO `lesson` VALUES (56, '食品感官检验技术', 1007, NULL, NULL, '巴音郭楞职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/w7.jpg', '9899', NULL, '一种科学方法，两类人群参加，三种感官分析方法，四个过程，五个');
INSERT INTO `lesson` VALUES (57, '仪器分析', 1007, NULL, NULL, '山东畜牧兽医职业学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/w8.jpg', '997', NULL, '仪器分析是测定物质的化学组成、含量、状态、结构和进行化学研究');
INSERT INTO `lesson` VALUES (58, '实用日语会话（Practical Japanese Conversation）', 1008, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/a1.jpg', '6万+', NULL, '教授生活中使用频率最高的日语口语，以及各种在日本生活的知识');
INSERT INTO `lesson` VALUES (59, '日语与日本文化', 1008, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/a2.jpg', '24万+', NULL, '带你了解日本人的生活细节和民族文化');
INSERT INTO `lesson` VALUES (60, '中医英语入门', 1008, NULL, NULL, '广州中医药大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/a3.jpg', '2万+', NULL, '如何开始用英语讲中医故事？');
INSERT INTO `lesson` VALUES (61, '铁路行业英语', 1008, NULL, NULL, '哈尔滨铁道职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/a4.jpg', '5599', NULL, '增强学生的职业能力，形成完整的英语应用能力体系。');
INSERT INTO `lesson` VALUES (62, '韩语日常会话入门', 1008, NULL, NULL, '华南理工大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/a5.jpg', '4万+', NULL, '表意精确、地道实用的韩语日常会话学习');
INSERT INTO `lesson` VALUES (63, '中西经典对话（英语）', 1008, NULL, NULL, '暨南大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/a6.jpg', '1747', NULL, '一起探索妙趣横生的文学之旅');
INSERT INTO `lesson` VALUES (64, '高级英语口语', 1008, NULL, NULL, '山东理工大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/a7.jpg', '3385', NULL, '本课程情景真实，语言地道，能够全面提升学生的口语交际能力。通');
INSERT INTO `lesson` VALUES (65, '日语与中日航海文化', 1008, NULL, NULL, '大连海事大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/a8.jpg', '1万+', NULL, '将日语语言技能与中日航海文化交流的历史与现状紧密结合。');
INSERT INTO `lesson` VALUES (66, '现代电子系统设计', 1009, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/b1.jpg', '2万+', NULL, '系统地掌握现代电子系统的设计方法，同时培养创新设计思想。');
INSERT INTO `lesson` VALUES (67, '粘性流体力学—层流', 1009, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/b2.jpg', '1万+', NULL, '用清晰的方式讲解流体力学这一深奥却深入生产生活的力学课程');
INSERT INTO `lesson` VALUES (68, '钢筋混凝土结构原理', 1009, NULL, NULL, '空军工程大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/b3.jpg', '1万+', NULL, '基于理论分析和试验研究来指导工程应用。');
INSERT INTO `lesson` VALUES (69, '光电子技术（器件及电力应用）', 1009, NULL, NULL, '华北电力大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/b4.jpg', '5862', NULL, '研究光与物质中电子的相互作用及其能量的相互转换。');
INSERT INTO `lesson` VALUES (70, '物联网工程导论', 1009, NULL, NULL, '云南大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/b5.jpg', '3万+', NULL, '介绍物联网技术的基本概念、关键技术、应用领域及发展现状');
INSERT INTO `lesson` VALUES (71, '汽车发动机构造', 1009, NULL, NULL, '岭南师范学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/b6.jpg', '2万+', NULL, '系统讲解四冲程发动机的基本结构、工作原理');
INSERT INTO `lesson` VALUES (72, '飞机电气维修基本技能', 1009, NULL, NULL, '日照职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/b7.jpg', '2475', NULL, '《飞机电气维修基本技能》是高职院校飞行器维修技术专业的核心课');
INSERT INTO `lesson` VALUES (73, '工程项目管理及BIM应用', 1009, NULL, NULL, '日照职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/b8.jpg', '3357', NULL, '建筑业是我国国民经济的重要支柱产业，工程项目管理在推动建筑业');
INSERT INTO `lesson` VALUES (74, '电磁暂态分析', 1010, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/c1.jpg', '1万+', NULL, '探寻暂态过程规律');
INSERT INTO `lesson` VALUES (75, '电磁兼容', 1010, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/c2.jpg', '2万+', NULL, '让电子世界更和谐');
INSERT INTO `lesson` VALUES (76, '粮油储藏', 1010, NULL, NULL, '黑龙江交通职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/c3.jpg', '3193', NULL, '科学储粮靠你我，学好本领保粮安。');
INSERT INTO `lesson` VALUES (77, '化学学科理解', 1010, NULL, NULL, '东北师范大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/c4.jpg', '3万+', NULL, '教师应加强化学学科理解能力。');
INSERT INTO `lesson` VALUES (78, '数据时代的推断陷阱', 1010, NULL, NULL, '上海财经大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/c5.jpg', '2759', NULL, '构筑数据和答案之间的重要关联');
INSERT INTO `lesson` VALUES (79, '生态保护概论', 1010, NULL, NULL, '华南农业大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/c6.jpg', '147', NULL, '了解全面、系统的生态保护');
INSERT INTO `lesson` VALUES (80, '仪器分析', 1010, NULL, NULL, '山东畜牧兽医职业学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/c7.jpg', '997', NULL, '仪器分析是测定物质的化学组成、含量、状态、结构和进行化学研究');
INSERT INTO `lesson` VALUES (81, '原子物理学', 1010, NULL, NULL, '济宁学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/c8.jpg', '220', NULL, '本课程内容采用模块化专题化创新设计，带领大家探寻物质奥秘，解');
INSERT INTO `lesson` VALUES (82, '明·园境赏析：明代四大胜园', 1011, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/d1.jpg', '6510', NULL, '在研究的基础上对明代园境进行重构、分析，并且尽可能生动地呈现');
INSERT INTO `lesson` VALUES (83, '设计伦理', 1011, NULL, NULL, '清华大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/d2.jpg', '4万+', NULL, '在设计历史中寻找真相，为设计伦理寻求出路；');
INSERT INTO `lesson` VALUES (84, '设计创意思维', 1011, NULL, NULL, '深圳信息职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/d3.jpg', '1439', NULL, '创意思维设计，给你一个发挥创新的想象力的舞台。');
INSERT INTO `lesson` VALUES (85, '中国舞蹈 Chinese Dance', 1011, NULL, NULL, '襄阳职业技术学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/d4.jpg', '5270', NULL, '在世界的舞台，来感受中国舞蹈的独特魅力！');
INSERT INTO `lesson` VALUES (86, '视觉传达与传播设计', 1011, NULL, NULL, '安徽工程大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/d5.jpg', '7428', NULL, '艺术设计、动画、工业设计发展整合而成');
INSERT INTO `lesson` VALUES (87, '声乐', 1011, NULL, NULL, '广东石油化工学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/d6.jpg', '1万+', NULL, '正确运用歌唱方法，解读歌曲内涵，把握不同风格的声乐作品');
INSERT INTO `lesson` VALUES (88, '中国古代文学-魏晋南北朝隋唐五代部分', 1011, NULL, NULL, '山东理工大学', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/d7.jpg', '5902', NULL, '培养人文关怀意识，提高文学核心素养。');
INSERT INTO `lesson` VALUES (89, '探寻广告的奥秘——广告创意解读', 1011, NULL, NULL, '黑龙江财经学院', NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/d8.jpg', '3977', NULL, '本门课程以广告创意为中心，更好的进行了课堂思政的融入。在快乐');

-- ----------------------------
-- Table structure for lesson_detail
-- ----------------------------
DROP TABLE IF EXISTS `lesson_detail`;
CREATE TABLE `lesson_detail`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `introduce` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '课程介绍',
  `vedio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4' COMMENT '视频',
  `lesson_id` int NULL DEFAULT NULL COMMENT '课程id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lesson_detail
-- ----------------------------
INSERT INTO `lesson_detail` VALUES (1, '《实验室机电安全》是实验室安全通识课程之一，包含《实验室物理性危害》、《实验室用电安全》、《机械安全》、《如何安全使用特种设备》四节内容，该课程基于实验室现状，结合常见的机电安全隐患，帮助学习者识别实验室物理性危险源，掌握风险防控措施，提升事故应急能力，是进入实验室工作前的必备课程之一。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 1);
INSERT INTO `lesson_detail` VALUES (2, '阿尔伯特·爱因斯坦曾说过：“只懂得科学技术本身是不够的，关心人的本身，应当成为一切技术的主要目标。” 近年来，人工智能技术蓬勃发展，并逐步被应用于医疗健康领域（比如：医学影像辅助诊断、医用机器人、诊疗决策支持、健康检测可穿戴设备等）。人工智能如何给医疗健康领域带来变革和创新？本课程将帮助你建立对智慧医疗和人工智能的整体认知，了解智慧医疗当前最新前沿技术，并具备主动跟踪未来发展趋势的意识及能力。本课程已入选“清华大学通识荣誉课程”。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 3);
INSERT INTO `lesson_detail` VALUES (3, '道法术器势案，营销江湖风云变幻，课程团队的七位老师将和您一起携手踏入这网络时代瞬息万变的营销世界！谁主沉浮，且看后浪肆意江湖！！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 4);
INSERT INTO `lesson_detail` VALUES (4, '管窥中国文化发展脉络和特质，了解王阳明的传奇生平、人格精神及学术内容和特色，学习王阳明为学的功夫，培养情操、完善人格，树立文化自信。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 5);
INSERT INTO `lesson_detail` VALUES (5, '电工电子技术已经渗透到我们工作生活的方方面面，几乎是一个无所不在的世界。在这里，我们解剖着电脑的细胞（逻辑门），我们组装着电厂的心脏（发电机）……高高的塔线是电工的五线谱，流光溢彩的影视是电子的音响。R的阻碍挡不住LC的和谐（谐振），晶体管放大了我们的理想。这是一个无所不在的领域，让我们和先哲们共舞，探究未来的世界。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 6);
INSERT INTO `lesson_detail` VALUES (6, '科学研究和工程实践离不开仪器和测量，而仪器和测量的最核心目标，不仅是获得最佳测量值，还应给出最佳测量值的精度参数。从测量的角度，没有精度参数的最佳估计值是不科学的。本课程从误差的维度，学习误差的基本性质及数据处理基本方法、评价方法，培养学生对实际测量系统与测量结果进行误差分析、精度设计、数据处理以及科学评价的能力。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 7);
INSERT INTO `lesson_detail` VALUES (7, '时尚买手在国内外发展迅速，是服装设计、时尚管理、国际贸易、商务英语等专业很多毕业生的首选职业之一。时尚买手影响着从商品设计到店铺终端的整个过程，需要较高的综合能力，因为时尚买手是一个企业或品牌商业成败的核心人物，不仅需要时尚常识，管理和沟通能力，还需要商业头脑和强大的数据分析能力，而外企或与外企合作的品牌或企业对其买手的英语能力要求非常高。 《时尚买手训练营（双语）》课程汇聚了具备丰富经验的高校教师和时尚精英买手，讲解时尚买手基本理论、核心买货数据、货品规划、供应链管理、时尚流行趋势等内容，为同学们带来不同的视角与方法论，提升专业英语能力，助力大家入门时尚买手的学习，拥有成为优秀的初级买手机会。 如果你热爱时尚，热爱货品，热爱通过数据平衡艺术与商业，那就快快入营吧！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 8);
INSERT INTO `lesson_detail` VALUES (8, '我们经常听数学老师说“我现在讲的是思路，你们写答案的时候要反过来写啊！”从某种意义上说，数学知识本身的逻辑是一种“反思考”的逻辑，它与人们从拆解问题到组装答案的习惯性思考过程是不一致的。传统的课堂教学按照数学知识本身的逻辑组织材料，尽管很准确，但给学生对知识进行消化和理解制造了障碍。在这门课程中，主讲人将遵循思考的逻辑，带领学生梳理高等数学特别是微积分理论中一系列重要的概念和知识点，以及它们的背景和拓展应用，内容包含四个板块。第一板块是数学通识板块，学生将从这里了解到一些关于数学的基本观点和事实；第二板块将回答一个基本的问题：高等数学何以称之为高等？高等数学里的内容跟中学数学里的内容有多大的区别，是不是存在一个明确的分水岭？第三板块是课程的核心，主讲人将借助局部—整体原则讨论微积分理论的核心要义和基本框架，包括函数极限、连续性、无穷小及其比较、导数与微分、微积分基本定理、多元函数微积分等；最后一个板块是微积分的实践之路，内容包括泰勒展开、傅里叶展开、最小作用量原理，极值问题在数学、工程学、人工智能等领域的应用。本门课程是第一次系统开设，部分内容曾由负责人在首都师范大学2021年暑假小学期面向多个院系的本科生讲', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 9);
INSERT INTO `lesson_detail` VALUES (9, '高分子合成材料的性能优异，应用广泛，是人们生活和生产不可缺少的基础材料，也是高新技术领域重点发展的新型材料。本课程将带你了解和掌握高分子合成材料的类型、合成工艺及原理、结构与性能关系、成型加工及其应用，以及高分子合成材料的新技术等内容，加深对高分子材料基础知识和基本理论的掌握，了解高分子合成材料领域的新进展，拓展材料领域知识面，为今后从事高分子材料方面的科学研究或生产工作打下坚实基础。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 10);
INSERT INTO `lesson_detail` VALUES (10, '随着人工智能和大数据时代的到来，对运筹和优化的需求也愈加迫切。本课程将重点介绍最优化的基本理论及算法，并引入前沿科研课题，介绍优化方法如何应用于实际问题求解。对优化算法感兴趣的小伙伴们，快来加入吧！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 11);
INSERT INTO `lesson_detail` VALUES (11, '《偏微分方程》是数学科学学院各专业研究生重要的基础课程。教材方面，我院采用数学家Lawrence C. Evans教授编撰的《Partial Differential Equations》教材，并且经过教学的反复实践，取得了广泛的好评。数学学科是我校重点支持的强势学科，2017年入选世界一流建设学科名单，现拥有“数学与应用数学”和“统计学”两个国家一流本科专业。《偏微分方程》课程作为数学学科的重要学科基础课程，具有很强的学科支撑。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 12);
INSERT INTO `lesson_detail` VALUES (12, '这是一门关于马克思哲学和马克思主义的基础研究课程，以政治哲学为研究视角，以经典马克思主义、列宁主义和中国化马克思主义为研究线索，以马克思的法哲学批判、哲学人类学批判、历史哲学批判、政治经济学批判和形而上学批判为研究领域，“三大时期”“五大批判”经纬交织，纵横捭阖，适用于相关专业研究生和本科生。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 13);
INSERT INTO `lesson_detail` VALUES (13, '《流行病学原理与方法》是在流行病学的基本理论和基本方法基础上，深入、扩展的适用于公共卫生、公共卫生与预防医学、社会医学与卫生事业管理和临床医学专业硕士研究生及公共卫生工作者的一门课程。本课程通过“理论课堂-案例分析-文献评阅”三位一体的教学模式，力图充分调动学生学习的主观能动性；在掌握教学大纲所要求的基本理论、知识和技能的基础上，培养学生独立分析问题、解决问题的能力。本课程着重于开阔学生科研视野，拓宽其解决问题的思路和拓展其专业知识储备，以期他们能够在未来科研及公共卫生实践中运用科学的思维，进行文献收集及评价、开展健康相关问题科研设计、资料收集及分析、科研论文和调查报告的撰写，特别是能够在新形势下研判可能的公共卫生事件，进行应急处理并解决公共卫生问题，以适应新世纪医药卫生事业发展的需要。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 14);
INSERT INTO `lesson_detail` VALUES (14, '《高级免疫学理论与技术》是由吉林大学基础医学院免疫学系承担的面向医学、药学及护理学等相关各专业的研究生医学公共课，也是医学专业的主干课程，是生命科学和医学领域中一门基础性、前沿性和支柱性学科，具有比较完整的理论体系和极具应用价值的技术体系，与临床医学、预防医学及生命科学等学科广泛交叉、渗透，已成为当今生命科学发展最迅速的前沿学科。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 15);
INSERT INTO `lesson_detail` VALUES (15, '哈尔滨工业大学马军院士、环境学院南军副院长、环境学院邱微教授的教学团队，精心设计打造《水工程伦理》上线了！提升工程伦理素养，尊重自然规律，实现永续发展，守护绿水青山，创造金山银山。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 16);
INSERT INTO `lesson_detail` VALUES (16, '1.课程内容体现高阶前沿引领 课程内容注重前沿引领，反映学科和专业的基本内容与最新研究成果。 2.教学设计实现个性化智慧教学 先进的教育技术与新教学理念融合，运用智慧教学工具创新授课方式和教学方法。 3.考核方式多元化实现过程性评价 建立“学测一体化”、“多元化”的学习评价', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 17);
INSERT INTO `lesson_detail` VALUES (17, '钢筋混凝土与砌体结构课程是土建类专业进行岗位能力培养的一门专业核心课程。主要任务是学习钢筋混凝土结构和砌体结构的基本概念、构件组成、计算原理及识图方法。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 26);
INSERT INTO `lesson_detail` VALUES (18, '安装概预算课程是工程造价专业开设的专业核心课程，重点培养学生独立对给排水工程、采暖工程、电气照明工程识图与工程量计算的能力，培养学生严谨的学习态度和灵活将理论应用于实践的能力，从而提高专业综合素质。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 27);
INSERT INTO `lesson_detail` VALUES (19, '古往今来，光阴飞逝，时间在风起云涌的历史中穿梭，却始终眷恋着神舟大地上的每一处建筑。挖土为穴、草木砖石、雕梁画栋、建筑与结构本就是时间的化身，凝固着无数穿越的美丽、印刻着一代代匠人的传承与坚守，建筑结构的每一处都悠扬着动听的声音，需要你用心去聆听。本课程以“大国工匠”精神为引领，将“结构构件的设计”与“结构施工图的识读”紧密结合起来，选取统一的典型项目为载体，在学习过程中你将达到“对结构基本知识掌握”——“对结构基本构件设计”——“对结构施工图识读”的能力。 我们将建筑行业发展的新技术、新工艺、新材料、新设备纳入教学内容，及时响应新规范、新图集，对接行业岗位新需求，遵循“能力渐进”的学习规律，将课程内容重构为九大项目，以认识建筑结构基本知识为基础进行展开，介绍实际工程中常用的建筑结构形式：有框架结构、预应力混凝土结构、剪力墙结构、楼盖结构、装配式混凝土结构、单层工业厂房结构、砌体结构和钢结构，每种结构体系从选用结构类型材料、设计结构基本构件到结构施工图应用依次展开，逐步提高学生对基本构件设计和对结构施工图识读的能力。 大国工匠、匠心筑梦，梦想从这里出发！你——准备好了吗？', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 28);
INSERT INTO `lesson_detail` VALUES (20, '瑜伽学科如天空般广阔，我们旨在做您瑜伽路上的启蒙者，指引您沿着正确的方向开启瑜伽这场身心同修之旅。愿我们的相遇是您瑜伽的开始！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 29);
INSERT INTO `lesson_detail` VALUES (21, '风雨变幻证券市场，风险投资金融市场，股市之奥妙，尽在证期课堂。 本课程是在行业专家对证券实务专业所涵盖的岗位群进行任务与职业能力分析的基础上开设的。教学过程中，通过校企合作，校内实训基地建设等多种途径，让学生全面了解证券市场，了解各种金融工具，初步掌握操作技巧，投资技巧，明晰相应风险控制，最终通过本课程的学习，为后续课程的学习打下坚实的基础。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 30);
INSERT INTO `lesson_detail` VALUES (22, '《药物检测技术》作为高职院校药学类专业的专业核心课程，具有很强技术性、应用性和实践性。该课程从制药企业药品检测岗位所需的实际技能要求出发，整个授课过程以混合式教学模式为主线，线上线下有机结合，有效的利用信息技术，观看3D动画、微课、教学视频，将抽象的内容形象化，复杂的问题简单化，克服传统教学方法的枯燥乏味，使课程教学面貌焕然一新，教学模式、教学方法、教学手段、教学资源等方面发生显著变化，最大程度的提高学生学习兴趣、动手能力、团队协作意识，实现现代信息化技术对“做中学、做中教、教学互动、理实一体”教学模式的强大辅助作用，为今后走向药品检测岗位奠定基础。 《药物检测技术》先后荣获全国职业院校信息化教学大赛三等奖、陕西省高等职业院校信息化教学大赛二等奖、陕西省高等职业院校课堂教学创新大赛二等奖、微课《药品崩解时限的检查》先后荣获学校第二届微课教学比赛二等奖、陕西省第二届高校教师微课教学比赛二等奖。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 31);
INSERT INTO `lesson_detail` VALUES (23, '《钢结构制作安装》形成了“以应用为主线，案例驱动，理实一体”的课程特色，适合建筑工程技术专业、建筑工程造价、建筑工程监理等相关专业在校高职学生的学习。该课程的学习任务和工作任务吻合度高，项目案例典型，实用性强，对企业技术人员具有较强的参考性。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 32);
INSERT INTO `lesson_detail` VALUES (24, '液压与气动技术是机械传动与控制中的一门关键技术，与智能控制技术、计算机控制技术等技术结合越来越紧密，其水平的高低已成为一个国家工业发展水平的标志，并广泛应用于国民经济各个领域。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 33);
INSERT INTO `lesson_detail` VALUES (25, '机器学习（Machine Learning）是人工智能的核心研究领域之一，并取得了广泛的应用效果，是引领这一轮“人工智能热潮”的关键技术支撑。《机器学习初步》课程覆盖机器学习的入门基石内容，课程主讲人周志华教授是领域内学者，所著《机器学习》（网友昵称为“西瓜书”）正是本课程的教材。本课程的教学目标是使学生对机器学习有初步的认识，初步掌握机器学习的基本原理和方法，并初步形成利用机器学习技术解决问题的思维方式。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 18);
INSERT INTO `lesson_detail` VALUES (26, '大数据、人工智能、机器学习……热点词汇频繁映入眼帘 ,非计算机专业的你，是不是也希望能紧跟时代潮流？ 不想转专业？也不想学n多硬核专业课？还想在大数据或者人工智能领域开启一角？ 这门课，可以让你的梦想照进现实！ 理论+实操，带你来到实践前沿，助你获得敲开大数据、机器学习领域的第一块砖！ 选它! 在产教融合创新课，体验通识提升，数十位具有十年以上经验的清华老师和业界大咖领你入门~', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 19);
INSERT INTO `lesson_detail` VALUES (27, '本课程联合相关高职院校、企业的多位工业机器人技术与应用专家，提炼多个典型工业机器人应用典型案例，理论和实践相结合。力争使学生通过学习本课程，掌握工业机器人离线编程与生产线虚拟仿真技术。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 20);
INSERT INTO `lesson_detail` VALUES (28, '“人工智能”正在取代人类吗？至少目前人工智能已经主宰着我们的生活，本课程就是“对技术设计的一种诉求——人工智能必须证明自己是一种社会服务”的澄清。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 21);
INSERT INTO `lesson_detail` VALUES (29, '自底向上讲述计算系统各类安全保护机制底层算法、信息传输认证协议和实现方案、基于软件开发、网络应用、操作系统和数据库系统使用的安全攻防原理和技术。完善计算机安全知识结构教学设计体系，兼顾研究型和应用型学习者的不同需求，支持计算机安全综合实践能力培养，是一门有温度的计算机专业基础课。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 22);
INSERT INTO `lesson_detail` VALUES (30, '“破译”计算机网络之奥秘，探秘这“熟悉的陌生人”。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 23);
INSERT INTO `lesson_detail` VALUES (31, '本课程针对Unity初学者的特点和需求，本着“起点低，终点高”的原则进行教学设计，力求以实用为宗旨，基于企业级项目规范设计的案例来贯穿讲解，培养游戏作品的设计能力。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 24);
INSERT INTO `lesson_detail` VALUES (32, '本课程使学生掌握计算机的基础应用技能，具有运用计算机获取信息、加工信息和应用信息的能力，同时还要激发和培养学生学习计算机的兴趣，使学生树立自信心，养成良好的学习习惯，形成有效的学习策略，发展自主学习的能力和团队协作精神。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 25);
INSERT INTO `lesson_detail` VALUES (33, '从哈丁的“公地悲剧”到奥斯特罗姆的《公共事物的治理之道》，公共事物（Commons）治理历经半个世纪的发展，研究对象已经扩展到一切带有公共属性的物品，成为蓬勃发展的新兴学科领域。本课程系统介绍公共事物的学科概览、框架、理论、方法以及应用，阐释公共事物研究国际前沿以及本土化思考。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 34);
INSERT INTO `lesson_detail` VALUES (34, '《金融交易导论》课程从金融交易的角度出发，对金融交易的原理、机制和实务进行了详细分析和阐述。该课程既体现出知识性、专业性，以提高学生的知识水平，也体现出普及性、实务性，为广大观看者提供参考借鉴。全课由金融界资深专家教授焦瑾璞老师及其博士后研究团队主讲，知识体系科学，资源配置丰富合理，讲解生动清晰，欢迎大家品鉴。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 35);
INSERT INTO `lesson_detail` VALUES (35, '本课程是财务和会计专业的核心必修课。课程系统介绍了财务报表分析的逻辑框架和方法技巧。通过课程学习，可以帮助学员借助财务报表快速找到分析企业管理问题的“突破口”，从而对企业进行合理的管理诊断和价值判断。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 36);
INSERT INTO `lesson_detail` VALUES (36, '营销，这是人人都需要的一项能力！无论你营销的是产品或是服务，是企业或是非盈利机构，是别人或是自己。 ------《市场营销理论与实务》助你了解和掌握这种能力。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 37);
INSERT INTO `lesson_detail` VALUES (37, '《西方经济学》作为经济管理专业本科生的必修课。本课程基于贵州高校经济管理类学生的实际情况，在阐释经济学基本理论和基本知识的基础上，着重结合贵州省及中国西部经济发展的实际，培养学生经济理论联系经济社会现实的解决问题能力。 《西方经济学》课程面向西部经济基础相对较弱地区的学员免费开放，传递经济学的智慧，激发学习经济学的兴趣，并注重引导学员形成运用经济理论分析问题的思维能力，解决现实生计问题的经营能力。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 38);
INSERT INTO `lesson_detail` VALUES (38, '公共管理的目标是关注公共福祉，实现公共利益，如果你关注社会现实，想要了解公共管理的发展规律，试图探究公共管理的本质特征，这门课程将带你步入公共管理的知识殿堂，帮助你探索公共管理学科前沿，引领你运用所学知识，联系国家社会治理与公共服务的实际，分析解决当前公共管理的各类问题。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 39);
INSERT INTO `lesson_detail` VALUES (39, '民为邦本，本固邦宁。 民法是社会主体享有自由的权利宪章。 民为邦本，法乃公器。 了解民法，就是体悟生活中的岁月静好。 民法学习没有高不可攀的围墙，从民法总论起步，我们都是等待发光的种子。 因为， 在民法慈母般的眼睛里，每个个人就是整个国家。 小伙伴们，来，咱们一起出发！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 40);
INSERT INTO `lesson_detail` VALUES (40, '本课程为面向全院所有专业学生开设的公共基础课程，通过本课程的学习，让学生了解创新对于推动整个人类社会发展和进步的重要意义，帮助学生学习并掌握创新的基本理论、创新思维和创新技法，激发学生的创新兴趣和热情,并提高创新能力和水平。让学生了解创业活动过程的内在规律，了解创业过程经常遇到的问题和初创企业的特点。培育学生的创新意识，强化创业精神，以及资源整合、团队建设等创业技能，使学生能用创业的思维和行为准则开展工作，并具有创造性地分析和解决问题的能力。为学生今后的专业学习和创新创业实践打下良好基础。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 41);
INSERT INTO `lesson_detail` VALUES (41, '你可曾好奇过时间的结构可能是怎样的？在不同结构的时间中，我们对于过去和未来该如何进行推理？ 你可曾好奇过个体的思维的结构可能是怎样的？在种种我们认为可能的世界图景之上，可能性和必然性分别意味着什么？信念是如何被构建的？随着可信度不同的新信息的输入，我们又会如何相应地改变自己的信念系统？ 你可曾好奇过在特定的社会情境中，不同主体如何认知该情境，他们的认知结构又如何互相关联？不同视角的主体分别对事实有什么判断，对他人对事实的判断有什么判断，对他人对他人或自己对事实的判断的判断有什么判断……? 这样从一阶到高阶的多主体认知结构该如何表示，又会随着对象范围不同、可信度不同的信息更新发生怎样的变化？ 在这门课中，你将在一位模态逻辑大师的引领下踏上探索这些问题的征程。除了满足自己对这些引人入胜的问题的好奇心外，你将学习模态逻辑中的时态逻辑、认知逻辑和动态社会认知逻辑等。在逻辑学本身之外，这门课上学到的许多理论模型在计算机、认知科学、博弈论和语言学等多个领域也都有所应用。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 42);
INSERT INTO `lesson_detail` VALUES (42, '移动社交媒体时代背景下，职业选择与发展路径的信息过载化、金钱绝对化、人性娱乐化现象越来越突出，导致青年学子在学术与职业生涯中面临越来越多的职业伦理问题。本课程由清华大学深圳国际研究生院职业伦理跨学科教学团队精心打造，通过深入浅出的理论探讨与鲜活生动的案例剖析，带领学习者成长为一名负责任创新、积极心理行动的职业伦理“实践家”。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 43);
INSERT INTO `lesson_detail` VALUES (43, '本课程面向建筑学、城乡规划、风景园林等专业学生，从环境行为学经典理论出发，引入前沿技术，结合典型案例，开展技术方法专题讲解。从科学实证的视角引导学生对“环境、空间与人”的关系进行思考与再认知。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 44);
INSERT INTO `lesson_detail` VALUES (44, '楚国为何以“荆条”来命名？楚人究竟来自哪里？历史上真有芈月这个人吗？仙侠剧中萌萌哒的神兽与楚人有什么关系？说起楚文化人们往往想到的是惊采绝艳的《楚辞》、《老庄》。20世纪下半叶以来，一次次震惊世界的考古发现，为我们展示了不一样的楚文化。那些恢诡谲怪的青铜器上诉说了怎样的峥嵘岁月？流光溢彩的漆器上反映了楚人怎样的时尚品味？本课程将带领大家进入楚人神奇浪漫的世界。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 45);
INSERT INTO `lesson_detail` VALUES (45, '《说文解字》作为中国文字学的奠基之作、经典之作，收录了9353个汉字，蕴涵了丰富的文化信息，是打开中国古代文化宝库的一把钥匙。本课程以《说文解字》为纲，以文字结构、文字说解、字义引申为突破口，以“天文”和“民俗”相关用字为例，探究其中蕴含的中国古代文化奥秘，融知识性、趣味性与学术性于一体。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 46);
INSERT INTO `lesson_detail` VALUES (46, '昆虫文化课程中插入了许多精美的图片和视频，学习该门课程不仅可以学习相关知识，而且可以陶冶性情，发展个性，拓展思维。本课程是一门高质量的课程。主讲教师为安徽农业大学段亚妮教授。欢迎大家学习昆虫文化。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 47);
INSERT INTO `lesson_detail` VALUES (47, '太极，是中国文化的始原，代表了派生宇宙万物的本源。以太极命名拳术，象征着太极拳的拳法、拳理包罗一阴一阳、天地变化。太极拳以其中正安舒，含蓄内敛，急缓相间，刚柔相济的特点诠释了太极拳核心的运动理念。24式太极拳也叫简化太极拳，虽然它只有24个动作，但却是汲取了杨式太极拳之精华，其内容精炼，动作规范，充分体现了太极拳的运动特点。24式太极拳是高校体育课的必选项目之一，本课程是专门为大学生和初学太极拳的爱好者而设计，通过跟学，跟练的方式，让大家尽快掌握和熟悉太极拳的基本原理，并流畅的完成24式太极拳的动作演练！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 48);
INSERT INTO `lesson_detail` VALUES (48, '文学的世界，像浩瀚神秘的大海，更像深邃无垠的天空。在璀璨的天空中，有无数耀眼的星座。那里有屈原、李白，也有荷马、但丁。文学是心灵的琴弦，它弹奏的乐章，有陶潜的朴素淡远、杜甫的沉郁顿挫，也有恵特曼的浪漫热烈、紫氏部的哀婉凄美。让我们走进外国文学，与那些纯净而伟大的心灵对话，领略思想的深邃，感悟人生的真谛。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 49);
INSERT INTO `lesson_detail` VALUES (49, '人体胚胎学属于基础医学学科，对医学生和普通本科生均有丰富知识体系、提高综合素质的价值。人体胚胎学系统发生主要介绍人体各个系统的基本机构和功能、系统发生过程和常见畸形，分别为神经系统、眼和耳、颜面、头颈和骨骼四肢、心血管系统、消化系统、呼吸系统、泌尿系统和生殖系统。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 50);
INSERT INTO `lesson_detail` VALUES (50, '组织学是研究正常人体微细结构及其相关功能的学科。本课程的内容包含组织学的基本概念，人体的四种基本组织及循环系统、免疫系统、消化系统等多个系统的组织学知识，组织学是医学专业课程的基础课，也是临床医学等专业的必修课程。本课程的授课团队来自于清华大学医学院、北京大学基础医学院、北京大学医学部、首都医科大学基础医学院组胚教研室的8位有多年授课经验的组胚学教师，应该说本课程是北京三所医学高校的强强合作。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 51);
INSERT INTO `lesson_detail` VALUES (51, '欢迎大家走进智能医学发展前沿！ 智能医学是一个全新的学科，从2018年首批专业开设以来，智能医学发展迅速，其内涵、概念逐渐明晰，范畴、理论渐成体系，技术、应用日新月异； 智能医学是一个全新的领域，它融合了神经工程、健康大数据、远程医疗、医学机器人、工程材料等多个交叉门类，推动现代医学进入崭新发展阶段； 智能医学是一个全新的业态，它凝聚了医学科技前沿的最新成果，面向人民生命健康的重大需求，成为创新驱动卫生与健康事业发展的先导力量。 智能医学，打造通识课程。 智能医学，赋能健康中国。 智能医学，拥抱美好未来！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 52);
INSERT INTO `lesson_detail` VALUES (52, '运用中医中药，护佑女性健康！ 女性健康在健康社会中扮演着重要的角色，健康的女性对于下一代的健康孕育、健康家庭以及健康社会的发展都至关重要。随着社会的发展和进步，女性在各领域肩负更重要的责任和使命，随之而来的还有各种各样的健康问题和疾病。你想知道女性有哪些常见病和多发病吗？如何运用中医中药预防和治疗这些疾病呢？本课程将从女性生殖系统解剖讲起，带领大家全面认识女性的月经、带下、妊娠、产育等现象，并详解月经病、带下病、妊娠病、产后病和妇科杂病等妇科常见疾病的诊断和防治。 《中医妇科学》课程，欢迎你的加入！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 53);
INSERT INTO `lesson_detail` VALUES (53, '病人与患者有何不同？医患关系与普通人际关系有何区别？如何处理知情同意与保护性医疗的关系？是否应当把全部诊疗信息都完全告知患者？面对家属的询问，医务人员应否将患者感染艾滋病的事实告知家属？对不同的患者在沟通时应当注意哪些特殊的问题？多一点沟通，少一份报怨，多一点理解，少一桩纠纷，只有了解了医患沟通的原则、技巧和要求，才能共同构建和谐的医患关系。为此，广州医科大学、广东省人民医院、广州市红十会医院的医学伦理学专家、临床心理学专家、医院管理专家共同打造了该门课程，该课程实现了医患沟通的基本理论与临床实践的无缝对接，既有理论分析，也是技能介绍，具有较强的针对性和可操作性，适用于高校医科类学生、 广大医护人员以及对医患关系感兴趣的所有公众。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 54);
INSERT INTO `lesson_detail` VALUES (54, '没有解剖学就没有医学，没有断层解剖学就没有现代医学。为了成就心中的梦想，成为一名出色的医生，让我们一起开始断层解剖学学习吧！不论是在读的医学生还是在职的老医生，您都可以增长知识，提升能力，收获自信！你的医路之旅必将精彩绽放！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 55);
INSERT INTO `lesson_detail` VALUES (55, '一种科学方法，两类人群参加，三种感官分析方法，四个过程，五个感觉通道，心动从舌尖开始', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 56);
INSERT INTO `lesson_detail` VALUES (56, '仪器分析是测定物质的化学组成、含量、状态、结构和进行化学研究的重要手段。本课程旨在引导初学者入门，为进一步深入学习打下必要的基础。通过本课程的学习，学生可以依据待测混合物各组分的物理性质的差异，选择合适的仪器分析方法进行分离、定性分析、定量分析及结构分析；建立起准确的“定性”及“定量”的概念并掌握与此相关的基本理论、测定原理及实验技术；并能够应用仪器分析中常用的分析手段解决一些简单物质的分析问题。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 57);
INSERT INTO `lesson_detail` VALUES (57, '面向懂英语或中文的所有人群，适用于从零起点到中高级学习者的各种水平。 教授生活中最常见的使用频率最高的日语口语，以及各种在日本生活的知识和方法。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 58);
INSERT INTO `lesson_detail` VALUES (58, '你想了解日本人的生活细节和民族文化吗？你想快速掌握日语的基础知识吗？欢迎选择本课程。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 59);
INSERT INTO `lesson_detail` VALUES (59, '中医药文化——中华文化的瑰宝和精髓，需要我们每一位国人传承和弘扬！如何开始用英语讲中医故事？我们来帮你做到！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 60);
INSERT INTO `lesson_detail` VALUES (60, '纵观中国铁路的发展，中国铁路由小到大、由弱变强，从内燃机车到电力机车，再到高铁动车，实现跨越式发展的中国铁路无疑是70多年伟大成就的一个具体缩影。近年来，中国铁路“走出去”的步伐不断加快，足迹遍及亚洲、欧洲、北美洲和非洲，成为“一带一路”建设和国际产能合作的一张靓丽名片，也为全球发展事业贡献了中国力量。因此就业市场对铁路行业人才的需求迅速增长，对人才知识结构和职业能力也提出了新的要求。作为高职教育重要组成部分的公共基础英语课程，既要衔接好基础英语的教学，更要体现职业教育的特点。 本课程以职场工作情境引领语言技能目标，通过真实的语言材料和训练，把实际工作场景带入课堂，给学生带来直观的职业体验，融“教、学、做”为一体，以学生为主，充分调动学生的积极性，增强学生的职业能力，形成完整的英语应用能力体系，从而做到学以致用。课程视频内容通俗易懂、概念清楚，思政元素巧妙地融入，同时也配套大量铁路现场图片、视频和习题，无论是在校学生还是社会学习者，都能够通过课程的学习，了解铁路、理解铁路、热爱铁路。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 61);
INSERT INTO `lesson_detail` VALUES (61, '你想全面了解和掌握韩语基础知识吗？你想用韩语讲述中国故事吗？那赶紧加入韩语学习之旅吧！本课程通过表意精确、地道实用的韩语日常会话学习加深对韩国文化的了解，增加对多元文化的兴趣，提高你跨语言、跨文化交际能力。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 62);
INSERT INTO `lesson_detail` VALUES (62, '想提高英语水平？又想学习中国文学文化知识？想事半功倍，一举两得，那么加入我们的课程吧。 《中西经典对话》探讨文学作品中有趣的文学意象，阐释同一个文学意象下中西文学经典相同或不同的表达方式。课程全英授课，中英双语字幕。学习用英语讲述中国故事，让我们一起探索妙趣横生的文学之旅。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 63);
INSERT INTO `lesson_detail` VALUES (63, '本课程情景真实，语言地道，能够全面提升学生的口语交际能力。通过感受、理解和比较多元文化，能够有效提升学生的跨文化交际能力、国际视野以及文化素养。激发学生多角度深入思维和多层次讨论，从而培养学生的思辨创新能力。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 64);
INSERT INTO `lesson_detail` VALUES (64, '1、本课程生动讲解了学习日语文字、语音、基础语法的快捷方法，并指出了中国学习者在日语学习方面的常见错误。课程涵盖了初级日语的核心语法点，并具体讲解了日语形容词、形容动词、动词变化规则，是初级日语学习和考试的必修课。2、本课程以“海“为切入点，对古代、近代、现代中日文化交流的历史事件、商贸往来、人物故事等进行了回顾与发掘。通过本课程的学习，不但可以了解日语的全貌、岛国日本的海洋文化特色，还是学习日本史、中日文化交流史的入门课，一举两得。3、本课程拓展了中日航海交通史视野，深化对中日航海文化的理解和认识，可为E+教育时代的中国日语学习者、研究者提供新目标、新方法、新思路。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 65);
INSERT INTO `lesson_detail` VALUES (65, '本课程系统介绍基于片上系统SoC的现代电子系统，包括系统组成、设计方法、最新技术、设计样例、实验内容及实验结果展示等。帮助学生系统全面地掌握现代电子系统的设计方法，同时培养创新设计思想。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 66);
INSERT INTO `lesson_detail` VALUES (66, '我们将用明了清晰的方式为大家讲解流体力学这一深奥却深入生产生活的力学课程，不论你是流体力学的研究者还是具体的应用者，在这里你都能有所收获。欢迎关注我们的课程，并与我们交流沟通。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 67);
INSERT INTO `lesson_detail` VALUES (67, '《钢筋混凝土结构原理》是2021年陕西省一流本科课程、2022年首批空军和军队精品课程，是土木工程专业的核心专业基础类必修课，是一门理论性、实践性都很强的课程，主要基于理论分析和试验研究来指导工程应用。本课程主要以高等数学和概率论等数学为工具，以材料力学和结构力学等力学为基础，讲授混凝土结构材料的力学性能、结构设计的基本原理和各类构件的合理配筋及承载力计算的科学。 本课程采用梁兴文、史庆轩主编的《混凝土结构设计原理》（第四版，中国建筑工业出版社）作为主讲教材。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 68);
INSERT INTO `lesson_detail` VALUES (68, '光电子技术主要研究光与物质中电子的相互作用及其能量的相互转换。广义的光电子技术包括光电能量系统和光电信息系统，其中前者包括太阳能光伏发电、激光加工、激光医疗、激光核聚变和高能激光武器等，主要解决大功率光辐射能量的产生、控制、利用以及向其它能量形式的转换等，而后者主要包括激光、光波导、光调制、光探测、光显示、光通信、光传感、光存储等技术，主要解决综合利用光学与电子学方法进行信息的采集、加载、传输、处理、存储或显示等。光电子技术与国民经济、国防建设和人民生活的各个方面密切相关，即使是在近期非常热门的量子信息科学、5G通信和激光雷达等研究应用领域中，光电子技术也是其重要一环。据SPIE2020估计，光电子及其应用所带来的市场价值高达全球经济的11%。那就让我们光电子技术课程团队带领大家迅速进入这一年轻且充满发展活力的交叉应用领域吧！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 69);
INSERT INTO `lesson_detail` VALUES (69, '本课程是面向大学一年级物联网工程专业学生开设的物联网导论课程，主要介绍物联网技术的基本概念、关键技术、应用领域及发展现状，帮助大学一年级学生了解物联网工程专业知识与课程体系，尽早确立专业方向，树立创新意识和工程意识。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 70);
INSERT INTO `lesson_detail` VALUES (70, '《汽车发动机构造》系统讲解四冲程内燃发动机的基本结构、工作原理，从而让我们知道汽车发动机这个复杂系统是如何协调有序工作的？当今社会汽车已成为大众化的产品，每个成年人几乎都是驾驶员的时代；因此除了专业学生外，非专业学生也非常有必要对汽车发动机的基本结构和工作原理知识有所了解，以增强对汽车发动机结构与原理的科学认识，对汽车驾驶具有重要作用。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 71);
INSERT INTO `lesson_detail` VALUES (71, '《飞机电气维修基本技能》是高职院校飞行器维修技术专业的核心课程，是迈向飞机电气维修工程师的摇篮。根据飞行器维修的特点和要求，校企深度融合，将民航局147技能标准和新技术纳入教学内容，以飞机维修岗位真实工作任务为载体，设计教学内容，深入浅出讲解规范的维修技能，为尽早达到维修岗位要求奠定基础。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 72);
INSERT INTO `lesson_detail` VALUES (72, '建筑业是我国国民经济的重要支柱产业，工程项目管理在推动建筑业发展的过程中起到了至关重要的作用，优秀的项目管理不仅能提高经济效益、企业信誉，还能带来环境效益、社会效益等的增值。为应对建筑业转型升级，项目管理也向着精细化、智慧化发展，《工程项目管理及BIM应用》是在山东省精品资源共享课《建设工程项目管理》的基础上，为应对建筑业转型升级，对接智慧建造、绿色建造等产业高端，对接1+X-BIM职业技能等级证书制度，而更新打造的课程。 本课程建筑工程技术专业群的一门专业平台课程，同时又是“1+X”建筑信息模型（BIM-中级管理方向）、建筑施工工艺实施与管理（中级）证书考核的支撑课程和国家注册建造师考试科目，欢迎大家加入学习！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 73);
INSERT INTO `lesson_detail` VALUES (73, '课程讲授电磁暂态数值计算的基本方法，及其在电力系统、电气系统电磁暂态分析中的应用。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 74);
INSERT INTO `lesson_detail` VALUES (74, '电磁兼容是电类及机电类工科研究生及高年级本科生必须掌握的基本技能，在科学研究、设备开发、电路板及微电子设计、解决实际工程问题等方面都具有非常重要的作用。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 75);
INSERT INTO `lesson_detail` VALUES (75, '民以食为天，食以粮为先。粮食是人类赖以生存的宝贵资源，是关系国计民生的重要战略物资。中国人必须把饭碗牢牢端在自己手里。同学们，作为未来粮油仓储战线的英才，粮油仓储岗位工作需要哪些知识和技能？用什么理论指导实践，才能最大化节粮减损，保障国家粮食安全？《粮油储藏》这门课将为同学们释疑解惑，引导大家更好地成就职业生涯，为国家的粮食仓储企业发展添砖加瓦，为“中国大粮仓”黑龙江的粮食事业贡献力量。 《粮油储藏》是高职粮食储运与质量安全专业对接（粮油）仓储管理员职业岗位的专业核心课程。是粮食工程技术专业的专业必修课。本课程分“基础知识”、 “粮情检查”、“粮情控制与处理”3个单元，主要介绍粮油从入库后到出库前，在库储藏过程中的各作业环节所需的知识和技能。 “积好粮、好积粮”，重任在肩！科学储粮靠你我，学好本领保粮安，同学们加油！\r\n\r\n\r\n', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 76);
INSERT INTO `lesson_detail` VALUES (76, '化学学科理解指教师对化学学科知识及其思维方式和方法的本原性、结构化的理解。核心素养的实质是创新，为培养创新型人才，教师应加强化学学科理解能力，从而实现学科核心素养在教学实践中的落地。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 77);
INSERT INTO `lesson_detail` VALUES (77, '在大数据时代开启的寻宝游戏中，在欣喜于“一切皆可量化”的同时，你是否感觉到了“让数据主宰一切”的隐忧？你是否怀疑过数据正以良莠参半的方式统治着我们？本课程将从应用问题和现实数据出发来深层次探讨如何获得有效数据、进行数据展示、完成统计推断和解析，最终构筑数据和答案之间的重要关联。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 78);
INSERT INTO `lesson_detail` VALUES (78, '本课程是基于优秀而丰富的线下教学经验和积累，结合现代信息手段，经过教师们精心打磨而成的MOOC。《生态保护概论》MOOC有扎实的学术基础，有条理清晰的知识脉络，有全面、系统的生态保护（海洋、森林、湿地、草原、农村与城市），有丰富生动的案例，有清晰精彩的图像。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 79);
INSERT INTO `lesson_detail` VALUES (79, '仪器分析是测定物质的化学组成、含量、状态、结构和进行化学研究的重要手段。本课程旨在引导初学者入门，为进一步深入学习打下必要的基础。通过本课程的学习，学生可以依据待测混合物各组分的物理性质的差异，选择合适的仪器分析方法进行分离、定性分析、定量分析及结构分析；建立起准确的“定性”及“定量”的概念并掌握与此相关的基本理论、测定原理及实验技术；并能够应用仪器分析中常用的分析手段解决一些简单物质的分析问题。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 80);
INSERT INTO `lesson_detail` VALUES (80, '本课程内容采用模块化专题化创新设计，带领大家探寻物质奥秘，解密微观世界运行规则，了解现代科技应用，一同感受“诺贝尔奖”和“科技创新”的盛宴，玩转“原宇宙”。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 81);
INSERT INTO `lesson_detail` VALUES (81, '中国古代园林的美境，我们能看到的只有清代遗存。本课程在研究的基础上对明代园境进行重构、分析，并且尽可能生动地呈现，让同学们认识明代园林有什么样貌、有什么动人之处、有什么奇异景象、有什么设计经验。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 82);
INSERT INTO `lesson_detail` VALUES (82, '清华大学美术学院必修课 院级精品课', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 83);
INSERT INTO `lesson_detail` VALUES (83, '当艺术遇见科技会擦出什么样的火花？感性的视角，理性的剖析，将会产生怎样的化学反应？设计的本质是创意，思维设计的灵魂是不断的创新，今天就让我们一起探讨创意和设计1+1＞N的无限可能。培养创新创意精神，迈出时代新步伐；树立思维培养的观念，打造不一样的自我。新动力、新生命，尽在创新中焕发光彩。创意思维设计，给你一个发挥创新的想象力的舞台。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 84);
INSERT INTO `lesson_detail` VALUES (84, '《中国舞蹈》的课程内容以国际化课程体系、课程教学标准、教学模式为参考，选取了具有民族特色的中国古典舞身韵和中国民族民间舞为课程的主体内容。通过本课程的学习，激发国内及国际学生对中国舞蹈的兴趣，使学生感受具有中国特色的中国古典舞身韵、中国民族民间舞的独特魅力。欢迎学习《中国舞蹈》课程，祝大家学习愉快。The stage is as big as the heart.Let\'s appreciate the unique charming of Chinese dance in the world stage！', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 85);
INSERT INTO `lesson_detail` VALUES (85, '安徽工程大学艺术学院的视觉传达课程是从艺术设计、动画、工业设计的课程体系发展整合而成，使用该名称更能直观体现课程的内容和性质，更能体现课程的教学目的、方法与形式。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 86);
INSERT INTO `lesson_detail` VALUES (86, '声乐在线公开课程通过不同声乐教师对声乐教材中部分经典作品的讲解，使声乐课程更大众化、专业化，能更好地为声乐学习者提供一个便利的、互动式的学习平台。学习者在学习过程享有充分的灵活性和自主性，他们可以选择自己方便的时间和地点上网学习，可以根据自身专业水平、兴趣点和条件有针对性的选择学习。本课程可以通过线上学习、线下反思与实践，使学习者在获得一定的专业基础理论知识的同时，掌握一定的演唱技能，对歌唱发声的基本原理和方法有较清楚的理解和认识，并能正确运用歌唱方法，解读歌曲内涵，把握不同风格的声乐作品。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 87);
INSERT INTO `lesson_detail` VALUES (87, '本课程采用授课视频学习与作业、讨论相结合的方式。重点突出，思路清晰，对人格高尚、品行卓立的作家和充满家国情怀的作品进行重点讲解，树立科学的、开放的文学史观，培养人文关怀意识，提高文学核心素养。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 88);
INSERT INTO `lesson_detail` VALUES (88, '本门课程以广告创意为中心，更好的进行了课堂思政的融入。在快乐的学习中，能够轻松的掌握广告的理论知识，并且能够提升学生的思想意识，宣传中国文化，传播正能量。', 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/0262076c81d9f303-10.mp4', 89);

-- ----------------------------
-- Table structure for mylesson
-- ----------------------------
DROP TABLE IF EXISTS `mylesson`;
CREATE TABLE `mylesson`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Lesson_Id` int NULL DEFAULT NULL COMMENT '课程Id',
  `User_Id` int NULL DEFAULT NULL COMMENT '用户',
  `Time` datetime NULL DEFAULT NULL COMMENT '加入时间',
  `Is_Finish` int NULL DEFAULT 0 COMMENT '是否完成',
  `durations` int NULL DEFAULT NULL COMMENT '视频播放时间',
  `expanded_List` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '默认展开节点',
  `tree_id` int NULL DEFAULT NULL COMMENT '子链id',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '我的课程' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mylesson
-- ----------------------------
INSERT INTO `mylesson` VALUES (1, 1, 3, '2023-04-23 21:22:44', 0, 0, '1', 23);
INSERT INTO `mylesson` VALUES (2, 4, 3, '2023-04-23 18:28:32', 0, 203, '', 13);
INSERT INTO `mylesson` VALUES (3, 3, 3, '2023-04-23 18:28:56', 0, 0, '3,1', 24);
INSERT INTO `mylesson` VALUES (5, 5, 3, '2023-04-23 20:22:15', 0, 25, '2', 19);
INSERT INTO `mylesson` VALUES (7, 3, 3, '2023-04-23 20:57:57', 0, 0, '3,1', 12);
INSERT INTO `mylesson` VALUES (27, 8, 6, '2023-04-25 20:38:34', 0, 90, '0,1', NULL);
INSERT INTO `mylesson` VALUES (28, 1, 6, '2023-04-25 20:38:52', 0, 0, '1', NULL);
INSERT INTO `mylesson` VALUES (33, 3, 6, '2023-04-25 20:46:03', 0, 0, '3,1', NULL);
INSERT INTO `mylesson` VALUES (34, 3, 6, '2023-04-25 20:46:10', 0, 0, '3,1', NULL);
INSERT INTO `mylesson` VALUES (35, 7, 6, '2023-04-25 20:52:12', 0, NULL, '', NULL);
INSERT INTO `mylesson` VALUES (36, 88, 6, '2023-04-25 20:56:14', 0, 0, '3,5', NULL);
INSERT INTO `mylesson` VALUES (37, 60, 6, '2023-04-25 20:58:22', 0, 0, '5,2,1', NULL);
INSERT INTO `mylesson` VALUES (38, 3, 11, '2023-04-26 02:10:44', 0, 0, '3,1', NULL);
INSERT INTO `mylesson` VALUES (39, 1, 13, '2023-04-26 08:21:20', 0, 0, '1', NULL);
INSERT INTO `mylesson` VALUES (40, 3, 13, '2023-04-26 08:23:35', 0, 0, '3,1', NULL);
INSERT INTO `mylesson` VALUES (41, 4, 13, '2023-04-26 08:26:24', 0, 203, '', NULL);

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `is_hot` int NULL DEFAULT 0 COMMENT '是否热门展示(0否 1是)',
  `Title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `teacher_id` int NULL DEFAULT NULL COMMENT '老师id （作者）',
  `Img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面',
  `Time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '时间',
  `Dian_Ji` int NULL DEFAULT NULL COMMENT '点击量',
  `Content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `Remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '简介',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '新闻表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, 1, '砥砺奋进正当时 奋楫扬帆启新程！扬州市职业大学高邮湖校区项目正式开工', 1, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/%E7%83%AD%E9%97%A8%E6%96%B0%E9%97%BB1.jpg', '2023-03-01 15:54:19', 4093, '在热烈的掌声中，张宝娟宣布扬州市职业大学高邮湖校区项目开工！张宝娟、张长金、余珽、马顺圣、林刚、田醒民、张秋红、徐永宝等与会领导与嘉宾共同移步到培土区，同擎铁锹为新校区项目培土奠基。张长金代表扬州市委、市政府，向扬州市职业大学高邮湖校区开工建设表示热烈的祝贺。她说，高邮湖校区的兴建既是扬州职大发展史上具有里程碑意义的一件大事，也是高邮教育事业高质量发展中的一件盛事。新校区的建成，将有力推动校地高水平融合与高质量发展，为扬州产业科创名城建设蓄势赋能。她希望，扬州职大要坚持扎根高邮大地办学，优化专业设置和人才培养，深度对接高邮重点产业和经济社会发展需求，为地方经济社会发展多做贡献。校地双方要密切配合、通力合作，确保新校区如期建成并投入运行；要创新共建模式，把高邮湖校区打造成职普融通、产教融合、科教融汇的“先行区”，深化职教改革、优化校地资源配置的“试验区”,共同谱写校地融合、共赢发展新篇章。马顺圣在致辞中代表学校向一直以来关心和支持扬州市职业大学事业发展的社会各界人士表示衷心的感谢。他指出，建设高邮湖校区是高邮和职大未来发展共同的战略需要，是学校获取新动能、实现新突破的长远布局。新校区建设与扬州市委、市政府推动扬州产教融合和科创名城建设，高邮市委、市政府推进校地高水平融合的发展需求深度吻合。学校将积极推进校企协同、产教融合，服务城市发展和产业转型升级，努力把高邮湖校区打造成“地方支持职教发展、院校服务地方建设”的典范，助力建设“强富美高”新扬州。田醒民在致辞中表示，将以今天的开工仪式为起点，进一步增强机遇意识、大局意识，为项目建设提供全方位、全天候、全过程服务，把新校区建成民生工程、精品工程、百年工程，让扬州职大瘦西湖校区和高邮湖校区双“湖”辉映、好事成双！将与校方一道，本着“平等互利、优势互补、合作共赢”原则，在人才培养、项目孵化、特色专业建设、办学模式创新上打造校地合作新典范，让高校建设与城市发展双向奔赴、彼此赋能、共享精彩！扬州市职业大学是一所办学历史悠久的高等院校，办学历史可溯源至1907年创办的高邮师范传习所。如今，学校与高邮再度结缘，是扬州职大进一步扩大办学规模、提升办学层次的关键举措，也是高邮进一步集聚高端人才和创新资源，加快在苏中地区率先崛起的战略机遇。高邮湖校区开工奠基，是扬州职大发展史上的里程碑，是继往开来、再铸辉煌的新起点。相信高邮湖校区的建成，一定会为扬州职大内涵式发展打开新空间、提供新引擎、增添新动力。高邮湖校区项目计划总投资17.96亿元，总用地570亩，紧邻S333省道，东至正通新路、南至S333、西至文游南路、北至桑蚕支路。校区以“一芯·两轴·三区”的布局模式，计划设立7个学院、200个班级，总建筑面积约15.7万平方米，可满足7000人规模的在校生使用需求。从瘦西湖畔到高邮湖畔，从瘦西湖科创园到高邮科创园，扬州市职业大学逐梦新征程，全体职大人为学校事业高质量发展而努力奋斗。扬州市职业大学高邮湖校区施工单位负责人、江苏弘盛建设工程集团有限公司总经理张金生代表建设单位发言。出席开工仪式的领导和嘉宾还有扬州市委组织部、发改委、教育局、科技局、财政局、人社局、资规局、住建局、文旅局等部门主要负责同志，扬州市职业大学全体领导班子及各部门、学院主要负责同志，高邮市有关领导，有关部门和各乡镇（园区）主要负责同志，城南经济新区党政领导班子全体成员等300余人。', '3月1日，高邮湖畔、春光明媚，秦观故里、嘉宾云集，扬州市职业大学高邮湖校区项目正式开工。江苏省人大常委会副主任、扬州市委书记张宝娟，扬州市委常委、宣传部部长张长金，扬州市副市长余珽，扬州市职业大学党委书记马顺圣，扬州市职业大学党委副书记、校长林刚，高邮市委副书记、市长田醒民，高邮市人大常委会主任张秋红，高邮市政协主席徐永宝等出席开工仪式，开工仪式由高邮市委副书记郑志明主持。');
INSERT INTO `news` VALUES (2, 1, '勇担新使命 开启新征程——学校举行第三届教职工暨第三届工会会员代表大会第五次会议', 1, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/%E7%83%AD%E9%97%A8%E6%96%B0%E9%97%BB2.jpg', '2023-03-06 15:59:05', 1145, '在会上，马顺圣就如何贯彻落实好大会精神，抓好今年各项重点工作，提出以下三点要求：一要聚焦政治建设，坚持和加强党对学校工作的全面领导。从全面增强党的政治领导力、党的思想引领力、党的风险防范力入手，坚定不移地以习近平新时代中国特色社会主义思想引领学校的高质量发展。二要聚焦关键重点，持续锚定高质量发展目标不放松。全力做好高水平校建设、专业群建设、师资队伍建设、现代职教体系建设，筹备召开学校第三次党代会，持续推动办学条件改善，统筹全局，以重点突破带动全面发展，逐项攻坚，让校党委各项决策部署如期落地见效。三要聚焦实干担当，持续提升执行力战斗力不放松。在推动学校高质量发展中充分彰显艰苦创业、勤奋踏实、开拓进取、百折不挠的精神气质和优秀品质。马顺圣指出，全校上下要坚持不懈用习近平新时代中国特色社会主义思想凝心铸魂，始终坚守“为党育人、为国育才”初心使命，保持拼搏创新、奋斗前行的力量和久久为功、善作善成的韧劲，矢志不渝，持续奋斗，全面提高办学实力和水平，全面提升人才培养质量，全面开启建设江苏省高水平高职学校的新征程，奋力实现学校高质量发展新跨越。林刚代表学校作题为《勇担新使命 开启新征程 奋力夺取高水平高职院校建设新胜利》的工作报告。在回顾2022年工作时，他表示，学校坚持以习近平新时代中国特色社会主义思想为指导，深入贯彻落实党的二十大精神，各领域捷报频传，多项标志性成果位居全省同类高校前列。学校成功获批省中国特色高水平高职学校建设单位，入选全国高职院校资源建设优势学校60强，知名度和美誉度明显提升。他指出，2023年，是全面贯彻党的二十大精神的起始之年，是我校“十四五”规划承上启下的关键一年，也是实现学校第二次党代会提出的奋斗目标的收官一年，还将隆重召开学校第三次党代会。学校工作要坚持以习近平新时代中国特色社会主义思想为指引，深入学习贯彻党的二十大精神，聚焦党的建设和内涵高质量发展，团结一致、勇毅笃行，奋力推进学校高质量发展取得新胜利。他从聚焦党建引领奋力汇聚事业发展新动能，聚焦人才培养着力打造教育教学改革新引擎，聚焦人才强校全力构建师资队伍新高地，聚焦区域发展合力提升社会服务新能级，聚焦管理优化倾力开创服务保障新局面等五个方面部署了学校2023年党政重点工作。会议审议通过了陈建军所做的《凝心聚力 务实奋进 为开创学校事业高质量发展新局面贡献力量》的工会工作报告。报告回顾了2022年学校工会所做的工作和取得的成绩，对今年的工作提出了初步设想。会议认为，工会工作报告总结去年的工作客观全面、实事求是，谋划今后的工作思路清晰、措施有力。会议还对学校第三届工会委员会主席、副主席进行了民主评议，对工会建家工作进行了民主评议。会议号召，全体与会代表要在学校党委的领导下，以习近平新时代中国特色社会主义思想为指导，充分发挥教代会和工代会的作用，为不断开创新时代我校各项工作的新局面，不断推动学校事业高质量发展而努力奋斗！', '3月5日，扬州市职业大学第三届教职工暨第三届工会会员代表大会第五次会议在科技综合楼1号楼举行。会议审议并通过了《学校工作报告》《工会工作报告》，讨论并通过了《扬州市职业大学章程（修订稿）》《扬州市职业大学2022年财务决算》《扬州市职业大学2023年财务预算（草案）》。党委书记马顺圣出席并讲话，党委副书记、校长林刚作学校工作报告并主持第二次全体会议，校领导许金如、陈亚鸿分别主持第一次全体会议和主席团会议，学校工会主席陈建军作工会工作报告。132名正式代表出席会议，不是代表的部门、学院主要负责人，市政协委员，学校民主党派主要负责人列席了会议。');
INSERT INTO `news` VALUES (3, 0, '扬州市职业大学艺术学院学生外出接送服务中标公告', 1, NULL, '2023-04-25 16:05:20', 71, '扬州市职业大学艺术学院学生外出接送服务，按规定程序进行了评审，现就本次招标的结果公布如下：\r\n\r\n一、招标项目名称\r\n\r\n扬州市职业大学艺术学院学生外出接送服务。\r\n\r\n二、招标项目简要说明：\r\n\r\n扬州市职业大学艺术学院学生外出接送服务。\r\n\r\n三、招标公告媒体及日期：\r\n\r\n2023年4月17日公布于扬州市职业大学官网。\r\n\r\n四、评标信息：\r\n\r\n评标日期：2023年4月24日\r\n\r\n评标地点：扬州市职业大学行政楼101会议室\r\n\r\n评标委员会成员名单：朱军、王格、冯晋\r\n\r\n五、中标信息：\r\n\r\n中标单位：江苏省扬州汽车运输集团有限责任公司\r\n\r\n中标金额：55000元\r\n\r\n六、本次招标联系事项：\r\n\r\n 国资处联系人：孔老师87697823\r\n\r\n 地址：扬州市文昌西路458号           邮政编码：225009\r\n\r\n本中标结果公告期限为1个工作日。各有关当事人对中标结果有异议的，可以在公告期限届满之日起三个工作日内，以书面形式向扬州市职业大学国资处提出质疑，逾期将不再受理。', '扬州市职业大学艺术学院学生外出接送服务，按规定程序进行了评审。');
INSERT INTO `news` VALUES (4, 0, '扬州市职业大学老同志一日游服务中标公告', 1, NULL, '2023-04-24 16:07:57', 144, '扬州市职业大学老同志一日游服务，按规定程序进行了评审，现就本次招标的结果公布如下：\r\n\r\n一、招标项目名称\r\n\r\n扬州市职业大学老同志一日游服务。\r\n\r\n二、招标项目简要说明：\r\n\r\n扬州市职业大学老同志一日游服务。\r\n\r\n三、招标公告媒体及日期：\r\n\r\n2023年4月14日公布于扬州市职业大学官网。\r\n\r\n四、评标信息：\r\n\r\n评标日期：2023年4月24日\r\n\r\n评标地点：扬州市职业大学行政楼101会议室\r\n\r\n评标委员会成员名单：王旭方、王格、冯晋\r\n\r\n五、中标信息：\r\n\r\n中标单位：扬州市旅游集散中心有限公司\r\n\r\n六、本次招标联系事项：\r\n\r\n 国资处联系人：孔老师87697823\r\n\r\n 地址：扬州市文昌西路458号           邮政编码：225009\r\n\r\n本中标结果公告期限为1个工作日。各有关当事人对中标结果有异议的，可以在公告期限届满之日起三个工作日内，以书面形式向扬州市职业大学国资处提出质疑，逾期将不再受理。', '扬州市职业大学老同志一日游服务，按规定程序进行了评审。');
INSERT INTO `news` VALUES (5, 0, '扬州市职业大学科技综合楼规划竣工测绘项目中标公告', 1, NULL, '2023-04-10 16:09:29', 383, '扬州市职业大学科技综合楼规划竣工测绘项目，按规定程序进行了评审，现就本次招标的结果公布如下：\r\n\r\n一、招标项目名称\r\n\r\n扬州市职业大学科技综合楼规划竣工测绘项目。\r\n\r\n二、招标项目简要说明：\r\n\r\n扬州市职业大学科技综合楼规划竣工测绘项目，预算价为65700元。\r\n\r\n三、招标公告媒体及日期：\r\n\r\n2023年3月31日公布于扬州市职业大学官网。\r\n\r\n四、评标信息：\r\n\r\n评标日期：2023年4月10日\r\n\r\n评标地点：扬州市职业大学行政楼101会议室\r\n\r\n评标委员会成员名单：邵红才、姚荣、钟爱军\r\n\r\n五、中标信息：\r\n\r\n中标单位：扬州市邗江勘测规划技术中心\r\n\r\n中标金额：60575元\r\n\r\n六、本次招标联系事项：\r\n\r\n 国资处联系人：孔老师87697823\r\n\r\n 地址：扬州市文昌西路458号           邮政编码：225009\r\n\r\n本中标结果公告期限为1个工作日。各有关当事人对中标结果有异议的，可以在公告期限届满之日起三个工作日内，以书面形式向扬州市职业大学国资处提出质疑，逾期将不再受理。', '扬州市职业大学科技综合楼规划竣工测绘项目，按规定程序进行了评审。');
INSERT INTO `news` VALUES (6, 0, '我校位居校友会2023中国高职院校排名第37位 跻身中国一流高职院校', 1, NULL, '2023-04-13 16:12:25', 421, '近日，全国第三方大学评价机构艾瑞深校友会网（Cuaa.Net）正式发布《校友会（第21届）2023中国大学排名》。我校在校友会2023中国高职院校排名（Ⅱ类）位列全国第37位，比去年前进1位，成功跻身中国一流高职院校行列。艾瑞深研究院是得到社会各界认可的、有良好公信力的第三方大学评价研究机构。自2003年起，艾瑞深校友会网每年发布中国大学排名，相关成果被中央电视台（CCTV）、人民日报、中国教育报、中国青年报、人民网、新华网等上百家国内外权威主流新闻媒体转载、报道和引用。近年来，我校始终以立德树人为根本任务，聚焦学生全面发展，深入开展产教融合、校企合作，不断加强师资队伍建设，努力打造更高水平的教学科研服务平台，扎实推进省高水平高职学校建设，在人才培养、科学研究和社会服务等方面取得了显著成绩，形成了鲜明办学特色，社会贡献力明显增强，得到地方、行业的认可以及就业单位、广大校友、学生家长等社会各界的普遍好评。', '近日，全国第三方大学评价机构艾瑞深校友会网（Cuaa.Net）正式发布《校友会（第21届）2023中国大学排名》。');
INSERT INTO `news` VALUES (7, 0, '喜报！这项工作我校名列全省高职院校前茅', 1, NULL, '2023-04-24 16:13:59', 233, '近日，江苏省科技资源统筹服务中心、江苏省技术产权交易市场公布了2022年度全省技术交易情况，我校2022年度在政务网登记的技术服务实际到账额1969.13万元，名列全省高职院校第一；技术交易额3699.80万元，位列全省高职院校第三；技术合同成交额为3923.15万元，位列全省高职院校第五。近年来，在上级部门的关心和学校领导的高度重视下，全校上下认真贯彻落实省政府《关于加快推进全省技术转移体系建设的实施意见》，高质量持续推进科技成果转化工作。2022年度我校横向项目共计409项，服务于全国的9个省、市、自治区，包括江苏、安徽、上海、吉林、辽宁、广东、北京、新疆、浙江。其中服务江苏省项目共391项，合同数量占比95.60%，金额3778.14万元，占比96.30%。服务于扬州市的项目351项，项目数占比为85.8%，合同金额3488.31万元，占比为88.91%。下一步我校将积极服务区域经济与社会发展，把科研论文写在“好地方”扬州、写在“强富美高”新江苏的大地上，继续用科研创新、科技服务为扬州市产业科创名城建设再立新功。', '近日，江苏省科技资源统筹服务中心、江苏省技术产权交易市场公布了2022年度全省技术交易情况。');
INSERT INTO `news` VALUES (8, 0, '团北京市委来我校调研共青团服务青年创新创业工作', 1, NULL, '2023-04-12 16:15:11', 313, '4月11日上午，团北京市委二级巡视员、大学中专工作部部长刘炳全、团北京市委大学中专工作部副部长曲斌、团北京市委大学中专工作部四级调研员官美玲、团北京市委就业工作专班干部寇蕴、刘衡升及北京各高职院校代表一行来到我校，围绕共青团服务青年创新创业工作开展调研，团市委副书记赵文婕、团市委学少部副部长姜彤陪同调研。学校党委书记马顺圣，党委副书记、副校长许金如热情接待了调研组。校团委、机械工程学院、艺术学院、纺织服装学院、园林园艺学院、医学院、旅游学院、师范学院等相关人员参与活动并与调研组进行了深入交流。刘炳全一行参观了我校智能制造先进技术示范中心、青年学习社、匠才培育工作坊、漆艺工作室、玉雕工作室、扬州剪纸大师工作室、艺术学院展厅等，体验了“团团公益课堂”的实践内容，听取了我校关于青年大学生创新创业工作方面的创新做法、队伍建设以及服务成效，了解了我校青年学生在“挑战杯”“互联网+”等科技创新工作中的具体做法及取得的成绩。调研组还走进匠才培育工作坊与大师工作室，了解学生创新创业团队情况及服务社会的事迹。刘炳全与各学院领导、实验室工作人员及青年学子等进行了深入的交流。他对我校双创工作给予了充分肯定，鼓励同学们要充分发挥各自专业优势，在学好专业知识的基础上积极参与社会服务，毕业后创造更多的就业岗位。刘炳全建议学校团委也要充分发挥学校专业门类齐全的优势，开展内容丰富、形式多样的各类活动，为同学们搭建良好的创新创业平台、提升同学们的科创意识与科创能力，助力学校的高质量发展，为把扬州建设成为古代文化与现代文明交相辉映的名城贡献青春力量。', '4月11日上午，团北京市委二级巡视员、大学中专工作部部长刘炳全、团北京市委大学中专工作部副部长曲斌、团北京市委大学中专工作部四级调研员官美玲、团北京市委就业工作专班干部寇蕴、刘衡升及北京各高职院校代表一行来到我校，围绕共青团服务青年创新创业工作开展调研。');
INSERT INTO `news` VALUES (9, 0, '学校召开审计委员会第一次会议', 1, NULL, '2023-04-11 16:16:23', 210, '近日，扬州市职业大学审计委员会召开第一次全体会议。党委书记、审计委员会主任马顺圣出席并主持会议，党委副书记、校长、审计委员会主任林刚出席会议并讲话。党委副书记、副校长、审计委员会副主任许金如，副校长、审计委员会副主任陈亚鸿，纪委书记、审计委员会副主任黄华明以及审计委员会成员参加了会议。马顺圣以“努力提高审计监督水平，奋力开创学校审计监督工作新局面”为主题，强调要切实贯彻执行江苏省、扬州市审计委员会会议精神，真抓实干，常抓不懈，努力提高审计监督水平，奋力开创学校审计监督工作新局面。他提出四点要求：一要提高政治站位，切实把党的领导贯穿审计工作全过程。坚持以习近平新时代中国特色社会主义思想为指导，以贯彻党的二十大精神为工作主线，做到党的工作重点在哪里，审计监督就聚焦哪里。二要聚焦主责主业，以高质量审计护航学校事业高质量发展。提高认识、提升水平、强化落实，坚持问题导向、目标导向、结果导向，努力拓展审计监督职能，做到应审尽审、凡审必严、严肃问责。三要突出贯通协同，不断提升审计工作能力水平。健全完善审计与其他监督贯通协同的制度体系，推动各类监督在深化审计成果运用上相向而行、同向发力。四要强化自身建设，打造专业审计队伍。审计工作人员要增强责任意识、加强学习、不断提高业务能力和综合素质，努力建设“政治过硬、本领高强”的高素质专业化审计队伍。林刚总结了近5年学校内部审计重点工作，部署2023年度学校审计重点工作。他提出三点要求：一要着眼全局明确定位，不断强化新时代内审工作的职责感和使命感；二要认真谋划审计项目，做细做实做好审计业务，突出内部审计监督工作重点；三要建立审计与内控建设的良性循环，建立健全长效机制，加强审计整改落实，做实审计监督后半篇文章。会上，审议通过了《扬州市职业大学审计委员会工作规则（试行）》《扬州市职业大学审计委员会办公室工作细则（试行）》。', '近日，扬州市职业大学审计委员会召开第一次全体会议。');
INSERT INTO `news` VALUES (10, 0, '学校获批4项教育部第二期供需对接就业育人项目', 1, NULL, '2023-04-11 16:17:25', 269, '为贯彻落实党中央、国务院“稳就业”“保就业”决策部署，深化产教融合校企合作，推动人才培养与就业有机联动、人才供需有效对接，教育部高校学生司组织有关用人单位和高校实施供需对接就业育人项目。4月6日，教育部高校学生司第二期供需对接就业育人项目立项名单公布，我校4个项目通过审批获准立项。经用人单位审核、专家评审、立项单位信息复核等多个环节批准，学校与常州市润源农业生态园、天嘉智能装备制造江苏股份有限公司、中兴软件技术（济南）有限公司、扬州东园有限公司4家用人单位达成定向人才培养、就业实习等合作项目。其中就业实习基地项目3个，定向人才培养培训项目1个。经用人单位审核、专家评审、立项单位信息复核等多个环节批准，学校与常州市润源农业生态园、天嘉智能装备制造江苏股份有限公司、中兴软件技术（济南）有限公司、扬州东园有限公司4家用人单位达成定向人才培养、就业实习等合作项目。其中就业实习基地项目3个，定向人才培养培训项目1个。下一步，我校将以就业育人项目为契机，进一步强化就业育人实效，加强与立项用人单位的对接，开展各种就业推进和服务工作，深入推进“书记校长访企拓岗促就业”专项行动，不断拓宽就业渠道，努力为学生搭建更为广阔的实习就业平台，为项目实施提供环境和条件支持，确保项目顺利实施，推动学生就业与培养的有机联动、人才供需的有效对接，促进毕业生更充分更高质量就业。', '为贯彻落实党中央、国务院“稳就业”“保就业”决策部署，深化产教融合校企合作，推动人才培养与就业有机联动、人才供需有效对接，教育部高校学生司组织有关用人单位和高校实施供需对接就业育人项目。');
INSERT INTO `news` VALUES (11, 0, '学校2023年田径运动会开幕', 1, NULL, '2023-04-21 16:19:13', 330, '4月20日上午，扬州市职业大学田径运动会开幕式在田径场举行。学校党委书记马顺圣致辞，宣布扬州市职业大学2023年田径运动会正式开幕。副校长陈亚鸿、刘宏，纪委书记黄华明，相关学院、部门负责人及运动员代表参加了开幕式。开幕式由党委副书记、副校长许金如主持。马顺圣指出，习近平总书记高度重视体育事业，始终站在战略全局高度谋划部署体育事业发展，强调加快建设体育强国。党的二十大报告明确指出，“广泛开展全民健身活动，加强青少年体育工作，促进群众体育和竞技体育全面发展，加快建设体育强国”，这为新发展阶段体育工作指明了前进方向，提供了根本遵循。长期以来，我校始终坚持把体育作为实现立德树人根本任务、提升学生综合素质的基础性工程。举办一年一度的校运会就是其中的重要举措，这不仅是对全校体育运动水平的一次检阅，也是为广大师生积极参与全民体育健身活动提供一个舞台，从而达到强身健体、舒张身心、陶怡情操、锻炼意志的效果。希望我们的校园形成一种人人参与、个个争先、生龙活虎、生机勃勃的体育运动氛围；希望全体运动员本着“重在参与”的奥林匹克精神，争取更快、更高、更强，努力赛出风格、赛出水平，争取运动成绩和精神文明的“双丰收”。上午9点，伴随着激昂的《运动员进行曲》，国旗护卫队、校旗护卫队、彩球队、彩旗队以及由各学院和裁判员组成的代表队方阵依次入场。各学院以队列方阵形式展示了拼搏向上、爱国爱校的精神风貌及对运动会的美好期待。体育学院体管2203班陈冰、人文学院新闻2102班朱子豪分别代表裁判员、运动员庄严宣誓。开幕式文艺表演由健美操、跆拳道、健身健美、艺术体操、武术和舞狮组成。开幕式结束后，运动会各项比赛正式开始。此次运动会共计29支参赛队近2000名师生运动员参赛，在田径项目中展开激烈角逐。此次运动会将成为展示学校师生风采、促进交流合作、振奋精神、凝聚力量、增强凝聚力的一次盛会，全体运动员将秉承“更高、更快、更强”的奥林匹克精神，发扬“友谊第一，比赛第二”的体育风尚，在赛场上奋力拼搏。', '4月20日上午，扬州市职业大学田径运动会开幕式在田径场举行。学校党委书记马顺圣致辞，宣布扬州市职业大学2023年田径运动会正式开幕。副校长陈亚鸿、刘宏，纪委书记黄华明，相关学院、部门负责人及运动员代表参加了开幕式。开幕式由党委副书记、副校长许金如主持。');
INSERT INTO `news` VALUES (12, 0, '我校与晶澳科技举行校企合作签约仪式', 1, NULL, '2023-04-22 16:21:22', 426, '为深化产教融合，创新人才培养模式，共建新型现代产业学院，4月20日，我校党委副书记、校长林刚受邀出席晶澳太阳能科技股份有限公司在河北宁晋举行的“凝聚阳光 点亮未来”校企协同发展合作大会。会上，林刚代表学校作以“双链对接 互惠共赢 聚力谱写产教融合校企合作新篇章”为主题的交流发言。他指出，学校长期以来一直积极推进产教融合、科教融汇，与晶澳开展了深度合作，希望双方能够以本次签约为契机，继续深化产教融合，加大合作力度，共同打造校企命运共同体。在领导和嘉宾们的见证下，林刚与晶澳科技高级副总裁孙广彬分别代表学校、企业共同签署了共建“智能光电与智造”产业学院协议。双方表示，建设好特色产业学院对于扎实推进产教融合、创新校企合作模式、深化合作内涵具有重大深远的意义。产业学院成立后，校企双方将充分发挥各自优势，构建校企合作人才培养的长效机制，发挥校企双主体育人的协同优势，打造“招生、培养、师资、资源、育人”五位一体、全程全面共育的培养模式，在人才培训、协同创新、技术成果交流等方面加强共享共通，为区域经济、社会和产业发展培养更多高素质技能人才，为现代光伏产业转型升级和国家新能源发展战略贡献更大的力量。发展规划处、电子工程学院有关负责人参加大会。', '为深化产教融合，创新人才培养模式，共建新型现代产业学院，4月20日，我校党委副书记、校长林刚受邀出席晶澳太阳能科技股份有限公司在河北宁晋举行的“凝聚阳光 点亮未来”校企协同发展合作大会。');
INSERT INTO `news` VALUES (13, 0, '我校在2023年省职业院校技能大赛中喜获佳绩', 1, NULL, '2023-03-28 16:23:14', 677, '近日，由江苏省教育厅、江苏省发展和改革委员会等单位主办的2023年江苏省职业院校技能大赛落下帷幕。我校代表团由领队、指导教师、参赛选手计180人组成，参加了农林牧渔、医药卫生、土木建筑、教育与体育、文化艺术、旅游、生物与化工、电子信息、装备制造、财经商贸、资源环境与安全、轻工纺织、公共管理与服务等13个专业大类30个项目的角逐，最终获得一等奖3项，二等奖7项，三等奖19项的成绩。电气与汽车工程学院姜伟荣获嵌入式技术与应用开发赛项教师组一等奖；土木工程学院郑娟、王鹏老师指导的李秋昱、马沿沿、许一凡三位同学荣获建筑工程识图赛项一等奖；旅游学院刘水琴老师指导的杨瑜洁同学荣获导游服务赛项一等奖。备赛期间，教务处、后勤处、设备处等多部门协同，积极推进备赛、参赛工作，为大赛做好服务与保障工作。各学院周密制订技能大赛训练方案，解决备赛工作中实际问题。指导教师们精诚合作、不计得失、全力以赴，全校上下营造出积极奋进的备赛氛围。临近赛前，学校专门组织召开赛前动员大会，我校党委副书记、校长林刚到会发表热情洋溢的讲话，凝聚力量，鼓舞士气，充分体现了学校领导对学生技能大赛工作的高度重视。赛场上，参赛选手不畏强手、沉着冷静，拼技能、比速度、展风采，展示出高尚的职业道德、向上的精神风貌和良好的职业技能，充分体现了精益求精、追求卓越的工匠精神，全面展现了学校技能人才培养水平。', '近日，由江苏省教育厅、江苏省发展和改革委员会等单位主办的2023年江苏省职业院校技能大赛落下帷幕。');
INSERT INTO `news` VALUES (14, 0, '学校新聘实践性教学专家 助力实践教学提质发展', 1, NULL, '2023-04-10 16:24:22', 289, '学校新聘实践性教学专家 助力实践教学提质发展。结束交流活动后，林刚为魏民、赵林、宁伟东三位专家颁发了聘书，聘请为学校实践性教学专家（顾问），今后三位专家将对我校实践性教学设计的科学性、先进性以及实验室建设的可行性进行指导把关，为推动实践教学提质发展提供助力。据悉开学以来，设备处对标学校高质量发展要求，以服务学校高邮校区实验室建设及拟升级专业实验室建设为切入点和着力点，务实笃行，先后组织了医学院、电子工程学院、机械工程学院、园林园艺学院等8个学院及教务处代表一行23人参加2023年南京国际教育装备及科教技术展览会；组织天津天堰科技有限公司、上海信品工程科技有限公司等六家具有实验室设计、实验室工程总包、实验室装备设备供应能力的公司进校，为涉及高邮校区建设的各学院提供深化设计服务；组织机械、电汽学院调研兄弟院校智能制造中心建设等活动。今后设备处将继续担负起主体责任，充分履职尽责，以实际行动加强对学校设备建设的统筹和管理，服务大局，实现部门工作新发展、新突破。', '学校新聘实践性教学专家 助力实践教学提质发展。');
INSERT INTO `news` VALUES (15, 1, '校领导到校关工委、现教中心调研指导工作', 1, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/%E7%83%AD%E9%97%A8%E6%96%B0%E9%97%BB3.jpg', '2023-04-25 17:43:46', 379, '3月14日，党委副书记、校长林刚前往学校关工委、现教中心调研指导工作。在学校关工委，林刚强调关心下一代工作是十分重要的，要积极支持和鼓励，并就今后学校关工委工作提出四点要求：一要加强服务青年学生的工作，开展学生心理健康教育，组织高质量学术讲座报告，丰富学生的校园生活；二要加强服务青年教师的工作，关注青年教师的职业生涯规划，以老带新促进青年教师的成长；三要在优质化建设均衡发展的过程中进一步提高、优化工作水平和工作质量；四要围绕学校“双高”建设，积极发挥关工委的作用，在服务和关心下一代成长的过程中多提宝贵意见。校关工委主任张网女介绍了近年来我校关工委围绕常态化建设和优质化建设开展的各项创新性工作，以及聚焦铸魂育人，打造彰显扬职大特点、富有关工委特色的工作品牌情况。会后，校关工委与会人员结合目前工作 情况进行了交流与讨论，并就2023年重点工作任务进行了完善。在现教中心，林刚深入数据中心，详细查看了学校电控、监控、出入管理、云桌面等业务系统运行质态和实时数据监控情况。林刚肯定了现教中心2022年取得的成绩，并对今后的工作提出了四点要求：一要加强顶层设计，提高智慧校园建设水平，不断优化、提升建设方案，加快推进集成化，开发便捷化的应用系统；二要创新工作机制，进一步提高信息化工作效率，建立归口管理机制、部门联动机制、项目管理机制、对外合作机制；三要重视安全稳定，守牢网络安全底线；四要强化服务意识，提高教学、科研信息化服务保障水平，以师生为中心，提升师生体验感、获得感。现教中心主任赵龙祥对部门基本运行情况、智慧校园建设工作及今年的重点工作计划、高邮湖校区信息化建设做了汇报。', '3月14日，党委副书记、校长林刚前往学校关工委、现教中心调研指导工作。');
INSERT INTO `news` VALUES (16, 0, '扬州市社会科学馆建成开馆', 2, NULL, '2023-04-18 16:29:13', 746, '3月17日下午，扬州市社会科学馆开馆仪式在我校科技综合楼三号楼举行，扬州市社会科学馆如期建成并面向社会开放。市委常委、宣传部部长张长金，校党委书记马顺圣出席活动并为新落成的扬州市社会科学馆揭牌。市社科联党组书记、主席晏明主持活动。开馆仪式后，张长金一行对社科馆进行了调研，参观了展览大厅、交流中心和社科精品陈列室，听取了展览内容介绍和布展情况汇报。张长金指出，建设一座生动反映扬州哲学社会科学繁荣发展的现代化场馆是全市社科界长久以来的共同愿望。2022年初，市委、市政府提出建设扬州市社科馆的任务要求。历时一年，在市社科联和扬州职业大学的通力协作下，社科馆如期建成开放，可喜可贺。张长金指出，扬州市社科馆以哲学社会科学为窗口，集宣传展示、教育普及、交流研讨、学术研究等功能为一体，传承历史、面向未来，很好地展示了扬州哲学社会科学发展的历史和成就，是“好地方”扬州建设的一张崭新名片。张长金要求，在接下来的工作中，市社科联与扬州职业大学要继续通力协作，以助力扬州经济社会高质量发展为宗旨，以推动全市哲学社会科学繁荣发展为使命，按照“全省首家、做好表率”的要求，创新制度机制，创新思路举措，把社科馆使用好、管理好、运行好、维护好，充分发挥其各项功能，着力提升其使用效能，为新时代新征程全面推进中国式现代化扬州新实践做出新贡献。马顺圣表示，认真贯彻落实好市委部署要求，全力协助建设好社科馆，是扬州职业大学义不容辞的责任，感谢市委宣传部和市社科联的信任，下一步扬州职业大学将一如既往地支持社科馆开展工作，按照高标准高要求，把“好地方”扬州这一新名片建设维护好、管理运营好、宣传展示好。晏明代表市社科联致欢迎词，向关心支持扬州市社科馆建设和扬州社科事业发展的各级领导和建设工作者表示感谢。市纪委监委第六派驻纪检监察组组长张曹，市社科联副主席张锡文、李镇风，兼职副主席高阜、李存灵，校领导许金如、刘宏及相关部门负责同志，市社科界代表和学校师生代表参加活动。', '3月17日下午，扬州市社会科学馆开馆仪式在我校科技综合楼三号楼举行，扬州市社会科学馆如期建成并面向社会开放。');
INSERT INTO `news` VALUES (17, 1, '志愿服务再出发！我校举行2023年志愿行动发布会', 2, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/%E7%83%AD%E9%97%A8%E6%96%B0%E9%97%BB4.jpg', '2023-03-03 16:31:23', 543, '3月1日，在毛泽东等老一辈革命家为雷锋同志题词60周年之际，我校举行了2023年志愿行动发布会暨“团团公益课堂”启动仪式。本次活动由扬州市文明办、共青团扬州市委、扬州市职业大学主办，共青团扬州市职业大学委员会承办。扬州市委宣传部副部长、市文明办主任吴军，我校党委书记马顺圣，共青团扬州市委兼职副书记李祥祥等领导参加活动。整场活动分为启动仪式、课程展示和新时代雷锋故事分享会三个阶段，共有12个项目团队通过现场演示、视频播放和课程试讲的形式将极具专业特色的公益课程展示在来宾面前。在医学院“守护健康路 科普践‘医’心”项目展区，学生志愿者演示了急救的方法，普及了中医的养生理论，还展示了中药包的制作流程。在体验环节，来宾们可以亲身感受到中西医不同理疗方式的差异。机械工程学院的师生把生产设备搬到了广场，他们带来的是“神奇的3D打印”。这是一种现代工业中采用的快速成型技术，广泛使用在模具制造、工业设计等领域。不管多么复杂的造型，只要建立了对应的三维数字模型，3D打印机都能准确的制作出来。“这种在《流浪地球2》电影里出现过的技术就在我们身边，没想到科幻真就照进现实啦！”参观的同学们看着打印出来的小机器人发出了由衷的赞叹。“老年人还是应该开展一些适度的、相对温和的运动。八段锦就是比较适合的一种锻炼形式。”龙头关社区党总支副书记张庆介绍，广陵区龙头关社区与我校体育学院签订了共建协议书，将开展系列结对共建活动。今年“团团公益课堂”联手“新闻女生春季助学行动”大手牵小手，将科学人文知识普及到小学，助力留守儿童快乐成长。室外展示精彩纷呈，映月报告厅内故事分享笑声阵阵。“实践证明，无论时代如何变迁，雷锋精神永不过时。”中国石化江苏油田分公司工程技术服务中心高级技师田明老师带来了《新时代雷锋故事分享会》，讲述了自己如何从一名普通技校生成长为全国岗位学雷锋标兵、全国劳模、全国最美职工的成长经历，他在讲座上引用一个个鲜活的事例告诉同学们，无论时代如何变迁，雷锋精神永不过时的道理。我校“团团公益课堂”活动开展已经是第三个年头，主要面向广大青少年、老年人开展了具有特色的志愿服务活动。经过不断积累，“团团公益课堂”的内容和形式更加充实与新颖。公益课程走出大学校园走进扬州的大街小巷，取得了良好的社会效果。“今年三月三日的爱耳日，我们医学院的志愿者团队将走进小学课堂；同时，我们还有机械学院的‘晓轩’先锋队，会把3D打印技术展示给留守儿童，让他们体验科技的发展。”我校团委书记王淼介绍，学生志愿服务团队走出校门、走入社会、走近群众，让同学们在实践中接受德育熏陶与劳动教育。发布会现场还展示了学校志愿服务品牌项目成果，发布了2023年度“团团公益课堂”立项名单，参会领导与嘉宾为园林园艺学院等6个学院的“青年学习社”授牌。艺术学院、电气与汽车工程学院、管理学院还分别与邗江区方家巷社区、邗江区绿杨社区、李典镇团委等签订共建社会实践基地协议。', '3月1日，在毛泽东等老一辈革命家为雷锋同志题词60周年之际，我校举行了2023年志愿行动发布会暨“团团公益课堂”启动仪式。');
INSERT INTO `news` VALUES (18, 1, '校关工委召开2023年度工作会议', 1, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/%E7%83%AD%E9%97%A8%E6%96%B0%E9%97%BB5.jpg', '2023-04-25 16:34:38', 400, '3月21日上午，校关工委召开2023年度工作会议。校党委书记、关工委主任马顺圣出席会议并讲话，校关工委主任张网女，各学院党总支书记和关工委副主任等30余人参加会议。会议由校关工委秘书长褚结主持。马顺圣在会上提出要求：一要提高站位，重视关工委工作，加强做好关心下一代工作的使命感和责任感；二要关爱学生，支持关工委工作，用心用情推动学校关心下一代工作优质化发展；三要脚踏实地，扎实开展关工委工作，进一步创造学生成长成才的良好环境；四要加强自身建设，推进关工委优质化建设，为做好关工委工作打牢基础。马顺圣强调，关工委工作要坚持全面贯彻落实党的二十大精神，认真落实省教育系统关工委工作会议和市委对关工委工作的相关部署要求，推动新时代关工委工作提质增效，努力开创新时代关工委工作高质量发展新局面。张网女对学校关工委2022年的工作做了总结，并对2023年工作进行了部署。她提出关工委工作要提高政治站位、把握工作方向，坚持“党建带关键”，将学习宣传贯彻党的二十大精神同深入贯彻习近平总书记对关心下一代工作的重要指示精神结合起来，积极开展“五爱”、党的二十大精神学习教育，做好贫困学生的帮扶工作，开展爱心志愿服务，进一步加强优质化建设，逐项对照、逐条落实，巩固提升校关工委工作水平。会上，褚结宣读了学校《关于公布2022年度学校关工委优质化建设均衡发展考核结果的通知》《关于公布2022年度学校关工委“精品教育项目”案例评选结果的通知》。', '3月21日上午，校关工委召开2023年度工作会议。校党委书记、关工委主任马顺圣出席会议并讲话，校关工委主任张网女，各学院党总支书记和关工委副主任等30余人参加会议。会议由校关工委秘书长褚结主持。');

-- ----------------------------
-- Table structure for progress
-- ----------------------------
DROP TABLE IF EXISTS `progress`;
CREATE TABLE `progress`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Video_Id` int NULL DEFAULT NULL COMMENT '视频Id',
  `User_Id` int NULL DEFAULT NULL COMMENT '用户',
  `Site` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '位置',
  `Time` datetime NULL DEFAULT NULL COMMENT '记录位置的时间',
  `Is_Finish` int NULL DEFAULT NULL COMMENT '是否完成',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '视频进度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of progress
-- ----------------------------

-- ----------------------------
-- Table structure for school
-- ----------------------------
DROP TABLE IF EXISTS `school`;
CREATE TABLE `school`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `School_Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `Remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '简介',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `School_Name`(`School_Name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学校表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of school
-- ----------------------------

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `User_Id` int NULL DEFAULT NULL COMMENT '用户',
  `Time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '加入时间',
  `Score` decimal(4, 1) NULL DEFAULT 100.0 COMMENT '积分',
  `status` int NULL DEFAULT 0 COMMENT '每日是否签到 0为未签 ，1为已签',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '积分表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES (1, 3, '2023-04-26 02:01:28', 201.5, 1);
INSERT INTO `score` VALUES (2, 2, '2023-04-24 19:57:36', 105.0, 0);
INSERT INTO `score` VALUES (3, 4, '2023-04-26 01:57:55', 103.0, 1);
INSERT INTO `score` VALUES (4, 5, '2023-04-24 20:20:19', 180.0, 0);
INSERT INTO `score` VALUES (5, 8, '2023-04-26 11:46:36', 100.5, 1);
INSERT INTO `score` VALUES (7, 10, '2023-04-25 22:29:57', 101.0, 0);
INSERT INTO `score` VALUES (8, 12, '2023-04-26 02:28:02', 100.5, 1);
INSERT INTO `score` VALUES (9, 13, '2023-04-26 08:14:37', 100.5, 1);

-- ----------------------------
-- Table structure for sysfunction
-- ----------------------------
DROP TABLE IF EXISTS `sysfunction`;
CREATE TABLE `sysfunction`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Parent_Id` int NOT NULL COMMENT '父节点(根节点的父节点为0）',
  `Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '功能名称',
  `Is_Leaf` bit(1) NOT NULL COMMENT '是否叶节点',
  `Node_Order` int NOT NULL COMMENT '节点序号（显示顺序）',
  `Is_Show` bit(1) NULL DEFAULT b'1' COMMENT '是否要显示',
  `Url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '对应连接地址',
  `Remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `role_id` int NULL DEFAULT 1 COMMENT '角色id',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统功能表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sysfunction
-- ----------------------------

-- ----------------------------
-- Table structure for syspower
-- ----------------------------
DROP TABLE IF EXISTS `syspower`;
CREATE TABLE `syspower`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Role_Id` int NOT NULL COMMENT '用户Id',
  `Function_Id` int NOT NULL COMMENT '功能Id',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户权限对照表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of syspower
-- ----------------------------

-- ----------------------------
-- Table structure for sysrole
-- ----------------------------
DROP TABLE IF EXISTS `sysrole`;
CREATE TABLE `sysrole`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Role_Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `Role_Name`(`Role_Name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sysrole
-- ----------------------------
INSERT INTO `sysrole` VALUES (1, '普通教师');
INSERT INTO `sysrole` VALUES (2, '超级管理员');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `T_Name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名 （管理端登录名）',
  `School` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单位：学校',
  `Xue_Yuan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学院',
  `Zhi_Cheng` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职称',
  `Birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `Good_At` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '擅长',
  `Img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png' COMMENT '图片',
  `Remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '简介',
  `role_id` int NULL DEFAULT 1 COMMENT '用户角色1为普通教师 2为超级管理员',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户密码',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '教师表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (1, 'isla', '扬州职业大学', '信息工程学院', NULL, NULL, NULL, 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', NULL, 2, NULL);
INSERT INTO `teacher` VALUES (2, '姚楚生', '扬州职业大学', '信息工程学院', NULL, NULL, NULL, 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', '我是小丑', 1, NULL);

-- ----------------------------
-- Table structure for tree
-- ----------------------------
DROP TABLE IF EXISTS `tree`;
CREATE TABLE `tree`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `parent_id` int NULL DEFAULT NULL,
  `level` int NULL DEFAULT NULL,
  `introduce` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tree_show` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tree
-- ----------------------------
INSERT INTO `tree` VALUES (1, '第一章  智慧医疗简史', NULL, 1, '', 0);
INSERT INTO `tree` VALUES (2, '第二章  医工结合的5大关系', NULL, 1, NULL, 0);
INSERT INTO `tree` VALUES (3, '第三章  人工智能探秘', NULL, 1, NULL, 0);
INSERT INTO `tree` VALUES (4, '第四章  医疗场景与AI应用', NULL, 1, NULL, 0);
INSERT INTO `tree` VALUES (5, '第五章  临床场景驱动的医工结合', NULL, 1, NULL, 0);
INSERT INTO `tree` VALUES (6, '第六章  智慧养老', NULL, 1, NULL, 0);
INSERT INTO `tree` VALUES (7, '第七章  医疗机器人', NULL, 1, NULL, 0);
INSERT INTO `tree` VALUES (8, '第八章  医疗大数据', NULL, 1, NULL, 0);
INSERT INTO `tree` VALUES (9, '第九章  临床决策支持系统', NULL, 1, NULL, 0);
INSERT INTO `tree` VALUES (10, '第十章  医疗影像与AI', NULL, 1, NULL, 0);
INSERT INTO `tree` VALUES (11, '期末考试', NULL, 1, NULL, 0);
INSERT INTO `tree` VALUES (12, '1.1  19世纪：数理统计与霍乱传染途径', 1, 2, NULL, 0);
INSERT INTO `tree` VALUES (13, '1.2  20世纪70年代： MYCIN专家系统与细菌感染疾病', 1, 2, NULL, 0);
INSERT INTO `tree` VALUES (14, '1.3  20世纪80年代：贝叶斯网络与内科诊断', 1, 2, NULL, 0);
INSERT INTO `tree` VALUES (15, '1.4  20世纪90年代：神经网络应用于医学', 1, 2, NULL, 0);
INSERT INTO `tree` VALUES (16, '1.5  20世纪90年代后：中国智慧医疗产业进入快速发展阶段', 1, 2, NULL, 0);
INSERT INTO `tree` VALUES (17, '1.6  19世纪：数理统计与霍乱传染途径', 1, 2, NULL, 0);
INSERT INTO `tree` VALUES (18, '2.1  医学与创新', 2, 2, NULL, 0);
INSERT INTO `tree` VALUES (19, '2.2  医学与工程学', 2, 2, NULL, 0);
INSERT INTO `tree` VALUES (20, '2.3  医学与科学研究', 2, 2, NULL, 0);
INSERT INTO `tree` VALUES (21, '2.4  医学与人工智能', 2, 2, NULL, 0);
INSERT INTO `tree` VALUES (22, '2.5  医学与转化', 2, 2, NULL, 0);
INSERT INTO `tree` VALUES (23, '3.1  人工智能的概念和历史', 3, 2, NULL, 0);
INSERT INTO `tree` VALUES (24, '3.2  学科交叉促进人工智能发展', 3, 2, NULL, 0);
INSERT INTO `tree` VALUES (25, '3.3  人工智能推动交叉领域发展', 3, 2, NULL, 0);
INSERT INTO `tree` VALUES (26, '4.1  智慧医疗发展的两种驱动模式', 4, 2, NULL, 0);
INSERT INTO `tree` VALUES (27, '4.2  典型医疗场景与智慧医疗应用', 4, 2, NULL, 0);
INSERT INTO `tree` VALUES (28, '4.3  临床场景驱动的案例', 4, 2, NULL, 0);
INSERT INTO `tree` VALUES (29, '5.1  临床场景驱动医工结合研究的技巧', 5, 2, NULL, 0);
INSERT INTO `tree` VALUES (30, '5.2  颠覆式创新', 5, 2, NULL, 0);
INSERT INTO `tree` VALUES (31, '5.3  用户目标达成理论', 5, 2, NULL, 0);
INSERT INTO `tree` VALUES (32, '6.1  智慧养老的问题背景', 6, 2, NULL, 0);
INSERT INTO `tree` VALUES (33, '6.2  智慧养老的场景分析', 6, 2, NULL, 0);
INSERT INTO `tree` VALUES (34, '6.3  智慧养老的解决方案', 6, 2, NULL, 0);
INSERT INTO `tree` VALUES (35, '7.1  医疗机器人的概念', 7, 2, NULL, 0);
INSERT INTO `tree` VALUES (36, '7.2  医疗机器人的发展历史', 7, 2, NULL, 0);
INSERT INTO `tree` VALUES (37, '7.3  医疗机器人的应用领域', 7, 2, NULL, 0);
INSERT INTO `tree` VALUES (38, '7.4  医疗机器人的技术要点', 7, 2, NULL, 0);
INSERT INTO `tree` VALUES (39, '8.1  医疗大数据的概念与特点', 8, 2, NULL, 0);
INSERT INTO `tree` VALUES (40, '8.2  医疗健康大数据的四种类型', 8, 2, NULL, 0);
INSERT INTO `tree` VALUES (41, '8.3  基于大数据分析的哮喘分型', 8, 2, NULL, 0);
INSERT INTO `tree` VALUES (42, '9.1  临床决策支持系统的概念与架构', 9, 2, NULL, 0);
INSERT INTO `tree` VALUES (43, '9.2  技术案例：Watson Health', 9, 2, NULL, 0);
INSERT INTO `tree` VALUES (44, '9.3  应用案例：药品福利管理系统', 9, 2, NULL, 0);
INSERT INTO `tree` VALUES (45, '10.1  AI医疗影像发展与医疗影像技术', 10, 2, NULL, 0);
INSERT INTO `tree` VALUES (46, '10.2  计算机视觉技术', 10, 2, NULL, 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `salt` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '加密盐值',
  `Id` int NOT NULL AUTO_INCREMENT,
  `Login_Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录名',
  `Role_Id` int NULL DEFAULT NULL COMMENT '用户角色',
  `Password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录密码',
  `Real_Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `Phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `Sex` int NULL DEFAULT NULL COMMENT '性别',
  `xue_Li` int NULL DEFAULT NULL COMMENT '学历',
  `Zhi_Cheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职称',
  `Dan_Wei` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单位',
  `Zheng_Hao` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证',
  `Email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `User_Status` int NULL DEFAULT 1 COMMENT '状态（1正常、0禁用）',
  `Remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '说明',
  `Img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png' COMMENT '图片',
  `Shen_He` int NULL DEFAULT 0 COMMENT '审核（0未审核 1审核通过 2未通过）	',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `Login_Name`(`Login_Name` ASC) USING BTREE,
  UNIQUE INDEX `Phone`(`Phone` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('9589235f4a3d498bba3ca85edb52525a', 2, '姚楚生', NULL, '1a5fe0fddac49e8fbf6e2f493f3e7bfd', NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, 1, NULL, 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', 0);
INSERT INTO `user` VALUES ('a357543b0544438e837f9649651c5079', 3, 'isla', NULL, '7697ae3a51b4386178e3202ead87bdda', '蒋栋', '18106170237', 1, 3, '产品总监', '杨职大', '320281200306047013', '1020321364@qq.com', 1, NULL, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/c839839d774f4ec69d560cc1a93141d7.jpg', 0);
INSERT INTO `user` VALUES ('f7a0f7dd7e1a4a57bcbe45491e15bd81', 4, 'jd', NULL, 'd41f4d28d88fe03d636455d2f9ac77bb', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', 0);
INSERT INTO `user` VALUES ('91be396a03a4438ea2040f1b474736ec', 5, 'wxwhsndwyjd', NULL, '7716b530035c2b19225a05209778d984', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', 0);
INSERT INTO `user` VALUES ('0f8b345cb0be42fb94998c3e2643f876', 8, '小楚生2', NULL, '50171781179fb61a5f311a5450b816dc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', 0);
INSERT INTO `user` VALUES ('b36a6e0e4cb54a8cbf2bda0750dc85f8', 10, '小楚生', NULL, '91286f82a69985db147f0e2faf27a611', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', 0);
INSERT INTO `user` VALUES ('0314e5087af246a6b7e9c8fb76e766b9', 12, '楚生2', NULL, '170e9681fb920a87566eacc5af1ae27d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', 0);
INSERT INTO `user` VALUES ('3d0ae9338d64433da060cc5b73788d2b', 13, '楚生22', NULL, '387692201c5a4a51c1e7623b0e69850c', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', 0);

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video`  (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Link` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '连接地址',
  `Time` datetime NULL DEFAULT NULL COMMENT '上传时间',
  `User_Id` int NULL DEFAULT NULL COMMENT '上传人',
  `Remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '简介',
  `tree_id` int NULL DEFAULT NULL COMMENT '子链id',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '视频表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of video
-- ----------------------------
INSERT INTO `video` VALUES (1, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/ccdc0683492d9b21-10.mp4', NULL, NULL, NULL, 12);
INSERT INTO `video` VALUES (2, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/248e264b654bb322-10.mp4', NULL, NULL, NULL, 13);
INSERT INTO `video` VALUES (3, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/240dffb0867af0f2-10.mp4', NULL, NULL, NULL, 14);
INSERT INTO `video` VALUES (4, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/51abcce3b4aab7a2-10.mp4', NULL, NULL, NULL, 15);
INSERT INTO `video` VALUES (5, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/e734351f3f0f86ac-10.mp4', NULL, NULL, NULL, 16);
INSERT INTO `video` VALUES (6, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/22b5a63457664eb4-10.mp4', NULL, NULL, NULL, 17);
INSERT INTO `video` VALUES (7, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/ccdc0683492d9b21-10.mp4', NULL, NULL, NULL, 18);
INSERT INTO `video` VALUES (8, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/248e264b654bb322-10.mp4', NULL, NULL, NULL, 19);
INSERT INTO `video` VALUES (9, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/240dffb0867af0f2-10.mp4', NULL, NULL, NULL, 20);
INSERT INTO `video` VALUES (10, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/51abcce3b4aab7a2-10.mp4', NULL, NULL, NULL, 21);
INSERT INTO `video` VALUES (11, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/e734351f3f0f86ac-10.mp4', NULL, NULL, NULL, 22);
INSERT INTO `video` VALUES (12, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/ccdc0683492d9b21-10.mp4', NULL, NULL, NULL, 23);
INSERT INTO `video` VALUES (13, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/248e264b654bb322-10.mp4', NULL, NULL, NULL, 24);
INSERT INTO `video` VALUES (14, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/240dffb0867af0f2-10.mp4', NULL, NULL, NULL, 25);
INSERT INTO `video` VALUES (15, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/ccdc0683492d9b21-10.mp4', NULL, NULL, NULL, 26);
INSERT INTO `video` VALUES (16, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/248e264b654bb322-10.mp4', NULL, NULL, NULL, 27);
INSERT INTO `video` VALUES (17, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/240dffb0867af0f2-10.mp4', NULL, NULL, NULL, 28);
INSERT INTO `video` VALUES (18, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/ccdc0683492d9b21-10.mp4', NULL, NULL, NULL, 29);
INSERT INTO `video` VALUES (19, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/248e264b654bb322-10.mp4', NULL, NULL, NULL, 30);
INSERT INTO `video` VALUES (20, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/240dffb0867af0f2-10.mp4', NULL, NULL, NULL, 31);
INSERT INTO `video` VALUES (21, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/ccdc0683492d9b21-10.mp4', NULL, NULL, NULL, 32);
INSERT INTO `video` VALUES (22, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/248e264b654bb322-10.mp4', NULL, NULL, NULL, 33);
INSERT INTO `video` VALUES (23, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/240dffb0867af0f2-10.mp4', NULL, NULL, NULL, 34);
INSERT INTO `video` VALUES (24, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/ccdc0683492d9b21-10.mp4', NULL, NULL, NULL, 35);
INSERT INTO `video` VALUES (25, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/248e264b654bb322-10.mp4', NULL, NULL, NULL, 36);
INSERT INTO `video` VALUES (26, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/240dffb0867af0f2-10.mp4', NULL, NULL, NULL, 37);
INSERT INTO `video` VALUES (27, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/51abcce3b4aab7a2-10.mp4', NULL, NULL, NULL, 38);
INSERT INTO `video` VALUES (28, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/ccdc0683492d9b21-10.mp4', NULL, NULL, NULL, 39);
INSERT INTO `video` VALUES (29, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/248e264b654bb322-10.mp4', NULL, NULL, NULL, 40);
INSERT INTO `video` VALUES (30, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/240dffb0867af0f2-10.mp4', NULL, NULL, NULL, 41);
INSERT INTO `video` VALUES (31, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/ccdc0683492d9b21-10.mp4', NULL, NULL, NULL, 42);
INSERT INTO `video` VALUES (32, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/248e264b654bb322-10.mp4', NULL, NULL, NULL, 43);
INSERT INTO `video` VALUES (33, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/240dffb0867af0f2-10.mp4', NULL, NULL, NULL, 44);
INSERT INTO `video` VALUES (34, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/e734351f3f0f86ac-10.mp4', NULL, NULL, NULL, 45);
INSERT INTO `video` VALUES (35, 'https://study-onlne.oss-cn-nanjing.aliyuncs.com/22b5a63457664eb4-10.mp4', NULL, NULL, NULL, 46);

-- ----------------------------
-- Table structure for xue_li
-- ----------------------------
DROP TABLE IF EXISTS `xue_li`;
CREATE TABLE `xue_li`  (
  `id` int NOT NULL COMMENT '学历id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学历名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xue_li
-- ----------------------------
INSERT INTO `xue_li` VALUES (1, '小学');
INSERT INTO `xue_li` VALUES (2, '初中');
INSERT INTO `xue_li` VALUES (3, '中专');
INSERT INTO `xue_li` VALUES (4, '高中');
INSERT INTO `xue_li` VALUES (5, '职高');
INSERT INTO `xue_li` VALUES (6, '本科');
INSERT INTO `xue_li` VALUES (7, '研究生');

SET FOREIGN_KEY_CHECKS = 1;
