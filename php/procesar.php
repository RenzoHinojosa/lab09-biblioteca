<?php
/**
 * procesar.php - Controlador: recibe POST, valida, guarda en sesión y redirige (patrón PRG).
 * Ciclo de vida PHP: parse -> execute -> output (cada petición arranca de cero).
 */
declare(strict_types=1);
require __DIR__ . '/config.php';

// Solo se acepta POST -> si no, 405 Method Not Allowed
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    header('Allow: POST');
    exit('405 Method Not Allowed: use el formulario (POST).');
}

// Validación y saneamiento con filter_input() (sin register_globals)
$nombre = trim((string) filter_input(INPUT_POST, 'nombre', FILTER_UNSAFE_RAW));
$correo = filter_input(INPUT_POST, 'correo', FILTER_VALIDATE_EMAIL);
$libro  = (string) filter_input(INPUT_POST, 'libro', FILTER_UNSAFE_RAW);
$dias   = filter_input(INPUT_POST, 'dias', FILTER_VALIDATE_INT, [
    'options' => ['min_range' => 1, 'max_range' => 15],
]);

$errores = [];
if (!preg_match('/^.{1,80}$/su', $nombre))      { $errores[] = 'El nombre es obligatorio (máx. 80 caracteres).'; }
if ($correo === false || $correo === null)      { $errores[] = 'El correo no tiene un formato válido.'; }
if (!array_key_exists($libro, LIBROS))          { $errores[] = 'Seleccione un libro de la lista.'; }
if ($dias === false || $dias === null)          { $errores[] = 'Los días deben ser un número entre 1 y 15.'; }

if ($errores) {
    http_response_code(400); // Bad Request
    ?>
    <!DOCTYPE html>
    <html lang="es"><head><meta charset="UTF-8"><title>Error</title>
    <link rel="stylesheet" href="css/estilo.css"></head><body>
    <header><h2>Biblioteca UNCP <small>| Errores de validación</small></h2></header>
    <main>
      <?php foreach ($errores as $err): ?>
        <div class="error"><?= e($err) ?></div>
      <?php endforeach; ?>
      <a class="btn" href="index.html">Volver</a>
    </main></body></html>
    <?php
    exit;
}

// Estado entre peticiones: se guarda en la sesión del servidor
$_SESSION['reserva'] = [
    'nombre' => $nombre,
    'correo' => $correo,
    'libro'  => LIBROS[$libro],
    'dias'   => $dias,
    'fecha'  => date('d/m/Y H:i:s'),
];
$_SESSION['total_reservas'] = ($_SESSION['total_reservas'] ?? 0) + 1;

// Post/Redirect/Get -> 302 evita reenvío del formulario al recargar
header('Location: resultado.php', true, 302);
exit;
