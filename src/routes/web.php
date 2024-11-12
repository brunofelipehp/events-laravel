<?php

use App\Http\Controllers\EventController;
use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

Route::get("/", [EventController::class, 'index']);
Route::get("/events/create", [EventController::class, 'create'])->middleware('auth');
Route::get("/events/{id}", [EventController::class, 'show']);
Route::post("/events", [EventController::class, 'store']);
Route::delete("/events/{id}", [EventController::class, 'destroy']);
Route::get('/events/edit/{id}', [EventController::class, 'edit'])->middleware('auth');
Route::put('events/update/{id}', [EventController::class, 'update'])->middleware('auth');
Route::post('/events/join/{id}', [EventController::class, 'joinEvent'])->middleware('auth');

Route::get("/contact", function () {
    return view("contact");
});


Route::middleware("auth")->group(function () {
    Route::get("/profile", [ProfileController::class, "edit"])->name(
        "profile.edit"
    );
    Route::patch("/profile", [ProfileController::class, "update"])->name(
        "profile.update"
    );
    Route::delete("/profile", [ProfileController::class, "destroy"])->name(
        "profile.destroy"
    );
});


Route::get('/dashboard', [EventController::class, 'dashboard'])->middleware('auth');

require __DIR__ . "/auth.php";
