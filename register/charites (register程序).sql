-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1:3306
-- 產生時間： 2023-07-14 08:16:49
-- 伺服器版本： 10.4.28-MariaDB
-- PHP 版本： 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `charites`
--

DELIMITER $$
--
-- 程序
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (`myuid` VARCHAR(20), `mypwd` VARCHAR(20))   BEGIN
 DECLARE n int DEFAULT 0;
        DECLARE mytoken varchar(40) DEFAULT uuid();
    SELECT COUNT(*)INTO n FROM userinfo WHERE uid=myuid and pwd = mypwd;
    IF n=1 THEN
        update userinfo set token=mytoken where uid =myuid;
     SELECT 'welcome.php' as result,mytoken as token;
    else 
     SELECT 'error.html' as result,null as token;
      
    END IF ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `logout` (`mytoken` VARCHAR(40))   BEGIN 
 UPDATE userinfo set token=null WHERE token=mytoken;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register` (`myuid` VARCHAR(50), `mycname` VARCHAR(50), `mypwd` VARCHAR(50), `myphone` VARCHAR(20), `myemail` VARCHAR(70), `mygender` VARCHAR(20))   BEGIN
   
    IF EXISTS (SELECT phone FROM UserInfo WHERE phone = myphone) THEN
         SELECT '註冊失敗，手機號碼已綁定' AS result;
    ELSE
        -- 新增一筆資料到userinfo
        INSERT into UserInfo (uid,cname, pwd, phone, email, gender) VALUES (myuid,mycname, mypwd, myphone, myemail, mygender);
        -- 在这里执行插入或其他操作，表示 uid 不存在的情况
       	SELECT '成功註冊' AS result;
       
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uidregister` (`myuid` VARCHAR(50))   BEGIN
    DECLARE uid_count INT;
    
    -- 查询符合条件的记录数量
    SELECT COUNT(*) INTO uid_count FROM UserInfo WHERE uid = myuid;
    
    -- 判断 uid_count 的值
    IF uid_count > 0 THEN
        SELECT 'UID存在' AS result;
    ELSE
        -- 在这里执行插入或其他操作，表示 uid 不存在的情况
        SELECT '成功註冊' AS result;
    END IF;
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 資料表結構 `userinfo`
--

CREATE TABLE `userinfo` (
  `uid` varchar(50) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `cname` varchar(50) NOT NULL,
  `pwd` varchar(50) NOT NULL,
  `image` mediumblob DEFAULT NULL,
  `email` varchar(70) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `token` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `userinfo`
--

INSERT INTO `userinfo` (`uid`, `gender`, `cname`, `pwd`, `image`, `email`, `phone`, `address`, `token`) VALUES
('A01', 'male', '王大明', '1234', NULL, 'wangdaming01@example.com', '1111', '台北市中山路一段一號', '49b70741-21ea-11ee-a195-e03f4948e305'),
('A02', 'female', 'Amy', '4567', NULL, 'amy002@example.com', '2222', '台中市一中街2號', ''),
('Z01', 'female', '朱小梅', '1234', NULL, NULL, NULL, NULL, '');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `userinfo`
--
ALTER TABLE `userinfo`
  ADD PRIMARY KEY (`uid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
