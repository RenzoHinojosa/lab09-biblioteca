<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<!DOCTYPE html>
<html lang="es"><head><meta charset="UTF-8"><title>Error</title>
<link rel="stylesheet" href="css/estilo.css"></head><body>
<header><h2>Biblioteca UNCP <small>| Errores de validación</small></h2></header>
<main>
<% List<String> errores = (List<String>) request.getAttribute("errores");
   if (errores != null) for (String err : errores) { %>
  <div class="error"><%= err %></div>
<% } %>
  <a class="btn" href="index.jsp">Volver</a>
</main></body></html>
