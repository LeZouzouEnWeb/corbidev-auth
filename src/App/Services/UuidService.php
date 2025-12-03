<?php
declare(strict_types=1);

namespace App\Services;

use Ramsey\Uuid\Uuid;

/**
 * UuidService — UUID v4
 */
final class UuidService
{
    public static function v4(): string
    {
        return Uuid::uuid4()->toString();
    }
}
