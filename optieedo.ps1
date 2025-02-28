# Charger les assemblies nécessaires pour l'interface graphique
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Création de la fenêtre principale
$form = New-Object System.Windows.Forms.Form
$form.Text = "Eedo Tools - Windows Optimization"
$form.Size = New-Object System.Drawing.Size(700, 650)
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.BackColor = [System.Drawing.Color]::FromArgb(28, 28, 28)  # Fond sombre
$form.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog

# Logo et titre
$logoLabel = New-Object System.Windows.Forms.Label
$logoLabel.Text = "Eedo Tools"
$logoLabel.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$logoLabel.ForeColor = [System.Drawing.Color]::White
$logoLabel.AutoSize = $true
$logoLabel.Location = New-Object System.Drawing.Point(20, 20)
$form.Controls.Add($logoLabel)

# Panneau principal
$panel = New-Object System.Windows.Forms.Panel
$panel.Location = New-Object System.Drawing.Point(20, 60)
$panel.Size = New-Object System.Drawing.Size(650, 480)
$panel.BackColor = [System.Drawing.Color]::FromArgb(37, 37, 38)
$panel.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$form.Controls.Add($panel)

# Fonction pour créer des groupes de paramètres
function Add-GroupBox {
    param ($title, $yPosition)
    $groupBox = New-Object System.Windows.Forms.GroupBox
    $groupBox.Text = $title
    $groupBox.ForeColor = [System.Drawing.Color]::White
    $groupBox.Size = New-Object System.Drawing.Size(620, 120)
    $groupBox.Location = New-Object System.Drawing.Point(15, $yPosition)
    $panel.Controls.Add($groupBox)
    return $groupBox
}

# Ajouter les catégories
$essentialGroup = Add-GroupBox "Essential Tweaks" 10
$advancedGroup = Add-GroupBox "Advanced Tweaks (Caution)" 140
$customizeGroup = Add-GroupBox "Customize Preferences" 270
$performanceGroup = Add-GroupBox "Performance Plans" 400

# Fonction pour créer une case à cocher
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

# Ajouter les options dans chaque catégorie
$cbRestorePoint = Add-CheckBox "Create Restore Point" $essentialGroup 20
$cbTempFiles = Add-CheckBox "Delete Temporary Files" $essentialGroup 45
$cbTelemetry = Add-CheckBox "Disable Telemetry" $essentialGroup 70

$cbNetworkBlock = Add-CheckBox "Adobe Network Block" $advancedGroup 20
$cbDebloat = Add-CheckBox "Adobe Debloat" $advancedGroup 45
$cbIPv6 = Add-CheckBox "Disable IPv6" $advancedGroup 70

$cbDarkMode = Add-CheckBox "Dark Theme for Windows" $customizeGroup 20
$cbNumLock = Add-CheckBox "NumLock on Startup" $customizeGroup 45
$cbShowHidden = Add-CheckBox "Show Hidden Files" $customizeGroup 70

$cbPerformanceMode = Add-CheckBox "Activate Ultimate Performance Mode" $performanceGroup 20

# Boutons d'action
$buttonApply = New-Object System.Windows.Forms.Button
$buttonApply.Text = "Run Tweaks"
$buttonApply.Size = New-Object System.Drawing.Size(180, 40)
$buttonApply.Location = New-Object System.Drawing.Point(130, 560)
$buttonApply.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$buttonApply.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonApply)

$buttonUndo = New-Object System.Windows.Forms.Button
$buttonUndo.Text = "Undo Selected Tweaks"
$buttonUndo.Size = New-Object System.Drawing.Size(180, 40)
$buttonUndo.Location = New-Object System.Drawing.Point(370, 560)
$buttonUndo.BackColor = [System.Drawing.Color]::FromArgb(204, 0, 0)
$buttonUndo.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($buttonUndo)

# Fonction pour appliquer les tweaks
function Apply-Tweaks {
    if ($cbRestorePoint.Checked) {
        Checkpoint-Computer -Description "EedoTools Restore Point" -RestorePointType "MODIFY_SETTINGS"
    }
    if ($cbTempFiles.Checked) {
        Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force
        Remove-Item -Path "$env:TEMP\*" -Recurse -Force
    }
    if ($cbTelemetry.Checked) {
        Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0
    }
    if ($cbNetworkBlock.Checked) {
        New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\Tcpip\Parameters" -Name "DisableTaskOffload" -PropertyType DWord -Value 1 -Force
    }
    if ($cbDarkMode.Checked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
    }
    if ($cbPerformanceMode.Checked) {
        powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    }
    [System.Windows.Forms.MessageBox]::Show("Tweaks Applied Successfully!", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}

# Fonction pour annuler les tweaks
function Undo-Tweaks {
    if ($cbTelemetry.Checked) {
        Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry"
    }
    if ($cbDarkMode.Checked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 1
    }
    [System.Windows.Forms.MessageBox]::Show("Selected Tweaks Undone!", "Reverted", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
}

# Lier les boutons aux fonctions
$buttonApply.Add_Click({ Apply-Tweaks })
$buttonUndo.Add_Click({ Undo-Tweaks })

# Afficher la fenêtre
$form.ShowDialog()
