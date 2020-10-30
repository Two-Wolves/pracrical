<?php

namespace ytwl\service;

use think\Config;

/**
 * 阿里短信发送
 */
class Alisms
{

    public $error = [];
    protected $config = [];
    // Access Key ID
    private $accessKeyId = '';
    // Access Access Key Secret
    private $accessKeySecret = '';
    // 签名
    private $signName = '';

    public function __construct($options = [])
    {
        if ($config = Config::get('service.alisms'))
        {
            $this->config = array_merge($this->config, $config);
        }
        $this->config = array_merge($this->config, is_array($options) ? $options : []);
        // 配置参数
        $this->accessKeyId = $this->config['key'];
        $this->accessKeySecret = $this->config['secret'];
        $this->signName = $this->config['signName'];
    }

    private function percentEncode($string) {
        $string = urlencode ( $string );
        $string = preg_replace ( '/\+/', '%20', $string );
        $string = preg_replace ( '/\*/', '%2A', $string );
        $string = preg_replace ( '/%7E/', '~', $string );
        return $string;
    }
    /**
     * 签名
     *
     * @param unknown $parameters
     * @param unknown $accessKeySecret
     * @return string
     */
    private function computeSignature($parameters, $accessKeySecret) {
        ksort ( $parameters );
        $canonicalizedQueryString = '';
        foreach ( $parameters as $key => $value ) {
            $canonicalizedQueryString .= '&' . $this->percentEncode ( $key ) . '=' . $this->percentEncode ( $value );
        }
        $stringToSign = 'GET&%2F&' . $this->percentencode ( substr ( $canonicalizedQueryString, 1 ) );
        $signature = base64_encode ( hash_hmac ( 'sha1', $stringToSign, $accessKeySecret . '&', true ) );
        return $signature;
    }

    /**
     * 发送短信
     * @param $mobile 手机号
     * @param $templateCode 模板ID
     * @param string $verify_code 验证码
     * @return bool|unknown
     */
    public function send_verify($mobile, $templateCode, $code=array()) {
        $params = array (
            'SignName' => $this->signName,
            'Format' => 'JSON',
            'Version' => '2017-05-25',
            'AccessKeyId' => $this->accessKeyId,
            'SignatureVersion' => '1.0',
            'SignatureMethod' => 'HMAC-SHA1',
            'SignatureNonce' => uniqid (),
            'Timestamp' => gmdate ( 'Y-m-d\TH:i:s\Z' ),
            'Action' => 'SendSms',
            'TemplateCode' => $templateCode,
            'PhoneNumbers' => $mobile,
            'TemplateParam' => json_encode($code),
        );
        // 计算签名并把签名结果加入请求参数
        $params ['Signature'] = $this->computeSignature ( $params, $this->accessKeySecret );
        // 发送请求
        $url = 'http://dysmsapi.aliyuncs.com/?' . http_build_query ( $params );

        $ch = curl_init ();
        curl_setopt ( $ch, CURLOPT_URL, $url );
        curl_setopt ( $ch, CURLOPT_SSL_VERIFYPEER, FALSE );
        curl_setopt ( $ch, CURLOPT_SSL_VERIFYHOST, FALSE );
        curl_setopt ( $ch, CURLOPT_RETURNTRANSFER, 1 );
        curl_setopt ( $ch, CURLOPT_TIMEOUT, 10 );
        $result = curl_exec ( $ch );
        curl_close ( $ch );
        $result = json_decode ( $result, true );
        if ($result ['Message'] = 'OK') {
            return true;
        }else{
            return $this->getErrorMessage ( $result ['Code'] );
        }
    }
    /**
     * 获取详细错误信息
     *
     * @param unknown $status
     */
    public function getErrorMessage($status) {
        // 阿里云的短信 乱八七糟的(其实是用的阿里大于)
        // https://api.alidayu.com/doc2/apiDetail?spm=a3142.7629140.1.19.SmdYoA&apiId=25450
        $message = array (
            'InvalidDayuStatus.Malformed' => '账户短信开通状态不正确',
            'InvalidSignName.Malformed' => '短信签名不正确或签名状态不正确',
            'InvalidTemplateCode.MalFormed' => '短信模板Code不正确或者模板状态不正确',
            'InvalidRecNum.Malformed' => '目标手机号不正确，单次发送数量不能超过100',
            'InvalidParamString.MalFormed' => '短信模板中变量不是json格式',
            'InvalidParamStringTemplate.Malformed' => '短信模板中变量与模板内容不匹配',
            'InvalidSendSms' => '触发业务流控',
            'InvalidDayu.Malformed' => '变量不能是url，可以将变量固化在模板中'
        );
        if (isset ( $message [$status] )) {
            return $message [$status];
        }
        return $status;
    }

}
