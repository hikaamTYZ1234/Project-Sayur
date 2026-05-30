<?php
namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens;

    protected $fillable = ['name', 'email', 'password', 'phone', 'avatar', 'role'];

    protected $hidden = ['password'];

    public function orders() {
        return $this->hasMany(Order::class);
    }
}