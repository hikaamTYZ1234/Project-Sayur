<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\ProductController;
use App\Http\Controllers\Admin\CategoryController;
use App\Http\Controllers\Admin\OrderController;

Route::get('/', fn() => redirect('/admin/products'));

Route::prefix('admin')->name('admin.')->group(function () {
    Route::resource('products',   ProductController::class);
    Route::resource('categories', CategoryController::class);
    Route::resource('orders',     OrderController::class);
});