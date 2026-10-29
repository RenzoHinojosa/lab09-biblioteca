<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%!
    /** Escapa salida HTML para evitar XSS (equivale a htmlspecialchars). */
    private static String e(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                .replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    @SuppressWarnings("unchecked")
    Map<String,String> r = (Map<String,String>) session.getAttribute("reserva");
    Integer total = (Integer) session.getAttribute("totalReservas");
%>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Resultado - JSP</title>
<link rel="stylesheet" href="css/estilo.css"></head>
<body>
<header><h2>Biblioteca UNCP <small>| Versión JSP</small></h2></header>
<main>
<% if (r == null) { %>
  <div class="error">Aún no hay reservas en esta sesión.</div>
<% } else { %>
  <div class="ok">✔ Reserva registrada correctamente</div>
  <table>
    <tr><th>Solicitante</th><td><%= e(r.get("nombre")) %></td></tr>
    <tr><th>Correo</th><td><%= e(r.get("correo")) %></td></tr>
    <tr><th>Libro</th><td><%= e(r.get("libro")) %></td></tr>
    <tr><th>Días</th><td><%= e(r.get("dias")) %></td></tr>
    <tr><th>Registrada</th><td><%= e(r.get("fecha")) %></td></tr>
    <tr><th>Reservas en esta sesión</th><td><%= total == null ? 0 : total %></td></tr>
    <tr><th>ID de sesión</th><td><code><%= e(session.getId().substring(0, 8)) %>…</code></td></tr>
  </table>
<% } %>
  <a class="btn" href="index.jsp">Nueva reserva</a>
</main>
<footer>Servidor: <%= e(application.getServerInfo()) %> · Java <%= e(System.getProperty("java.version")) %></footer>
</body></html>
