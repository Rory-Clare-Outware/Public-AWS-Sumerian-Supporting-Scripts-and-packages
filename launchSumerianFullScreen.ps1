# This is a PowerShell script written by ARQGroup
# Maintainer: Rory Clare (rory.clare@arq.group)
# This script is designed to full screen and unmute an AWS Sumerian scene in a chrome browser.
# It was written with PowerShell version 5.1.17134.590
# Tested with Chrome Version 73.0.36383.86 (64 bit)

# Requirements:
# You must have installed the "Selenium" PowerShell module and Google Chrome browser.
# You can install this module by running the following in an elevated PowerShell window:
# Install-Module Selenium -Scope AllUsers -Force

#Import modules
Import-Module Selenium

# Set up our options for launching chrome without the warning:
# "Chrome is being controlled by automated test software."
$Chrome_Options = New-Object -TypeName "OpenQA.Selenium.Chrome.ChromeOptions"
$Chrome_Options.AddArguments("disable-infobars")

# Creates a new object that handles launching chrome with selenium.
$Driver = New-Object -TypeName "OpenQA.Selenium.Chrome.ChromeDriver" -ArgumentList $Chrome_Options

# Launches chrome with our URL and options:
$URL = "your_published_sumerian_scene_url_goes_here.scene"
Enter-SeUrl $URL -Driver $Driver

# get the mute, fullscreen and loadingScreen elements on the page:
$muteButtonElement = Find-SeElement -Driver $Driver -Id "mute-button"
$fullScreenButtonElement = Find-SeElement -Driver $Driver -Id "maximize-button"
$loadingScreen = Find-SeElement -Driver $Driver -Id "loading-screen"

# If the loading screen is still visible, wait for 1 second.
# If the URL is changed or the Sumerian loading screen/page is changed this could end up being an infinate loop.
While($loadingScreen.Displayed -eq $True){
    Start-Sleep -s 1
}
 
# Click the mute and full screen buttons. 
Invoke-SeClick -Element $muteButtonElement
Invoke-SeClick -Element $fullScreenButtonElement
