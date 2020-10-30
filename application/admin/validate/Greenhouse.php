<?php

namespace app\admin\validate;

use think\Validate;

class Greenhouse extends Validate
{
    /**
     * 验证规则
     */
    protected $rule = [
        'id' => 'require',
        'name' => 'require'
    ];
    /**
     * 提示消息
     */
    protected $message = [
        'id.require' => '参数错误',
        'name.require' => '大棚名不得为空'
    ];
    /**
     * 验证场景
     */
    protected $scene = [
        'add'  => ['name'],
        'edit' => ['name'],
        'del'  => ['id'],
    ];
    
}
