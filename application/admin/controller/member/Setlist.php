<?php
/**
 * Created by PhpStorm.
 * User: zhangzhe
 * Date: 2018-12-19
 * Time: 13:15
 */

namespace app\admin\controller\member;


use app\common\controller\AdminController;

/**
 *  对账单管理
 */
class Setlist extends AdminController
{
    public function index($status = null){
        if ($status != null) {
            dump($status);
        } else {
            echo 'all';
        }
    }
}