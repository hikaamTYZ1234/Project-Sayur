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
        [
            'name' => 'Wortel Segar', 
            'category_id' => 1, 
            'price' => 5000, 
            'stock' => 100, 
            'rating' => 4.5,
            'image' => 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?auto=format&fit=crop&q=80&w=600'
        ],
        [
            'name' => 'Bayam Organik', 
            'category_id' => 1, 
            'price' => 3000, 
            'stock' => 80, 
            'rating' => 4.2,
            'image' => 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?auto=format&fit=crop&q=80&w=600'
        ],
        [
            'name' => 'Alpukat', 
            'category_id' => 2, 
            'price' => 8000, 
            'stock' => 50, 
            'rating' => 4.8,
            'image' => 'https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?auto=format&fit=crop&q=80&w=600'
        ],
        [
            'name' => 'Telur Ayam', 
            'category_id' => 3, 
            'price' => 2500, 
            'stock' => 200, 
            'rating' => 4.6,
            'image' => 'https://images.unsplash.com/photo-1506976785307-8732e854ad03?auto=format&fit=crop&q=80&w=600'
        ],
        [
            'name' => 'Salmon Fillet', 
            'category_id' => 3, 
            'price' => 45000, 
            'stock' => 30, 
            'rating' => 4.9,
            'image' => 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&q=80&w=600'
        ],
        [
            'name' => 'Jus Sayur Mix', 
            'category_id' => 4, 
            'price' => 15000, 
            'stock' => 60, 
            'rating' => 4.3,
            'image' => 'https://images.unsplash.com/photo-1622597467836-f3285f2131b8?auto=format&fit=crop&q=80&w=600'
        ],
    ];
    foreach ($products as $p) {
        \App\Models\Product::create(array_merge($p, [
            'slug' => \Illuminate\Support\Str::slug($p['name']),
        ]));
    }
}
    }

