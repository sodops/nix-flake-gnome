#!/usr/bin/env bash
# Reset GNOME to default settings
# This fixes icons, fonts, and appearance after KDE installation

echo "🔄 Resetting GNOME to defaults"
echo "==============================="
echo ""

# Reset GNOME Shell settings
echo "📝 Resetting GNOME Shell..."
dconf reset -f /org/gnome/shell/

# Reset desktop interface settings
echo "📝 Resetting desktop interface..."
dconf reset -f /org/gnome/desktop/interface/

# Reset window manager settings
echo "📝 Resetting window manager..."
dconf reset -f /org/gnome/desktop/wm/

# Reset theme settings
echo "📝 Resetting theme..."
gsettings reset org.gnome.desktop.interface gtk-theme
gsettings reset org.gnome.desktop.interface icon-theme
gsettings reset org.gnome.desktop.interface cursor-theme

# Reset font settings
echo "📝 Resetting fonts..."
gsettings reset org.gnome.desktop.interface font-name
gsettings reset org.gnome.desktop.interface document-font-name
gsettings reset org.gnome.desktop.interface monospace-font-name
gsettings reset org.gnome.desktop.wm.preferences titlebar-font

echo ""
echo "✅ GNOME reset complete!"
echo ""
echo "Please log out and log back in for changes to take effect."
