-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: localhost    Database: nodejs63qva
-- ------------------------------------------------------
-- Server version	5.7.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `nodejs63qva`
--

/*!40000 DROP DATABASE IF EXISTS `nodejs63qva`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `nodejs63qva` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `nodejs63qva`;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='配置文件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'picture1','upload/picture1.jpg'),(2,'picture2','upload/picture2.jpg'),(3,'picture3','upload/picture3.jpg');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dingfangxinxi`
--

DROP TABLE IF EXISTS `dingfangxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dingfangxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kefangbianhao` varchar(200) DEFAULT NULL COMMENT '客房编号',
  `kefangleixing` varchar(200) DEFAULT NULL COMMENT '客房类型',
  `kefangjiage` float DEFAULT NULL COMMENT '客房价格',
  `ruzhushijian` datetime DEFAULT NULL COMMENT '入住时间',
  `yudingshijian` datetime DEFAULT NULL COMMENT '预订时间',
  `beizhu` varchar(200) DEFAULT NULL COMMENT '备注',
  `zhanghao` varchar(200) DEFAULT NULL COMMENT '账号',
  `xingming` varchar(200) DEFAULT NULL COMMENT '姓名',
  `shouji` varchar(200) DEFAULT NULL COMMENT '手机',
  `sfsh` varchar(200) DEFAULT '否' COMMENT '是否审核',
  `shhf` longtext COMMENT '审核回复',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='订房信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dingfangxinxi`
--

LOCK TABLES `dingfangxinxi` WRITE;
/*!40000 ALTER TABLE `dingfangxinxi` DISABLE KEYS */;
INSERT INTO `dingfangxinxi` VALUES (31,'2022-03-23 03:02:03','客房编号1','客房类型1',1,'2022-03-23 11:02:03','2022-03-23 11:02:03','备注1','账号1','姓名1','13823888881','是',''),(32,'2022-03-23 03:02:03','客房编号2','客房类型2',2,'2022-03-23 11:02:03','2022-03-23 11:02:03','备注2','账号2','姓名2','13823888882','是',''),(33,'2022-03-23 03:02:03','客房编号3','客房类型3',3,'2022-03-23 11:02:03','2022-03-23 11:02:03','备注3','账号3','姓名3','13823888883','是',''),(34,'2022-03-23 03:02:03','客房编号4','客房类型4',4,'2022-03-23 11:02:03','2022-03-23 11:02:03','备注4','账号4','姓名4','13823888884','是',''),(35,'2022-03-23 03:02:03','客房编号5','客房类型5',5,'2022-03-23 11:02:03','2022-03-23 11:02:03','备注5','账号5','姓名5','13823888885','是',''),(36,'2022-03-23 03:02:03','客房编号6','客房类型6',6,'2022-03-23 11:02:03','2022-03-23 11:02:03','备注6','账号6','姓名6','13823888886','是','');
/*!40000 ALTER TABLE `dingfangxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feiyongxinxi`
--

DROP TABLE IF EXISTS `feiyongxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feiyongxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `feiyongbianhao` varchar(200) DEFAULT NULL COMMENT '费用编号',
  `kefangbianhao` varchar(200) DEFAULT NULL COMMENT '客房编号',
  `kefangleixing` varchar(200) DEFAULT NULL COMMENT '客房类型',
  `feiyongjine` float DEFAULT NULL COMMENT '费用金额',
  `feiyongmiaoshu` longtext COMMENT '费用描述',
  `zhanghao` varchar(200) DEFAULT NULL COMMENT '账号',
  `xingming` varchar(200) DEFAULT NULL COMMENT '姓名',
  `ispay` varchar(200) DEFAULT '未支付' COMMENT '是否支付',
  PRIMARY KEY (`id`),
  UNIQUE KEY `feiyongbianhao` (`feiyongbianhao`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='费用信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feiyongxinxi`
--

LOCK TABLES `feiyongxinxi` WRITE;
/*!40000 ALTER TABLE `feiyongxinxi` DISABLE KEYS */;
INSERT INTO `feiyongxinxi` VALUES (71,'2022-03-23 03:02:03','1111111111','客房编号1','客房类型1',1,'费用描述1','账号1','姓名1','未支付'),(72,'2022-03-23 03:02:03','2222222222','客房编号2','客房类型2',2,'费用描述2','账号2','姓名2','未支付'),(73,'2022-03-23 03:02:03','3333333333','客房编号3','客房类型3',3,'费用描述3','账号3','姓名3','未支付'),(74,'2022-03-23 03:02:03','4444444444','客房编号4','客房类型4',4,'费用描述4','账号4','姓名4','未支付'),(75,'2022-03-23 03:02:03','5555555555','客房编号5','客房类型5',5,'费用描述5','账号5','姓名5','未支付'),(76,'2022-03-23 03:02:03','6666666666','客房编号6','客房类型6',6,'费用描述6','账号6','姓名6','未支付');
/*!40000 ALTER TABLE `feiyongxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `huanfangxinxi`
--

DROP TABLE IF EXISTS `huanfangxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `huanfangxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kefangbianhao` varchar(200) DEFAULT NULL COMMENT '客房编号',
  `kefangleixing` varchar(200) DEFAULT NULL COMMENT '客房类型',
  `huanfangshijian` datetime DEFAULT NULL COMMENT '换房时间',
  `huanfangbianhao` varchar(200) DEFAULT NULL COMMENT '换房编号',
  `huanfangyuanyin` varchar(200) DEFAULT NULL COMMENT '换房原因',
  `zhanghao` varchar(200) DEFAULT NULL COMMENT '账号',
  `xingming` varchar(200) DEFAULT NULL COMMENT '姓名',
  `shouji` varchar(200) DEFAULT NULL COMMENT '手机',
  `sfsh` varchar(200) DEFAULT '否' COMMENT '是否审核',
  `shhf` longtext COMMENT '审核回复',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='换房信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `huanfangxinxi`
--

LOCK TABLES `huanfangxinxi` WRITE;
/*!40000 ALTER TABLE `huanfangxinxi` DISABLE KEYS */;
INSERT INTO `huanfangxinxi` VALUES (51,'2022-03-23 03:02:03','客房编号1','客房类型1','2022-03-23 11:02:03','换房编号1','换房原因1','账号1','姓名1','13823888881','是',''),(52,'2022-03-23 03:02:03','客房编号2','客房类型2','2022-03-23 11:02:03','换房编号2','换房原因2','账号2','姓名2','13823888882','是',''),(53,'2022-03-23 03:02:03','客房编号3','客房类型3','2022-03-23 11:02:03','换房编号3','换房原因3','账号3','姓名3','13823888883','是',''),(54,'2022-03-23 03:02:03','客房编号4','客房类型4','2022-03-23 11:02:03','换房编号4','换房原因4','账号4','姓名4','13823888884','是',''),(55,'2022-03-23 03:02:03','客房编号5','客房类型5','2022-03-23 11:02:03','换房编号5','换房原因5','账号5','姓名5','13823888885','是',''),(56,'2022-03-23 03:02:03','客房编号6','客房类型6','2022-03-23 11:02:03','换房编号6','换房原因6','账号6','姓名6','13823888886','是','');
/*!40000 ALTER TABLE `huanfangxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kefangxinxi`
--

DROP TABLE IF EXISTS `kefangxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kefangxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kefangbianhao` varchar(200) DEFAULT NULL COMMENT '客房编号',
  `kefangleixing` varchar(200) DEFAULT NULL COMMENT '客房类型',
  `kefangweizhi` varchar(200) DEFAULT NULL COMMENT '客房位置',
  `kefangzhuangtai` varchar(200) DEFAULT NULL COMMENT '客房状态',
  `kefangjiage` int(11) DEFAULT NULL COMMENT '客房价格',
  `kefangjieshao` longtext COMMENT '客房介绍',
  `kefangtupian` varchar(200) DEFAULT NULL COMMENT '客房图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='客房信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kefangxinxi`
--

LOCK TABLES `kefangxinxi` WRITE;
/*!40000 ALTER TABLE `kefangxinxi` DISABLE KEYS */;
INSERT INTO `kefangxinxi` VALUES (21,'2022-03-23 03:02:03','客房编号1','客房类型1','客房位置1','可预订',1,'客房介绍1','upload/kefangxinxi_kefangtupian1.jpg'),(22,'2022-03-23 03:02:03','客房编号2','客房类型2','客房位置2','可预订',2,'客房介绍2','upload/kefangxinxi_kefangtupian2.jpg'),(23,'2022-03-23 03:02:03','客房编号3','客房类型3','客房位置3','可预订',3,'客房介绍3','upload/kefangxinxi_kefangtupian3.jpg'),(24,'2022-03-23 03:02:03','客房编号4','客房类型4','客房位置4','可预订',4,'客房介绍4','upload/kefangxinxi_kefangtupian4.jpg'),(25,'2022-03-23 03:02:03','客房编号5','客房类型5','客房位置5','可预订',5,'客房介绍5','upload/kefangxinxi_kefangtupian5.jpg'),(26,'2022-03-23 03:02:03','客房编号6','客房类型6','客房位置6','可预订',6,'客房介绍6','upload/kefangxinxi_kefangtupian6.jpg');
/*!40000 ALTER TABLE `kefangxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tuifangxinxi`
--

DROP TABLE IF EXISTS `tuifangxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tuifangxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kefangbianhao` varchar(200) DEFAULT NULL COMMENT '客房编号',
  `kefangleixing` varchar(200) DEFAULT NULL COMMENT '客房类型',
  `kefangjiage` float DEFAULT NULL COMMENT '客房价格',
  `tuifangshijian` datetime DEFAULT NULL COMMENT '退房时间',
  `tuifangbeizhu` varchar(200) DEFAULT NULL COMMENT '退房备注',
  `zhanghao` varchar(200) DEFAULT NULL COMMENT '账号',
  `xingming` varchar(200) DEFAULT NULL COMMENT '姓名',
  `shouji` varchar(200) DEFAULT NULL COMMENT '手机',
  `sfsh` varchar(200) DEFAULT '否' COMMENT '是否审核',
  `shhf` longtext COMMENT '审核回复',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COMMENT='退房信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tuifangxinxi`
--

LOCK TABLES `tuifangxinxi` WRITE;
/*!40000 ALTER TABLE `tuifangxinxi` DISABLE KEYS */;
INSERT INTO `tuifangxinxi` VALUES (61,'2022-03-23 03:02:03','客房编号1','客房类型1',1,'2022-03-23 11:02:03','退房备注1','账号1','姓名1','13823888881','是',''),(62,'2022-03-23 03:02:03','客房编号2','客房类型2',2,'2022-03-23 11:02:03','退房备注2','账号2','姓名2','13823888882','是',''),(63,'2022-03-23 03:02:03','客房编号3','客房类型3',3,'2022-03-23 11:02:03','退房备注3','账号3','姓名3','13823888883','是',''),(64,'2022-03-23 03:02:03','客房编号4','客房类型4',4,'2022-03-23 11:02:03','退房备注4','账号4','姓名4','13823888884','是',''),(65,'2022-03-23 03:02:03','客房编号5','客房类型5',5,'2022-03-23 11:02:03','退房备注5','账号5','姓名5','13823888885','是',''),(66,'2022-03-23 03:02:03','客房编号6','客房类型6',6,'2022-03-23 11:02:03','退房备注6','账号6','姓名6','13823888886','是','');
/*!40000 ALTER TABLE `tuifangxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `role` varchar(100) DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'abo','abo','管理员','2022-03-23 03:02:03');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xufangxinxi`
--

DROP TABLE IF EXISTS `xufangxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xufangxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kefangbianhao` varchar(200) DEFAULT NULL COMMENT '客房编号',
  `kefangleixing` varchar(200) DEFAULT NULL COMMENT '客房类型',
  `kefangjiage` float DEFAULT NULL COMMENT '客房价格',
  `xuzhushijian` datetime DEFAULT NULL COMMENT '续住时间',
  `xuzhubeizhu` varchar(200) DEFAULT NULL COMMENT '续住备注',
  `zhanghao` varchar(200) DEFAULT NULL COMMENT '账号',
  `xingming` varchar(200) DEFAULT NULL COMMENT '姓名',
  `shouji` varchar(200) DEFAULT NULL COMMENT '手机',
  `sfsh` varchar(200) DEFAULT '否' COMMENT '是否审核',
  `shhf` longtext COMMENT '审核回复',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='续房信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xufangxinxi`
--

LOCK TABLES `xufangxinxi` WRITE;
/*!40000 ALTER TABLE `xufangxinxi` DISABLE KEYS */;
INSERT INTO `xufangxinxi` VALUES (41,'2022-03-23 03:02:03','客房编号1','客房类型1',1,'2022-03-23 11:02:03','续住备注1','账号1','姓名1','13823888881','是',''),(42,'2022-03-23 03:02:03','客房编号2','客房类型2',2,'2022-03-23 11:02:03','续住备注2','账号2','姓名2','13823888882','是',''),(43,'2022-03-23 03:02:03','客房编号3','客房类型3',3,'2022-03-23 11:02:03','续住备注3','账号3','姓名3','13823888883','是',''),(44,'2022-03-23 03:02:03','客房编号4','客房类型4',4,'2022-03-23 11:02:03','续住备注4','账号4','姓名4','13823888884','是',''),(45,'2022-03-23 03:02:03','客房编号5','客房类型5',5,'2022-03-23 11:02:03','续住备注5','账号5','姓名5','13823888885','是',''),(46,'2022-03-23 03:02:03','客房编号6','客房类型6',6,'2022-03-23 11:02:03','续住备注6','账号6','姓名6','13823888886','是','');
/*!40000 ALTER TABLE `xufangxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yonghu`
--

DROP TABLE IF EXISTS `yonghu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yonghu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `zhanghao` varchar(200) NOT NULL COMMENT '账号',
  `mima` varchar(200) NOT NULL COMMENT '密码',
  `xingming` varchar(200) NOT NULL COMMENT '姓名',
  `xingbie` varchar(200) DEFAULT NULL COMMENT '性别',
  `shouji` varchar(200) DEFAULT NULL COMMENT '手机',
  `shenfenzheng` varchar(200) DEFAULT NULL COMMENT '身份证',
  PRIMARY KEY (`id`),
  UNIQUE KEY `zhanghao` (`zhanghao`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yonghu`
--

LOCK TABLES `yonghu` WRITE;
/*!40000 ALTER TABLE `yonghu` DISABLE KEYS */;
INSERT INTO `yonghu` VALUES (11,'2022-03-23 03:02:03','账号1','123456','姓名1','男','13823888881','440300199101010001'),(12,'2022-03-23 03:02:03','账号2','123456','姓名2','男','13823888882','440300199202020002'),(13,'2022-03-23 03:02:03','账号3','123456','姓名3','男','13823888883','440300199303030003'),(14,'2022-03-23 03:02:03','账号4','123456','姓名4','男','13823888884','440300199404040004'),(15,'2022-03-23 03:02:03','账号5','123456','姓名5','男','13823888885','440300199505050005'),(16,'2022-03-23 03:02:03','账号6','123456','姓名6','男','13823888886','440300199606060006');
/*!40000 ALTER TABLE `yonghu` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-25 10:53:00
