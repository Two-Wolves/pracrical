<?php
/**
 * Created by PhpStorm.
 * User: zhangzhe
 * Date: 2018-12-19
 * Time: 11:14
 */
namespace app\admin\controller\member;

use app\common\controller\AdminController;


/**
 *  会员管理
 */
class Userlist extends AdminController
{
    // 会员
    public function index($type = null)
    {
        if ($type != null) {
            dump($type);
        } else {
            echo 'all';
        }
    }
    // 会员积分明细
    public function coin($name = null){
        dump($name);
    }
    // 会员积分处理
    public function coin_process(){
        dump(123);
    }
    // 会员等级管理
    public function grade(){
        dump(123);
    }
    // 虚拟账户明细
    public function account(){
        dump(123);
    }
    // 虚拟账户处理
    public function account_process(){
        dump(123);
    }
    // 修改密码
    public function change_password(){
        dump(123);
    }
}