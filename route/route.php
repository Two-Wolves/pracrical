<?php

//前台地址
Route::domain('www.pracrical.com', 'index');

//后台地址
Route::domain('sys.pracrical.com', 'admin');

//刷新缓存地址
Route::get('cache/clean/:password', 'cache/clean/index');
