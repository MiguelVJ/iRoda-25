#!/bin/bash
set -e

echo "=== XCODE CLOUD WORKSPACE FIX ==="

# Configurar environment
export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"

# 1. Build Ionic
echo "🔨 Building Ionic app..."
npm ci
ionic build

# 2. Preparar iOS
echo "📱 Preparing iOS platform..."
ionic cordova prepare ios

# 3. Navegar a iOS
cd platforms/ios

# 4. Instalar CocoaPods
echo "📦 Installing CocoaPods..."
gem install cocoapods --user-install --no-document

echo "🔧 Installing Pods..."
pod install --repo-update --clean-install

# 5. ✅✅✅ SOLUCIÓN CRÍTICA: FORZAR WORKSPACE ✅✅✅
echo "🚨 FORZANDO USO DEL WORKSPACE..."

# Crear directorio de schemes si no existe
mkdir -p "LUA Studio.xcworkspace/xcshareddata"

# Copiar scheme del project al workspace (si existe)
if [ -f "LUA Studio.xcodeproj/xcshareddata/LUA Studio.xcscheme" ]; then
    cp "LUA Studio.xcodeproj/xcshareddata/LUA Studio.xcscheme" "LUA Studio.xcworkspace/xcshareddata/"
    echo "✅ Scheme copiado al workspace"
fi

# ✅ ELIMINAR COMPLETAMENTE EL SCHEME DEL PROJECT
rm -rf "LUA Studio.xcodeproj/xcshareddata" 2>/dev/null || true

# ✅ CREAR SCHEME MANUALMENTE SI NO EXISTE
if [ ! -f "LUA Studio.xcworkspace/xcshareddata/LUA Studio.xcscheme" ]; then
    cat > "LUA Studio.xcworkspace/xcshareddata/LUA Studio.xcscheme" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Scheme LastUpgradeVersion = "1500" version = "1.7">
   <BuildAction parallelizeBuildables = "YES" buildImplicitDependencies = "YES">
      <BuildActionEntries>
         <BuildActionEntry buildForTesting = "YES" buildForRunning = "YES" buildForProfiling = "YES" buildForArchiving = "YES" buildForAnalyzing = "YES">
            <BuildableReference BuildableIdentifier = "primary" BlueprintIdentifier = "PRIMARY_TARGET_ID" BuildableName = "LUA Studio.app" BlueprintName = "LUA Studio" ReferencedContainer = "container:LUA Studio.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
   <TestAction buildConfiguration = "Debug" selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB" selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB" shouldUseLaunchSchemeArgsEnv = "YES">
      <Testables>
      </Testables>
   </TestAction>
   <LaunchAction buildConfiguration = "Debug" selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB" selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB" launchStyle = "0" useCustomWorkingDirectory = "NO" ignoresPersistentStateOnLaunch = "NO" debugDocumentVersioning = "YES" debugServiceExtension = "internal" allowLocationSimulation = "YES">
      <BuildableProductRunnable runnableDebuggingMode = "0">
         <BuildableReference BuildableIdentifier = "primary" BlueprintIdentifier = "PRIMARY_TARGET_ID" BuildableName = "LUA Studio.app" BlueprintName = "LUA Studio" ReferencedContainer = "container:LUA Studio.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </LaunchAction>
   <ProfileAction buildConfiguration = "Release" shouldUseLaunchSchemeArgsEnv = "YES" savedToolIdentifier = "" useCustomWorkingDirectory = "NO" debugDocumentVersioning = "YES">
      <BuildableProductRunnable runnableDebuggingMode = "0">
         <BuildableReference BuildableIdentifier = "primary" BlueprintIdentifier = "PRIMARY_TARGET_ID" BuildableName = "LUA Studio.app" BlueprintName = "LUA Studio" ReferencedContainer = "container:LUA Studio.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </ProfileAction>
   <AnalyzeAction buildConfiguration = "Debug"/>
   <ArchiveAction buildConfiguration = "Release" revealArchiveInOrganizer = "YES"/>
</Scheme>
EOF
    echo "✅ Scheme creado manualmente en workspace"
fi

# 6. VERIFICACIÓN EXTREMA
echo "🔍 VERIFICACIÓN FINAL:"
echo "Workspace existe:" && [ -d "LUA Studio.xcworkspace" ] && echo "✅ SÍ" || echo "❌ NO"
echo "Scheme en workspace existe:" && [ -f "LUA Studio.xcworkspace/xcshareddata/LUA Studio.xcscheme" ] && echo "✅ SÍ" || echo "❌ NO"
echo "Scheme en project existe:" && [ -f "LUA Studio.xcodeproj/xcshareddata/LUA Studio.xcscheme" ] && echo "❌ SÍ (PROBLEMA)" || echo "✅ NO (CORRECTO)"

# Listar estructura
echo "📁 Estructura final:"
find . -name "*.xcscheme" -type f
find . -name "*.xcworkspace" -type d

echo "✅✅✅ CONFIGURACIÓN WORKSPACE COMPLETADA ✅✅✅"