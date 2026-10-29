<?php
declare(strict_types=1);
require __DIR__ . '/config.php';
$r = $_SESSION['reserva'] ?? null;
?>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Resultado - PHP</title>
<link rel="stylesheet" href="css/estilo.css"></head>
<body>
<header><h2>Biblioteca UNCP <small>| Versión PHP</small></h2></header>
<main>
<?php if ($r === null): ?>
  <div class="error">Aún no hay reservas en esta sesión.</div>
<?php else: ?>
  <div class="ok">✔ Reserva registrada correctamente</div>
  <table>
    <tr><th>Solicitante</th><td><?= e($r['nombre']) ?></td></tr>
    <tr><th>Correo</th><td><?= e($r['correo']) ?></td></tr>
    <tr><th>Libro</th><td><?= e($r['libro']) ?></td></tr>
    <tr><th>Días</th><td><?= (int) $r['dias'] ?></td></tr>
    <tr><th>Registrada</th><td><?= e($r['fecha']) ?></td></tr>
    <tr><th>Reservas en esta sesión</th><td><?= (int) ($_SESSION['total_reservas'] ?? 0) ?></td></tr>
    <tr><th>ID de sesión</th><td><code><?= e(substr(session_id(), 0, 8)) ?>…</code></td></tr>
  </table>
<?php endif; ?>
  <a class="btn" href="index.html">Nueva reserva</a>
</main>
<footer>Servidor: <?= e($_SERVER['SERVER_SOFTWARE'] ?? 'PHP') ?> · PHP <?= e(PHP_VERSION) ?></footer>
</body></html>
