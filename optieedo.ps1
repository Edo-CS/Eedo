# Eedo Tool - PowerShell GUI Script

# Importation des modules nécessaires
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Création de la fenêtre principale
$form = New-Object System.Windows.Forms.Form
$form.Text = "Eedo Tool"
$form.Size = New-Object System.Drawing.Size(600, 700)
$form.StartPosition = "CenterScreen"

# Ajout d'un label titre
$label = New-Object System.Windows.Forms.Label
$label.Text = "Eedo Tool - Optimisation Windows"
$label.AutoSize = $true
$label.Font = New-Object System.Drawing.Font("Arial",14,[System.Drawing.FontStyle]::Bold)
$label.Location = New-Object System.Drawing.Point(150,10)
$form.Controls.Add($label)

# Création d'un onglet principal
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Size = New-Object System.Drawing.Size(580, 600)
$tabControl.Location = New-Object System.Drawing.Point(10, 40)

# Onglet Optimisations
$tabOptimizations = New-Object System.Windows.Forms.TabPage
$tabOptimizations.Text = "Optimisations"
$tabControl.TabPages.Add($tabOptimizations)

# Onglet Installation Applications
$tabApps = New-Object System.Windows.Forms.TabPage
$tabApps.Text = "Installation Apps"
$tabControl.TabPages.Add($tabApps)

$form.Controls.Add($tabControl)

# Checkbox pour les optimisations
$optimizations = @(
    "Créer un point de restauration",
    "Supprimer les fichiers temporaires",
    "Désactiver la télémétrie",
    "Désactiver GameDVR",
    "Désactiver le suivi de localisation",
    "Désactiver les applications en arrière-plan",
    "Désactiver Edge et OneDrive",
    "Activer le clic droit pour fermer une tâche",
    "Optimiser les performances de l'affichage",
    "Désactiver Copilot et autres services inutiles"
)

$checkboxes = @()
$y = 20
foreach ($opt in $optimizations) {
    $chk = New-Object System.Windows.Forms.CheckBox
    $chk.Text = $opt
    $chk.Location = New-Object System.Drawing.Point(20, $y)
    $chk.AutoSize = $true
    $checkboxes += $chk
    $tabOptimizations.Controls.Add($chk)
    $y += 30
}

# Bouton d'exécution des optimisations
$btnApply = New-Object System.Windows.Forms.Button
$btnApply.Text = "Appliquer"
$btnApply.Location = New-Object System.Drawing.Point(230, 500)
$btnApply.Add_Click({
    foreach ($chk in $checkboxes) {
        if ($chk.Checked) {
            Write-Output "Activation: $($chk.Text)"
        } else {
            Write-Output "Désactivation: $($chk.Text)"
        }
    }
})
$tabOptimizations.Controls.Add($btnApply)

# Lancer l'interface
$form.ShowDialog()
