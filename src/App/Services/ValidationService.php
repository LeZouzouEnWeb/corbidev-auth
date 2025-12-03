<?php
declare(strict_types=1);

namespace App\Services;

use Respect\Validation\Validator as v;

/**
 * ValidationService — helpers simples
 */
final class ValidationService
{
    public static function email(string $value): bool
    {
        return v::email()->validate($value);
    }

    public static function nonEmptyString(string $value): bool
    {
        return v::stringType()->notEmpty()->validate(trim($value));
    }
}
