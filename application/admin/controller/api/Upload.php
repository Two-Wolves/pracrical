<?php

namespace app\admin\controller\api;


use app\common\controller\AdminController;
use app\common\service\QiniuService;
use think\Db;

/**
 * 后台上传通用接口
 * Class Upload
 * @package app\admin\controller\api
 */
class Upload extends AdminController {

    /**
     * 编辑器多图片上传
     * @return \think\response\Json
     */
    public function image() {
        $files = request()->file();
        if (is_array($files)) {
            foreach ($files as $vo) {
                $info = $vo->move('../public/static/uploads');
                if ($info) {
                    $url[] = '/static/uploads/' . date('Ymd') . '/' . $info->getFilename();
                } else {
                    return json(['code' => 1, 'msg' => $vo->getError()]);
                }
            }
        } else {
            $info = $files->move('../public/static/uploads');
            if ($info) {
                $url[] = '/static/uploads/' . date('Ymd') . '/' . $info->getFilename();
            } else {
                return json(['code' => 1, 'msg' => $files->getError()]);
            }
        }
        //判断是否使用七牛云上传
        $file_type = Db::name('SystemConfig')->where(['name' => 'FileType', 'group' => 'file'])->value('value');
        if ($file_type == 2) {
            foreach ($url as &$vo) {
                $vo = QiniuService::upload($vo);
            }
        }
        return json(['code' => 0, 'msg' => '上传成功！', 'url' => $url]);
    }

}