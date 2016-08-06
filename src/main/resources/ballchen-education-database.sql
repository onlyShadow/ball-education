/*创建角色表*/
DROP TABLE IF EXISTS `ballchen_t_role`;
CREATE TABLE `ballchen_t_role`(
  `ID` VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `ROLE_NAME` VARCHAR(50) NOT NULL COMMENT '角色名称',
  `ROLE_CODE` VARCHAR(50) NOT NULL UNIQUE COMMENT '角色代码',
  `MARK` VARCHAR(500) COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_ROLE_NAME(`ROLE_NAME`),
  KEY IDX_ROLE_CODE(`ROLE_CODE`)
)ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='账户信息表';

/*创建权限表*/
DROP TABLE  IF EXISTS `ballchen_t_authorization`;
CREATE TABLE `ballchen_t_authorization`(
  `ID` VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `AUTHORIZATION_NAME` LONGTEXT  NOT NULL COMMENT '权限名称',
  `AUTHORIZATION_CODE` LONGTEXT  NOT NULL  COMMENT '权限代码',
  `WORK_URL` LONGTEXT NOT NULL COMMENT '作用地址',
  `MARK` VARCHAR(500),
  PRIMARY KEY (`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`)
)ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='权限信息表';

/*创建权限-----角色表*/
DROP TABLE IF EXISTS `ballchen_t_role_authorization`;
CREATE TABLE `ballchen_t_role_authorization`(
  `ID` VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `AUTHORIZATION_ID` VARCHAR(50) NOT NULL  COMMENT '权限ID',
  `ROLE_ID` VARCHAR(50) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_AUTHORIZATION_ID(`AUTHORIZATION_ID`),
  KEY IDX_ROLE_ID(`ROLE_ID`),
  CONSTRAINT `FK_T_ROLE_AUTHORIZATION_T_AUTHORIZATION_ID` FOREIGN KEY (`AUTHORIZATION_ID`) REFERENCES `ballchen_t_authorization` (`ID`),
  CONSTRAINT `FK_T_ROLE_AUTHORIZATION_T_ROLE_ID` FOREIGN KEY (`ROLE_ID`) REFERENCES `ballchen_t_role` (`ID`)
)ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='权限-----角色表';

/*创建账户表*/
DROP TABLE IF EXISTS `ballchen_t_account`;
CREATE TABLE `ballchen_t_account`(
  `ID` VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `ACCOUNT_NAME` VARCHAR(50) NOT NULL COMMENT '账户名称',
  `PASSWORD` VARCHAR(50) NOT NULL COMMENT '密码',
  `DENIED` BIT(1) DEFAULT b'0' COMMENT '禁用（0.false;1.true）',
  `MARK` VARCHAR(500) COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_ACCOUNT_NAME(`ACCOUNT_NAME`)
)ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='账户表';

