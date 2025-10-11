# abdallahnas-compose

Docker Compose infrastructure for AbdallahNAS home media server and related services.

## Overview

This repository contains Docker Compose configurations for a complete home media server setup, organized into separate service stacks for better management and isolation.

## Repository Structure

```
├── database/          # PostgreSQL 18 (shared database)
├── downloaders/       # Download clients (qBittorrent, slskd, SABnzbd) with VPN
├── media_managers/    # Servarr stack (Prowlarr, Sonarr, Radarr, Lidarr)
├── plex/             # Plex Media Server and helpers (Tautulli, Kometa, etc.)
├── public/           # Public-facing services (Jellyseerr, Komga, Vaultwarden, etc.)
├── kaizoku/          # Manga downloader
├── monitoring/       # Monitoring tools (speedtest-tracker)
├── game-servers/     # Minecraft servers with Velocity proxy
├── discord-bots/     # Discord music bots
├── proxy/            # Caddy reverse proxy with custom error pages
├── portainer/        # Docker management UI
├── infrastructure/   # Core services (Watchtower)
└── gitlab/           # GitLab (planned - .env.example provided)
```

## Prerequisites

- Docker Engine
- Docker Compose v2
- TrueNAS or similar NAS with network shares
- Environment variables configured in each service directory

## Quick Start

1. Clone this repository to your TrueNAS system
2. Copy `.env.example` files to `.env` in each service directory (if provided)
3. Configure environment variables for your setup
4. Create required Docker networks:
   ```bash
   docker network create downloaders
   docker network create media_management
   ```
5. Start services individually:
   ```bash
   cd <service-directory>
   docker compose up -d
   ```

## Key Features

- **VPN Protection**: All torrent traffic routed through Gluetun (AirVPN Wireguard)
- **Database Backend**: Shared PostgreSQL instance for multiple services
- **Network Isolation**: Each stack has dedicated networks for security
- **Automatic Updates**: Watchtower manages container updates
- **Media Management**: Complete Servarr stack with quality profiles
- **Game Servers**: Minecraft with automatic mod updates via Modrinth

## Environment Variables

Each service requires its own `.env` file. Common variables include:

- `PUID`, `PGID`: User/group IDs for file permissions
- `TZ`: Timezone (e.g., America/Los_Angeles)
- `MEDIA_PATH`: Path to media storage
- `DOCKER_PATH`: Path to container config/data
- `PG_HOST`, `PG_PORT`, `PG_USER`, `PG_PASS`: PostgreSQL connection details

See individual service directories for specific requirements.

## Network Architecture

- **downloaders**: Shared between download clients and media managers
- **media_management**: Shared between media managers and public services
- **public**: Isolated network for public-facing services
- **monitoring**: Isolated network for monitoring tools
- **kaizoku**: Isolated network for manga downloader

## Managing Services

Start a stack:
```bash
cd <service-directory>
docker compose up -d
```

Stop a stack:
```bash
cd <service-directory>
docker compose down
```

View logs:
```bash
cd <service-directory>
docker compose logs -f [service-name]
```

Update images:
```bash
cd <service-directory>
docker compose pull
docker compose up -d
```

## Documentation

For detailed architecture information and development guidelines, see [CLAUDE.md](CLAUDE.md).

## License

Private repository for personal use.
