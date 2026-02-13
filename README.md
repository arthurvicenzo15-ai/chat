# Base FiveM - Academy PVP

Este repositório entrega uma **base inicial funcional** para subir um servidor FiveM focado em Academy PVP (treino, arena, loadout e placar simples).

## O que já está incluso

- Estrutura de servidor (`server.cfg`, scripts de setup e start).
- Resource `academy_core` com:
  - Spawn na arena.
  - Seleção rápida de kit (AK/M4/SMG/Sniper).
  - Contagem de kills/deaths.
  - Comandos `/kit`, `/stats`, `/resetkd`.
- Resource `academy_pvp_mode` com:
  - Captura de kill/death pelo evento basegame.
  - Broadcast de killfeed no chat.
- SQL inicial para ranking e persistência básica.
- Guia de instalação com tudo que é necessário (incluindo o que não pode ser distribuído aqui).

## O que **não** pode ser distribuído aqui (e onde conseguir)

1. **Artefatos oficiais do servidor FiveM (FXServer binaries)**
   - Baixe em: https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/
2. **Key do servidor (sv_licenseKey)**
   - Gere em: https://keymaster.fivem.net/
3. **Banco MySQL/MariaDB gerenciado** (produção)
   - Pode usar: Aiven, PlanetScale (MySQL compat), AWS RDS, DigitalOcean Managed Databases.
4. **Anti-cheat premium / AC proprietário** (opcional)
   - Deve ser adquirido com fornecedores externos.
5. **MLOs/Mapas/Assets pagos**
   - Comprar em lojas confiáveis (Tebex dos criadores, por exemplo).

## Requisitos

- Ubuntu 22.04+ (ou Debian 12+)
- `git`, `curl`, `tar`, `xz-utils`
- MariaDB/MySQL
- Porta aberta (ex.: `30120` TCP/UDP)

## Setup rápido

```bash
cp .env.example .env
# preencha variáveis (IP, key, DB)

bash scripts/setup_server.sh
bash scripts/start_server.sh
```

## Próximos passos recomendados para Academy PVP

- Adicionar sistema de matchmaking por MMR.
- Separar arenas por modo (`1v1`, `2v2`, `FFA`).
- Integrar anticheat robusto.
- Adicionar painel web de ranking.
- Implementar temporadas e reset automático de elo.

## Estrutura

```text
.
├── server.cfg
├── scripts/
├── resources/[academy]/
│   ├── academy_core/
│   └── academy_pvp_mode/
├── sql/
└── docs/
```

## Importante

Este projeto é base inicial para desenvolvimento. Para operar em produção, configure backup, monitoramento, proteção DDoS e anticheat avançado.
