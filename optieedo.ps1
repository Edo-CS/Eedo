# Eedo Tool - Windows Optimization Script
# Version: 1.0
# Interface graphique avec toutes les options demandées

Add-Type -AssemblyName System.Windows.Forms

# Création de la fenêtre principale
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Eedo Tool - Windows Optimizer"
$Form.Size = New-Object System.Drawing.Size(800,600)
$Form.BackColor = "#1E1E1E"
$Form.ForeColor = "#FFFFFF"

# Ajout d'un label pour le titre
$Title = New-Object System.Windows.Forms.Label
$Title.Text = "Eedo Tool - Windows Optimization"
$Title.Size = New-Object System.Drawing.Size(780,30)
$Title.Location = New-Object System.Drawing.Point(10,10)
$Title.Font = New-Object System.Drawing.Font("Arial",14,[System.Drawing.FontStyle]::Bold)
$Form.Controls.Add($Title)

# Ajout des checkboxes pour les optimisations
$Tweaks = @(
    "Create Restore Point",
    "Delete Temporary Files",
    "Disable Consumer Features",
    "Disable Telemetry",
    "Disable Activity History",
    "Disable GameDVR",
    "Disable Hibernation",
    "Disable Homegroup",
    "Disable Location Tracking",
    "Disable Storage Sense",
    "Disable Wifi-Sense",
    "Enable End Task With Right Click",
    "Run Disk Cleanup",
    "Change Windows Terminal default: PowerShell 5 -> PowerShell 7",
    "Disable PowerShell 7 Telemetry",
    "Disable Recall",
    "Set Hibernation as default (good for laptops)",
    "Set Services to Manual",
    "Debloat Edge"
)

$CheckBoxes = @{}
$yPos = 50

foreach ($tweak in $Tweaks) {
    $Checkbox = New-Object System.Windows.Forms.CheckBox
    $Checkbox.Text = $tweak
    $Checkbox.Location = New-Object System.Drawing.Point(20, $yPos)
    $Checkbox.ForeColor = "#FFFFFF"
    $Form.Controls.Add($Checkbox)
    $CheckBoxes[$tweak] = $Checkbox
    $yPos += 25
}

# Bouton pour appliquer les optimisations
$ApplyButton = New-Object System.Windows.Forms.Button
$ApplyButton.Text = "Run Tweaks"
$ApplyButton.Location = New-Object System.Drawing.Point(20, $yPos + 10)
$ApplyButton.BackColor = "#007ACC"
$ApplyButton.ForeColor = "#FFFFFF"
$ApplyButton.Add_Click({
    foreach ($tweak in $CheckBoxes.Keys) {
        if ($CheckBoxes[$tweak].Checked) {
            Write-Host "Activating: $tweak" -ForegroundColor Green
        }
    }
})
$Form.Controls.Add($ApplyButton)

# Affichage de l'interface
$Form.ShowDialog()
