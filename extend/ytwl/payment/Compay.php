<?php
/**
 * 微信企业付款接口
 * @author jorsh20160108
 */
namespace ytwl\payment;
use Think\Controller;
class Compay extends Controller {
 
    protected $payurl = 'https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers';
    protected $appid = 'wx7cc9a68xxxxxxxxx'; //appid
    protected $mchid = '137xxxxxxxxx';
    protected $signkey ='68nsX1NqtoB50Jxxxxxxxxxxxxxxxxxxxxxxxxxxx';//支付密钥
    
    //这里的路径很重要  一定要写相对路径
    protected $cacab =  array(
        'api_cert'=>'./cert_com/apiclient_cert.pem',	
        'api_key'=>'./cert_com/apiclient_key.pem',
        'api_ca'=>'./cert_com/rootca.pem',
    );
    //$data 要传递的参数， $wxchat微信企业支付等信息 
    /** $data 格式如下
     *  $data = array(
            'userid' //申请退款者ID
            'openid' //退款者openid
            'refundid' //退款申请ID
            'money' //退款金额
            'desc'  //退款描述
        );
     *
     */
    public function wxbuild($data, $wxchat){
        //判断有没有CA证书及支付信息
        if(empty($wxchat['api_cert']) || empty($wxchat['api_key']) || empty($wxchat['api_ca']) || empty($wxchat['appid']) || empty($wxchat['mchid'])){
            $wxchat['appid'] = $this->appid;
            $wxchat['mchid'] = $this->mchid;
            $wxchat['api_cert'] = $this->cacab['api_cert'];
            $wxchat['api_key'] = $this->cacab['api_key'];
            $wxchat['api_ca'] = $this->cacab['api_ca'];
        }
        $webdata = array(
            'mch_appid' => $wxchat['appid'],
            'mchid'     => $wxchat['mchid'],
            'nonce_str' => md5(time()),
            //'device_info' => '1000',
            'partner_trade_no'  => $data['userid'].'_'.$data['refundid'].'_'.$data['money'], //商户订单号，需要唯一
            'openid'    => $data['openid'],
            'check_name'=> 'NO_CHECK', //OPTION_CHECK不强制校验真实姓名, FORCE_CHECK：强制 NO_CHECK：
            //'re_user_name' => 'jorsh', //收款人用户姓名
            'amount'    => $data['money'] * 100, //付款金额单位为分
            'desc'      => empty($data['desc'])? '退款' : $data['desc'],
            'spbill_create_ip' => $this->getip(),
        );
        foreach ($webdata as $k => $v) {
            $tarr[] =$k.'='.$v;
        }
        sort($tarr);
        $sign = implode($tarr, '&');
        $sign .= '&key='.$this->signkey;
        $webdata['sign']=strtoupper(md5($sign));
        $wget = $this->array2xml($webdata);
        $res = $this->http_post($this->payurl, $wget, $wxchat);
        if(!$res){
            return array('status'=>1, 'msg'=>"Can't connect the server" );
        }
        $content = simplexml_load_string($res, 'SimpleXMLElement', LIBXML_NOCDATA);
        if(strval($content->return_code) == 'FAIL'){
            return array('status'=>1, 'msg'=>strval($content->return_msg));
        }
        if(strval($content->result_code) == 'FAIL'){
            return array('status'=>1, 'msg'=>strval($content->err_code),':'.strval($content->err_code_des));
        }
        $rdata = array(
            'mch_appid'        => strval($content->mch_appid),
            'mchid'            => strval($content->mchid),
            'device_info'      => strval($content->device_info),
            'nonce_str'        => strval($content->nonce_str),
            'result_code'      => strval($content->result_code),
            'partner_trade_no' => strval($content->partner_trade_no),
            'payment_no'       => strval($content->payment_no),
            'payment_time'     => strval($content->payment_time),
        );
        return $rdata;
    }
 
