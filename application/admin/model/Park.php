<?php

namespace app\admin\model;

use app\common\service\ModelService;

class Park extends ModelService
{
    // 表名
    protected $table = 'park';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    
    // 追加属性
    protected $append = [];

    /**
     * 获取Park列表数据
     * @param int   $page
     * @param int   $limit
     * @param array $search
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public static function getParkList($page = 1, $limit = 10, $search = []) {
        $where = [['is_deleted', '=', 0]];

        //搜索条件
        foreach ($search as $key => $value) {
            if (!empty($value)) {
                switch ($key) {
                    case 'name':
                        $where[] = [$key, 'LIKE', '%' . $value . '%'];
                        break;
                    case 'createtime':
                        $value_list = explode(" - ", $value);
                        $where[] = [$key, 'BETWEEN', ["{$value_list[0]} 00:00:00", "{$value_list[1]} 23:59:59"]];
                        break;
                    default:
                        !empty($value) && $where[] = [$key, 'LIKE', '%' . $value . '%'];
                }
            }
        }

        $count = self::where($where)->count();
        $data = self::where($where)->page($page, $limit)->order(['id' => 'desc'])->select();
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

    public function getParkIdList()
    {
        if(cache('park')){
            return cache('park');
        }else{
            $park =  self::where(array('status'=>1,'is_deleted'=>0))->column('id,name');
            cache('park',$park);
            return $park;
        }
    }
}
