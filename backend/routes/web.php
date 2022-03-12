<?php

use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/test', function (){
    echo env('APP_URL').'|<a href="'.route('hello').'">hello</a>';
    phpinfo();
})->name('test');

Route::get('/hello', function () {
    return '<a href="' . route('test') . '">test</a>';
})->name('hello');
