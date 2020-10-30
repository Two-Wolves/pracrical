<?php

namespace app\admin\model\article;


use app\common\service\ModelService;

/**
 * 搜索记录模型
 * Class SearchRecord
 * @package app\admin\model\article
 */
class SearchRecord extends ModelService {

    /**
     * 绑定数据表
     * @var string
     */
    protected $table = 'yt_search_record';

    /**
     * 获取列表数据
     * @param int   $page
     * @param int   $limit
     * @param array $search
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public static function getList($page = 1, $limit = 10, $search = []) {
        $where = [];

        //搜索条件
        foreach ($search as $key => $value) {
            if (!empty($value)) {
                switch ($key) {
                    case 'type':
                        $where[] = [$key, '=', $value];
                        break;
                    case 'create_at':
                        $value_list = explode(" - ", $value);
                        $where[] = [$key, 'BETWEEN', ["{$value_list[0]} 00:00:00", "{$value_list[1]} 23:59:59"]];
                        break;
                    default:
                        !empty($value) && $where[] = [$key, 'LIKE', '%' . $value . '%'];
                }
            }
        }

        $count = self::where($where)->count();
        $data = self::where($where)->page($page, $limit)->order(['create_at' => 'desc'])->select();
        empty($data) ? $msg = '暂无数据！' : $msg = '查询成功！';
        $info = [
            'limit'        => $limit,
            'page_current' => $page,
            'page_sum'     => ceil($count / $limit),
        ];
        $list = [
            'code'  => 0,
            'msg'   => $msg,
            'count' => $count,
            'info'  => $info,
            'data'  => $data,
        ];
        return $list;
    }
}