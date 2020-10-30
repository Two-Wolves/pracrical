<?php
/**
 * Created by PhpStorm.
 * User: zhangzhe
 * Date: 2018-12-19
 * Time: 11:50
 */

namespace app\admin\controller\member;


use app\common\controller\AdminController;

/**
 *  会员留言管理
 */
class Feedback extends AdminController
{
    public function index($type = null){
        if ($type != null) {
            dump($type);
        } else {
            echo 'all';
        }
    }
}