# Load required assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Windows 11 Amelioration"
$form.Size = New-Object System.Drawing.Size(400, 450)
$form.StartPosition = "CenterScreen"

# Create checkboxes
$chkDebloat = New-Object System.Windows.Forms.CheckBox
$chkDebloat.Text = "Debloat Windows 11"
$chkDebloat.Location = New-Object System.Drawing.Point(20, 20)
$chkDebloat.Size = New-Object System.Drawing.Size(200, 20)
$form.Controls.Add($chkDebloat)

$chkPrivacy = New-Object System.Windows.Forms.CheckBox
$chkPrivacy.Text = "Enhance Privacy and Remove Telemetry"
$chkPrivacy.Location = New-Object System.Drawing.Point(20, 50)
$chkPrivacy.Size = New-Object System.Drawing.Size(300, 20)
$form.Controls.Add($chkPrivacy)

$chkOptimize = New-Object System.Windows.Forms.CheckBox
$chkOptimize.Text = "Optimize Windows"
$chkOptimize.Location = New-Object System.Drawing.Point(20, 80)
$chkOptimize.Size = New-Object System.Drawing.Size(300, 20)
$form.Controls.Add($chkOptimize)

$chkMoveStartMenu = New-Object System.Windows.Forms.CheckBox
$chkMoveStartMenu.Text = "Move Start Menu to Left"
$chkMoveStartMenu.Location = New-Object System.Drawing.Point(20, 110)
$chkMoveStartMenu.Size = New-Object System.Drawing.Size(300, 20)
$form.Controls.Add($chkMoveStartMenu)

$chkRemoveCopilot = New-Object System.Windows.Forms.CheckBox
$chkRemoveCopilot.Text = "Remove AI Copilot"
$chkRemoveCopilot.Location = New-Object System.Drawing.Point(20, 140)
$chkRemoveCopilot.Size = New-Object System.Drawing.Size(300, 20)
$form.Controls.Add($chkRemoveCopilot)

$chkRemoveWeatherNews = New-Object System.Windows.Forms.CheckBox
$chkRemoveWeatherNews.Text = "Remove Weather and News"
$chkRemoveWeatherNews.Location = New-Object System.Drawing.Point(20, 170)
$chkRemoveWeatherNews.Size = New-Object System.Drawing.Size(300, 20)
$form.Controls.Add($chkRemoveWeatherNews)

$chkRemoveEdge = New-Object System.Windows.Forms.CheckBox
$chkRemoveEdge.Text = "Remove Edge Browser"
$chkRemoveEdge.Location = New-Object System.Drawing.Point(20, 200)
$chkRemoveEdge.Size = New-Object System.Drawing.Size(300, 20)
$form.Controls.Add($chkRemoveEdge)

$chkInstallApps = New-Object System.Windows.Forms.CheckBox
$chkInstallApps.Text = "Download and Install Office, PDFgear, Firefox"
$chkInstallApps.Location = New-Object System.Drawing.Point(20, 230)
$chkInstallApps.Size = New-Object System.Drawing.Size(350, 20)
$form.Controls.Add($chkInstallApps)

$chkRestart = New-Object System.Windows.Forms.CheckBox
$chkRestart.Text = "Restart Computer After Completion"
$chkRestart.Location = New-Object System.Drawing.Point(20, 260)
$chkRestart.Size = New-Object System.Drawing.Size(300, 20)
$form.Controls.Add($chkRestart)

# Create a button
$btnRun = New-Object System.Windows.Forms.Button
$btnRun.Text = "Run"
$btnRun.Location = New-Object System.Drawing.Point(20, 300)
$btnRun.Size = New-Object System.Drawing.Size(100, 30)
$form.Controls.Add($btnRun)

