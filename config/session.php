<?php

// +----------------------------------------------------------------------
// | 会话设置
// +----------------------------------------------------------------------

return [

    //使用服务器保存session
    'type'           => '',

    //使用redis保存session
//    'type'     => 'redis',
//    'host'     => '127.0.0.1',
//    'port'     => 6379,
//    'password' => '',

    //session有效期为24小时
    'expire'         => 86400,
    'prefix'         => 'ytwlSystemForOa_session_',
    'auto_start'     => true,

];
