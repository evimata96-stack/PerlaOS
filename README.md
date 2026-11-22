# PerlaOS

**PerlaOS** es un sistema operativo doméstico basado en **Debian Stable (Trixie)** con entorno **GNOME**, diseñado para que cualquier persona hispanohablante lo use sin conocimientos técnicos.

> Debian es la concha (sólida, estable, probada).  
> **PerlaOS** es la perla que se forma encima: pulida, elegante y fácil de usar.

---

## Principios

1. **Cero terminal obligatoria** — Todo se hace con clic.
2. **Español de serie** — Sistema, instalador, aplicaciones y ayuda en español.
3. **Estabilidad ante todo** — Base Debian Stable.
4. **Belleza cuidada** — Identidad visual propia (paleta perla violeta).
5. **Respeto al usuario** — Sin telemetría, sin publicidad, software libre.

---

## Características principales

- Base: Debian Stable (Trixie)
- Escritorio: GNOME
- Instalador: Calamares (en español)
- Capa de comandos en español (`instalar`, `copia`, `borra`, `ayuda`...)
- Tema visual propio (Perla-purple)
- Asistente de bienvenida
- Solo amd64 en la versión 1.0

---

## Versión actual

- **1.0 "Nácar"** (en desarrollo)

---

## Estructura del proyecto

```
PerlaOS/
├── config/                  # Configuración de live-build
│   ├── package-lists/       # Listas de paquetes
│   ├── includes.chroot/     # Archivos que se copian al sistema
│   └── hooks/               # Scripts de personalización
├── branding/                # Logo, wallpapers, tema
├── calamares/               # Configuración del instalador
├── docs/                    # Documentación
└── scripts/                 # Scripts de construcción
```

---

## Cómo construir la ISO (desarrollo)

```bash
# Requisitos
sudo apt install live-build

# Construir
sudo lb clean
sudo lb config
sudo lb build
```

---

## Estado del proyecto

| Fase | Contenido                              | Estado     |
|------|----------------------------------------|------------|
| 0    | Definición                             | ✅ Hecho   |
| 1    | Identidad visual                       | 🟡 En curso |
| 2    | ISO funcional (live-build + Calamares) | 🟡 En curso |
| 3    | Utilidades propias                     | ⬜ Pendiente |
| 4    | Pruebas beta                           | ⬜ Pendiente |
| 5    | Lanzamiento 1.0 "Nácar"                | ⬜ Pendiente |

---

## Licencia

Este proyecto se distribuye bajo los términos de la **GNU General Public License v3** (o posterior).  
La base del sistema es Debian, que tiene su propia política de licencias.

---

**Proyecto iniciado en noviembre 2026.**  
Hecho con ❤️ para la comunidad hispanohablante.
