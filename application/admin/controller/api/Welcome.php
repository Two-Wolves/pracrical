<?php

namespace app\admin\controller\api;


use app\common\controller\AdminController;

/**
 * 欢迎页接口
 * Class Welcome
 * @package app\admin\controller\api
 */
class Welcome extends AdminController {

    /**
     * 获取文章分类信息
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function article_census() {
        $data = [];
        $category_list = \app\admin\model\article\Category::getCategoryList();
        foreach ($category_list as $vo) {
            $data['category'][] = $vo['title'];
            $data['categoryData'][] = [
                'value' => \app\admin\model\article\Article::articleCount($vo['id']),
                'name'  => $vo['title'],
            ];
        }
        if (empty($data)) {
            return __error('无数据');
        } else {
            return __success('获取成功', $data);
        }
    }
}