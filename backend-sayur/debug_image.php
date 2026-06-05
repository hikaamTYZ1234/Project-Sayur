<?php
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$p = App\Models\Product::latest()->first();
if ($p) {
    echo "Name: " . $p->name . "\n";
    echo "Image path in DB: " . $p->image . "\n";
    echo "Generated Image URL: " . $p->image_url . "\n";
} else {
    echo "No products found.\n";
}
