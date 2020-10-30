<?php

namespace app\admin\controller;

use app\common\controller\AdminController;

use think\Exception;
use think\Controller;
use think\Request;

/**
 * 大棚管理
 */
class Greenhouse extends AdminController
{
    
    /**
     * Greenhouse模型对象
     */
    protected $model = null;

    public function __construct() {
        parent::__construct();
        $this->model = model('Greenhouse');
        $this->view->assign("parkIdList", model('Park')->getParkIdList());
    }
    
    /**
     * 查看
     */
    public function index()
    {
        $park_id = $this->request->get('id', '');
        if ($park_id == '') {
            throw new Exception("查不到所属园区", 502);
        }
        if ($this->request->get('type') == 'ajax') {
            $page = $this->request->get('page', 1);
            $limit = $this->request->get('limit', 10);
            $search = (array)$this->request->get('search', []);
            $search['park_id'] = $park_id;
            return json($this->model->getGreenhouseList($page, $limit, $search));
        }
        $basic_data = [
            'title' => '大棚管理',
            'data'  => '',
            'id' => $park_id,
        ];
        return $this->fetch('', $basic_data);
    }

    /**
     * 添加
     * @return mixed
     */
    public function add() {
        if (!$this->request->isPost()) {
            $basic_data = [
                'title' => '添加大棚信息',
                'park_id' => $this->request->get('park_id'),
            ];
            return $this->fetch('add', $basic_data);
        } else {
            $post = $this->request->post();

            //验证数据
            $validate = $this->validate($post, 'app\admin\validate\Greenhouse.add');
            if (true !== $validate) return __error($validate);

            //保存数据,返回结果
            return $this->model->addData($post);
        }
    }

    /**
     * 修改
     * @return mixed|string|\think\response\Json
     */
    public function edit() {
        if (!$this->request->isPost()) {

            //查找所需修改的大棚管理
            $data = $this->model->where('id', $this->request->get('id'))->find();
            if (empty($data)) return msg_error('暂无数据，请重新刷新页面！');

            //基础数据
            $basic_data = [
                'title'    => '修改大棚信息',
                'info' => $data,
            ];
            return $this->fetch('edit', $basic_data);
        } else {
            $post = $this->request->post();

            //验证数据
            $validate = $this->validate($post, 'app\admin\validate\Greenhouse.edit');
            if (true !== $validate) return __error($validate);

            //保存数据,返回结果
            return $this->model->editData($post);
        }
    }

    /**
     * 删除
     * @return \think\response\Json
     */
    public function del() {
        $get = $this->request->get();

        //验证数据
        if (!is_array($get['id'])) {
            $validate = $this->validate($get, 'app\admin\validate\Greenhouse.del');
            if (true !== $validate) return __error($validate);
        }

        //执行删除操作
        return $this->model->delData($get['id']);
    }

    /**
     * 更改状态
     * @return \think\response\Json
     */
    public function status() {
        $get = $this->request->get();

        //验证数据
        $validate = $this->validate($get, 'app\admin\validate\Greenhouse.status');
        if (true !== $validate) return __error($validate);

        //判断状态
        $status = $this->model->where('id', $get['id'])->value('status');
        $status == 1 ? list($msg, $status) = ['禁用成功', $status = 0] : list($msg, $status) = ['启用成功', $status = 1];

        //执行更新操作操作
        $update = $this->model->where('id', $get['id'])->update(['status' => $status]);

        if ($update >= 1) return __success($msg);
        return __error('数据有误，请刷新重试！');
    }

}
