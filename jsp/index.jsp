<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Reserva de libros - JSP</title>
  <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
<header><h2>Biblioteca UNCP <small>| Versión JSP</small></h2></header>
<main>
  <h3>Reservar un libro</h3>
  <form action="procesar.jsp" method="post">
    <label for="nombre">Apellidos y nombres</label>
    <input id="nombre" name="nombre" required maxlength="80">

    <label for="correo">Correo electrónico</label>
    <input id="correo" name="correo" type="email" required>

    <label for="libro">Libro</label>
    <select id="libro" name="libro" required>
      <option value="">-- Seleccione --</option>
      <option value="ing-software">Ingeniería de Software (Sommerville)</option>
      <option value="redes">Redes de Computadoras (Tanenbaum)</option>
      <option value="bd">Fundamentos de Bases de Datos (Silberschatz)</option>
      <option value="web">Desarrollo Web con PHP y MySQL</option>
      <option value="java">Java: Cómo programar (Deitel)</option>
    </select>

    <label for="dias">Días de préstamo (1 a 15)</label>
    <input id="dias" name="dias" type="number" min="1" max="15" value="7" required>

    <button type="submit">Reservar</button>
  </form>
  <p><a href="resultado.jsp">Ver mi última reserva</a> |
     <a href="http://localhost/lab09/index.html">Versión PHP</a></p>
</main>
<footer>IS093A - Lab 09 - Arquitectura Cliente-Servidor</footer>
</body>
</html>
