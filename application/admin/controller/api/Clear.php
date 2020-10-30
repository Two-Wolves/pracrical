<?php
namespace app\admin\controller\api;

use app\common\controller\AdminController;

class Clear extends AdminController {

    /**
     * 后台刷新缓存接口
     * @return \think\response\Json
     */
    public function clearCache() {
        if (app('cache')->clear()) {
            return __success('缓存刷新成功！');
        } else {
            return __error('缓存刷新失败！');
        }
    }
}