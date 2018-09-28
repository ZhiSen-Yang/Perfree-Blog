/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50508
Source Host           : localhost:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 50508
File Encoding         : 65001

Date: 2018-09-28 08:44:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for abourt
-- ----------------------------
DROP TABLE IF EXISTS `abourt`;
CREATE TABLE `abourt` (
  `name` varchar(16) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '名字',
  `abs` text CHARACTER SET utf8 COMMENT '简介,签名',
  `githubName` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT 'github名称',
  `githubUrl` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT 'github   url',
  `weiboName` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '微博名称',
  `weiboUrl` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT 'weiboUrl',
  `QQ` varchar(11) CHARACTER SET utf8 DEFAULT NULL COMMENT 'QQ',
  `imageUrl` varchar(80) CHARACTER SET utf8 DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='关于我';

-- ----------------------------
-- Records of abourt
-- ----------------------------
INSERT INTO `abourt` VALUES ('1111', '啊啊撒啊', null, '啊啊啊', null, null, null, null);

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` varchar(36) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `title` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '标题',
  `imageUrl` varchar(80) CHARACTER SET utf8 DEFAULT NULL COMMENT '封面url',
  `context` text CHARACTER SET utf8 COMMENT '内容',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `boardId` bigint(20) DEFAULT NULL,
  `pageView` bigint(20) DEFAULT '0' COMMENT '浏览量',
  `revertNum` bigint(20) DEFAULT '0' COMMENT '回复量',
  `stick` int(11) DEFAULT NULL COMMENT '是否置顶,0否,1是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='文章表';

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('153775093550204', '初次配置使用MyBatis', 'http://47.104.251.24/group1/M00/00/02/rB802luoN4uAYJ6eAAk2Keh1EzI785.jpg', 'MyBatis是一款支持定制化SQL,存储过程以及高级映射的优秀的持久层框架。MyBatis 避免了几乎所有的 JDBC 代码和手工设置参数以及抽取结果集。MyBatis 使用简单的 XML 或注解来配置和映射基本体，将接口和 Java 的 POJOs(Plain Old Java Objects,普通的 Java对象)映射成数据库中的记录。[官方文档](http://www.mybatis.org/mybatis-3/zh/index.html)\n\n\n----------\n## 1.下载MyBatis\n[官方下载地址](https://github.com/mybatis/mybatis-3/releases)\n这里使用的是`mybatis-3.4.6.zip`\n![下载][1]\n\n\n## 2.导包\n将下载的压缩包解压,导入里边所有jar包(一共13个...),之后再导入所使用的数据库jar包就ok了,这里使用的是MySql数据库\n\n## 3.全局配置\nweb项目在Java Resources新建config资源目录,在该目录下新建MyBatis全局配置文件sqlMapConfig.xml(名称随意),它包含了数据源和事务管理器等设置和属性信息,基础环境配置:\n``` bash\n<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<!DOCTYPE configuration\nPUBLIC \"-//mybatis.org//DTD Config 3.0//EN\"\n\"http://mybatis.org/dtd/mybatis-3-config.dtd\">\n<configuration> \n	<environments default=\"development\"> \n		<environment id=\"development\"> \n			<transactionManager type=\"JDBC\"/> \n			<dataSource type=\"POOLED\"> \n				<!-- 数据库连接配置 -->\n				<property name=\"driver\" value=\"${driver}\"/> \n				<property name=\"url\" value=\"${url}\"/> \n				<property name=\"username\" value=\"${username}\"/> \n				<property name=\"password\" value=\"${password}\"/> \n			</dataSource> \n		</environment> \n	<environment id=\"development2\">\n		<!--核心映射文件地址,示例如下(可使用相对路径或者绝对路径)-->\n		<mapper resource=\"mapper/UserMapper.xml\"/>\n		<!--绝对路径-->\n		<mapper url=\"file:///var/sqlmaps/AuthorMapper.xml\"/>\n		......\n	</environment> \n	</environments> \n</configuration> \n```\n### 3.1.MyBatis 事务管理类\nJDBC - 这个类型直接全部使用 JDBC 的提交和回滚功能。它依靠使用连接的数据源来管理事务的作用域。\nMANAGED - 这个类型什么不做 ， 它从不提交 、 回滚和关闭连接 。 而是让窗口来管理事务的全部生命周期 。（比如说 Spring 或者JAVAEE 服务器）\n### 3.2.MyBatis 数据源类型\nUNPOOLED -这个数据源实现只是在每次请求的时候简单的打开和关闭一个连接。虽然这有点慢，但作为一些不需要性能和立即响应简单应用来说 ，不失为一种好选择 。 \nPOOLED - 这个数据源缓存 JDBC 连接对象用于避免每次都要连接和生成连接实例而需要的验证时间 。对于并发WEB应用，这种方式非常流行因为它有最快的响应时间。\nJNDI - 这个数据源实现是为了准备和 Spring 或应用服务一起使用，可以在外部也可以在内部配置这个数据源，然后在JNDI上下文中引用它\n\n## 4.log4j\n在config目录下新建log4j.properties复制下方代码:\n``` bash\n    # Global logging configuration\n    log4j.rootLogger=DEBUG, stdout\n    # Console output...\n    log4j.appender.stdout=org.apache.log4j.ConsoleAppender\n    log4j.appender.stdout.layout=org.apache.log4j.PatternLayout\n    log4j.appender.stdout.layout.ConversionPattern=%5p [%t] - %m%n\n```\n## 5.核心映射文件\n在config下新建mapper包,在包内新建UserMapper.xml(名称随意..)参考以下代码:\n``` bash\n<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<!DOCTYPE mapper PUBLIC \"-//ibatis.apache.org//DTD Mapper 3.0//EN\" \"http://ibatis.apache.org/dtd/ibatis-3-mapper.dtd\">\n    <mapper namespace=\"user\" >\n    	<select id =\"getUsers\" resultType=\"com.entiy.User\">\n    		SELECT * FROM USER\n    	</select>\n    	<select id=\"findUserById\" parameterType=\"int\" resultType=\"com.test.User\">\n    		SELECT * FROM USER WHERE id = #{id}\n    	</select>\n    </mapper>\n```\n### 5.1.SQL 映射文件结构：\n注:第一次使用仅作为了解就可以了\ncache -  配置给定命名空间的缓存。 \ncache-ref –  从其他命名空间引用缓存配置。 \nresultMap  –  最复杂，也是最有力量的元素，用来描述如何从数据库结果集中来加载对象。 \nsql –  可以重用的 SQL 块，也可以被其他语句引用。 \ninsert –  映射插入语句 \nupdate –  映射更新语句 \ndelete –  映射删除语句 \nselect –  映射查询语句\n## 6.Java代码\n这里直接在main方法中写的:\n```bash\npackage com.fly;\n\nimport java.io.InputStream;\nimport java.util.List;\nimport org.apache.ibatis.io.Resources;\nimport org.apache.ibatis.session.SqlSession;\nimport org.apache.ibatis.session.SqlSessionFactory;\nimport org.apache.ibatis.session.SqlSessionFactoryBuilder;\nimport com.entiy.User;\n\npublic class Test {\n	public static void main(String[] args) {\n		SqlSession session = null;\n		//声明配置文件\n		String resource = \"sqlMapConfig.xml\";\n		try {\n			//读取全局配置文件\n			InputStream is = Resources.getResourceAsStream(resource);\n			//创建SqlSessionFactory会话工厂\n			SqlSessionFactoryBuilder ssfb = new SqlSessionFactoryBuilder();\n			SqlSessionFactory ssf = ssfb.build(is);\n			//获取SqlSession会话\n			session = ssf.openSession();\n			//拿到结果集放入List集合\n			List<User> list = session.selectList(\"user.getUsers\");\n			//遍历输出\n			for(User u:list){\n				System.out.println(u.toString());\n			}\n		} catch (Exception e) {\n			// TODO Auto-generated catch block\n			e.printStackTrace();\n		}finally{\n			//关闭资源\n			if(session != null){\n				session.close();\n			}\n		}\n	}\n}\n```\n### 6.1.SqlSessionFactoryBuilder的生命周期： \n这个类可以被初始 、 使用和丢弃 ， 如果你已经创建好了一个 SqlSessionFactory 后就不用再保留它 。 因此 ，SqlSessionFactoryBuilder 的最好作用域是方法体内，比如说定义一个方法变量。你可以重复使 用SqlSessionFactoryBuilder 生成多个SqlSessionFactory 实例 ， 但是最好不要强行保留 ， 因为 XML 的解析资源要用来做其它更重要的事。\n### 6.2.SqlSessionFactory：\n一旦创建， SqlSessionFactory 就会在整个应用过程中始终存在。所以没有理由去销毁和再创建它，一个应用运行中也不建议多次创建 SqlSessionFactory 。 如果真的那样做 ， 会显得很拙劣 。 因此 SqlSessionFactor y最好的作用域是 Application 。可以有多种方法实现。最简单的方法是单例模式或者是静态单例模式 。 然而这既不是广泛赞成和好用的 。 反而 ， 使用 Google Guice 或 Spring 来进行依赖反射会更好 。 这些框架允许你生成管理器来管理 SqlSessionFactory 的单例生命周期。\n### 6.3.SqlSession：\n每个线程都有自己的 SqlSession 实例， SqlSession 实例是不能被共享，也是不是线程安全的。因此最好使用 Request 作用域或者方法体作用域。不要使用类的静态变量来引用一个 SqlSession 实例，甚至不要使用类的一个实例变更来引用。如果你正在使用 WEB 框架，应该让 SqlSession 跟随 HTTP 请求的相似作用域。也就是说，在收到一个 HTTP 请求过后，打开 SqlSession ，等返回一个回应以后，立马关掉这个 SqlSession 。 关闭 SqlSession 是非常重要的。你必须要确保 SqlSession 在 finally 方法体中正常关闭\n  \n  [1]: https://i.loli.net/2018/06/11/5b1e3ae88c758.png', '2018-09-24 09:02:16', '2018-09-24 09:02:50', '38', '7', '1', '0');
INSERT INTO `article` VALUES ('153775105886584', 'MyBatis Mapper代理的开发方式', 'http://47.104.251.24/group1/M00/00/02/rB802luoOACAGSSfAAXYZr-S8Cs569.jpg', 'Mapper接口开发方法只需要程序员编写Mapper接口（相当于Dao接口），由Mybatis框架根据接口定义创建接口的动态代理对象，代理对象的方法体同上边Dao接口实现类方法。同时mybatis官方也推荐使用mapper代理方法开发mapper接口，程序员不用编写mapper接口实现类，使用mapper代理方法时，输入参数可以使用pojo包装对象或map对象，保证dao的通用性。\n## 1.开发规范\n(1) Mapper.xml文件中的namespace与mapper接口的类路径相同。\n(2) Mapper接口方法名和Mapper.xml中定义的每个statement的id相同\n(3) Mapper接口方法的输入参数类型和mapper.xml中定义的每个sql 的parameterType的类型相同\n(4) Mapper接口方法的输出参数类型和mapper.xml中定义的每个sql的resultType的类型相同\n\n## 2.Mapper.xml映射文件\n定义mapper映射文件UserMapper.xml,需要修改如下几项:\n\n(1) namespace的值为UserMapper接口的路径\n(2) parameterType要和接口定义的输入参数类型保持一致\n(3) resultType同样和接口中定义的输出(返回)参数类型保持一致,如果返回的值类型为List,直接定义为实体存储对象即可,这和selectOne或selectList有关\n\n代码示例:\n```bash\n<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE mapper\n    PUBLIC \"-//mybatis.org//DTD Mapper 3.0//EN\"\n    \"http://mybatis.org/dtd/mybatis-3-mapper.dtd\">\n<mapper namespace=\"com.fly.mapper.UserMapper\">\n	<select id=\"findUserById\" parameterType=\"int\" resultType=\"user\">\n		SELECT * FROM t_user WHERE id = #{id}\n	</select>\n	<update id=\"updateUserById\" parameterType=\"user\">\n		UPDATE t_user SET username = #{username} WHERE id = #{id}\n	</update>\n</mapper>\n```\n## 3.Mapper.java接口文件\n接口的定义需注意以下几项:\n\n(1) Mapper接口方法名和Mapper.xml中定义的statement的id相同\n(2) Mapper接口方法的输入参数类型和mapper.xml中定义的statement的parameterType的类型相同\n(3) Mapper接口方法的输出参数类型和mapper.xml中定义的statement的resultType的类型相同\n\n代码示例:\n```bash\npackage com.fly.mapper;\n\nimport com.fly.pojo.User;\n\npublic interface UserMapper {\n	//根据id查找用户信息\n	public User findUserById(int id);\n	//根据id修改用户名称\n	public void updateUserById(User user);\n}\n```\n## 4.加载Mapper.xml映射文件\n在sqlMapConfig.xml做如下修改(多种方式加载):\n```bash\n<mappers>\n	<!-- 通过mapper代理接口加载mapper配置文件mapper接口和映射文件名称相同，且在同一目录下面 -->\n	<!-- <mapper class=\"com.fly.mapper.UserMapper\"/> -->\n	<!-- 单个加载映射文件 -->\n	<mapper resource=\"mapper/UserMapper.xml\"/>\n	<!-- 批量加载映射文件 必须保证mapper配置文件mapper接口和映射文件名称相同且在同一目录下面  -->\n	<!-- <package name=\"com.fly.mapper\"/> -->\n</mappers>\n```\n## 5.测试\n\n这里使用了junit进行测试:\n\n```bash\npackage com.fly.test;\n\nimport java.io.InputStream;\nimport org.apache.ibatis.io.Resources;\nimport org.apache.ibatis.session.SqlSession;\nimport org.apache.ibatis.session.SqlSessionFactory;\nimport org.apache.ibatis.session.SqlSessionFactoryBuilder;\nimport org.junit.Before;\nimport org.junit.Test;\nimport com.fly.mapper.UserMapper;\nimport com.fly.pojo.User;\n\npublic class MybatisTest {\n	private SqlSessionFactory ssf;\n	@Before\n	public void createSqlSessionFactory() throws Exception{\n		String resource = \"sqlMapConfig.xml\";\n		InputStream is = Resources.getResourceAsStream(resource);\n		//使用SqlSessionFactoryBuilder创建sessionFactory\n		SqlSessionFactoryBuilder ssfb = new SqlSessionFactoryBuilder();\n		ssf=ssfb.build(is);\n	}\n	@Test\n	public void findUserById(){\n		//获取session\n		SqlSession session = ssf.openSession();\n		//创建usermapper对象，mybatis自动生成mapper代理对象\n		UserMapper mapper = session.getMapper(UserMapper.class);\n		//调用代理对象方法\n		User u = mapper.findUserById(10);\n		System.out.println(u);\n		//关闭session\n		session.close();\n	}\n	@Test\n	public void updateUserById(){\n		//获取session\n		SqlSession session = ssf.openSession();\n		//创建usermapper对象，mybatis自动生成mapper代理对象\n		UserMapper mapper = session.getMapper(UserMapper.class);\n		User u = new User();\n		u.setId(10);\n		u.setUsername(\"小钢炮\");\n		//调用代理对象方法\n		mapper.updateUserById(u);\n		//提交\n		session.commit();\n		//关闭session\n		session.close();\n	}\n}\n```\n## 6.总结\n(1) selectOne和selectList\n	如果mapper方法返回单个pojo对象（非集合对象），代理对象内部通过selectOne查询数据库。\n	如果mapper方法返回集合对象，代理对象内部通过selectList查询数据库。\n\n(2) namespace\n	(重申)Mapper.xml文件中的namespace与mapper接口的类路径一定要相同。\n\n## 7.最后扩展下#{}和${}\n(1) #{}\n	#{}表示一个占位符号，#{}接收输入参数，类型可以是简单类型，pojo、hashmap。\n	如果接收简单类型，#{}中可以写成value或其它名称。\n	#{}接收pojo对象值，通过OGNL读取对象中的属性值，通过属性.属性.属性...的方式获取对象属性值。\n\n\n(2) ${}\n	${}表示一个拼接符号，会引用sql注入，所以不建议使用${}\n	${}接收输入参数，类型可以是简单类型，pojo、hashmap。\n	如果接收简单类型，${}中只能写成value。\n	${}接收pojo对象值，通过OGNL读取对象中的属性值，通过属性.属性.属性...的方式获取对象属性值。', '2018-09-24 09:04:19', '2018-09-24 09:04:19', '38', '44', '1', '0');
INSERT INTO `article` VALUES ('153778358481660', 'Java Web 博客搭建心得体会', 'http://47.104.251.24/group1/M00/00/02/rB802luoWJyAejN2AAboaT9DvQU207.jpg', '这段时间摔着胳膊在家养伤,实在是太无聊,就想着自己写个博客,不再使用原先的Hexo+gihub搭建的博客 [[Perfree的博客]](http://www.perfree.top \"(Perfree的博客)\"),托着一只胳膊而且还是右胳膊.....慢慢悠悠的也算是用一只手把这个博客给搭建了起来,下面简单的介绍下此博客使用到的一些东西:\n## 后台页面\n先简单的上两张图:\n![发表文章](http://47.104.251.24/group1/M00/00/02/rB802luoWzSACnz1AAFijKcX_U4628.jpg \"发表文章\")![](http://47.104.251.24/group1/M00/00/02/rB802luoW-iAPQG-AAEqOl6qNXQ573.jpg)\n\n------------\n\n\n页面使用了hui-admin模板进行二次开发,感觉图片上传不理想,又自己写了个上传插件......文章的编辑器采用了[editor.md](https://github.com/pandao/editor.md \"editor.md\")编辑器,至于为啥使用这个,只是单纯的喜欢markdown码字而已...后端的话最后再说吧\n\n------------\n\n## 前台页面\n下方多图:\n![首页](http://47.104.251.24/group1/M00/00/02/rB802luosPeASmVLAAHBYtsUAgk103.jpg \"首页\")\n![分类](http://47.104.251.24/group1/M00/00/02/rB802luosQKABEtbAAEpOY_umrc200.jpg \"分类\")\n![标签](http://47.104.251.24/group1/M00/00/02/rB802luosS6AT4f7AADp_J_bxo4488.jpg \"标签\")\n![时间流](http://47.104.251.24/group1/M00/00/02/rB802luosaOAGNCnAADupCus2hY010.jpg \"时间流\")\n![文章列表](http://47.104.251.24/group1/M00/00/02/rB802luose-AUI-FAAGmN4rlUi0934.jpg \"文章列表\")\n![文章展示](http://47.104.251.24/group1/M00/00/02/rB802luosgGAfxI4AAGcLeEyUt0858.jpg \"文章展示\")\n![评论](http://47.104.251.24/group1/M00/00/02/rB802luoshSAUE_wAAElJi1CPQY653.jpg \"评论\")\n\n\n------------\n\n写前端简直要了老命,再加上为了在手机上出现效果,又搞响应式....都懒得再看了,直接了解后端吧...\n\n------------\n## 后端技术\n1.整体框架: SSM [Spring,Spring MVC,Mybatis]\n2.安全框架: Shiro [登录,注册,权限角色认证]\n3.图片服务器: FastDfs [是不是大材小用了:joy:]\n4.项目管理: Maven+Git [习惯了...]\n5.数据库: Mysql [...]\n其实也没多少东西,写来写去都是那些代码,大部分时间都耗费在前端上边了......\n## 总结\n整体写下来基本都是遇到前端的坑,后端倒是一番风顺,托着一只受伤的手,左手从页面布局-数据库设计-功能实现,写写停停的将近一个月也算是基本完工了,右手现在也快好了,这个博客也算是有纪念意义了吧,总之,接下来右手好了就得尽快找工作养活自己了,加油吧~', '2018-09-24 18:06:25', '2018-09-24 18:10:52', '46', '105', '1', '1');

-- ----------------------------
-- Table structure for article_tag
-- ----------------------------
DROP TABLE IF EXISTS `article_tag`;
CREATE TABLE `article_tag` (
  `articleId` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '文章id',
  `tagId` bigint(20) DEFAULT NULL COMMENT '标签id'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='文章标签中间表';

-- ----------------------------
-- Records of article_tag
-- ----------------------------
INSERT INTO `article_tag` VALUES ('153775093550204', '35');
INSERT INTO `article_tag` VALUES ('153775105886584', '35');
INSERT INTO `article_tag` VALUES ('153778358481660', '28');
INSERT INTO `article_tag` VALUES ('153778358481660', '33');
INSERT INTO `article_tag` VALUES ('153778358481660', '34');

-- ----------------------------
-- Table structure for board
-- ----------------------------
DROP TABLE IF EXISTS `board`;
CREATE TABLE `board` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parentId` bigint(20) DEFAULT NULL COMMENT '父id,父节点只需保存name,0为父',
  `name` varchar(16) DEFAULT NULL COMMENT '分类名称',
  `abs` varchar(30) DEFAULT NULL COMMENT '一句话简介',
  `image` varchar(80) DEFAULT NULL COMMENT '图片url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of board
-- ----------------------------
INSERT INTO `board` VALUES ('37', '0', '网络编程', null, null);
INSERT INTO `board` VALUES ('38', '37', 'java', '一杯java解千愁', 'http://47.104.251.24/group1/M00/00/01/rB802lucnFuAG5opAAk2Keh1EzI268.jpg');
INSERT INTO `board` VALUES ('39', '0', '资源分享', null, null);
INSERT INTO `board` VALUES ('40', '39', '资料分享', '一些比较调皮的学习资料', 'http://47.104.251.24/group1/M00/00/01/rB802lueM6OAEfkpAAboaT9DvQU467.jpg');
INSERT INTO `board` VALUES ('41', '37', 'python', '人生苦短,我用python', 'http://47.104.251.24/group1/M00/00/01/rB802lueM9mAeebAAAXYZr-S8Cs288.jpg');
INSERT INTO `board` VALUES ('42', '37', 'c/c++', '学习ing...', 'http://47.104.251.24/group1/M00/00/01/rB802lueM_6AV_DWAAk2Keh1EzI650.jpg');
INSERT INTO `board` VALUES ('44', '39', '代码分享', '我的代码经不起推敲=_=', 'http://47.104.251.24/group1/M00/00/02/rB802luoNS2AIUT_AAk2Keh1EzI275.jpg');
INSERT INTO `board` VALUES ('45', '0', '其他', null, null);
INSERT INTO `board` VALUES ('46', '45', '心得体会', '小小年纪有啥心得', 'http://47.104.251.24/group1/M00/00/02/rB802luoNmqATBhTAAboaT9DvQU200.jpg');

-- ----------------------------
-- Table structure for content
-- ----------------------------
DROP TABLE IF EXISTS `content`;
CREATE TABLE `content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `imageUrl` varchar(80) CHARACTER SET utf8 DEFAULT NULL COMMENT '图片url',
  `clickUrl` varchar(80) CHARACTER SET utf8 DEFAULT NULL COMMENT '点击跳转url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1 COMMENT='内容表,轮播图';

-- ----------------------------
-- Records of content
-- ----------------------------
INSERT INTO `content` VALUES ('35', 'http://47.104.251.24/group1/M00/00/02/rB802luoNUqAcj6vAAGdhRe9CCU746.jpg', null);
INSERT INTO `content` VALUES ('36', 'http://47.104.251.24/group1/M00/00/02/rB802luoNVGABFDJAAE8MN6YgB0439.jpg', null);
INSERT INTO `content` VALUES ('37', 'http://47.104.251.24/group1/M00/00/02/rB802luoNVmAcStbAAFkSqqWdHA453.jpg', null);

-- ----------------------------
-- Table structure for revert
-- ----------------------------
DROP TABLE IF EXISTS `revert`;
CREATE TABLE `revert` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `context` text CHARACTER SET utf8 COMMENT '评论内容',
  `createTime` datetime DEFAULT NULL COMMENT '评论时间',
  `articleId` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '所属文章id',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1 COMMENT='评论表';

-- ----------------------------
-- Records of revert
-- ----------------------------
INSERT INTO `revert` VALUES ('54', '<img src=\'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/4a/2018new_xiaoku_thumb.png\' height=\'22\' width=\'22\' />', '2018-09-24 16:43:17', '153775105886584', '15');
INSERT INTO `revert` VALUES ('55', '组长辛苦了，早日康复', '2018-09-24 19:08:35', '153778358481660', '17');
INSERT INTO `revert` VALUES ('58', '测试<img src=\'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/a1/2018new_doge02_org.png\' height=\'22\' width=\'22\' />', '2018-09-25 17:40:24', '153775093550204', '15');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'admin');
INSERT INTO `role` VALUES ('2', 'user');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(16) CHARACTER SET utf8 DEFAULT NULL COMMENT '标签名字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1 COMMENT='标签表';

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES ('28', '上线');
INSERT INTO `tag` VALUES ('29', 'spring');
INSERT INTO `tag` VALUES ('30', '事务管理');
INSERT INTO `tag` VALUES ('31', 'AOP');
INSERT INTO `tag` VALUES ('32', '注解');
INSERT INTO `tag` VALUES ('33', '心得');
INSERT INTO `tag` VALUES ('34', '记录');
INSERT INTO `tag` VALUES ('35', 'mybatis');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `nickname` varchar(16) CHARACTER SET utf8 DEFAULT NULL COMMENT '昵称',
  `phone` varchar(11) CHARACTER SET utf8 DEFAULT NULL COMMENT '手机号',
  `password` varchar(36) CHARACTER SET utf8 DEFAULT NULL COMMENT '密码,要求加密加盐',
  `image` varchar(80) CHARACTER SET utf8 DEFAULT NULL COMMENT '头像',
  `createTime` datetime DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('15', 'Perfree', '18339275822', '96821db7b8a1b0aac7652b06a06ec1c6', '/images/user.jpg', '2018-09-24 08:50:09');
INSERT INTO `user` VALUES ('16', 'Yin123', '15136204822', '2f956ee3a1fedc3f38ba27d84150bead', '/images/user.jpg', '2018-09-24 09:50:30');
INSERT INTO `user` VALUES ('17', 'wyh666', '13033711222', '01b9086492adb8e508cdd163b1b4ec74', '/images/user.jpg', '2018-09-24 19:07:05');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `userId` bigint(20) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('15', '2');
INSERT INTO `user_role` VALUES ('15', '1');
INSERT INTO `user_role` VALUES ('16', '2');
INSERT INTO `user_role` VALUES ('17', '2');
