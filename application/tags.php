<?php
use think\exception\HttpResponseException;

use think\facade\Cache;
use think\facade\Config;

// 应用行为扩展定义文件
return [
    // 应用初始化
    'app_init'     => [],
    // 应用开始
    'app_begin'    => function () {
        if (app('request')->module() != 'install') {
            //缓存系统配置信息
            Cache::tag('basic')->remember('SysInfo', function () {
                $SysInfo = new \app\admin\model\Config;
                return $SysInfo->getBasicConfig();
            });
            //缓存系统配置信息
            Cache::tag('index_basic')->remember('IndexInfo', function () {
                $IndexInfo = new \app\index\model\Config;
                return $IndexInfo->getIndexConfig();
            });
            //渲染到视图层
            app('view')->init(config('template.'))->assign([
                'SysInfo'   => Cache::get('SysInfo'),
                'IndexInfo'  => Cache::get('IndexInfo'),
                'is_mobile' => is_mobile(),
                'website'   => [
                    'index'    => Config::get('website.index'),
                ],
            ]);
        }
    },
    // 模块初始化
    'module_init'  => [],
    // 操作开始执行
    'action_begin' => function () {
        //声明模板常量，保证在修改后台模块名的时候可以正常访问
        list($thisModule, $thisController, $thisAction) = [app('request')->module(), app('request')->controller(), app('request')->action()];
        $thisClass = parseNodeStr("{$thisModule}/{$thisController}");
        $thisRequest = parseNodeStr("{$thisModule}/{$thisController}/{$thisAction}");
        app('view')->init(config('template.'))->assign([
            'thisModule'     => $thisModule,
            'thisController' => $thisController,
            'thisClass'      => $thisClass,
            'thisRequest'    => $thisRequest,
        ]);
    },
    // 视图内容过滤
    'view_filter'  => [],
    // 日志写入
    'log_write'    => [],
    // 应用结束
    'app_end'      => [],
];
