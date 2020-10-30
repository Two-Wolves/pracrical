<?php
namespace app\index\controller;
use app\common\controller\IndexController;

/**
 * Created by PhpStorm.
 * User: liuqiang
 * Date: 2018/12/6
 * Time: 11:24 PM
 */
class Index extends IndexController
{
    public function index()
    {
        return $this->fetch();
    }

}