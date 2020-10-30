<?php
namespace app\admin\controller\api;

use app\common\controller\AdminController;
use think\facade\Cache;

class Menu extends AdminController {

    /**
     * 根据权限规则生成菜单栏数据
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function getMenu() {
        if (!empty(Cache::tag('menu')->get(session('user.id') . '_AdminMenu'))) {
            return json(Cache::get(session('user.id') . '_AdminMenu'));
        } else {
            $menu_list = \app\admin\model\Menu::getMenuApi();
            Cache::tag('menu')->set(session('user.id') . '_AdminMenu', $menu_list, 86400);
            return json($menu_list);
        }
    }
}