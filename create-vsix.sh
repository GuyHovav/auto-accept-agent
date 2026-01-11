#!/bin/bash
set -e

# Clean up old build
rm -f auto-accept-agent-7.5.0-pro.vsix

# Create temporary directory
TEMP_DIR=$(mktemp -d)
echo "Creating VSIX in $TEMP_DIR"

# Copy necessary files
cp package.json "$TEMP_DIR/"
cp -r dist "$TEMP_DIR/"
cp settings-panel.js "$TEMP_DIR/"
cp config.js "$TEMP_DIR/"
cp -r main_scripts "$TEMP_DIR/"
cp -r media "$TEMP_DIR/" 2>/dev/null || true
cp LICENSE.md "$TEMP_DIR/" 2>/dev/null || true
cp README.md "$TEMP_DIR/" 2>/dev/null || true

# Copy ws module
mkdir -p "$TEMP_DIR/node_modules"
cp -r node_modules/ws "$TEMP_DIR/node_modules/"

# Create [Content_Types].xml
cat > "$TEMP_DIR/[Content_Types].xml" << 'XMLEOF'
<?xml version="1.0" encoding="utf-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="json" ContentType="application/json"/>
  <Default Extension="js" ContentType="application/javascript"/>
  <Default Extension="md" ContentType="text/markdown"/>
  <Default Extension="png" ContentType="image/png"/>
</Types>
XMLEOF

# Create extension.vsixmanifest
cat > "$TEMP_DIR/extension.vsixmanifest" << 'MANIFESTEOF'
<?xml version="1.0" encoding="utf-8"?>
<PackageManifest Version="2.0.0" xmlns="http://schemas.microsoft.com/developer/vsx-schema/2011">
  <Metadata>
    <Identity Language="en-US" Id="auto-accept-agent" Version="7.5.0" Publisher="MunKhin"/>
    <DisplayName>Auto Accept Agent</DisplayName>
    <Description>Auto Accept Agent: Automated Cursor and Antigravity workflow with Pro recovery tools.</Description>
  </Metadata>
  <Installation>
    <InstallationTarget Id="Microsoft.VisualStudio.Code"/>
  </Installation>
  <Dependencies/>
  <Assets>
    <Asset Type="Microsoft.VisualStudio.Code.Manifest" Path="extension/package.json"/>
  </Assets>
</PackageManifest>
MANIFESTEOF

# Create extension directory and move files
mkdir -p "$TEMP_DIR/extension"
mv "$TEMP_DIR/package.json" "$TEMP_DIR/extension/"
mv "$TEMP_DIR/dist" "$TEMP_DIR/extension/"
mv "$TEMP_DIR/settings-panel.js" "$TEMP_DIR/extension/"
mv "$TEMP_DIR/config.js" "$TEMP_DIR/extension/"
mv "$TEMP_DIR/main_scripts" "$TEMP_DIR/extension/"
mv "$TEMP_DIR/node_modules" "$TEMP_DIR/extension/"
[ -d "$TEMP_DIR/media" ] && mv "$TEMP_DIR/media" "$TEMP_DIR/extension/" || true
[ -f "$TEMP_DIR/LICENSE.md" ] && mv "$TEMP_DIR/LICENSE.md" "$TEMP_DIR/extension/" || true
[ -f "$TEMP_DIR/README.md" ] && mv "$TEMP_DIR/README.md" "$TEMP_DIR/extension/" || true

# Create VSIX (which is just a ZIP file)
cd "$TEMP_DIR"
zip -r auto-accept-agent-7.5.0-pro.vsix . -x "*.git*"

# Move VSIX to original directory
mv auto-accept-agent-7.5.0-pro.vsix "$OLDPWD/"

# Cleanup
cd "$OLDPWD"
rm -rf "$TEMP_DIR"

echo "✅ VSIX created: auto-accept-agent-7.5.0-pro.vsix"
ls -lh auto-accept-agent-7.5.0-pro.vsix
