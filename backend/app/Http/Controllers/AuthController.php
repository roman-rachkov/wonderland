<?php

namespace App\Http\Controllers;

use Illuminate\Auth\Events\Registered;
use Illuminate\Http\Request;
use Laravel\Fortify\Contracts\CreatesNewUsers;
use Laravel\Fortify\Contracts\RegisterResponse;

class AuthController extends Controller
{
    public function register(Request $request, CreatesNewUsers $creator)
    {
        event(new Registered($creator->create($request->all())));

        return app(RegisterResponse::class);
    }
}
