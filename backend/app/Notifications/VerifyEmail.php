<?php

namespace App\Notifications;

use Illuminate\Auth\Notifications\VerifyEmail as VerifyEmailNotification;
use Illuminate\Support\Facades\URL;

class VerifyEmail extends VerifyEmailNotification
{
    protected function verificationUrl($notifiable)
    {
        URL::forceRootUrl(config('app.frontend_url'));
        return URL::temporarySignedRoute(
            'verification.verify',
            now()->addDays(),
            ['id' => $notifiable->getKey(), 'hash' => sha1($notifiable->getEmailForVerification())]
        );
    }
}
