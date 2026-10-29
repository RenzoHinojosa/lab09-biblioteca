<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.text.SimpleDateFormat" %>
<%!
    // Catálogo (equivalente a LIBROS en config.php)
    private static final Map<String,String> LIBROS = new LinkedHashMap<>();
    static {
        LIBROS.put("ing-software", "Ingeniería de Software (Sommerville)");
        LIBROS.put("redes", "Redes de Computadoras (Tanenbaum)");
        LIBROS.put("bd", "Fundamentos de Bases de Datos (Silberschatz)");
        LIBROS.put("web", "Desarrollo Web con PHP y MySQL");
        LIBROS.put("java", "Java: Cómo programar (Deitel)");
    }
    private static final java.util.regex.Pattern EMAIL =
        java.util.regex.Pattern.compile("^[\\w.+-]+@[\\w-]+(\\.[\\w-]+)+$");
%>
<%
    // Solo POST -> si no, 405
    if (!"POST".equals(request.getMethod())) {
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        response.setHeader("Allow", "POST");
        out.print("405 Method Not Allowed: use el formulario (POST).");
        return;
    }
    request.setCharacterEncoding("UTF-8");

    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String libro  = request.getParameter("libro");
    String diasStr = request.getParameter("dias");

    nombre = (nombre == null) ? "" : nombre.trim();
    correo = (correo == null) ? "" : correo.trim();
    List<String> errores = new ArrayList<>();
    int dias = 0;

    if (nombre.isEmpty() || nombre.length() > 80) errores.add("El nombre es obligatorio (máx. 80 caracteres).");
    if (!EMAIL.matcher(correo).matches())          errores.add("El correo no tiene un formato válido.");
    if (libro == null || !LIBROS.containsKey(libro)) errores.add("Seleccione un libro de la lista.");
    try {
        dias = Integer.parseInt(diasStr == null ? "" : diasStr.trim());
        if (dias < 1 || dias > 15) throw new NumberFormatException();
    } catch (NumberFormatException ex) {
        errores.add("Los días deben ser un número entre 1 y 15.");
    }

    if (!errores.isEmpty()) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
        request.setAttribute("errores", errores);
        request.getRequestDispatcher("error.jsp").forward(request, response);
        return;
    }

    // Estado en sesión (HttpSession)
    Map<String,String> reserva = new LinkedHashMap<>();
    reserva.put("nombre", nombre);
    reserva.put("correo", correo);
    reserva.put("libro", LIBROS.get(libro));
    reserva.put("dias", String.valueOf(dias));
    reserva.put("fecha", new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date()));
    session.setAttribute("reserva", reserva);

    Integer total = (Integer) session.getAttribute("totalReservas");
    session.setAttribute("totalReservas", (total == null) ? 1 : total + 1);

    // Post/Redirect/Get -> 302
    response.sendRedirect("resultado.jsp");
%>
