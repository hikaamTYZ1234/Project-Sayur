<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\OrderController;

// ─── PUBLIC ROUTES ───────────────────────────────────────────────
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login',    [AuthController::class, 'login']);

Route::get('/products',                    [ProductController::class, 'index']);
Route::get('/products/top-rated',          [ProductController::class, 'topRated']);
Route::get('/products/{id}',               [ProductController::class, 'show']);
Route::get('/categories',                  [CategoryController::class, 'index']);
Route::get('/categories/{id}/products',    [CategoryController::class, 'products']);

// ─── PROTECTED ROUTES (perlu token) ──────────────────────────────
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout',     [AuthController::class, 'logout']);
    Route::get('/me',          [AuthController::class, 'me']);

    Route::get('/orders',      [OrderController::class, 'index']);
    Route::post('/orders',     [OrderController::class, 'store']);
    Route::get('/orders/{id}', [OrderController::class, 'show']);
});