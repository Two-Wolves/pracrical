<?php
/**
 * Created by PhpStorm.
 * User: zhangzhe
 * Date: 2018-12-19
 * Time: 12:00
 */

namespace app\admin\controller\member;


use app\common\controller\AdminController;

/**
 *  邮件订阅管理
 */
class Email extends AdminController
{
    // 邮件订阅会员
    public function index($type = null){
        if ($type != null) {
            dump($type);
        } else {
            echo 'all';
        }
    }
    // 发送订阅邮件
    public function send(){
        dump(123);
    }
}