<?php

use Illuminate\Support\Facades\Route;
use Laravel\Fortify\Http\Controllers\VerifyEmailController;

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

Route::post('/register', [\App\Http\Controllers\AuthController::class, 'register']);

Route::get('/email/verify/{id}/{hash}', [VerifyEmailController::class, '__invoke'])
    ->middleware([config('fortify.auth_middleware', 'auth').':'.config('fortify.guard'), 'throttle:6,1'])
    ->name('verification.verify');
Route::any('/teapot', function (\Illuminate\Http\Request $request) {
    abort(418);
});

Route::any('/', function (\Illuminate\Http\Request $request) {
    phpinfo();
});


