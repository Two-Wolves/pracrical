<?php
/**
 * Created by PhpStorm.
 * User: zhangzhe
 * Date: 2018-12-19
 * Time: 13:04
 */

namespace app\admin\controller\member;


use app\common\controller\AdminController;

/**
 *  供应商管理
 */
class Supplier extends AdminController
{
    // 供应商管理
    public function index($name = null){
        dump($name);
    }
    // 供应商添加
    public function add(){
        dump(123);
    }
    // 佣金分类管理
    public function cate($name = null){
        dump($name);
    }
    // 佣金分类添加
    public function cate_add(){
        dump(123);
    }
    // 政策通知管理
    public function message($name = null){
        dump($name);
    }
    // 政策通知管理
    public function message_add(){
        dump(123);
    }
}