# Define button click event
$btnRun.Add_Click({
    # Check if PowerShell is running as administrator
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        [System.Windows.Forms.MessageBox]::Show("Please run this script as an Administrator.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    # Debloat Windows 11
    if ($chkDebloat.Checked) {
        Write-Host "Running Windows10Debloater..."
        Invoke-WebRequest -Uri "https://github.com/Sycnex/Windows10Debloater/archive/master.zip" -OutFile "$env:USERPROFILE\Downloads\Windows10Debloater.zip"
        Expand-Archive -Path "$env:USERPROFILE\Downloads\Windows10Debloater.zip" -DestinationPath "$env:USERPROFILE\Downloads\Windows10Debloater"
        cd "$env:USERPROFILE\Downloads\Windows10Debloater\Windows10Debloater-master"
        Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
        .\Windows10Debloater.ps1 -Silent
    }

    # Enhance Privacy and Remove Telemetry
    if ($chkPrivacy.Checked) {
        Write-Host "Running O&O ShutUp10++..."
        Invoke-WebRequest -Uri "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -OutFile "$env:USERPROFILE\Downloads\OOSU10.exe"
        Start-Process -FilePath "$env:USERPROFILE\Downloads\OOSU10.exe" -ArgumentList "/silent /applyall" -Wait

        Write-Host "Running WPD..."
        Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile "$env:USERPROFILE\Downloads\WPD.zip"
        Expand-Archive -Path "$env:USERPROFILE\Downloads\WPD.zip" -DestinationPath "$env:USERPROFILE\Downloads\WPD"
        Start-Process -FilePath "$env:USERPROFILE\Downloads\WPD\WPD.exe" -ArgumentList "/silent" -Wait
    }

    # Optimize Windows
    if ($chkOptimize.Checked) {
        Write-Host "Running Debotnet..."
        Invoke-WebRequest -Uri "https://github.com/mirinsoft/debotnet/archive/master.zip" -OutFile "$env:USERPROFILE\Downloads\Debotnet.zip"
        Expand-Archive -Path "$env:USERPROFILE\Downloads\Debotnet.zip" -DestinationPath "$env:USERPROFILE\Downloads\Debotnet"
        cd "$env:USERPROFILE\Downloads\Debotnet\debotnet-master"
        Start-Process -FilePath "$env:USERPROFILE\Downloads\Debotnet\debotnet-master\debotnet.exe" -ArgumentList "/silent" -Wait
    }

    # Move Start Menu to Left
    if ($chkMoveStartMenu.Checked) {
        Write-Host "Moving Start Menu to Left..."
        New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -PropertyType DWORD -Value 0 -Force
    }

    # Remove AI Copilot
    if ($chkRemoveCopilot.Checked) {
        Write-Host "Removing AI Copilot..."
        Get-AppxPackage -Name Microsoft.Windows.Copilot | Remove-AppxPackage -AllUsers
    }

    # Remove Weather and News
    if ($chkRemoveWeatherNews.Checked) {
        Write-Host "Removing Weather and News..."
        Get-AppxPackage -Name MicrosoftWindows.Client.WebExperience | Remove-AppxPackage -AllUsers
    }

    # Remove Edge Browser
    if ($chkRemoveEdge.Checked) {
        Write-Host "Removing Edge Browser..."
        Get-AppxPackage -Name Microsoft.MicrosoftEdge.Stable | Remove-AppxPackage -AllUsers
        Get-AppxPackage -Name Microsoft.MicrosoftEdge | Remove-AppxPackage -AllUsers
    }

    # Download and Install Office, PDFgear, Firefox
    if ($chkInstallApps.Checked) {
        Write-Host "Downloading and Installing Office, PDFgear, and Firefox..."
        # Download and Install Office
        Invoke-WebRequest -Uri "https://aka.ms/office-install" -OutFile "$env:USERPROFILE\Downloads\OfficeSetup.exe"
        Start-Process -FilePath "$env:USERPROFILE\Downloads\OfficeSetup.exe" -ArgumentList "/configure configuration.xml" -Wait

        # Download and Install PDFgear
        Invoke-WebRequest -Uri "https://pdfgear.com/download" -OutFile "$env:USERPROFILE\Downloads\PDFgearSetup.exe"
        Start-Process -FilePath "$env:USERPROFILE\Downloads\PDFgearSetup.exe" -ArgumentList "/S" -Wait

        # Download and Install Firefox
        Invoke-WebRequest -Uri "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US" -OutFile "$env:USERPROFILE\Downloads\FirefoxSetup.exe"
        Start-Process -FilePath "$env:USERPROFILE\Downloads\FirefoxSetup.exe" -ArgumentList "/S" -Wait
    }

    # Clean up downloaded files
    Write-Host "Cleaning up downloaded files..."
    Remove-Item "$env:USERPROFILE\Downloads\Windows10Debloater.zip" -Force
    Remove-Item "$env:USERPROFILE\Downloads\Windows10Debloater" -Recurse -Force
    Remove-Item "$env:USERPROFILE\Downloads\OOSU10.exe" -Force
    Remove-Item "$env:USERPROFILE\Downloads\WPD.zip" -Force
    Remove-Item "$env:USERPROFILE\Downloads\WPD" -Recurse -Force
    Remove-Item "$env:USERPROFILE\Downloads\Debotnet.zip" -Force
    Remove-Item "$env:USERPROFILE\Downloads\Debotnet" -Recurse -Force
    Remove-Item "$env:USERPROFILE\Downloads\OfficeSetup.exe" -Force
    Remove-Item "$env:USERPROFILE\Downloads\PDFgearSetup.exe" -Force
    Remove-Item "$env:USERPROFILE\Downloads\FirefoxSetup.exe" -Force

    if ($chkRestart.Checked) {
        [System.Windows.Forms.MessageBox]::Show("Windows 11 amelioration complete! The system will now restart.", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        Restart-Computer
    } else {
        [System.Windows.Forms.MessageBox]::Show("Windows 11 amelioration complete!", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
})

# Show the form
$form.Topmost = $true
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()
