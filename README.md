# Sodiqning NixOS Konfiguratsiyasi

Custom flake-based NixOS konfiguratsiyasi Home Manager bilan.

## 📁 Struktura

```
nixos-config/
├── flake.nix                  # Flake konfiguratsiyasi
├── flake.lock                 # Dependencies lock
├── configuration.nix          # NixOS sistema sozlamalari
├── hardware-configuration.nix # Apparat konfiguratsiyasi
└── home.nix                   # Home Manager konfiguratsiyasi
```

## 🚀 Qo'llash

### Birinchi marta o'rnatish

```bash
# Repositoryni clone qilish
git clone https://github.com/sodops/nix-flake-gnome.git /home/sodiq/nixos-config
cd /home/sodiq/nixos-config

# Sistemani yangilash
make

# Yoki (agar make bo'lmasa)
./apply.sh

# Qo'lda yangilash
sudo nixos-rebuild switch --flake .#sodiq
```

### Keyingi yangilanishlar

```bash
cd /home/sodiq/nixos-config
sudo nixos-rebuild switch --flake .#sodiq
```

### Faqat Home Manager ni yangilash

```bash
home-manager switch --flake .#sodiq
```

### Test qilish (build qilmasdan)

```bash
# Konfiguratsiya to'g'riligini tekshirish
nix flake check

# Dry build (hech narsa o'rnatmasdan test)
sudo nixos-rebuild dry-build --flake .#sodiq
```

## 📦 O'rnatilgan Paketlar

### GUI Dasturlar
- Telegram Desktop
- Google Chrome
- Discord
- Spotify
- VS Code
- Postman
- OBS Studio
- Firefox
- Antigravity (AI kod yordamchisi)

### DevOps Tools
- Docker & Docker Compose
- Kubernetes (kubectl, helm)
- Terraform
- Ansible

### Desktop Environment
- GNOME Desktop
- GDM Display Manager
- GSConnect (Android integratsiyasi)

## ⚙️ Asosiy Sozlamalar

- **Bootloader**: systemd-boot (max 2 konfiguratsiya)
- **Time Zone**: Asia/Tashkent
- **Locale**: en_US.UTF-8
- **Cursor**: Bibata Modern Ice
- **Nix Features**: flakes, nix-command
- **Garbage Collection**: Haftalik, 7 kundan eski fayllarni o'chirish
- **ZRAM**: 50% RAM compressed swap

## 🔧 Konfiguratsiyani O'zgartirish

1. Kerakli faylni tahrirlang (`configuration.nix` yoki `home.nix`)
2. Sistemani yangilang:
   ```bash
   sudo nixos-rebuild switch --flake .#sodiq
   ```

## 📌 Eslatmalar

- Barcha konfiguratsiya flake orqali boshqariladi
- `/etc/nixos/` dan foydalanish shart emas
- Hardware konfiguratsiyasini o'zgartirmang (avtomatik yaratilgan)
- Version control uchun Git ishlatiladi

## 🔗 Foydali Havolalar

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
