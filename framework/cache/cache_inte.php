<?php
 //缓存接口
interface ICache
{
    public function set($key, $content);
    public function get($key);
    public function delete($key);
}
