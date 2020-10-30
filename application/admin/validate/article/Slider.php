<?php

namespace app\admin\validate\article;


use think\Validate;

class Slider extends Validate {

    /**
     * 验证规则
     * @var array
     */
    protected $rule = [
        'id'     => 'require|number|checkId',
        'image'  => 'require',
        'title'  => 'require|max:20',
        'remark' => 'max:250',
    ];

    /**
     * 错误提示
     * @var array
     */
    protected $message = [
        'id.require'    => '编号必须',
        'title.require' => '名称必须',
        'title.max'     => '名称最多不能超过20个字符',
        'remark.max'    => '备注最多不能超过250个字符',
    ];

    /**
     * 验证场景
     * @var array
     */
    protected $scene = [
        //添加
        'add'    => ['title', 'image', 'remark'],

        //编辑
        'edit'   => ['id', 'image', 'title', 'remark'],

        //删除
        'del'    => ['id'],

        //更改状态
        'status' => ['id'],
    ];

    /**
     * 判断ID是否存在
     * @param       $value
     * @param       $rule
     * @param array $data
     * @return bool|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    protected function checkId($value, $rule, $data = []) {
        $where = [
            ['id', '=', $value],
        ];
        $member = \app\admin\model\article\Slider::where($where)->find();
        if (empty($member)) return '分类信息不存在！';
        return true;
    }

}