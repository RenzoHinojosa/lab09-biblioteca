# Lab 09 – Reserva de Libros (PHP + JSP)

**Asignatura:** Desarrollo de Aplicaciones Web (IS093A) · **UNCP – Ingeniería de Sistemas**
**Guía:** Práctica Semana 09 – Tecnología Web Backend, Arquitectura Cliente-Servidor, PHP & JSP
**Autor:** Hinojosa Yaranga, Renzo Sebastián · **Fecha:** 28/10/2026

Aplicación mínima de **reserva de libros de biblioteca** implementada dos veces (PHP y JSP) para comparar
el ciclo de vida, el manejo de sesiones y el despliegue en cada tecnología.

## Estructura

```
lab09-biblioteca/
├── php/                 → copiar a  htdocs/lab09/   (XAMPP / Laragon)
│   ├── index.html       formulario (POST)
│   ├── procesar.php     controlador: valida, guarda sesión, redirige (302)
│   ├── resultado.php    vista: muestra la reserva
│   ├── config.php       constantes, sesión, función e() = htmlspecialchars
│   └── css/estilo.css
├── jsp/                 → copiar a  Tomcat/webapps/lab09/
│   ├── index.jsp, procesar.jsp, resultado.jsp, error.jsp
│   ├── WEB-INF/web.xml
│   └── css/estilo.css
└── docs/                comparativa.md · evidencias.md
```

## Cómo ejecutar

**PHP (XAMPP):** copiar `php/` a `C:\xampp\htdocs\lab09\`, iniciar Apache y abrir `http://localhost/lab09/index.html`.
Alternativa rápida: `cd php && php -S localhost:8081`.

**JSP (Tomcat 10.x, JDK 17+):** copiar `jsp/` a `<TOMCAT>/webapps/lab09/`, ejecutar `bin/startup.bat` (Windows) o
`bin/startup.sh` (Linux/Mac) y abrir `http://localhost:8080/lab09/`.
> Tomcat 10 usa el espacio de nombres `jakarta.*`; no usar Tomcat 9 con este `web.xml`.

## Qué se valida (y cómo comprobarlo)

| Caso | PHP | JSP | Resultado esperado |
|---|---|---|---|
| Enviar formulario válido | `procesar.php` | `procesar.jsp` | **302** → `resultado` (200) |
| Abrir `procesar` con GET | `procesar.php` | `procesar.jsp` | **405** + cabecera `Allow: POST` |
| Datos inválidos | `procesar.php` | `procesar.jsp` | **400** + lista de errores |
| Nombre con `<script>` | `resultado.php` | `resultado.jsp` | Se muestra escapado (sin XSS) |
| Segunda reserva, misma sesión | contador = 2 | contador = 2 | Estado guardado en sesión |

Prueba por consola (Postman / REST Client / curl):

```bash
curl -i http://localhost/lab09/procesar.php                       # 405
curl -i -d "nombre=Ana&correo=a@b.com&libro=web&dias=7" http://localhost/lab09/procesar.php   # 302
```

## Buenas prácticas aplicadas

- Sin `register_globals`; entrada con `filter_input()` y salida con `htmlspecialchars()` (PHP) / función `e()` equivalente (JSP).
- Solo `POST` para procesar; `405` en otro caso; patrón **Post/Redirect/Get** para evitar reenvío del formulario.
- Cookie de sesión `HttpOnly` (`SameSite=Lax` en PHP, `<http-only>` en `web.xml`).
- Estructura MVC incipiente: formulario (vista) → `procesar` (controlador) → `resultado` (vista); catálogo en `config.php`.

## Logs a revisar (Paso 4)

- XAMPP: `xampp/apache/logs/access.log` y `error.log`
- Tomcat: `logs/catalina.out` (Linux/Mac) o `logs/catalina.<fecha>.log` y `localhost_access_log.<fecha>.txt`

Más detalle: [`docs/comparativa.md`](docs/comparativa.md) · [`docs/evidencias.md`](docs/evidencias.md)
