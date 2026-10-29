<?php
/**
 * config.php - Configuración central de la aplicación (PHP)
 * Lab 09 - IS093A Desarrollo de Aplicaciones Web - UNCP
 */
declare(strict_types=1);

const APP_NOMBRE = 'Biblioteca UNCP - Reserva de Libros';
const LIBROS = [
    'ing-software'  => 'Ingeniería de Software (Sommerville)',
    'redes'         => 'Redes de Computadoras (Tanenbaum)',
    'bd'            => 'Fundamentos de Bases de Datos (Silberschatz)',
    'web'           => 'Desarrollo Web con PHP y MySQL',
    'java'          => 'Java: Cómo programar (Deitel)',
];

// Sesión con cookie endurecida (buena práctica de seguridad)
if (session_status() === PHP_SESSION_NONE) {
    session_set_cookie_params([
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
    session_start();
}

/** Escapa salida HTML para evitar XSS. */
function e(string $texto): string
{
    return htmlspecialchars($texto, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}
