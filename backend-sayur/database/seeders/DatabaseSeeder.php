<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
   // database/seeders/DatabaseSeeder.php
public function run()
{
    // Admin user
    \App\Models\User::create([
        'name'     => 'Admin Sayur',
        'email'    => 'admin@sayur.com',
        'password' => bcrypt('password'),
        'role'     => 'admin',
    ]);

    // Categories
    $categories = ['Sayuran', 'Buah', 'Protein', 'Minuman'];
    foreach ($categories as $cat) {
        \App\Models\Category::create([
            'name' => $cat,
            'slug' => \Illuminate\Support\Str::slug($cat),
        ]);
    }

    // Products
    $products = [
        ['name' => 'Wortel Segar', 'category_id' => 1, 'price' => 5000, 'stock' => 100, 'rating' => 4.5],
        ['name' => 'Bayam Organik', 'category_id' => 1, 'price' => 3000, 'stock' => 80, 'rating' => 4.2],
        ['name' => 'Alpukat', 'category_id' => 2, 'price' => 8000, 'stock' => 50, 'rating' => 4.8],
        ['name' => 'Telur Ayam', 'category_id' => 3, 'price' => 2500, 'stock' => 200, 'rating' => 4.6],
        ['name' => 'Salmon Fillet', 'category_id' => 3, 'price' => 45000, 'stock' => 30, 'rating' => 4.9],
        ['name' => 'Jus Sayur Mix', 'category_id' => 4, 'price' => 15000, 'stock' => 60, 'rating' => 4.3],
    ];
    foreach ($products as $p) {
        \App\Models\Product::create(array_merge($p, [
            'slug' => \Illuminate\Support\Str::slug($p['name']),
        ]));
    }
}
    }

