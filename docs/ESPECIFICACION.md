# PerlaOS — Especificación Técnica v0.1

> Derivado de Debian Stable · GNOME · En español · Para cualquier persona

---

## 1. Misión

PerlaOS es un sistema operativo doméstico basado en Debian Stable con el entorno GNOME, diseñado para que cualquier persona hispanohablante lo use sin conocimientos técnicos. La metáfora del proyecto: Debian es la concha (sólida, estable, probada), PerlaOS es la perla que se forma encima: pulida, elegante y fácil de usar.

### Principios rectores:

1. **Cero terminal obligatoria.** Todo se hace con clic, como en Windows. La terminal existe, pero con comandos en español sencillos para quien quiera aprender.
2. **Español de serie.** Sistema, instalador, aplicaciones y ayuda, todo en español desde el primer arranque.
3. **Estabilidad ante todo.** Base Debian Stable (trixie). Nada de repositorios experimentales por defecto.
4. **Belleza cuidada.** Identidad visual propia: paleta "perla violeta", wallpapers originales, tema e iconos coherentes.
5. **Respeto al usuario.** Sin telemetría, sin publicidad, sin vendor lock-in. Software libre con firmware permitido para que el hardware funcione.

---

## 2. Decisiones técnicas aprobadas

| Decisión     | Elección                          | Justificación                                      |
|--------------|-----------------------------------|----------------------------------------------------|
| Base         | Debian Stable (trixie)            | Máxima estabilidad y soporte largo                 |
| Escritorio   | GNOME                             | Parecido a experiencia móvil/Windows 11            |
| Público      | Hogar, usuarios sin experiencia   | Simplicidad, software completo, ayuda integrada    |
| Idioma       | Español (es_ES.UTF-8) por defecto | Público hispanohablante                            |
| Comandos     | Capa de comandos en español       | Diferenciador clave del proyecto                   |
| Instalador   | Calamares (gráfico, en español)   | Más fácil que el instalador clásico de Debian      |
| Arquitectura | amd64 (primera versión)           | Cubre el 99% de PCs domésticos actuales            |

---

## 3. Identidad visual

- **Nombre:** PerlaOS
- **Versión 1.0:** "Nácar"
- **Paleta:** violetas profundos (#4B2E83, #7B4FA6) + blancos perlados (#F5F0FA) + acentos brillantes (#C084FC)
- **Logo:** perla estilizada sobre una espiral (guiño al espiral de Debian)
- **Wallpaper por defecto:** onda luminosa violeta sobre fondo oscuro
- **Tema:** Adwaita personalizado (Perla-purple) + iconos estilo redondeado

---

## 4. Software incluido por defecto

### Sistema y escritorio
- GNOME completo
- PipeWire + WirePlumber
- NetworkManager
- Firmware-linux

### Productividad y hogar
- LibreOffice (writer, calc, impress) en español
- Firefox ESR en español
- GNOME Software
- Nautilus, File Roller, Evince, Loupe, Totem
- Calculadora, calendario, contactos, reloj, notas, clima

### Multimedia
- Códecs multimedia (gstreamer good/bad/ugly, libav)
- VLC

### Utilidades PerlaOS propias
- Comandos PerlaOS en español
- Asistente de bienvenida (pendiente)
- Centro de ayuda PerlaOS (pendiente)

### Lo que NO lleva
- Sin snapd
- Flatpak soportado opcionalmente
- Sin juegos de ejemplo ni bloatware

---

## 5. Arquitectura del sistema

```
PerlaOS
├── Base: Debian Stable (trixie) + backports selectivos
├── Capa de personalización PerlaOS
│   ├── Tema visual (GTK, iconos, cursores, wallpapers)
│   ├── Ajustes GNOME por defecto (gschema overrides)
│   ├── Comandos en español (/usr/local/lib/perla/)
│   ├── Asistente de bienvenida
│   └── Centro de ayuda
├── Instalador: Calamares
└── Repositorio propio (fase posterior)
```

---

## 6. Comandos en español

Ver implementación en `live-build/config/includes.chroot/usr/local/lib/perla/comandos.sh`

---

## 7. Experiencia de usuario

1. Live USB: el usuario prueba PerlaOS sin instalar nada.
2. Instalación: Calamares en español.
3. Primer arranque: Asistente de bienvenida.
4. Uso diario: GNOME + comandos en español.

---

Documento maestro del proyecto PerlaOS — v0.1, noviembre 2026.
