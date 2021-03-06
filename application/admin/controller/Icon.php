<?php

namespace app\admin\controller;


use app\common\controller\AdminController;

/**
 * 图标管理
 * Class Icon
 * @package app\admin\controller
 */
class Icon extends AdminController {

    /**
     * 图标列表
     */
    public function index() {
        
        $basic_data = [
            'title' => '图标列表',
        ];
        return $this->fetch('', $basic_data);
    }

    public function fa(){
        $basic_data = [
            'title' => 'fa图标列表',
        ];
        return $this->fetch('', $basic_data);
    }
}