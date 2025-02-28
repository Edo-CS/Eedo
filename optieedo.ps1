# Charger les assemblies nécessaires pour l'interface graphique
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Créer la fenêtre principale
$form = New-Object System.Windows.Forms.Form
$form.Text = "Optimisations Windows"  # Titre de la fenêtre
$form.Size = New-Object System.Drawing.Size(600, 500)
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.BackColor = [System.Drawing.Color]::FromArgb(28, 28, 28)  # Fond sombre
$form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("C:\Windows\System32\shell32.dll")

# Titre principal
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Text = "Optimisation du Système"
$titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$titleLabel.ForeColor = [System.Drawing.Color]::White
$titleLabel.Location = New-Object System.Drawing.Point(20, 20)
$titleLabel.Size = New-Object System.Drawing.Size(300, 40)
$form.Controls.Add($titleLabel)

# Créer un panneau pour les optimisations
$panelOptimizations = New-Object System.Windows.Forms.Panel
$panelOptimizations.Location = New-Object System.Drawing.Point(20, 70)
$panelOptimizations.Size = New-Object System.Drawing.Size(550, 350)
$panelOptimizations.BackColor = [System.Drawing.Color]::FromArgb(37, 37, 38)
$panelOptimizations.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$form.Controls.Add($panelOptimizations)

# Créer les labels pour chaque optimisation
$labelVisuals = New-Object System.Windows.Forms.Label
$labelVisuals.Text = "Désactiver les effets visuels (réduit l'utilisation des ressources)"
$labelVisuals.ForeColor = [System.Drawing.Color]::White
$labelVisuals.Location = New-Object System.Drawing.Point(10, 20)
$labelVisuals.Size = New-Object System.Drawing.Size(530, 20)
$panelOptimizations.Controls.Add($labelVisuals)

$checkboxVisuals = New-Object System.Windows.Forms.CheckBox
$checkboxVisuals.Text = "Désactiver"
$checkboxVisuals.Location = New-Object System.Drawing.Point(450, 20)
$checkboxVisuals.ForeColor = [System.Drawing.Color]::White
$panelOptimizations.Controls.Add($checkboxVisuals)

$labelServices = New-Object System.Windows.Forms.Label
$labelServices.Text = "Désactiver les services inutiles (comme Windows Update, etc.)"
$labelServices.ForeColor = [System.Drawing.Color]::White
$labelServices.Location = New-Object System.Drawing.Point(10, 60)
$labelServices.Size = New-Object System.Drawing.Size(530, 20)
$panelOptimizations.Controls.Add($labelServices)

$checkboxServices = New-Object System.Windows.Forms.CheckBox
$checkboxServices.Text = "Désactiver"
$checkboxServices.Location = New-Object System.Drawing.Point(450, 60)
$checkboxServices.ForeColor = [System.Drawing.Color]::White
$panelOptimizations.Controls.Add($checkboxServices)

$labelNotifications = New-Object System.Windows.Forms.Label
$labelNotifications.Text = "Désactiver les notifications Windows (pour éviter les distractions)"
$labelNotifications.ForeColor = [System.Drawing.Color]::White
$labelNotifications.Location = New-Object System.Drawing.Point(10, 100)
$labelNotifications.Size = New-Object System.Drawing.Size(530, 20)
$panelOptimizations.Controls.Add($labelNotifications)

$checkboxNotifications = New-Object System.Windows.Forms.CheckBox
$checkboxNotifications.Text = "Désactiver"
$checkboxNotifications.Location = New-Object System.Drawing.Point(450, 100)
$checkboxNotifications.ForeColor = [System.Drawing.Color]::White
$panelOptimizations.Controls.Add($checkboxNotifications)

$labelTelemetry = New-Object System.Windows.Forms.Label
$labelTelemetry.Text = "Désactiver la télémétrie (envoi de données de diagnostic à Microsoft)"
$labelTelemetry.ForeColor = [System.Drawing.Color]::White
$labelTelemetry.Location = New-Object System.Drawing.Point(10, 140)
$labelTelemetry.Size = New-Object System.Drawing.Size(530, 20)
$panelOptimizations.Controls.Add($labelTelemetry)

