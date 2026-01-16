# Sodiqning NixOS Konfiguratsiyasi (Pro Version)

Professional, modulli va flake-based NixOS konfiguratsiyasi.

## 📁 Struktura

Ushbu konfiguratsiya modulli tizimga asoslangan:

```
nixos-config/
├── modules/               # Tizim darajasidagi sozlamalar (System-wide)
│   ├── core/              # Boot, User, Locale, Optimization
│   ├── desktop/           # GNOME, Display Manager, Audio
│   ├── networking/        # Network Manager, Firewall
│   └── programs/          # Tizim dasturlari (System Packages)
├── home/                  # Foydalanuvchi sozlamalari (Home Manager)
│   ├── shell/             # Zsh, Starship, Git, Aliases
│   └── desktop/           # User Apps, Cursor, Theming
├── hosts/                 # (Kelajak uchun) Turli xil kompyuterlar
├── flake.nix              # 🚀 Asosiy kirish nuqtasi
└── Makefile               # Qulay boshqaruv skriptlari
```

## 🚀 O'rnatish va Yangilash

Eng oson yo'li (tavsiya etiladi):

```bash
# Tizimni yangilash
./apply.sh

# Yoki make orqali
make
```

Agar xatolik chiqsa yoki qo'lda bajarish kerak bo'lsa:
```bash
sudo nixos-rebuild switch --flake .#sodiq
```

## ✨ Yangi Imkoniyatlar

- **Shell**: Zsh + Starship (Avtomatik to'ldirish va chiroyli prompt).
- **Git**: Integratsiya qilingan va sozланган.
- **Tezlik**: Tizim versiyasi muzlatilgan (pinned), ortiqcha yuklashlar yo'q.
- **Tartib**: Har bir sozlama o'z joyida.

## 🔗 Linklar
- Repo: [github.com/sodops/nix-flake-gnome](https://github.com/sodops/nix-flake-gnome)
