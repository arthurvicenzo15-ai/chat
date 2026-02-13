# Instalação detalhada (Academy PVP)

## 1) Dependências

```bash
sudo apt update
sudo apt install -y git curl tar xz-utils mariadb-server
```

## 2) Banco de dados

```bash
sudo mysql -e "CREATE DATABASE IF NOT EXISTS fivem_academy CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER IF NOT EXISTS 'fivem'@'%' IDENTIFIED BY 'troque_essa_senha';"
sudo mysql -e "GRANT ALL PRIVILEGES ON fivem_academy.* TO 'fivem'@'%'; FLUSH PRIVILEGES;"
mysql -u fivem -p fivem_academy < sql/001_academy_schema.sql
```

## 3) Configuração da base

```bash
cp .env.example .env
# Edite .env
```

Edite também `server.cfg`:
- `sv_licenseKey`
- string do MySQL
- `sv_hostname`

## 4) Instalar FXServer

```bash
bash scripts/setup_server.sh
```

## 5) Subir servidor

```bash
bash scripts/start_server.sh
```

## 6) Dependências que você deve instalar manualmente

- `oxmysql` (resource):
  - GitHub: https://github.com/overextended/oxmysql
  - Coloque em `resources/[standalone]/oxmysql` e adicione `ensure oxmysql` no `server.cfg`.

## 7) Melhorias recomendadas para Academy PVP

- Sistema de fila por modo (`/queue 1v1`, `/queue 2v2`).
- Elo/MMR por arma e por modo.
- Warmup + rounds curtos.
- Sistema de espectador com câmera livre.
- Proteção de spawnkill com tempo curto de invulnerabilidade.
