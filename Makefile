# Tizimni yangilash uchun Makefile

# Default komanda
all: switch

# Tizimni yangilash
switch:
	sudo nixos-rebuild switch --flake .#sodiq

# Test qilish (o'rnatmasdan)
check:
	nix flake check
	sudo nixos-rebuild dry-build --flake .#sodiq

# Home Manager ni yangilash (faqat user sozlamalari)
home:
	home-manager switch --flake .#sodiq

.PHONY: all switch check home
