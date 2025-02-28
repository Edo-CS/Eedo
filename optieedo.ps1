# Charger les assemblies nécessaires pour l'interface graphique
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Créer la fenêtre principale
$form = New-Object System.Windows.Forms.Form
$form.Text = "Optimisations Windows"  # Ajouter des guillemets autour du titre
$form.Size = New-Object System.Drawing.Size(500, 400)

# Créer les cases à cocher pour chaque optimisation
$checkboxVisuals = New-Object System.Windows.Forms.CheckBox
$checkboxVisuals.Text = "Désactiver les effets visuels"
$checkboxVisuals.Location = New-Object System.Drawing.Point(20, 30)

$checkboxServices = New-Object System.Windows.Forms.CheckBox
$checkboxServices.Text = "Désactiver les services inutiles"
$checkboxServices.Location = New-Object System.Drawing.Point(20, 70)

$checkboxNotifications = New-Object System.Windows.Forms.CheckBox
$checkboxNotifications.Text = "Désactiver les notifications"
$checkboxNotifications.Location = New-Object System.Drawing.Point(20, 110)

$checkboxTelemetry = New-Object System.Windows.Forms.CheckBox
$checkboxTelemetry.Text = "Désactiver la télémétrie"
$checkboxTelemetry.Location = New-Object System.Drawing.Point(20, 150)

$checkboxCortana = New-Object System.Windows.Forms.CheckBox
$checkboxCortana.Text = "Désactiver Cortana"
$checkboxCortana.Location = New-Object System.Drawing.Point(20, 190)

$checkboxApps = New-Object System.Windows.Forms.CheckBox
$checkboxApps.Text = "Supprimer les applications préinstallées"
$checkboxApps.Location = New-Object System.Drawing.Point(20, 230)

# Bouton d'exécution des optimisations
$buttonApply = New-Object System.Windows.Forms.Button
$buttonApply.Text = "Appliquer les optimisations"
$buttonApply.Size = New-Object System.Drawing.Size(200, 40)
$buttonApply.Location = New-Object System.Drawing.Point(150, 270)

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
    [System.Windows.Forms.MessageBox]::Show("Optimisations terminées !")
}

# Ajouter le bouton et les cases à cocher au formulaire
$form.Controls.Add($checkboxVisuals)
$form.Controls.Add($checkboxServices)
$form.Controls.Add($checkboxNotifications)
$form.Controls.Add($checkboxTelemetry)
$form.Controls.Add($checkboxCortana)
$form.Controls.Add($checkboxApps)
$form.Controls.Add($buttonApply)

# Action à effectuer lors du clic sur le bouton
$buttonApply.Add_Click({ Apply-Optimizations })

# Afficher le formulaire
$form.ShowDialog()