    public function getip() {
        static $ip = '';
        $ip = $_SERVER['REMOTE_ADDR'];
        if(isset($_SERVER['HTTP_CDN_SRC_IP'])) {
            $ip = $_SERVER['HTTP_CDN_SRC_IP'];
        } elseif (isset($_SERVER['HTTP_CLIENT_IP']) && preg_match('/^([0-9]{1,3}\.){3}[0-9]{1,3}$/', $_SERVER['HTTP_CLIENT_IP'])) {
            $ip = $_SERVER['HTTP_CLIENT_IP'];
        } elseif(isset($_SERVER['HTTP_X_FORWARDED_FOR']) AND preg_match_all('#\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}#s', $_SERVER['HTTP_X_FORWARDED_FOR'], $matches)) {
            foreach ($matches[0] AS $xip) {
                if (!preg_match('#^(10|172\.16|192\.168)\.#', $xip)) {
                    $ip = $xip;
                    break;
                }
            }
        }
        return $ip;
    }
 
        /**
     * 将一个数组转换为 XML 结构的字符串
     * @param array $arr 要转换的数组
     * @param int $level 节点层级, 1 为 Root.
     * @return string XML 结构的字符串
     */
    public function array2xml($arr, $level = 1) {
        $s = $level == 1 ? "<xml>" : '';
        foreach($arr as $tagname => $value) {
            if (is_numeric($tagname)) {
                $tagname = $value['TagName'];
                unset($value['TagName']);
            }
            if(!is_array($value)) {
                $s .= "<{$tagname}>".(!is_numeric($value) ? '<![CDATA[' : '').$value.(!is_numeric($value) ? ']]>' : '')."</{$tagname}>";
            } else {
                $s .= "<{$tagname}>" . $this->array2xml($value, $level + 1)."</{$tagname}>";
            }
        }
        $s = preg_replace("/([\x01-\x08\x0b-\x0c\x0e-\x1f])+/", ' ', $s);
        return $level == 1 ? $s."</xml>" : $s;
    }
    public function http_post($url, $param, $wxchat) {
        $oCurl = curl_init();
        if (stripos($url, "https://") !== FALSE) {
            curl_setopt($oCurl, CURLOPT_SSL_VERIFYPEER, FALSE);
            curl_setopt($oCurl, CURLOPT_SSL_VERIFYHOST, FALSE);
        }
        if (is_string($param)) {
            $strPOST = $param;
        } else {
            $aPOST = array();
            foreach ($param as $key => $val) {
                $aPOST[] = $key . "=" . urlencode($val);
            }
            $strPOST = join("&", $aPOST);
        }
        curl_setopt($oCurl, CURLOPT_URL, $url);
        curl_setopt($oCurl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($oCurl, CURLOPT_POST, true);
        curl_setopt($oCurl, CURLOPT_POSTFIELDS, $strPOST);
        if($wxchat){
            curl_setopt($oCurl,CURLOPT_SSLCERT,dirname(THINK_PATH).$wxchat['api_cert']);
            curl_setopt($oCurl,CURLOPT_SSLKEY,dirname(THINK_PATH).$wxchat['api_key']);
            curl_setopt($oCurl,CURLOPT_CAINFO,dirname(THINK_PATH).$wxchat['api_ca']);
        }
        $sContent = curl_exec($oCurl);
        $aStatus = curl_getinfo($oCurl);
        curl_close($oCurl);
        if (intval($aStatus["http_code"]) == 200) {
            return $sContent;
        } else {
            return false;
        }
    }
 
    //企业付款测试
    public function test(){
        $data = array(
            'userid' => '10',		//用户ID   做更新状态使用
            'openid' => 'ozOUuxM-Y53xHT1JwVq_KUfF2-JY',		//收钱的人微信 OPENID
            'refundid' => 1,		//退款申请ID
            'money'    => 1.5,		//金额
            'desc'     => '退款测试',
        );
 
        $res = $this->wxbuild($data, '');
        dump($res);
    }
 
}