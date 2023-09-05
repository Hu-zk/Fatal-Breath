<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class House extends Model
{
    use HasFactory;

    protected $table = 'houses';

    protected $fillable = [
        'name',
        'owner_id',
        'city',
        'country',
    ];

    public function owner()
    {
        return $this->belongsTo(User::class, 'owner_id');
    }

    public function rooms()
    {
        return $this->hasMany(Room::class);
    }

    public function members()
    {
        return $this->belongsToMany(User::class, 'users_houses');
    }

    public function membershipRequests()
    {
        return $this->hasMany(MembershipRequest::class);
    }
}