/*创建用户表基本表*/
DROP TABLE  IF EXISTS `ballchen_t_user_basic`;
CREATE TABLE `ballchen_t_user_basic`(
  `ID` VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `USER_NAME` VARCHAR(50) COMMENT '用户姓名',
  `NICK_NAME` VARCHAR(100) COMMENT '昵称',
  `SEX` BIT(1) DEFAULT b'0' COMMENT '性别0.女；1.男',
  `BIRTHDAY` TIMESTAMP COMMENT '生日',
  `EMAIL` VARCHAR(200) COMMENT '电子邮件',
  `ID_NUMBER` VARCHAR(30) UNIQUE COMMENT '身份证号码',
  `PHONE` VARCHAR(30) COMMENT '电话号码',
  `HOME_PHONE` VARCHAR(30) COMMENT '家庭电话',
  `DESCRIPTION` LONGTEXT COMMENT '个人描述',
  `ACCOUNT_ID` VARCHAR(50) NOT NULL COMMENT '账户ID',
  `MARK` VARCHAR(500) COMMENT '备注',
  `REAL_NAME_VALID` BIT(1) DEFAULT b'0' COMMENT '实名认证0.未认证；1.已认证',
  `DENIED` BIT(1) DEFAULT b'0' COMMENT '禁用（0.false;1.true）',
  `DENIED_REASON` VARCHAR(500) COMMENT '禁用原因',
  PRIMARY KEY (`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_USER_NAME(`USER_NAME`),
  KEY IDX_NICK_NAME(`NICK_NAME`),
  KEY IDX_SEX(`SEX`),
  KEY IDX_BIRTHDAY(`BIRTHDAY`),
  KEY IDX_EMAIL(`EMAIL`),
  KEY IDX_ID_NUMBER(`ID_NUMBER`),
  KEY IDX_PHONE(`PHONE`),
  KEY IDX_HOME_PHONE(`HOME_PHONE`),
  KEY IDX_ACCOUNT_ID(`ACCOUNT_ID`),
  KEY IDX_REAL_NAME_VALID(`REAL_NAME_VALID`),
  KEY IDX_DENIED(`DENIED`),
  CONSTRAINT `FK_T_USER_BASIC_T_ACCOUNT_ID` FOREIGN KEY (`ACCOUNT_ID`) REFERENCES `ballchen_t_account` (`ID`)
)ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户基本表';

/*创建用户----角色表*/
DROP TABLE IF EXISTS `ballchen_t_user_basic_role`;
CREATE TABLE `ballchen_t_user_basic_role`(
  `ID` VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `USER_BASIC_ID` VARCHAR(50) NOT NULL COMMENT '用户ID',
  `ROLE_ID` VARCHAR(50) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_USER_BASIC_ID(`USER_BASIC_ID`),
  KEY IDX_ROLE_ID(`ROLE_ID`),
  CONSTRAINT `FK_T_USER_BASIC_ROLE_T_USER_BASIC_ID` FOREIGN KEY (`USER_BASIC_ID`) REFERENCES `ballchen_t_user_basic` (`ID`),
  CONSTRAINT `FK_T_USER_BASIC_ROLE_T_ROLE_ID` FOREIGN KEY (`ROLE_ID`) REFERENCES `ballchen_t_role` (`ID`)
)ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户---角色表';

/*创建附件表*/
DROP TABLE IF EXISTS `ballchen_t_accessory`;
CREATE TABLE `ballchen_t_accessory`(
  `ID` VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `ACCESSORY_NAME` VARCHAR(50) NOT NULL COMMENT '附件名称',
  `SAVE_NAME` VARCHAR(200) NOT NULL COMMENT '保存名称',
  `FILE_NAME` VARCHAR(500) NOT NULL COMMENT '文件名',
  `URL` VARCHAR(500) NOT NULL COMMENT '附件路径',
  `EXT` VARCHAR(30) NOT NULL COMMENT '文件后缀名',
  `FILE_TYPE` VARCHAR(30) NOT NULL COMMENT '文件类型',
  `FILE_SIZE` BIGINT NOT NULL DEFAULT 0 COMMENT '文件大小',
  `FILE_SERVER_TYPE` VARCHAR(30) NOT NULL COMMENT '文件服务器类型',
  `MARK` VARCHAR(500) COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_ACCESSORY_NAME(`ACCESSORY_NAME`),
  KEY IDX_EXT(`EXT`),
  KEY IDX_FILE_NAME(`FILE_NAME`),
  KEY IDX_SAVE_NAME(`SAVE_NAME`)
)ENGINE =InnoDB AUTO_INCREMENT=2 CHARSET=utf8 COMMENT ='附件表';

/*创建附件用户关系表*/
DROP TABLE IF EXISTS `ballchen_t_user_basic_accessory`;
CREATE TABLE `ballchen_t_user_basic_accessory`(
  `ID` VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `USER_BASIC_ID` VARCHAR(50) NOT NULL COMMENT '用户ID',
  `ACCESSORY_ID` VARCHAR(50) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_USER_BASIC_ID(`USER_BASIC_ID`),
  KEY IDX_ACCESSORY_ID(`ACCESSORY_ID`),
  CONSTRAINT `FK_T_USER_BASIC_ACCESSORY_T_USER_BASIC_ID` FOREIGN KEY (`USER_BASIC_ID`) REFERENCES `ballchen_t_user_basic` (`ID`),
  CONSTRAINT `FK_T_USER_BASIC_ACCESSORY_T_ACCESSORY_ID` FOREIGN KEY (`ACCESSORY_ID`) REFERENCES `ballchen_t_accessory` (`ID`)
)ENGINE =InnoDB AUTO_INCREMENT=2 CHARSET =utf8 COMMENT ='用户--附件表';

/*创建分类表*/
DROP TABLE IF EXISTS `ballchen_t_category`;
CREATE TABLE `ballchen_t_category`(
  `ID` VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `CATEGORY_NAME` VARCHAR(50) NOT NULL COMMENT '分类名称',
  `CATEGORY_TYPE` VARCHAR(50) COMMENT '分类类型',
  `SEQUENCE` BIGINT DEFAULT '0' COMMENT '排序',
  `PARENT_ID` VARCHAR(50) COMMENT '父级ID',
  `USER_BASIC_ID` VARCHAR(50) COMMENT '所属用户ID',
  `ACCESSORY_ID` VARCHAR(50) COMMENT '附件ID',
  `MARK` VARCHAR(500) COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_CATEGORY_NAME(`CATEGORY_NAME`),
  KEY IDX_CATEGORY_TYPE(`CATEGORY_TYPE`),
  KEY IDX_PARENT_ID(`PARENT_ID`),
  KEY IDX_USER_BASIC_ID(`USER_BASIC_ID`),
  KEY IDX_ACCESSORY_ID(`ACCESSORY_ID`),
  CONSTRAINT `FK_T_CATEGORY_T_USER_BASIC_ID` FOREIGN KEY (`USER_BASIC_ID`) REFERENCES `ballchen_t_user_basic` (`ID`),
  CONSTRAINT `FK_T_CATEGORY_T_ACCESSORY_ID` FOREIGN KEY (`ACCESSORY_ID`) REFERENCES `ballchen_t_accessory` (`ID`)
)ENGINE =InnoDB AUTO_INCREMENT=2 CHARSET =utf8 COMMENT =' 分类表';


/*创建课程表*/
DROP TABLE IF EXISTS `ballchen_t_course`;
CREATE TABLE `ballchen_t_course`(
  `ID` VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `COURSE_NAME` VARCHAR(200) NOT NULL COMMENT '课程名称',
  `COURSE_TYPE` VARCHAR(30) NOT NULL COMMENT '课程类型（一对一，班课）',
  `PRICE` DECIMAL(10,2) DEFAULT '0.00' COMMENT '价格',
  `DENIED` BIT(1) DEFAULT b'1' COMMENT '禁用（0.false;1.true）',
  `RECOMMEND` BIT(1) DEFAULT b'0' COMMENT '推荐（0.false;1.true）',
  `CATEGORY_ID` VARCHAR(50) NOT NULL COMMENT '课程分类ID',
  `DESCRIPTION` LONGTEXT COMMENT '描述',
  PRIMARY KEY (`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_COURSE_NAME(`COURSE_NAME`),
  KEY IDX_COURSE_TYPE(`COURSE_TYPE`),
  KEY IDX_PRICE(`PRICE`),
  CONSTRAINT `FK_T_COURSE_T_CATEGORY_ID` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `ballchen_t_category` (`ID`)
)ENGINE =InnoDB AUTO_INCREMENT=2 CHARSET =utf8 COMMENT '课程表';

/*创建课程--用户中间表*/
DROP TABLE IF EXISTS `ballchen_t_course_user_basic`;
CREATE TABLE `ballchen_t_course_user_basic`(
  `ID`  VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP   NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `COURSE_ID` VARCHAR(50) NOT NULL COMMENT '课程ID',
  `USER_BASIC_ID` VARCHAR(50) NOT NULL COMMENT '用户ID',
  PRIMARY KEY(`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_COURSE_ID(`COURSE_ID`),
  KEY IDX_USER_BASIC_ID(`USER_BASIC_ID`),
  CONSTRAINT `Fk_T_COURSE_USER_BASIC_T_COURSE_ID` FOREIGN KEY (`COURSE_ID`) REFERENCES `ballchen_t_course`(`ID`),
  CONSTRAINT `Fk_T_COURSE_USER_BASIC_T_USER_BASIC_ID` FOREIGN KEY (`USER_BASIC_ID`) REFERENCES `ballchen_t_user_basic`(`ID`)
)ENGINE =InnoDB AUTO_INCREMENT=2 CHARSET =utf8 COMMENT '课程--用户中间表';

/*创建课程--附件中间表*/
DROP TABLE IF EXISTS `ballchen_t_course_accessory`;
CREATE TABLE `ballchen_t_course_accessory`(
  `ID`  VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP   NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `COURSE_ID` VARCHAR(50) NOT NULL COMMENT '课程ID',
  `ACCESSORY_ID` VARCHAR(50) NOT NULL COMMENT '附件ID',
  PRIMARY KEY(`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_COURSE_ID(`COURSE_ID`),
  KEY IDX_USER_BASIC_ID(`ACCESSORY_ID`),
  CONSTRAINT `FK_T_COURSE_ACCESSORY_T_COURSE_ID` FOREIGN KEY (`COURSE_ID`) REFERENCES `ballchen_t_course`(`ID`),
  CONSTRAINT `Fk_T_COURSE_ACCESSORY_T_ACCESSORY_ID` FOREIGN KEY (`ACCESSORY_ID`) REFERENCES `ballchen_t_accessory`(`ID`)
)ENGINE =InnoDB AUTO_INCREMENT=2 CHARSET =utf8 COMMENT '课程--附件中间表';
/*创建课程章节表*/
DROP TABLE IF EXISTS `ballchen_t_course_chapter`;
CREATE TABLE `ballchen_t_course_chapter` (
  `ID`  VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME` TIMESTAMP   NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `CHAPTER_NAME` VARCHAR(200) NOT NULL COMMENT '章节名称',
  `CHAPTER_TYPE` VARCHAR(50) NOT NULL COMMENT '章节类型（在线直播，线下，视频课，练习题，一对一，其它）',
  `PLAN_BEGIN_DATE` DATE COMMENT '计划开始日期',
  `PLAN_BEGIN_TIME` TIME COMMENT '计划开始时间',
  `PLAN_END_DATE` DATE COMMENT '计划结束日期',
  `PLAN_END_TIME` TIME COMMENT '计划结束时间',
  `REAL_BEGIN_DATE` DATE COMMENT '实际开始日期',
  `REAL_BEGIN_TIME` DATE COMMENT '实际开始时间',
  `REAL_END_DATE` DATE COMMENT '实际结束日期',
  `REAL_END_TIME` DATE COMMENT '实际结束时间',
  `COURSE_ID` VARCHAR(50) NOT NULL COMMENT '课程ID',
  PRIMARY KEY (`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_CHAPTER_NAME(`CHAPTER_NAME`),
  KEY IDX_CHAPTER_TYPE(`CHAPTER_TYPE`),
  KEY IDX_PLAN_BEGIN_TIME(`PLAN_BEGIN_TIME`),
  KEY IDX_PLAN_BEGIN_DATE(`PLAN_BEGIN_DATE`),
  KEY IDX_PLAN_END_TIME(`PLAN_END_TIME`),
  KEY IDX_PLAN_END_DATE(`PLAN_END_DATE`),
  KEY IDX_REAL_BEGIN_TIME(`REAL_BEGIN_TIME`),
  KEY IDX_REAL_BEGIN_DATE(`REAL_BEGIN_DATE`),
  KEY IDX_REAL_END_TIME(`REAL_END_TIME`),
  KEY IDX_REAL_END_DATE(`REAL_END_DATE`),
  CONSTRAINT `FK_T_COURSE_CHAPTER_T_COURSE_ID` FOREIGN KEY (`COURSE_ID`) REFERENCES ballchen_t_course(`ID`)
)ENGINE =InnoDB AUTO_INCREMENT=2 CHARSET =utf8 COMMENT '课程章节表';

/*创建课程章节附件表*/
DROP TABLE IF EXISTS `ballchen_t_course_chapter_accessory`;
CREATE TABLE `ballchen_t_course_chapter_accessory` (
  `ID`  VARCHAR(50) NOT NULL COMMENT '主键ID',
  `CREATE_TIME`   TIMESTAMP   NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
  `COURSE_CHAPTER_ID`     VARCHAR(50) NOT NULL COMMENT '课程章节ID',
  `ACCESSORY_ID` VARCHAR(50) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`ID`),
  KEY IDX_CREATE_TIME(`CREATE_TIME`),
  KEY IDX_COURSE_CHAPTER_ID(`COURSE_CHAPTER_ID`),
  KEY IDX_ACCESSORY_ID(`ACCESSORY_ID`),
  CONSTRAINT `FK_T_COURSE_CHAPTER_ACCESSORY_T_COURSE_CHAPTER_ID` FOREIGN KEY (`COURSE_CHAPTER_ID`) REFERENCES `ballchen_t_course_chapter` (`ID`),
  CONSTRAINT `Fk_T_COURSE_CHAPTER_ACCESSORY_T_ACCESSORY_ID` FOREIGN KEY (`ACCESSORY_ID`) REFERENCES `ballchen_t_accessory` (`ID`)
)ENGINE =InnoDB AUTO_INCREMENT=2 CHARSET =utf8 COMMENT '课程章节--附件表';