$checkboxTelemetry = New-Object System.Windows.Forms.CheckBox
$checkboxTelemetry.Text = "Désactiver"
$checkboxTelemetry.Location = New-Object System.Drawing.Point(450, 140)
$checkboxTelemetry.ForeColor = [System.Drawing.Color]::White
$panelOptimizations.Controls.Add($checkboxTelemetry)

$labelCortana = New-Object System.Windows.Forms.Label
$labelCortana.Text = "Désactiver Cortana (l'assistant virtuel)"
$labelCortana.ForeColor = [System.Drawing.Color]::White
$labelCortana.Location = New-Object System.Drawing.Point(10, 180)
$labelCortana.Size = New-Object System.Drawing.Size(530, 20)
$panelOptimizations.Controls.Add($labelCortana)

$checkboxCortana = New-Object System.Windows.Forms.CheckBox
$checkboxCortana.Text = "Désactiver"
$checkboxCortana.Location = New-Object System.Drawing.Point(450, 180)
$checkboxCortana.ForeColor = [System.Drawing.Color]::White
$panelOptimizations.Controls.Add($checkboxCortana)

$labelApps = New-Object System.Windows.Forms.Label
$labelApps.Text = "Supprimer les applications préinstallées comme OneDrive, Xbox"
$labelApps.ForeColor = [System.Drawing.Color]::White
$labelApps.Location = New-Object System.Drawing.Point(10, 220)
$labelApps.Size = New-Object System.Drawing.Size(530, 20)
$panelOptimizations.Controls.Add($labelApps)

$checkboxApps = New-Object System.Windows.Forms.CheckBox
$checkboxApps.Text = "Supprimer"
$checkboxApps.Location = New-Object System.Drawing.Point(450, 220)
$checkboxApps.ForeColor = [System.Drawing.Color]::White
$panelOptimizations.Controls.Add($checkboxApps)

# Bouton d'exécution des optimisations
$buttonApply = New-Object System.Windows.Forms.Button
$buttonApply.Text = "Appliquer les optimisations"
$buttonApply.Size = New-Object System.Drawing.Size(250, 40)
$buttonApply.Location = New-Object System.Drawing.Point(175, 420)
$buttonApply.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)  # Bleu attrayant
$buttonApply.ForeColor = [System.Drawing.Color]::White
$buttonApply.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$form.Controls.Add($buttonApply)

# Fonction pour appliquer les optimisations
function Apply-Optimizations {
    if ($checkboxVisuals.Checked) {
        # Désactivation des effets visuels
        $VisualEffects = "HKCU:\Control Panel\Desktop"
        Set-ItemProperty -Path $VisualEffects -Name "VisualFXSetting" -Value 2
    }

    if ($checkboxServices.Checked) {
        # Désactivation des services inutiles
        $servicesToDisable = @("wuauserv", "bits", "Spooler", "DiagTrack")
        foreach ($service in $servicesToDisable) {
            Set-Service -Name $service -StartupType Disabled
            Stop-Service -Name $service
        }
    }

    if ($checkboxNotifications.Checked) {
        # Désactivation des notifications
        $NotificationSettings = "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications"
        Set-ItemProperty -Path $NotificationSettings -Name "ToastEnabled" -Value 0
        Set-ItemProperty -Path $NotificationSettings -Name "NoToastApplicationNotification" -Value 1
    }

    if ($checkboxTelemetry.Checked) {
        # Désactivation de la télémétrie
        $TelemetrySettings = "HKLM:\Software\Policies\Microsoft\Windows\DataCollection"
        Set-ItemProperty -Path $TelemetrySettings -Name "AllowTelemetry" -Value 0
    }

    if ($checkboxCortana.Checked) {
        # Désactivation de Cortana
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaEnabled" -Value 0
    }

    if ($checkboxApps.Checked) {
        # Suppression des applications préinstallées
        Get-AppxPackage *Xbox* | Remove-AppxPackage
        Get-AppxPackage *OneDrive* | Remove-AppxPackage
    }

    # Affichage d'un message de confirmation
    [System.Windows.Forms.MessageBox]::Show("Optimisations terminées !", "Succès", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}

# Action à effectuer lors du clic sur le bouton
$buttonApply.Add_Click({ Apply-Optimizations })

# Afficher le formulaire
$form.ShowDialog()
