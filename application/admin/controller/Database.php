<?php

namespace app\admin\controller;

use app\common\controller\AdminController;
use think\Db;
use think\Debug;

/**
 * 数据库管理
 *
 * @icon fa fa-database
 * @remark 可在线进行一些简单的数据库表优化或修复,查看表结构和数据。也可以进行SQL语句的操作
 */
class Database extends AdminController
{

    /**
     * 查看
     */
    function index()
    {
        $tables_data_length = $tables_index_length = $tables_free_length = $tables_data_count = 0;
        $tables = $list = [];
        $list = Db::query("SHOW TABLES");
        foreach ($list as $key => $row)
        {
            $tables[] = ['name' => reset($row), 'rows' => 0];
        }
        $data['tables'] = $tables;
        $data['saved_sql'] = [];
        $this->view->assign($data);
        return $this->view->fetch();
    }

    /**
     * SQL查询
     */
    public function query()
    {
        $do_action = $this->request->post('do_action');

        echo '<style type="text/css">
            xmp,body{margin:0;padding:0;line-height:18px;font-size:12px;font-family:"Helvetica Neue", Helvetica, Microsoft Yahei, Hiragino Sans GB, WenQuanYi Micro Hei, sans-serif;}
            hr{height:1px;margin:5px 1px;background:#e3e3e3;border:none;}
            </style>';
        if ($do_action == '')
            exit(__('Invalid parameters'));

        $tablename = $this->request->post("tablename/a");

        if (in_array($do_action, array('doquery', 'optimizeall', 'repairall')))
        {
            $this->$do_action();
        }
        else if (count($tablename) == 0)
        {
            exit(__('Invalid parameters'));
        }
        else
        {
            foreach ($tablename as $table)
            {
                $this->$do_action($table);
                echo "<br />";
            }
        }
    }

    private function viewinfo($name)
    {
        $row = Db::query("SHOW CREATE TABLE `{$name}`");
        $row = array_values($row[0]);
        $info = $row[1];
        echo "<xmp>{$info};</xmp>";
    }

    private function viewdata($name = '')
    {
        $sqlquery = "SELECT * FROM `{$name}`";
        $this->doquery($sqlquery);
    }

    private function optimize($name = '')
    {
        if (Db::execute("OPTIMIZE TABLE `{$name}`"))
        {
            echo __('Optimize table %s done', $name);
        }
        else
        {
            echo __('Optimize table %s fail', $name);
        }
    }

    private function optimizeall($name = '')
    {
        $list = Db::query("SHOW TABLES");
        foreach ($list as $key => $row)
        {
            $name = reset($row);
            if (Db::execute("OPTIMIZE TABLE {$name}"))
            {
                echo __('Optimize table %s done', $name);
            }
            else
            {
                echo __('Optimize table %s fail', $name);
            }
            echo "<br />";
        }
    }

    private function repair($name = '')
    {
        if (Db::execute("REPAIR TABLE `{$name}`"))
        {
            echo __('Repair table %s done', $name);
        }
        else
        {
            echo __('Repair table %s fail', $name);
        }
    }

    private function repairall($name = '')
    {
        $list = Db::query("SHOW TABLES");
        foreach ($list as $key => $row)
        {
            $name = reset($row);
            if (Db::execute("REPAIR TABLE {$name}"))
            {
                echo __('Repair table %s done', $name);
            }
            else
            {
                echo __('Repair table %s fail', $name);
            }
            echo "<br />";
        }
    }

    private function doquery($sql = null)
    {
        $sqlquery = $sql ? $sql : $this->request->post('sqlquery');
        if ($sqlquery == '')
            exit(__('SQL can not be empty'));
        $sqlquery = str_replace("\r", "", $sqlquery);
        $sqls = preg_split("/;[ \t]{0,}\n/i", $sqlquery);
        $maxreturn = 100;
        $r = '';
        foreach ($sqls as $key => $val)
        {
            if (trim($val) == '')
                continue;
            $val = rtrim($val, ';');
            $r .= "SQL：<span style='color:green;'>{$val}</span> ";
            if (preg_match("/^(select|explain)(.*)/i ", $val))
            {
//                Debug::remark("begin");
                $limit = stripos(strtolower($val), "limit") !== false ? true : false;
                $count = Db::execute($val);
                if ($count > 0)
                {
                    $resultlist = Db::query($val . (!$limit && $count > $maxreturn ? ' LIMIT ' . $maxreturn : ''));
                }
                else
                {
                    $resultlist = [];
                }
//                Debug::remark("end");
//                $time = Debug::getRangeTime('begin', 'end', 4);

                $usedseconds = __('Query took %s seconds', '') . "<br />";
                if ($count <= 0)
                {
                    $r .= __('Query returned an empty result');
                }
                else
                {
                    $r .= (__('Total:%s', $count) . (!$limit && $count > $maxreturn ? ',' . __('Max output:%s', $maxreturn) : ""));
                }
                $r = $r . ',' . $usedseconds;
                $j = 0;
                $r = '<table border="1" cellspacing="0" cellpadding="0" style="width:100%;">';
                foreach ($resultlist as $m => $n)
                {
                    if ($m == 0) {
                        $r .= "<tr>";
                        foreach ($n as $k => $v)
                        {
                            $r .= "<th>{$k}</th>";
                        }
                        $r .= "</tr>";
                    }
                    $r .= "<tr>";
                    foreach ($n as $k => $v)
                    {
                        $r .= "<td>{$v}</td>";
                    }
                    $r .= "</tr>";
                }
                $r .= "</table>";
            }
            else
            {
//                Debug::remark("begin");
                $count = Db::execute($val);
//                Debug::remark("end");
//                $time = Debug::getRangeTime('begin', 'end', 4);
                $r .= __('Query affected %s rows and took %s seconds', $count, '') . "<br />";
            }
        }
        echo $r;
    }

    /**
     * 数据库备份与恢复列表
     * @param null $type 类型
     * @return mixed|void
     * @throws \ErrorException
     * @throws \think\exception\PDOException
     */
    public function indexs($type = null) {
        switch ($type) {
            /* 数据还原 */
            case 'import':
                //列出备份文件列表
                $path = Db::table('system_config')->where(array('name'=>'DataBack'))->value('value');
                if (!is_dir($path)) {
                    mkdir($path, 0755, true);
                }
                $path = realpath($path);
                $flag = \FilesystemIterator::KEY_AS_FILENAME;
                $glob = new \FilesystemIterator($path, $flag);

                $list = array();
                foreach ($glob as $name => $file) {
                    if (preg_match('/^\d{8,8}-\d{6,6}-\d+\.sql(?:\.gz)?$/', $name)) {
                        $name = sscanf($name, '%4s%2s%2s-%2s%2s%2s-%d');

                        $date = "{$name[0]}-{$name[1]}-{$name[2]}";
                        $time = "{$name[3]}:{$name[4]}:{$name[5]}";
                        $part = $name[6];

                        if (isset($list["{$date} {$time}"])) {
                            $info         = $list["{$date} {$time}"];
                            $info['part'] = max($info['part'], $part);
                            $info['size'] = $info['size'] + $file->getSize();
                        } else {
                            $info['part'] = $part;
                            $info['size'] = $file->getSize();
                        }
                        $extension        = strtoupper(pathinfo($file->getFilename(), PATHINFO_EXTENSION));
                        $info['compress'] = ($extension === 'SQL') ? '-' : $extension;
                        $info['time']     = strtotime("{$date} {$time}");

                        $list["{$date} {$time}"] = $info;
                    }
                }
                break;
            /* 数据备份 */
            case 'export':
                $Db    = \think\Db::connect();
                $list  = $Db->query('SHOW TABLE STATUS');
                $list  = array_map('array_change_key_case', $list);
                break;
            default:
                return $this->error('参数错误！');
        }
        //渲染模板
        $this->assign('list', $list);
        return $this->fetch($type);
    }
    /**
     * 删除备份文件
     * @param  Integer $time 备份时间
     */
    public function del($time = 0) {
        $url = $this->request->get('url', 'general/database');
        if ($time) {
            $name = date('Ymd-His', $time) . '-*.sql*';
            $path = realpath(model('config')->where(array('name'=>'DataBack'))->value('value')) . DIRECTORY_SEPARATOR . $name;
            array_map("unlink", glob($path));
            if (count(glob($path))) {
                $this->error(__("备份文件删除失败，请检查权限！"), $url);
                return;
            } else {
                $this->success(__("备份文件删除成功！"), $url);
                return;
            }
        } else {
            $this->error(__("参数错误！"), $url);
            return;
        }
    }
    /**
     * 备份数据库
     * @param  String  $tables 表名
     * @param  Integer $id     表ID
     * @param  Integer $start  起始行数
     */
    public function export($tables = null, $id = null, $start = null) {
        $url = $this->request->get('url', 'general/database');
        if (!empty($tables) && is_array($tables)) {
            //初始化
            $path = Db::table('system_config')->where(array('name'=>'DataBack'))->value('value');
            if (!is_dir($path)) {
                mkdir($path, 0755, true);
            }
            //读取备份配置
            $config = array('path' => realpath($path) . DIRECTORY_SEPARATOR,  'part' => 20971520, 'compress' => 1, 'level' => 9);
            //检查是否有正在执行的任务
            $lock = "{$config['path']}backup.lock";
            if (is_file($lock)) {
                $this->error(__("检测到有一个备份任务正在执行，请稍后再试！"), $url);
                return;
            } else {
                //创建锁文件
                file_put_contents($lock, time());
            }
            //检查备份目录是否可写
            if (!is_writeable($config['path'])) {
                $this->error(__("备份目录不存在或不可写，请检查后重试！"), $url);
                return;
            }
            session('backup_config', $config);
            //生成备份文件信息
            $file = array('name' => date('Ymd-His', time()), 'part' => 1);
            session('backup_file', $file);
            //缓存要备份的表
            session('backup_tables', $tables);
            //创建备份文件

            $Database = new \think\db\Database($file, $config);
            if (false !== $Database->create()) {
                $tab = array('id' => 0, 'start' => 0);
                $this->success(__("初始化成功！"), '',array('tables' => $tables, 'tab' => $tab));
                return;
            } else {
                $this->error(__("初始化失败，备份文件创建失败！"), $url);
                return;
            }
        } elseif (is_numeric($id) && is_numeric($start)) {
            //备份数据
            $tables = session('backup_tables');
            //备份指定表
            $Database = new \think\db\Database(session('backup_file'), session('backup_config'));
            $start    = $Database->backup($tables[$id], $start);
            if (false === $start) {
                //出错
                $this->error(__("备份出错！"), $url);
                return;
            } elseif (0 === $start) {
                //下一表
                if (isset($tables[++$id])) {
                    $tab = array('id' => $id, 'start' => 0);
                    $this->success(__("备份完成！"),  '', array('tab' => $tab));
                    return;
                } else {
                    //备份完成，清空缓存
                    unlink(session('backup_config.path') . 'backup.lock');
                    session('backup_tables', null);
                    session('backup_file', null);
                    session('backup_config', null);
                    $this->success(__("备份完成！"));
                    return;
                }
            } else {
                $tab  = array('id' => $id, 'start' => $start[0]);
                $rate = floor(100 * ($start[0] / $start[1]));
                $this->success(__("正在备份...({$rate}%)"), '', array('tab' => $tab));
                return;
            }
        } else {
            //出错
            $this->error('参数错误！');
            return;
        }
    }
    /**
     * 还原数据库
     */
    public function import($time = 0, $part = null, $start = null) {
        if (is_numeric($time) && is_null($part) && is_null($start)) {
            //初始化
            //获取备份文件信息
            $name  = date('Ymd-His', $time) . '-*.sql*';
            $path = Db::table('system_config')->where(array('name'=>'DataBack'))->value('value') . DIRECTORY_SEPARATOR . $name;
            $files = glob($path);
            $list  = array();
            foreach ($files as $name) {
                $basename        = basename($name);
                $match           = sscanf($basename, '%4s%2s%2s-%2s%2s%2s-%d');
                $gz              = preg_match('/^\d{8,8}-\d{6,6}-\d+\.sql.gz$/', $basename);
                $list[$match[6]] = array($match[6], $name, $gz);
            }
            ksort($list);
            //检测文件正确性
            $last = end($list);
            if (count($list) === $last[0]) {
                session('backup_list', $list); //缓存备份列表
                $this->success(__("初始化完成!"), '', array('part' => 1, 'start' => 0));
                return;
            } else {
                $this->error('备份文件可能已经损坏，请检查！');
                return;
            }
        } elseif (is_numeric($part) && is_numeric($start)) {
            $list = session('backup_list');

            $db = new \think\db\Database($list[$part], array('path' => realpath(config('data_backup_path')) . DIRECTORY_SEPARATOR, 'compress' => $list[$part][2]));

            $start = $db->import($start);

            if (false === $start) {
                $this->error('还原数据出错！');
                return;
            } elseif (0 === $start) {
                //下一卷
                if (isset($list[++$part])) {
                    $data = array('part' => $part, 'start' => 0);
                    $this->success("正在还原...#{$part}", '', $data);
                    return;
                } else {
                    session('backup_list', null);
                    $this->success('还原完成！');
                    return;
                }
            } else {
                $data = array('part' => $part, 'start' => $start[0]);
                if ($start[1]) {
                    $rate = floor(100 * ($start[0] / $start[1]));
                    $this->success("正在还原...#{$part} ({$rate}%)", '', $data);
                    return;
                } else {
                    $data['gz'] = 1;
                    $this->success("正在还原...#{$part}", '', $data);
                    return;
                }
            }
        } else {
            $this->error('参数错误！');
            return;
        }
    }

}
