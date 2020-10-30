<?php

// [ 应用入口文件 ]
namespace think;

// 加载基础文件
require __DIR__ . '/../thinkphp/base.php';

//判断应用是否已安装
if (file_exists('../config/lock/install.lock') == false) {
    header("location:./install.php");
    exit;
}

// 执行应用并响应
Container::get('app')->run()->send();
