<?php
declare(strict_types=1);

namespace SistemaTS;

function json_response(array $data, int $status = 200): void
{
    http_response_code($status);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
}

function env_or_fail(string $name): string
{
    $value = getenv($name);
    if ($value === false || $value === '') {
        throw new \RuntimeException("Environment variable {$name} is not set");
    }
    return $value;
}
