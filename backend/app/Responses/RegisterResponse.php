<?php

declare(strict_types=1);

namespace App\Responses;

use Illuminate\Http\JsonResponse;
use Laravel\Fortify\Contracts\RegisterResponse as RegisterResponseContract;
use Laravel\Fortify\Fortify;

class RegisterResponse implements RegisterResponseContract
{

    public function toResponse($request)
    {
        return $request->wantsJson()
            ? new JsonResponse(auth()->user(), 201)
            : redirect()->intended(Fortify::redirects('register'));
    }
}
