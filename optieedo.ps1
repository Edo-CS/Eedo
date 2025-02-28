# Charger les assemblies pour l'interface graphique
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Creation de la fenetre principale
$form = New-Object System.Windows.Forms.Form
$form.Text = "Eedo Tools - Windows Optimization"
$form.Size = New-Object System.Drawing.Size(800, 700)
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.BackColor = [System.Drawing.Color]::FromArgb(28, 28, 28)
$form.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog

# Creation d'un onglet principal
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Size = New-Object System.Drawing.Size(760, 600)
$tabControl.Location = New-Object System.Drawing.Point(20, 20)
$form.Controls.Add($tabControl)

# Onglet Optimisations
$tabOptimizations = New-Object System.Windows.Forms.TabPage
$tabOptimizations.Text = "Windows Optimizations"
$tabOptimizations.BackColor = [System.Drawing.Color]::FromArgb(37, 37, 38)
$tabControl.Controls.Add($tabOptimizations)

# Onglet Installation Apps
$tabApps = New-Object System.Windows.Forms.TabPage
$tabApps.Text = "Install Applications"
$tabApps.BackColor = [System.Drawing.Color]::FromArgb(37, 37, 38)
$tabControl.Controls.Add($tabApps)

# Creation des groupes de tweaks
function Add-GroupBox {
    param ($title, $yPosition, $parent)
    $groupBox = New-Object System.Windows.Forms.GroupBox
    $groupBox.Text = $title
    $groupBox.ForeColor = [System.Drawing.Color]::White
    $groupBox.Size = New-Object System.Drawing.Size(720, 120)
    $groupBox.Location = New-Object System.Drawing.Point(15, $yPosition)
    $parent.Controls.Add($groupBox)
    return $groupBox
}

$essentialGroup = Add-GroupBox "Essential Tweaks" 10 $tabOptimizations
$advancedGroup = Add-GroupBox "Advanced Tweaks (Caution)" 140 $tabOptimizations
$customizeGroup = Add-GroupBox "Customize Preferences" 270 $tabOptimizations
$performanceGroup = Add-GroupBox "Performance Plans" 400 $tabOptimizations

# Fonction pour creer une case a cocher
function Add-CheckBox {
    param ($text, $groupBox, $yPosition)
    $checkBox = New-Object System.Windows.Forms.CheckBox
    $checkBox.Text = $text
    $checkBox.ForeColor = [System.Drawing.Color]::White
    $checkBox.AutoSize = $true
    $checkBox.Location = New-Object System.Drawing.Point(10, $yPosition)
    $groupBox.Controls.Add($checkBox)
    return $checkBox
}

# Ajout des options dans chaque categorie
$cbRestorePoint = Add-CheckBox "Create Restore Point" $essentialGroup 20
$cbTempFiles = Add-CheckBox "Delete Temporary Files" $essentialGroup 45
$cbTelemetry = Add-CheckBox "Disable Telemetry" $essentialGroup 70

$cbNetworkBlock = Add-CheckBox "Adobe Network Block" $advancedGroup 20
$cbDebloat = Add-CheckBox "Adobe Debloat" $advancedGroup 45
$cbIPv6 = Add-CheckBox "Disable IPv6" $advancedGroup 70

$cbDarkMode = Add-CheckBox "Enable Dark Theme" $customizeGroup 20
$cbNumLock = Add-CheckBox "Enable NumLock on Startup" $customizeGroup 45
$cbShowHidden = Add-CheckBox "Show Hidden Files" $customizeGroup 70

$cbPerformanceMode = Add-CheckBox "Activate Ultimate Performance Mode" $performanceGroup 20

# Boutons d'action
$buttonApply = New-Object System.Windows.Forms.Button
$buttonApply.Text = "Run Tweaks"
$buttonApply.Size = New-Object System.Drawing.Size(180, 40)
$buttonApply.Location = New-Object System.Drawing.Point(130, 620)
$buttonApply.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$buttonApply.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonApply)

$buttonUndo = New-Object System.Windows.Forms.Button
$buttonUndo.Text = "Undo Selected Tweaks"
$buttonUndo.Size = New-Object System.Drawing.Size(180, 40)
$buttonUndo.Location = New-Object System.Drawing.Point(370, 620)
$buttonUndo.BackColor = [System.Drawing.Color]::FromArgb(204, 0, 0)
$buttonUndo.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonUndo)

# Ajout de l'onglet des applications
$installChrome = New-Object System.Windows.Forms.Button
$installChrome.Text = "Install Google Chrome"
$installChrome.Size = New-Object System.Drawing.Size(200, 40)
$installChrome.Location = New-Object System.Drawing.Point(50, 50)
$installChrome.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$installChrome.ForeColor = [System.Drawing.Color]::White
$tabApps.Controls.Add($installChrome)

$installVLC = New-Object System.Windows.Forms.Button
$installVLC.Text = "Install VLC Media Player"
$installVLC.Size = New-Object System.Drawing.Size(200, 40)
$installVLC.Location = New-Object System.Drawing.Point(50, 110)
$installVLC.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$installVLC.ForeColor = [System.Drawing.Color]::White
$tabApps.Controls.Add($installVLC)

# Afficher la fenetre
$form.ShowDialog()
