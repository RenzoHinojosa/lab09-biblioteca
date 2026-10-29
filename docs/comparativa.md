# Comparativa técnica PHP vs JSP (Paso 5)

| Aspecto | PHP (Apache + mod_php/FPM) | JSP (Apache Tomcat 10) |
|---|---|---|
| **Ciclo de vida** | Por petición: *parse → execute → output*; todo se descarta al terminar | Traducción a servlet → compilación → instanciación → `init()` → `service()` (por petición) → `destroy()` |
| **Compilación** | Interpretado (opcache guarda bytecode) | Se compila a `.class` la 1.ª vez que se pide la página |
| **Memoria** | Memoria aislada por petición/proceso; se libera al finalizar | Un solo proceso JVM; el servlet es singleton y multihilo (cuidado con variables de instancia compartidas) |
| **Estado / sesión** | `$_SESSION` (archivos en servidor + cookie `PHPSESSID`) | `HttpSession` en memoria del contenedor + cookie `JSESSIONID` |
| **Despliegue** | Copiar archivos a `htdocs/` (sin reiniciar) | Carpeta o `.war` en `webapps/` (recarga del contexto) |
| **Configuración** | `php.ini`, `config.php`, `.htaccess` | `web.xml`, `server.xml`, `context.xml` |
| **Puerto por defecto** | 80 (Apache) | 8080 (Tomcat) |
| **Escalabilidad** | Horizontal fácil (procesos sin estado compartido) | Vertical y horizontal (clustering/sesiones replicadas) |
| **Seguridad de salida** | `htmlspecialchars()` | Escapar a mano o `<c:out>` / `fn:escapeXml` (JSTL) |
| **Arranque** | Inmediato | Más lento (arranque de JVM + compilación inicial) |

**Conclusión:** ambos son *server-side rendering* sobre HTTP *stateless*; el estado se simula con sesiones
(cookie + almacenamiento en servidor). PHP prioriza simplicidad de despliegue; JSP/Tomcat ofrece un modelo
persistente y multihilo, con más control pero más configuración.

> Verificar contra documentación oficial: <https://www.php.net/manual/es/> · <https://tomcat.apache.org/tomcat-10.1-doc/>
