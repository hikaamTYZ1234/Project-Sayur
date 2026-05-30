<?php
/**
 * Laravel development server router.
 *
 * This file ensures that static files served by the built-in PHP server
 * carry CORS headers so Flutter Web can load images from the backend origin.
 */

$uri = urldecode(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));
$file = __DIR__.'/public'.$uri;

if ($uri !== '/' && file_exists($file)) {
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
    header('Access-Control-Allow-Headers: *');
    return false;
}

require_once __DIR__.'/public/index.php';
