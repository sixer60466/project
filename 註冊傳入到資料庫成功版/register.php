<?php
#1.獲取請求提交前端的資料，傳入到伺服器
$uid = $_REQUEST['uid'];
$cname = $_REQUEST['cname'];
$upwd = $_REQUEST['upwd'];
$phone = $_REQUEST['phone'];
$gender = $_REQUEST['gender'];
$email = $_REQUEST['email'];

#2.連線到資料庫
require("db.php");


#3.拼sql語句並執行
// $sql="insert into userinfo(uid,gender,cname,pwd,phone,email)values('$uid','$gender','$cname','$pwd','$phone','$email')";
$sql = "call register(?,?,?,?,?,?)";
$stmt = $mysqli->prepare($sql);
$stmt->bind_param('ssssss', $uid, $cname, $upwd, $phone, $email, $gender);
$stmt->execute();
$stmt->bind_result($result);
$stmt->fetch();
$stmt->close();

//執行sql語句，成功就導回到首頁
#4.根據執行結果給出響應
if ($result == '註冊失敗，手機號碼已綁定') {
    echo '( 註冊失敗，手機號碼已綁定其他帳號 )';
} 
else if ($result == '成功註冊') {
    header('Location: login.php');
    exit();
}
