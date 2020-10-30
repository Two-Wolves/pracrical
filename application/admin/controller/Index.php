<?php

namespace app\admin\controller;


use app\common\controller\AdminController;
use think\facade\Cache;

class Index extends AdminController {

    protected $selectpageSuffix = ['_id', '_ids'];
    /**
     * 首页
     * @return mixed
     */
    public function index() {
        Cache::remember('Home', function () {
            return model('menu')->getHome();
        });
        $sys_info = Cache::get('SysInfo');
        $basic_data = [
            'title' => $sys_info['ManageName'],
            'nav'   => model('menu')->getNav(),
            'home'  => Cache::get('Home'),
            'data'  => '',
        ];
        return $this->fetch('', $basic_data);
    }

    /**
     * 首页欢迎界面
     * @return mixed
     */
    public function welcome() {

        $basic_data = [
            'quick_nav' => \app\admin\model\Nav::getQuickNav(),
        ];
        return $this->fetch('', $basic_data);
    }
}