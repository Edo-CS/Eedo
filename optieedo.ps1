# Charger les assemblies nécessaires pour l'interface graphique
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Créer la fenêtre principale
$form = New-Object System.Windows.Forms.Form
$form.Text = "Optimisations Windows"  # Titre de la fenêtre
$form.Size = New-Object System.Drawing.Size(600, 400)
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
$panelOptimizations.Size = New-Object System.Drawing.Size(550, 250)
$panelOptimizations.BackColor = [System.Drawing.Color]::FromArgb(37, 37, 38)
$panelOptimizations.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$form.Controls.Add($panelOptimizations)

# Créer les cases à cocher pour chaque optimisation
$checkboxVisuals = New-Object System.Windows.Forms.CheckBox
$checkboxVisuals.Text = "Désactiver les effets visuels"
$checkboxVisuals.Location = New-Object System.Drawing.Point(10, 20)
$checkboxVisuals.ForeColor = [System.Drawing.Color]::White
$panelOptimizations.Controls.Add($checkboxVisuals)

$checkboxServices = New-Object System.Windows.Forms.CheckBox
$checkboxServices.Text = "Désactiver les services inutiles"
$checkboxServices.Location = New-Object System.Drawing.Point(10, 60)
$checkboxServices.ForeColor = [System.Drawing.Color]::White
$panelOptimizations.Controls.Add($checkboxServices)

$checkboxNotifications = New-Object System.Windows.Forms.CheckBox
$checkboxNotifications.Text = "Désactiver les notifications"
$checkboxNotifications.Location = New-Object System.Drawing.Point(10, 100)
$checkboxNotifications.ForeColor = [System.Drawing.Color]::White
$panelOptimizations.Controls.Add($checkboxNotifications)

$checkboxTelemetry = New-Object System.Windows.Forms.CheckBox
$checkboxTelemetry.Text = "Désactiver la télémétrie"
$checkboxTelemetry.Location = New-Object System.Drawing.Point(10, 140)
$checkboxTelemetry.ForeColor = [System.Drawing.Color]::White
$panelOptimizations.Controls.Add($checkboxTelemetry)

$checkboxCortana = New-Object System.Windows.Forms.CheckBox
$checkboxCortana.Text = "Désactiver Cortana"
$checkboxCortana.Location = New-Object System.Drawing.Point(10, 180)
$checkboxCortana.ForeColor = [System.Drawing.Color]::White
$panelOptimizations.Controls.Add($checkboxCortana)

$checkboxApps = New-Object System.Windows.Forms.CheckBox
$checkboxApps.Text = "Supprimer les applications préinstallées"
$checkboxApps.Location = New-Object System.Drawing.Point(10, 220)
$checkboxApps.ForeColor = [System.Drawing.Color]::White
$panelOptimizations.Controls.Add($checkboxApps)

# Bouton d'exécution des optimisations
$buttonApply = New-Object System.Windows.Forms.Button
$buttonApply.Text = "Appliquer les optimisations"
$buttonApply.Size = New-Object System.Drawing.Size(250, 40)
$buttonApply.Location = New-Object System.Drawing.Point(175, 330)
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
