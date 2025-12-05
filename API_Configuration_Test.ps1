#### =======================================
#### DISCLAIMER
#### ======================================= 
#### THIS SAMPLE SCRIPT IS FOR TESTING AND TROUBLESHOOTING PURPOSES ONLY
####
#### THIS SCRIPT IS PROVIDED "AS IS" AND WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED OR OTHERWISE.
#### BEYONDTRUST SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
#### THE SCRIPT HAS BEEN WRITTEN FOR YOUR CONVENIENCE TO HELP TROUBLESHOOT.
#### BEFORE RUNNING ANY SCRIPTS, PLEASE VIEW THE CODE AND BE SURE YOU UNDERSTAND WHAT IT IS DOING. 


#### =======================================
#### GETTING STARTED
#### ======================================= 
#### This test script does not require any direct modifications, but instead, has been designed as a PowerShell GUI where all required
#### inputs are directly entered from a form interface. For best performance and display of this GUI, we recommend opening the script
#### from Windows PowerShell ISE, and then click the green arrow icon or press the F5 key to Run Script. Some of the form fields include
#### mouse hover tool tips with helpful information. You can also click the Help button to view additional information about this script
#### along with some troubleshooting tips for common errors. Once you have successfully tested your API Configuration, click the Export
#### Settings button to create the file 'API_Configuration_Settings.ini' with the working API parameters that can then be used in your own
#### custom script, application, or other API integration.


#### =======================================
#### PASSWORD SAFE TECHNICAL SUPPORT TOOLS
#### =======================================
#### Last modified date: 5/9/2024
#### Last modified by: Joe Gohrs 


#### =======================================
#### FORM VARIABLES DEFINED
#### =======================================
#### Script Name value that is used by the form
$scriptName = 'Password Safe API Configuration Test'
#### Script Version value that is used by the form
$scriptVersion = 'v.3.1'
#### Update the version 0.0 (major.minor) number to coincide with new Change Log entries noted below  


#### =======================================
#### CHANGE LOG SUMMARY
#### =======================================
#### Version    Description
#### --------   ------------
#### v2.4       Added Change Log Summary and variable-based Form title
#### v2.4       Added Form validation for required Text Box fields
#### v2.4       Replaced Radio Buttons in API Test Type group with Combo Box selection menu
#### v2.4       Updated formatting for Test Results to Rich Text and append text for log
#### v2.4       Added additional detail to Test Results dialog output for each test type
#### v2.5       Added Password Safe Deployment Type and Base URL builder logic
#### v2.5       Added API Test Types for DSS Private Key and DSS Key Passphrase 
#### v2.5       Fixed issue with managedAccount passing the correct value
#### v2.6       Added 'Start Test' button action to display status as 'Running' and prevent multiple clicks until the script completes
#### v2.6       Added minor sleep delays between functions to allow for accurate status messaging in the Test Results Console
#### v2.6       Updated Test Results Console to include additional details
#### v2.7       Modified Form layout for improved flow and better compatibility on lower resolution systems
#### v2.7       Added tool tips for additional information on Form field requirements
#### v2.8       Incorporated changes suggested during development script review
#### v2.8       Added Export Settings Button option to create INI file with API Parameters
#### v2.9       Added Conflict Option radio button form elements and ConflictOption to Request Body Details
#### v2.9       Modified Form Width to fit new form elements (tested scale on U-Series Appliance with Resolution 1280 x 800) 
#### v2.9       Added Reason to Request Body Details for audit and reporting purposes
#### v3.0       Modified Form and Test Results Console with high contrast color scheme
#### v3.0       Added additional hover tool tip for Base Endpoint URL to indicate https:// is not required for the field
#### v3.0       Added Getting Started section
#### v3.1       Added Export Settings button click information message box
#### v3.1       Modified Export Settings output to include PowerShell script-ready parameters
#### 


     
     
$global:verbose = $True;
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

$iconBase64 = 'AAABAAEAMDAAAAEAIACoJQAAFgAAACgAAAAwAAAAYAAAAAEAIAAAAAAAgCUAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf80
AFX/kABV/78AVf/RAFX/0QBV/88AVf/PAFX/zwBV/88AVf/PAFX/zwBV/88AVf/PAFX/zwBV/88A
Vf/PAFX/zwBV/88AVf/PAFX/zwBV/90AVf/IAFX/EAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAFX/KABV/88AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//
AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf/3AFX/FQAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf9iAFX//wBV//8AVf//AFX//wBV//8AVf//AFX/
/wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//
AFX//wBV//8AVf/3AFX/FAAAAAAAVf8PAFX/IgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABV/2MAVf//AFX//wBV
//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX/
/wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf/3AFX/FAAAAAAAVf8PAFX/3gBV/0gAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAFX/KwBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX/4gBV/9QAVf/XAFX/1wBV
/9cAVf/XAFX/1wBV/9cAVf/XAFX/1wBV/9cAVf/WAFX/0wBV//UAVf//AFX//wBV//8AVf/3AFX/
FAAAAAAAAAAAAFX/8wBV//8AVf8wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFX/sQBV//8AVf//AFX//wBV//8AVf//AFX//wBV/4oA
Vf8ZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABV
/7MAVf//AFX//wBV//8AVf/3AFX/FAAAAAAAAAAAAFX/4wBV//8AVf/6AFX/MAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf8rAFX//wBV//8AVf//
AFX//wBV//8AVf/yAFX/KwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAABV/7EAVf//AFX//wBV//8AVf/3AFX/FAAAAAAAAAAAAFX/4wBV
//8AVf//AFX/+gBV/y4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAVf92AFX//wBV//8AVf//AFX//wBV//8AVf85AAAAAAAAAAAAAAAAAFX/DgBV/yUAVf8i
AFX/IQBV/yEAVf8hAFX/IQBV/yEAVf8hAFX/IQBV/yEAVf8bAFX/EABV/8sAVf//AFX//wBV//8A
Vf/3AFX/FAAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV/7YAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf+mAFX//wBV//8AVf//AFX//wBV/5QAAAAAAAAA
AAAAAAAAVf+DAFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//
AFX//wBV//8AVf//AFX//wBV//8AVf/3AFX/FAAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV/78A
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf+8AFX//wBV
//8AVf//AFX//wBV/z0AAAAAAAAAAABV/3wAVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX/
/wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf/3AFX/FAAAAAAAAAAA
AFX/4wBV//8AVf//AFX//wBV/78AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAVf+/AFX//wBV//8AVf//AFX/9QBV/xIAAAAAAAAAAABV/90AVf//AFX//wBV
//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX/
/wBV//8AVf/3AFX/FAAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV/78AAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/6gBV/wcA
AAAAAFX/DgBV//EAVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV
//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf/3AFX/FAAAAAAAAAAAAFX/4wBV//8AVf//AFX/
/wBV/78AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++
AFX//wBV//8AVf//AFX/6gBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf/yAFX/nABV/5cA
Vf+cAFX/nABV/5wAVf+cAFX/nABV/5wAVf+YAFX/mQBV/+8AVf//AFX//wBV//8AVf/3AFX/FAAA
AAAAAAAAAFX/4wBV//8AVf//AFX//wBV/78AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//
AFX//wBV//8AVf+9AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABV/7QA
Vf//AFX//wBV//8AVf/3AFX/FAAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV/78AAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/
6wBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf+8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAABV/7IAVf//AFX//wBV//8AVf/3AFX/FAAAAAAAAAAAAFX/4wBV//8A
Vf//AFX//wBV/78AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf+8AAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABV/7MAVf//AFX//wBV//8AVf/3
AFX/FAAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV/78AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV
//EAVf//AFX//wBV//8AVf+8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AABV/7MAVf//AFX//wBV//8AVf/3AFX/FAAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV/78AAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8A
Vf//AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf+8AAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAABV/7MAVf//AFX//wBV//8AVf/3AFX/FAAAAAAAAAAAAFX/
4wBV//8AVf//AFX//wBV/78AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8A
Vf+8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABV/7MAVf//AFX//wBV
//8AVf/3AFX/FAAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV/78AAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAA
AFX/DgBV//EAVf//AFX//wBV//8AVf+8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAABV/7MAVf//AFX//wBV//8AVf/3AFX/FAAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV
/78AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX/
/wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf+8AAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABV/7IAVf//AFX//wBV//8AVf/2AFX/FAAAAAAA
AAAAAFX/4wBV//8AVf//AFX//wBV/78AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//AFX/
/wBV//8AVf+9AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABV/7MAVf//
AFX//wBV//8AVf/4AFX/FgAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV/78AAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/6wBV
/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf/uAFX/gQBV/3wAVf+CAFX/ggBV/4IAVf+CAFX/
ggBV/4IAVf99AFX/fgBV/+oAVf//AFX//wBV//8AVf/5AFX/FgAAAAAAAAAAAFX/4wBV//8AVf//
AFX//wBV/78AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
Vf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf//AFX//wBV
//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf/5AFX/
FgAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV/78AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV//EA
Vf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV
//8AVf//AFX//wBV//8AVf/5AFX/FgAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV/78AAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//
AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8A
Vf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf/5AFX/FgAAAAAAAAAAAFX/4wBV
//8AVf//AFX//wBV/78AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf//
AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8A
Vf/5AFX/FgAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV/78AAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/
AwBV/zQAVf88AFX/OABV/zgAVf84AFX/OABV/zgAVf84AFX/OABV/zgAVf84AFX/OABV/zgAVf8y
AFX/KQBV/9EAVf//AFX//wBV//8AVf/5AFX/FgAAAAAAAAAAAFX/4wBV//8AVf//AFX//wBV/7kA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV
//8AVf//AFX/6wBV/wcAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABV/7IAVf//AFX//wBV//8AVf/5AFX/FgAAAAAAAAAA
AFX/4wBV//8AVf//AFX//wBV/z4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABV/7MAVf//AFX/
/wBV//8AVf/5AFX/FgAAAAAAAAAAAFX/4wBV//8AVf//AFX/QQAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcA
AAAAAFX/CgBV/7UAVf/PAFX/wABV/8AAVf/AAFX/wABV/8AAVf/AAFX/wABV/8AAVf/AAFX/wABV
/8AAVf+/AFX/uQBV/+4AVf//AFX//wBV//8AVf/5AFX/FgAAAAAAAAAAAFX/8ABV//8AVf9BAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++
AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf//AFX//wBV//8A
Vf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf/5AFX/FgAA
AAAAVf8MAFX/6ABV/1cAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//
AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8A
Vf//AFX//wBV//8AVf/5AFX/FgAAAAAAVf8SAFX/LgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf++AFX//wBV//8AVf//AFX/
6wBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf//
AFX//wBV//8AVf//AFX//wBV//8AVf//AFX//wBV//8AVf/5AFX/FgAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAVf++AFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf/6AFX/
5QBV/+YAVf/nAFX/5wBV/+cAVf/nAFX/5wBV/+cAVf/nAFX/5wBV/+cAVf/nAFX/5wBV//YAVf/h
AFX/FAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf+OAFX//wBV//8AVf//AFX/6wBV/wcAAAAAAFX/DgBV
//EAVf//AFX//wBV//8AVf+7AAAAAABV/wEAVf8GAFX/BgBV/wYAVf8GAFX/BgBV/wYAVf8GAFX/
BgBV/wYAVf8GAFX/BgBV/wcAVf8FAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFX/pgBV//8A
Vf//AFX/6wBV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf+3AAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAABV/6YAVf//AFX/7ABV/wcAAAAAAFX/DgBV//EAVf//AFX//wBV//8A
Vf+3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVf+7AFX//wBV/wgAAAAA
AFX/DgBV//EAVf//AFX//wBV//8AVf+3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAVf8FAFX/jwBV/yMAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf+3AAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFX/AQBV/wEAAAAAAFX/DgBV//EAVf//AFX/
/wBV//8AVf+3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAFX/DgBV//EAVf//AFX//wBV//8AVf+3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFX/DgBV//AAVf//AFX//wBV//8AVf+3AAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABV/54A
Vf//AFX//wBV//8AVf+3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAVf+nAFX//wBV//8AVf+3AAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFX/pwBV//8AVf+5
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAABV/84AVf/VAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/8AAAH/8AAP/AAAAf
/wAA/4AAABP/AAD/AAAAEf8AAP4AAAAY/wAA/gD/+Bh/AAD8A//4GD8AAPwHAAAYPwAA/A4AABg/
AAD8DAAAGD8AAPwMAAAYPwAA/AgAABg/AAD8CAAAGD8AAPwIH/gYPwAA/Agf+Bg/AAD8CB/4GD8A
APwIH/gYPwAA/Agf+Bg/AAD8CB/4GD8AAPwIH/gYPwAA/Agf+Bg/AAD8CB/4GD8AAPwIAAAYPwAA
/AgAABg/AAD8CAAAGD8AAPwIAAAYPwAA/AgAABg/AAD8CAAAGD8AAPwP//gYPwAA/A//+Bh/AAD8
CAAAGP8AAPwIAAAR/wAA/AgAABP/AAD8CAAAH/8AAPwIAAAf/wAA/AgQAD//AAD+CB////8AAP8I
H////wAA/4gf////AAD/iB////8AAP/IH////wAA//gf////AAD/+B////8AAP/8H////wAA//4f
////AAD//x////8AAP//n////wAA////////AAA='
$iconBytes = [Convert]::FromBase64String($iconBase64)


#### =======================================
#### VARIABLES DEFINED
#### =======================================

# initialize a Memory stream holding the bytes
$stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)

# -------------------- change path to ini file if required ------------------------------- #
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
#$init=Get-IniFile $scriptPath\getmacreds.ini

#$global:baseURL=$init["apiparams"]["baseurl"]
#$global:apiUser=$init["apiparams"]["apiuser"]
#$global:apikey=$init["apiparams"]["apikey"]
#$global:managedSystem=$init["account"]["managedsystem"]
#$global:managedAccount=$init["account"]["managedaccount"]


$formWidth = 980
$FormHeight = 600
$xb = 20
$yb = 40


function Get-IniFile {
    <#
    .SYNOPSIS
    Read an ini file.
    
    .DESCRIPTION
    Reads an ini file into a hash table of sections with keys and values.
    
    .PARAMETER filePath
    The path to the INI file.
    
    .PARAMETER anonymous
    The section name to use for the anonymous section (keys that come before any section declaration).
    
    .PARAMETER comments
    Enables saving of comments to a comment section in the resulting hash table.
    The comments for each section will be stored in a section that has the same name as the section of its origin, but has the comment suffix appended.
    Comments will be keyed with the comment key prefix and a sequence number for the comment. The sequence number is reset for every section.
    
    .PARAMETER commentsSectionsSuffix
    The suffix for comment sections. The default value is an underscore ('_').

    .PARAMETER commentsKeyPrefix
    The prefix for comment keys. The default value is 'Comment'.
    
    .EXAMPLE
    Get-IniFile /path/to/my/inifile.ini
    
    .NOTES
    The resulting hash table has the form [sectionName->sectionContent], where sectionName is a string and sectionContent is a hash table of the form [key->value] where both are strings.

    This function is largely copied from https://stackoverflow.com/a/43697842/1031534. An improved version has since been pulished at https://gist.github.com/beruic/1be71ae570646bca40734280ea357e3c.
    #>
    
    param(
        [parameter(Mandatory = $true)] [string] $filePath,
        [string] $anonymous = 'NoSection',
        [switch] $comments,
        [string] $commentsSectionsSuffix = '_',
        [string] $commentsKeyPrefix = 'Comment'
    )

    $ini = @{}
    switch -regex -file ($filePath) {
        "^\[(.+)\]$" {
            # Section
            $section = $matches[1]
            $ini[$section] = @{}
            $CommentCount = 0
            if ($comments) {
                $commentsSection = $section + $commentsSectionsSuffix
                $ini[$commentsSection] = @{}
            }
            continue
        }

        "^(;.*)$" {
            # Comment
            if ($comments) {
                if (!($section)) {
                    $section = $anonymous
                    $ini[$section] = @{}
                }
                $value = $matches[1]
                $CommentCount = $CommentCount + 1
                $name = $commentsKeyPrefix + $CommentCount
                $commentsSection = $section + $commentsSectionsSuffix
                $ini[$commentsSection][$name] = $value
            }
            continue
        }

        "^(.+?)\s*=\s*(.*)$" {
            # Key
            if (!($section)) {
                $section = $anonymous
                $ini[$section] = @{}
            }
            $name, $value = $matches[1..2]
            $ini[$section][$name] = $value
            continue
        }
    }

    return $ini
}



function Out-IniFile($InputObject, $FilePath) 
{
    $outFile = New-Item -ItemType file -Path $Filepath -Force
    foreach ($i in $InputObject.keys) 
    {
        if (!($($InputObject[$i].GetType().Name) -eq "Hashtable")) 
        {
            #No Sections
            Add-Content -Path $outFile -Value "$i=$($InputObject[$i])"
        }
        else {
            #Sections
            Add-Content -Path $outFile -Value "[$i]"
            Foreach ($j in ($InputObject[$i].keys | Sort-Object)) {
                if ($j -match "^Comment[\d]+") {
                    Add-Content -Path $outFile -Value "$($InputObject[$i][$j])"
                }
                else {
                    Add-Content -Path $outFile -Value "$j=$($InputObject[$i][$j])" 
                }

            }
            Add-Content -Path $outFile -Value ""
        }
    }
}

function New-IniContent {
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline)] [hashtable] $data,
        [string] $anonymous = 'NoSection'
    )
    process {
        $iniData = $_

        if ($iniData.Contains($anonymous)) {
            $iniData[$anonymous].GetEnumerator() |  ForEach-Object {
                Write-Output "$($_.Name)=$($_.Value)"
            }
            Write-Output ''
        }

        $iniData.GetEnumerator() | ForEach-Object {
            $sectionData = $_
            if ($sectionData.Name -ne $anonymous) {
                Write-Output "[$($sectionData.Name)]"

                $iniData[$sectionData.Name].GetEnumerator() |  ForEach-Object {
                    Write-Output "$($_.Name)=$($_.Value)"
                }
            }
            Write-Output ''
        }
    }
}

# .Net methods for hiding/showing the console in the background
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'

function Show-Console {
    $consolePtr = [Console.Window]::GetConsoleWindow()

    # Hide = 0,
    # ShowNormal = 1,
    # ShowMinimized = 2,
    # ShowMaximized = 3,
    # Maximize = 3,
    # ShowNormalNoActivate = 4,
    # Show = 5,
    # Minimize = 6,
    # ShowMinNoActivate = 7,
    # ShowNoActivate = 8,
    # Restore = 9,
    # ShowDefault = 10,
    # ForceMinimized = 11

    [Console.Window]::ShowWindow($consolePtr, 4)
}

function Hide-Console {
    $consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}





#### =======================================
#### FUNCTIONS
#### =======================================


function API-Test($apiUser, $apiKey, $baseURL, $managedAccount, $managedSystem) { 

    If ($ProductType.SelectedItem -eq 'U-Series Appliance') {
        $baseURL = "https://" + $baseURL + "/BeyondTrust/api/public/v3/"
        #$TextPassword.SelectionColor = 'black'
        #$TextPassword.AppendText("$baseURL `r`n")
        #$TextPAssword.AppendText("`r`n")
    }
    If ($ProductType.SelectedItem -eq 'Password Safe Cloud') {
        $baseURL = "https://" + $baseURL + ".ps.beyondtrustcloud.com/BeyondTrust/api/public/v3/"
        #$TextPassword.SelectionColor = 'black'
        #$TextPassword.AppendText("$baseURL `r`n")
        #$TextPAssword.AppendText("`r`n")
    }

    $OKButton.FlatStyle = 'Flat'
    $OKButton.BackColor = 'DarkGreen'
    $OKButton.ForeColor = 'White'
    $OKButton.Font = New-Object System.Drawing.Font("Calibri", 11, [System.Drawing.FontStyle]::Bold)
    $OKButton.Text = 'Running'
    $OKButton.Enabled = $false

    if ($RadioButton1.Checked) {
    
        $ConflictOption = 'reuse'
        
    }
    if ($RadioButton2.Checked) {
    
        $ConflictOption = 'renew'
        
    }

    try {
        $headers = @{ Authorization = "PS-Auth key=${apiKey}; runas=${apiUser};"; };
        "Signing-in..";
        #$TextPassword.SelectionColor = 'black'
        #$TextPassword.AppendText("========================================================== `r`n")
        $TextPassword.SelectionColor = 'black'
        $TextPassword.AppendText("Start Test - Login as $apiUser to $baseURL `r`n")
        #$TextPassword.SelectionColor = 'black'
        #$TextPassword.AppendText("========================================================== `r`n")
        $TextPAssword.AppendText("`r`n")
        Start-Sleep -Seconds 1
        
        #$signInResult = Invoke-RestMethod -Uri "${baseUrl}Auth/SignAppIn" -Method POST -Headers $headers -SessionVariable session;   
        $signInResult = Invoke-RestMethod -Uri "$baseURL/Auth/SignAppIn" -Method POST -Headers $headers -SessionVariable session;  

        $ma = Invoke-RestMethod -Uri "${baseURL}ManagedAccounts?systemName=${global:managedSystem}&accountName=${global:managedAccount}" -Method GET -Headers $headers -WebSession $session;
        $accountID = $ma.AccountId
        $durationInMins = 1;
        $data = @{SystemId = $ma.SystemId; AccountId = $ma.AccountId; type = "local"; DurationMinutes = $durationInMins; Reason = "Password Safe API Configuration Test Script"; ConflictOption = $ConflictOption };
        $json = $data | ConvertTo-Json;

        if ($listBox.SelectedItem -eq 'Change Password') {    
            $creds = Invoke-RestMethod -Uri "${baseUrl}ManagedAccounts/${accountID}/Credentials/Change" -Method POST -Headers $headers -WebSession $session;
            #Start-Sleep -Seconds 20
            if ($creds.StatusCode -eq $null) {
                $TextPassword.SelectionColor = 'green'
                $TextPassword.AppendText("PASS: Password Change Succeeded! `r`nManaged Account: $managedAccount")
                $TextPAssword.AppendText("`r`n")
            }
            else {
                $TextPassword.SelectionColor = 'red'
                $TextPassword.AppendText("FAIL:" + $($creds.Success))
                $TextPAssword.AppendText("`r`n")
            }
        }
        if ($listBox.SelectedItem -eq 'Test Password') {    
            $creds = Invoke-RestMethod -Uri "${baseUrl}ManagedAccounts/${accountID}/Credentials/Test" -Method POST -Headers $headers -WebSession $session;
        
            if ($creds.Success -eq "True") {
                $TextPassword.SelectionColor = 'green'
                $TextPassword.AppendText("PASS: Password Test Succeeded! `r`nManaged Account: $managedAccount")
                $TextPAssword.AppendText("`r`n")
            }
            else {
                $TextPassword.SelectionColor = 'red'
                $TextPassword.AppendText("FAIL: Password Test Failed `r`nManaged Account: $managedAccount")
                $TextPAssword.AppendText("`r`n")
            }  
        }

        if ($listBox.SelectedItem -eq 'Retrieve Password' -or $listBox.SelectedItem -eq 'DSS Private Key' -or $listBox.SelectedItem -eq 'DSS Key Passphrase') {

            $rURL = Invoke-RestMethod -Uri "${baseUrl}Requests" -Method POST -ContentType "application/json"  -Body $json -WebSession $session;
            
            if ($global:verbose) { "Request ID = {0}" -f $rURL; ""; } #outputs the request id
            
            if ($listBox.SelectedItem -eq 'Retrieve Password') {    
                $creds = Invoke-RestMethod -Uri "${baseUrl}Credentials/${rURL}" -Method GET -Headers $headers -WebSession $session;
                $TextPassword.SelectionColor = 'green'
                $TextPassword.AppendText("PASS: Password Retrieved Successfully! `r`nManaged Account: $managedAccount `r`n")
                $TextPassword.SelectionColor = 'green'
                $TextPassword.AppendText("Password: $creds")
                $TextPAssword.AppendText("`r`n")
            }
            
            if ($listBox.SelectedItem -eq 'DSS Private Key') {    
                $creds = Invoke-RestMethod -Uri "${baseUrl}Credentials/${rURL}?type=dsskey" -Method GET -Headers $headers -WebSession $session;
                $TextPassword.SelectionColor = 'green'
                $TextPassword.Text = $creds
                $TextPAssword.AppendText("`r`n")
            }

            if ($listBox.SelectedItem -eq 'DSS Key Passphrase') {    
                $creds = Invoke-RestMethod -Uri "${baseUrl}Credentials/${rURL}?type=passphrase" -Method GET -Headers $headers -WebSession $session;
                $TextPassword.SelectionColor = 'green'
                $TextPassword.Text = $creds
                $TextPAssword.AppendText("`r`n")
            }

            $reason = @{Reason = "${reason}" };
            $json = $reason | ConvertTo-Json;
            $checkin = Invoke-RestMethod -Uri "${baseUrl}Requests/${rURL}/Checkin" -Method PUT -Headers $headers -ContentType "application/json"  -Body $json -WebSession $session ;
        }
    
        "Signing-out..";
        $TextPAssword.AppendText("`r`n")
        #$TextPassword.SelectionColor = 'black'
        #$TextPassword.AppendText("========================================================== `r`n")
        $TextPassword.SelectionColor = 'black'
        $TextPassword.AppendText("End Test - $apiUser Logout Completed `r`n")
        #$TextPassword.SelectionColor = 'black'
        #$TextPassword.AppendText("========================================================== `r`n")
        $TextPAssword.AppendText("`r`n")
        Start-Sleep -Seconds 1
    
	
        $signOutResult = Invoke-RestMethod -Uri "${baseUrl}Auth/Signout" -Method POST -Headers $headers -WebSession $session;    
        if ($verbose) { "..Signed-out"; ""; }
    
        if ($verbose) {
            "Done!"; 
        }
    }
    catch {
        "Exception: {0}" -f $_.Exception.Message;
        $TextPassword.SelectionColor = 'red'
        $TextPassword.AppendText($_.Exception.Message)
        $TextPAssword.AppendText("`r`n")
    } 

    Start-Sleep -Seconds 1
    $OKButton.FlatStyle = 'system'
    $OKButton.Font = New-Object System.Drawing.Font("Calibri", 11, [System.Drawing.FontStyle]::Bold)
    $OKButton.Text = 'Start Test'
    $OKButton.Enabled = $true
}




#### =======================================
#### Start Test Button Click
#### =======================================


$ok_click = 
{ # Begin ok_click

    #validate the inputs:
    If ($ProductType.SelectedItem -eq $null) {
        $TextPassword.SelectionColor = 'red'
        $TextPassword.AppendText("Please select a Password Safe Product Type to continue`r`n")
        return          
    }
    If ($TextBoxAPIUser.TextLength -eq 0) {
        $TextPassword.SelectionColor = 'red'
        $TextPassword.AppendText("Please enter an API Run As User to continue`r`n")
        return         
    }
    If ($TextBaseURL.TextLength -eq 0) {
        $TextPassword.SelectionColor = 'red'
        $TextPassword.AppendText("Please complete the Base Endpoint URL to continue`r`n")         
        return
    }
    If ($TextBoxAPIKey.TextLength -eq 0) {
        $TextPassword.SelectionColor = 'red'
        $TextPassword.AppendText("Please enter an API Registration Key to continue`r`n")        
        return
    }
    If ($TextBoxMAName.TextLength -eq 0) {
        $TextPassword.SelectionColor = 'red'
        $TextPassword.AppendText("Please enter a Managed Account name to continue`r`n")         
        return
    }
    If ($TextBoxMSName.TextLength -eq 0) {
        $TextPassword.SelectionColor = 'red'
        $TextPassword.AppendText("Please enter a Managed System name to continue`r`n")         
        return
    }
    If ($listBox.SelectedItem -eq $null) {
        $TextPassword.SelectionColor = 'red'
        $TextPassword.AppendText("Please select an API Test Type to continue`r`n")         
        return
    }

    #perform the action
    $global:apiUser = $TextBoxAPIUser.Text.ToString()
    $global:apikey = $TextBoxAPIKey.Text.ToString()
    $global:baseURL = $TextBaseURL.Text.ToString()
    $global:managedAccount = $TextBoxMAName.Text.ToString()
    $global:managedSystem = $TextBoxMSName.Text.ToString()

    API-Test $global:apiUser $global:apikey $global:baseURL $global:managedAccount $global:managedSystem


} # End ok_click

$save_click = {
    
    $global:apiUser = $TextBoxAPIUser.Text.ToString()
    $global:apikey = $TextBoxAPIKey.Text.ToString()
    $global:baseURL = $TextBaseURL.Text.ToString()
    $global:managedAccount = $TextBoxMAName.Text.ToString()
    $global:managedSystem = $TextBoxMSName.Text.ToString()

    # validate the inputs:
    If ($ProductType.SelectedItem -eq $null) {
        $TextPassword.SelectionColor = 'red'
        $TextPassword.AppendText("Please select a Password Safe Product Type to continue`r`n")
        return          
    }


    # construct the base endpoint url based on the product type
    If ($ProductType.SelectedItem -eq 'U-Series Appliance') {
        $baseURL2 = "https://" + $baseURL + "/BeyondTrust/api/public/v3/"
        
    }
    If ($ProductType.SelectedItem -eq 'Password Safe Cloud') {
        $baseURL2 = "https://" + $baseURL + ".ps.beyondtrustcloud.com/BeyondTrust/api/public/v3/"
        
    }

    #$global:apiUser = $TextBoxAPIUser.Text.ToString()
    #$global:apikey = $TextBoxAPIKey.Text.ToString()
    #$global:baseURL = $TextBaseURL.Text.ToString()
    #$global:managedAccount = $TextBoxMAName.Text.ToString()
    #$global:managedSystem = $TextBoxMSName.Text.ToString()

    #$init["account"]["managedaccount"]=$managedAccount
    #$init["account"]["managedsystem"]=$managedSystem
    #$init["apiparams"]["apiuser"]=$apiUser
    #$init["apiparams"]["apikey"]=$apikey
    #$init["apiparams"]["baseurl"]=$baseURL
    
    # write to the file 
    Set-Content -Path $scriptPath\API_Configuration_Settings.ini -Value "# API Run As User"
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value "`$runAsUser = `"$apiUser`";"
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value ""
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value "# API Registration Key"
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value "`$apiKey = `"$apikey`";"
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value ""
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value "# API Base Endpoint URL"
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value "`$baseUrl = `"$baseURL2`";"
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value ""
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value "# Managed Account"
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value "`$accountToFind = `"$managedAccount`";"
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value ""
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value "# Managed System"
    Add-Content -Path $scriptPath\API_Configuration_Settings.ini -Value "`$systemToFind = `"$managedSystem`";"

    #Out-IniFile $init $scriptPath\getmacreds.ini
    
    # message box confirmation after button click
    $Message = 'API Configuration Test Settings saved to ' + $scriptPath + '\API_Configuration_Settings.ini'
            
    Show-MessageBox -Title 'Export Settings Confirmation' -Message $Message -Icon Information -Buttons OK

}


#### =======================================
#### Help Button Click
#### =======================================


$help_click = {

    Show-MessageBox -Title 'Information & Troubleshooting Tips' -Message '=======================================
Overview
=======================================
Password Safe Technical Support has crafted this PowerShell GUI script* to help you validate the basic requirements for your API configuration.

=======================================
What does this PowerShell script do?
=======================================
1) Verifies that your API RunAs User is correctly provisioned
2) Validates your API Registration, Key, and Authentication Rules
3) Constructs your Base Endpoint URL for the Public API depending on your Password Safe deployment type
4) Facilitates easy execution of the following Managed Account test types:
- Retrieve Password (Requires the requestor or requestor/approver role to the Managed Account)
- Change Password (Requires Full Control Permission for the Password Safe Account Management Feature)
- Test Password (Requires Full Control Permission for the Password Safe Account Management Feature)

=======================================
Troubleshooting 401 Errors
=======================================
If you have 401 errors when running the script, this normally points to one or more of the following:
- User has not been assigned to the correct User Management Group
- User is assigned to the correct User Management Group, but the API Registration is not enabled or correct
- The IP Address for the system executing the script is incorrect or missing from the API Registration Authentication Rules
- In some cases, disabling then enabling the API Registration from the User Management Group may resolve this error

=======================================
Troubleshooting 404 Errors
=======================================
Following a successful API authentication, you may receive a 404 error. This does not mean that there are issues with the requested web resource but that the requested account was not found:
- Confirm that the Managed Account > Account Settings > API Enabled option is selected
- Verify that the Managed Account is Linked to the Managed System
- The Managed Account is included in a Smart Rule with a Dedicated Account Mapping Action to a User other than the API RunAs User and can only be viewed by the Mapped To User
- Confirm the Smart Groups Permissions for the User Management Group are fully configured to include Read only access, the Password Safe Requestor Role, and an Access Policy for the Requestor that includes the View Password Policy Type
- In some cases, the PublicAPI log may show the Managed Account not found, even when the Managed Account is Onboarded to Password Safe with the API Enabled Account Setting. This can be the result of conflicting Smart Rules that include the Manage Account Settings Action with different Account Options, specfically Enable API Access. Navigate to the Managed Account > Go to Advanced Details > Smart Groups to look for duplicate Onboarding Smart Rules. Alternately, there is a Report named Smart Rule Overlap that can help identify conflicting Smart Rule Manage Actions.

=======================================
Additional Resources
=======================================
BeyondInsight and Password Safe API Overview
https://www.beyondtrust.com/docs/beyondinsight-password-safe/ps/api/index.htm

* Disclaimer: This script is offered "as is," and without warranty of any kind, express or implied or otherwise. BeyondTrust specifically disclaims any implied warranties of merchantability, fitness for a particular purpose and non-infringement.' -Icon Information -Buttons OK
        
}




#### =======================================
#### Function for Help & Troubleshooting Tips
#### =======================================

function Show-MessageBox {  
    [CmdletBinding()]  
    Param (   
        [Parameter(Mandatory = $false)]  
        [string]$Title = 'MessageBox in PowerShell',

        [Parameter(Mandatory = $true)]
        [string]$Message,  

        [Parameter(Mandatory = $false)]
        [ValidateSet('OK', 'OKCancel', 'AbortRetryIgnore', 'YesNoCancel', 'YesNo', 'RetryCancel')]
        [string]$Buttons = 'OKCancel',

        [Parameter(Mandatory = $false)]
        [ValidateSet('Error', 'Warning', 'Information', 'None', 'Question')]
        [string]$Icon = 'Information',

        [Parameter(Mandatory = $false)]
        [ValidateRange(1, 3)]
        [int]$DefaultButton = 1
    )            

    # determine the possible default button
    if ($Buttons -eq 'OK') {
        $Default = 'Button1'
    }
    elseif (@('AbortRetryIgnore', 'YesNoCancel') -contains $Buttons) {
        $Default = 'Button{0}' -f [math]::Max([math]::Min($DefaultButton, 3), 1)
    }
    else {
        $Default = 'Button{0}' -f [math]::Max([math]::Min($DefaultButton, 2), 1)
    }

    Add-Type -AssemblyName System.Windows.Forms
    # added from tip by [Ste](https://stackoverflow.com/users/8262102/ste) so the 
    # button gets highlighted when the mouse hovers over it.
    [void][System.Windows.Forms.Application]::EnableVisualStyles()

    # Setting the first parameter 'owner' to $null lets he messagebox become topmost
    [System.Windows.Forms.MessageBox]::Show($null, $Message, $Title,   
        [Windows.Forms.MessageBoxButtons]::$Buttons,   
        [Windows.Forms.MessageBoxIcon]::$Icon,
        [Windows.Forms.MessageBoxDefaultButton]::$Default)
}


 
# A function to create the form 
function MainMenu {
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
    
    # Set the size of your form
    $Form = New-Object System.Windows.Forms.Form
    $Form.FormBorderStyle = 'FixedSingle'
    $Form.MaximizeBox = $false
    $Form.width = $formWidth
    $Form.height = $FormHeight
    $Form.Text = "Password Safe Technical Support Tools"
    $Form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))
    $Form.StartPosition = "CenterScreen"
    $Form.BackColor = "#425563"
 
    # Set the font of the text to be used within the form
    $Font = New-Object System.Drawing.Font("Calibri", 10.5)
    $Form.Font = $Font
 
    # Create a group that will contain the text boxes
    $MyGroupBoxWidth = $FormWidth - 90
    $MyGroupBoxHeight = $FormHeight - 140
    $TextBoxWidth = $MyGroupBoxWidth - 40
    $TextBoxHeight = 100


    #define a tooltip object
    $tooltip1 = New-Object System.Windows.Forms.ToolTip
    <#
define a scriptblock to display the tooltip
add a _MouseHover event to display the corresponding tool tip
 e.g. $txtPath.add_MouseHover($ShowHelp)
 #>
    $ShowHelp = {
        #display popup help
        #each value is the name of a control on the form.
        Switch ($this.name) {
            "TextBoxAPIUser" { $tip = "Domain\Account Format for Domain Accounts" }
            "TextBoxMAName" { $tip = "Domain\Account Format for Domain Accounts" }
            "TextBoxMSName" { $tip = "Domain Accounts must be Linked to this System" }
            "TextBaseURL" { $tip = "Enter only the Hostname, IP Address, or Instance ID without https://" }
  
        }
        $tooltip1.SetToolTip($this, $tip)
    } #end ShowHelp


    $MyGroupBox = New-Object System.Windows.Forms.GroupBox
    $MyGroupBox.Location = '40,30'
    $MyGroupBox.size = "$MyGroupBoxWidth,$MyGroupBoxHeight"
    $MyGroupBox.ForeColor = "white"
    $MyGroupBox.Font = New-Object System.Drawing.Font("Calibri",10.5,[System.Drawing.FontStyle]::Regular)
    $MyGroupBox.text = " " + $scriptName + "  [ " + $scriptVersion + " ]  "
    


    #### Label Product Type ###################################################
    $objLabelPWSType = New-Object System.Windows.Forms.label
    $objLabelPWSType.Location = "$xb,40"
    $objLabelPWSType.Size = "210,20"
    $objLabelPWSType.BackColor = "Transparent"
    $objLabelPWSType.ForeColor = "white"
    $objLabelPWSType.Font = New-Object System.Drawing.Font("Calibri", 10.5, [System.Drawing.FontStyle]::Bold)
    $objLabelPWSType.Text = "Product Type"
    $yb = $yb + 22

    #### Product Product Type Combo Box ###################################################
    $ProductType = New-Object System.Windows.Forms.ComboBox
    $ProductType.Location = New-Object System.Drawing.Point($xb, $yb)
    $ProductType.Size = New-Object System.Drawing.Size(210, 20)
    $ProductType.Height = 60
    $ProductType.Text = 'Select a Product Type >>'
    [void] $ProductType.Items.Add('U-Series Appliance')
    [void] $ProductType.Items.Add('Password Safe Cloud')
    #$ProductType.SelectedItem = 'U-Series Appliance'
    $ProductType.SelectedIndex = -1
    $yb = $yb - 22

    #### Label API Key ###################################################
    $objLabelAPIKey = New-Object System.Windows.Forms.label
    $objLabelAPIKey.Location = "250,40"
    $objLabelAPIKey.Size = "210,20"
    $objLabelAPIKey.BackColor = "Transparent"
    $objLabelAPIKey.ForeColor = "white"
    $objLabelAPIKey.Font = New-Object System.Drawing.Font("Calibri", 10.5, [System.Drawing.FontStyle]::Bold)
    $objLabelAPIKey.Text = "API Registration Key"
    $yb = $yb + 22


    #### Text Box API Key ###################################################
    $TextBoxAPIKey = New-Object System.Windows.Forms.TextBox
    $TextBoxAPIKey.Multiline = $True
    $TextBoxAPIKey.ScrollBars = "None"
    $TextBoxAPIKey.Location = "250,$yb"
    $TextBoxAPIKey.Size = "210,93" 
    $TextBoxAPIKey.AppendText("$apiKey")
    $yb = $yb + 46


    #### Label API User ###################################################
    $objLabelAPIUser = New-Object System.Windows.Forms.label
    $objLabelAPIUser.Location = "$xb,$yb"
    $objLabelAPIUser.Size = "210,20"
    $objLabelAPIUser.BackColor = "Transparent"
    $objLabelAPIUser.ForeColor = "white"
    $objLabelAPIUser.Font = New-Object System.Drawing.Font("Calibri", 10.5, [System.Drawing.FontStyle]::Bold)
    $objLabelAPIUser.Text = "API Run As User"
    $yb = $yb + 22



    #### Text Box API User ###################################################
    $TextBoxAPIUser = New-Object System.Windows.Forms.TextBox
    $TextBoxAPIUser.Multiline = $False
    $TextBoxAPIUser.ScrollBars = "Vertical"
    $TextBoxAPIUser.Location = "$xb,$yb"
    $TextBoxAPIUser.Size = "210,$TextBoxHeight"   #  New-Object System.Drawing.Size(560,100) 
    $TextBoxAPIUser.AppendText("$global:apiUser")
    $TextBoxAPIUser.name = "TextBoxAPIUser"
    $TextBoxAPIUser.add_MouseHover($ShowHelp)
    $yb = $yb + 28

    #### Note API User ###################################################
    #$objNoteAPIUser = New-Object System.Windows.Forms.label
    #$objNoteAPIUser.Location = "$xb,$yb"
    #$objNoteAPIUser.Size = "210,20"
    #$objNoteAPIUser.BackColor = "Transparent"
    #$objNoteAPIUser.ForeColor = "black"
    #$objNoteAPIUser.Font = New-Object System.Drawing.Font("Calibri",6)
    #$objNoteAPIUser.Text = "Domain\Account Format for Domain Accounts"
    #$yb = $yb + 22


    #### Label Managed Account ###################################################
    $objLabelManagedAccount = New-Object System.Windows.Forms.label
    $objLabelManagedAccount.Location = "480,40"
    $objLabelManagedAccount.Size = "210,20"
    $objLabelManagedAccount.BackColor = "Transparent"
    $objLabelManagedAccount.ForeColor = "white"
    $objLabelManagedAccount.Font = New-Object System.Drawing.Font("Calibri", 10.5, [System.Drawing.FontStyle]::Bold)
    $objLabelManagedAccount.Text = "Managed Account"
    $yb = 62


    #### Text Box Managed Account ###################################################
    $TextBoxMAName = New-Object System.Windows.Forms.TextBox
    $TextBoxMAName.Multiline = $False
    $TextBoxMAName.ScrollBars = "Vertical"
    $TextBoxMAName.Location = "480,$yb"
    $TextBoxMAName.Size = "210,$TextBoxHeight" 
    $TextBoxMAName.AppendText($global:managedAccount)
    $TextBoxMAName.name = "TextBoxMAName"
    $TextBoxMAName.add_MouseHover($ShowHelp)
    $yb = $yb + 28


    #### Note Managed Account ###################################################
    #$objNoteManagedAccount = New-Object System.Windows.Forms.label
    #$objNoteManagedAccount.Location = "480,$yb"
    #$objNoteManagedAccount.Size = "210,20"
    #$objNoteManagedAccount.BackColor = "Transparent"
    #$objNoteManagedAccount.ForeColor = "black"
    #$objNoteManagedAccount.Font = New-Object System.Drawing.Font("Calibri",6)
    #$objNoteManagedAccount.Text = "Domain\Account Format for Domain Accounts"
    $yb = $yb + 18


    #### Label Managed System ###################################################
    $objLabelManagedSystem = New-Object System.Windows.Forms.label
    $objLabelManagedSystem.Location = "480,$yb"
    $objLabelManagedSystem.Size = "210,20"
    $objLabelManagedSystem.BackColor = "Transparent"
    $objLabelManagedSystem.ForeColor = "white"
    $objLabelManagedSystem.Font = New-Object System.Drawing.Font("Calibri", 10.5, [System.Drawing.FontStyle]::Bold)
    $objLabelManagedSystem.Text = "Managed System"
    $yb = $yb + 22

    #### Text Box Managed System ###################################################
    $TextBoxMSName = New-Object System.Windows.Forms.TextBox
    $TextBoxMSName.Multiline = $False
    $TextBoxMSName.ScrollBars = "Vertical"
    $TextBoxMSName.Location = "480,$yb"
    $TextBoxMSName.Size = "210,$TextBoxHeight" 
    $TextBoxMSName.AppendText($global:managedSystem)
    $TextBoxMSName.name = "TextBoxMSName"
    $TextBoxMSName.add_MouseHover($ShowHelp)
    $yb = $yb + 28

    
    #### Note Managed System ###################################################
    #$objNoteManagedSystem = New-Object System.Windows.Forms.label
    #$objNoteManagedSystem.Location = "480,$yb"
    #$objNoteManagedSystem.Size = "210,20"
    #$objNoteManagedSystem.BackColor = "Transparent"
    #$objNoteManagedSystem.ForeColor = "black"
    #$objNoteManagedSystem.Font = New-Object System.Drawing.Font("Calibri",6)
    #$objNoteManagedSystem.Text = "Domain Accounts must be Linked to this System"
    $yb = $yb + 28
    

    #### Base Endpoint URL Group Box ###################################################
    $GroupBoxProdType = New-Object System.Windows.Forms.GroupBox
    $GroupBoxProdType.Location = "$xb,180"
    $GroupBoxProdType.size = "440,90" 
    $GroupBoxProdType.Font = New-Object System.Drawing.Font("Calibri", 10.5, [System.Drawing.FontStyle]::Bold)
    $GroupBoxProdType.ForeColor = "white"
    $GroupBoxProdType.text = " Base Endpoint URL "
    $yb = $yb + 18


    #### Label Product Type ###################################################
    #$objLabelProduct = New-Object System.Windows.Forms.label
    #$objLabelProduct.Location = "$xb,$yb"
    #$objLabelProduct.Size = "250,20"
    #$objLabelProduct.BackColor = "Transparent"
    #$objLabelProduct.ForeColor = "black"
    #$objLabelProduct.Font = New-Object System.Drawing.Font("Calibri",10.5,[System.Drawing.FontStyle]::Bold)
    #$objLabelProduct.Text = "Password Safe Deloyment Type"
    #$yb = $yb + 22
 


    #### Label Base URL ###################################################
    $objLabelBaseURL = New-Object System.Windows.Forms.label
    $objLabelBaseURL.Location = "30,$yb"
    $objLabelBaseURL.Size = "410,20"
    $objLabelBaseURL.BackColor = "Transparent"
    $objLabelBaseURL.ForeColor = "white"
    $objLabelBaseURL.Font = New-Object System.Drawing.Font("Calibri", 10.5, [System.Drawing.FontStyle]::Bold)
    #$objLabelBaseURL.Text = "Enter your Appliance hostname for the Base Endpoint URL"
    $yb = $yb + 28

    #### Label https:// ###################################################
    #$objLabelBaseURL1 = New-Object System.Windows.Forms.label
    #$objLabelBaseURL1.Location = "30,$yb"
    #$objLabelBaseURL1.Size = "40,20"
    #$objLabelBaseURL1.BackColor = "Transparent"
    #$objLabelBaseURL1.ForeColor = "black"
    #$objLabelBaseURL1.Font = New-Object System.Drawing.Font("Calibri",6.5)
    #$objLabelBaseURL1.Text = "https://"
    
    
    #### Text Box Base URL ###################################################
    $TextBaseURL = New-Object System.Windows.Forms.TextBox
    $TextBaseURL.Multiline = $False
    $TextBaseURL.ScrollBars = "Vertical"
    $TextBaseURL.Location = "30,$yb"
    $TextBaseURL.Size = "110,20" 
    #$TextBaseURL.Text = "https://the-server/BeyondTrust/api/public/v3/"
    $TextBaseURL.AppendText($global:baseURL)
    $TextBaseURL.name = "TextBaseURL"
    $TextBaseURL.add_MouseHover($ShowHelp)
    $yb = $yb + 6



    #### Label /BeyondTrust/api/public/v3/ ###################################################
    $objLabelBaseURL2 = New-Object System.Windows.Forms.label
    $objLabelBaseURL2.Location = "140,$yb"
    $objLabelBaseURL2.Size = "315,20"
    $objLabelBaseURL2.BackColor = "Transparent"
    $objLabelBaseURL2.ForeColor = "white"
    $objLabelBaseURL2.Font = New-Object System.Drawing.Font("Calibri", 8)
    #$objLabelBaseURL2.Text = "/BeyondTrust/api/public/v3/" 
    

    $GroupBoxProdType.Controls.AddRange(@($ProductType, $objLabelBaseURL, $objLabelBaseURL1, $objLabelBaseURL2, $TextBaseURL))    

   
    #Catch changes to the list
    
    $ProductType.add_SelectedIndexChanged({
        
            $selected = $ProductType.SelectedItem
            if ($selected -eq 'U-Series Appliance') {
                $objLabelBaseURL.Text = "Enter your U-Series Appliance hostname or IP address"
                $objLabelBaseURL2.Text = "/BeyondTrust/api/public/v3/"
            }

            if ($selected -eq 'Password Safe Cloud') {
                $objLabelBaseURL.Text = "Enter your Password Safe Cloud Instance ID"
                $objLabelBaseURL2.Text = ".ps.beyondtrustcloud.com/BeyondTrust/api/public/v3/"
            }
        }) 

    $yb = $yb + 48


     
    

    $GroupBoxCredType = New-Object System.Windows.Forms.GroupBox
    $GroupBoxCredType.Location = "480,180"
    $GroupBoxCredType.size = "210,90" 
    $GroupBoxCredType.Font = New-Object System.Drawing.Font("Calibri", 10.5, [System.Drawing.FontStyle]::Bold)
    $GroupBoxCredType.ForeColor = "white"
    $GroupBoxCredType.text = " API Test Type "
    


    #### API Test Type Combo Box ###################################################
    $rbx = 10
    $rby = 40
    $listBox = New-Object System.Windows.Forms.ComboBox
    $listBox.Location = New-Object System.Drawing.Point($rbx, $rby)
    $listBox.Size = New-Object System.Drawing.Size(190, 20)
    $listBox.Height = 60
    $listBox.Text = 'Select a Test Type >>'
    [void] $listBox.Items.Add('Change Password')
    [void] $listBox.Items.Add('DSS Private Key')
    [void] $listBox.Items.Add('DSS Key Passphrase')
    [void] $listBox.Items.Add('Retrieve Password')
    [void] $listBox.Items.Add('Test Password')

    $GroupBoxCredType.Controls.AddRange(@($listBox))

        $GroupBoxConflictOption = New-Object System.Windows.Forms.GroupBox
    $GroupBoxConflictOption.Location = "710,180"
    $GroupBoxConflictOption.size = "150,90" 
    $GroupBoxConflictOption.Font = New-Object System.Drawing.Font("Calibri",10.5,[System.Drawing.FontStyle]::Bold)
    $GroupBoxConflictOption.ForeColor = "white"
    $GroupBoxConflictOption.text = " Conflict Option "
	
	$rbx = 10
    $rby = 28
    $RadioButton1 = New-Object System.Windows.Forms.RadioButton
    $RadioButton1.Location = "$rbx,$rby"
    $RadioButton1.size = '80,20'
    $RadioButton1.Checked = $true 
    $RadioButton1.Text = "Reuse"

    $rby = $rby + 28
    $RadioButton2 = New-Object System.Windows.Forms.RadioButton
    $RadioButton2.Location = "$rbx,$rby"
    $RadioButton2.size = '80,20'
    $RadioButton2.Checked = $false
    $RadioButton2.Text = "Renew"

 
  $GroupBoxConflictOption.Controls.AddRange(@($RadioButton1, $RadioButton2))

    
    # Label Text Box Password
    $objLabelTextBoxResults = New-Object System.Windows.Forms.label
    $objLabelTextBoxResults.Location = "$xb,$yb"
    $objLabelTextBoxResults.Size = "$TextBoxWidth,20"
    $objLabelTextBoxResults.BackColor = "Transparent"
    $objLabelTextBoxResults.ForeColor = "white"
    $objLabelTextBoxResults.Font = New-Object System.Drawing.Font("Calibri", 10.5, [System.Drawing.FontStyle]::Bold)
    $objLabelTextBoxResults.Text = "Test Results Console"
    $yb = $yb + 22

   
    # Text Box Password
    $TextPassword = New-Object System.Windows.Forms.RichTextBox
    $TextPassword.Multiline = $True
    $TextPassword.ScrollBars = "Vertical"
    $TextPassword.Location = "$xb,$yb"
    $TextPassword.Size = "$TextBoxWidth,$TextBoxHeight" 
    $TextPassword.Height = 134
    #$TextPassword.AppendText=""
    $TextPassword.Enabled = $True
    $TextPassword.ReadOnly = $True
    $TextPassword.BackColor = 'white'
    
    $yb = $yb + 30

 
    #### Start Button ###################################################
    $OKButtonX = 100
    $OKButtonY = $FormHeight - 94
    $OKButton = new-object System.Windows.Forms.Button
    $OKButton.Location = "$OKButtonX,$OKButtonY"
    $OKButton.Size = '120,40' 
    $OKButton.FlatStyle = 'system'
    #$OKButton.BackColor='DarkGreen'
    #$OKButton.ForeColor='White'
    $OKButton.Font = New-Object System.Drawing.Font("Calibri", 11, [System.Drawing.FontStyle]::Bold)
    $OKButton.Text = 'Start'
    $OKButton.Add_Click($ok_click)


    #### Clear Results Button ###################################################
    $ClearButtonX = 320
    $ClearButtonY = $FormHeight - 94
    $ClearButton = new-object System.Windows.Forms.Button
    $ClearButton.Location = "$ClearButtonX,$ClearButtonY"
    $ClearButton.Size = '120,40'
    $ClearButton.FlatStyle = 'system'
    #$ClearButton.BackColor='Orange'
    #$ClearButton.ForeColor='White'
    $ClearButton.Font = New-Object System.Drawing.Font("Calibri", 10.5, [System.Drawing.FontStyle]::Bold)
    $ClearButton.Text = "Clear Results"
    $ClearButton.Add_Click{ $TextPassword.Clear() }

    #Add a Clear Form button
    #$ClearFormButtonX = 350
    #$ClearFormButtonY = $FormHeight - 100
    #$ClearFormButton = new-object System.Windows.Forms.Button
    #$ClearFormButton.Location = "$ClearFormButtonX,$ClearFormButtonY"
    #$ClearFormButton.Size = '100,40'
    #$ClearFormButton.Font = New-Object System.Drawing.Font("Calibri",10.5,[System.Drawing.FontStyle]::Bold)
    #$ClearFormButton.Text = "Reset Form"
    #$ClearFormButton.Add_Click{$TextPassword.Clear(),$TextBoxAPIUser.Clear(),$TextBoxAPIKey.Clear(),$TextBaseURL.Clear(), $TextBoxMSName.Clear(),$TextBoxMAName.Clear()}


    #### Help Button ###################################################
    $HelpButtonX = 540
    $HelpButtonY = $FormHeight - 94
    $HelpButton = new-object System.Windows.Forms.Button
    $HelpButton.Location = "$HelpButtonX,$HelpButtonY"
    $HelpButton.Size = '100,40'
    $HelpButton.FlatStyle = 'system'
    #$HelpButton.BackColor='DarkBlue'
    #$HelpButton.ForeColor='White'
    $HelpButton.Font = New-Object System.Drawing.Font("Calibri", 11, [System.Drawing.FontStyle]::Bold)
    $HelpButton.Text = "Help"
    $HelpButton.Add_Click($help_click)
    
    
    #### Save Config Button ###################################################
    $SaveButtonX = 740
    $SaveButtonY = $FormHeight - 94
    $SaveButton = new-object System.Windows.Forms.Button
    $SaveButton.Location = "$SaveButtonX,$SaveButtonY"
    $SaveButton.Size = '120,40'
    $SaveButton.FlatStyle = 'system'
    #$SaveButton.BackColor='DarkRed'
    #$SaveButton.ForeColor='White'
    $SaveButton.Font = New-Object System.Drawing.Font("Calibri", 11, [System.Drawing.FontStyle]::Bold)
    $SaveButton.Text = "Export Settings"
    $SaveButton.Add_Click($save_click)



    
    # Add all the GroupBox controls on one line
    $MyGroupBox.Controls.AddRange(@($ProductType, $objLabelAPIUser, $TextBoxAPIUser, $objNoteAPIUser, $objLabelAPIKey, $TextBoxAPIKey, $objLabelPWSType, $objLabelProduct, $objLabelManagedAccount, $TextBoxMAName, $objLabelManagedSystem, $TextBoxMSName, $objLabelBaseURL, $objLabelBaseURL1, $objLabelBaseURL2, $TextBaseURL, $GroupBoxCredType, $GroupBoxConflictOption, $objLabelTextBoxResults, $TextPassword, $objNoteManagedAccount, $objNoteManagedSystem, $GroupBoxProdType))   
 
    # Add all the Form controls on one line 
    $form.Controls.AddRange(@($MyGroupBox, $OKButton, $ClearButton, $HelpButton, $SaveButton))
    
    
    # Assign the Accept and Cancel options in the form to the corresponding buttons
    $form.AcceptButton = $OKButton
    
    #$form.ClearButton = $ClearButton
 
    # Activate the form
    Hide-Console 
    $form.Add_Shown({ $form.Activate() })    
    
    # Get the results from the button click
    $dialogResult = $form.ShowDialog()
 
}


add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
public bool CheckValidationResult(
ServicePoint srvPoint, X509Certificate certificate,
WebRequest request, int certificateProblem) {
return true;
}
}
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

MainMenu
# SIG # Begin signature block
# MIIt2gYJKoZIhvcNAQcCoIItyzCCLccCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA9uulzoZViTXlP
# TkZmTZfjmU5i+8OPLuyOVb7qZBw5+qCCEz0wggWQMIIDeKADAgECAhAFmxtXno4h
# MuI5B72nd3VcMA0GCSqGSIb3DQEBDAUAMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNV
# BAMTGERpZ2lDZXJ0IFRydXN0ZWQgUm9vdCBHNDAeFw0xMzA4MDExMjAwMDBaFw0z
# ODAxMTUxMjAwMDBaMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
# bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lDZXJ0
# IFRydXN0ZWQgUm9vdCBHNDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIB
# AL/mkHNo3rvkXUo8MCIwaTPswqclLskhPfKK2FnC4SmnPVirdprNrnsbhA3EMB/z
# G6Q4FutWxpdtHauyefLKEdLkX9YFPFIPUh/GnhWlfr6fqVcWWVVyr2iTcMKyunWZ
# anMylNEQRBAu34LzB4TmdDttceItDBvuINXJIB1jKS3O7F5OyJP4IWGbNOsFxl7s
# Wxq868nPzaw0QF+xembud8hIqGZXV59UWI4MK7dPpzDZVu7Ke13jrclPXuU15zHL
# 2pNe3I6PgNq2kZhAkHnDeMe2scS1ahg4AxCN2NQ3pC4FfYj1gj4QkXCrVYJBMtfb
# BHMqbpEBfCFM1LyuGwN1XXhm2ToxRJozQL8I11pJpMLmqaBn3aQnvKFPObURWBf3
# JFxGj2T3wWmIdph2PVldQnaHiZdpekjw4KISG2aadMreSx7nDmOu5tTvkpI6nj3c
# AORFJYm2mkQZK37AlLTSYW3rM9nF30sEAMx9HJXDj/chsrIRt7t/8tWMcCxBYKqx
# YxhElRp2Yn72gLD76GSmM9GJB+G9t+ZDpBi4pncB4Q+UDCEdslQpJYls5Q5SUUd0
# viastkF13nqsX40/ybzTQRESW+UQUOsxxcpyFiIJ33xMdT9j7CFfxCBRa2+xq4aL
# T8LWRV+dIPyhHsXAj6KxfgommfXkaS+YHS312amyHeUbAgMBAAGjQjBAMA8GA1Ud
# EwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgGGMB0GA1UdDgQWBBTs1+OC0nFdZEzf
# Lmc/57qYrhwPTzANBgkqhkiG9w0BAQwFAAOCAgEAu2HZfalsvhfEkRvDoaIAjeNk
# aA9Wz3eucPn9mkqZucl4XAwMX+TmFClWCzZJXURj4K2clhhmGyMNPXnpbWvWVPjS
# PMFDQK4dUPVS/JA7u5iZaWvHwaeoaKQn3J35J64whbn2Z006Po9ZOSJTROvIXQPK
# 7VB6fWIhCoDIc2bRoAVgX+iltKevqPdtNZx8WorWojiZ83iL9E3SIAveBO6Mm0eB
# cg3AFDLvMFkuruBx8lbkapdvklBtlo1oepqyNhR6BvIkuQkRUNcIsbiJeoQjYUIp
# 5aPNoiBB19GcZNnqJqGLFNdMGbJQQXE9P01wI4YMStyB0swylIQNCAmXHE/A7msg
# dDDS4Dk0EIUhFQEI6FUy3nFJ2SgXUE3mvk3RdazQyvtBuEOlqtPDBURPLDab4vri
# RbgjU2wGb2dVf0a1TD9uKFp5JtKkqGKX0h7i7UqLvBv9R0oN32dmfrJbQdA75PQ7
# 9ARj6e/CVABRoIoqyc54zNXqhwQYs86vSYiv85KZtrPmYQ/ShQDnUBrkG5WdGaG5
# nLGbsQAe79APT0JsyQq87kP6OnGlyE0mpTX9iV28hWIdMtKgK1TtmlfB2/oQzxm3
# i0objwG2J5VT6LaJbVu8aNQj6ItRolb58KaAoNYes7wPD1N1KarqE3fk3oyBIa0H
# EEcRrYc9B9F1vM/zZn4wggawMIIEmKADAgECAhAIrUCyYNKcTJ9ezam9k67ZMA0G
# CSqGSIb3DQEBDAUAMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
# bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lDZXJ0
# IFRydXN0ZWQgUm9vdCBHNDAeFw0yMTA0MjkwMDAwMDBaFw0zNjA0MjgyMzU5NTla
# MGkxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjFBMD8GA1UE
# AxM4RGlnaUNlcnQgVHJ1c3RlZCBHNCBDb2RlIFNpZ25pbmcgUlNBNDA5NiBTSEEz
# ODQgMjAyMSBDQTEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDVtC9C
# 0CiteLdd1TlZG7GIQvUzjOs9gZdwxbvEhSYwn6SOaNhc9es0JAfhS0/TeEP0F9ce
# 2vnS1WcaUk8OoVf8iJnBkcyBAz5NcCRks43iCH00fUyAVxJrQ5qZ8sU7H/Lvy0da
# E6ZMswEgJfMQ04uy+wjwiuCdCcBlp/qYgEk1hz1RGeiQIXhFLqGfLOEYwhrMxe6T
# SXBCMo/7xuoc82VokaJNTIIRSFJo3hC9FFdd6BgTZcV/sk+FLEikVoQ11vkunKoA
# FdE3/hoGlMJ8yOobMubKwvSnowMOdKWvObarYBLj6Na59zHh3K3kGKDYwSNHR7Oh
# D26jq22YBoMbt2pnLdK9RBqSEIGPsDsJ18ebMlrC/2pgVItJwZPt4bRc4G/rJvmM
# 1bL5OBDm6s6R9b7T+2+TYTRcvJNFKIM2KmYoX7BzzosmJQayg9Rc9hUZTO1i4F4z
# 8ujo7AqnsAMrkbI2eb73rQgedaZlzLvjSFDzd5Ea/ttQokbIYViY9XwCFjyDKK05
# huzUtw1T0PhH5nUwjewwk3YUpltLXXRhTT8SkXbev1jLchApQfDVxW0mdmgRQRNY
# mtwmKwH0iU1Z23jPgUo+QEdfyYFQc4UQIyFZYIpkVMHMIRroOBl8ZhzNeDhFMJlP
# /2NPTLuqDQhTQXxYPUez+rbsjDIJAsxsPAxWEQIDAQABo4IBWTCCAVUwEgYDVR0T
# AQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUaDfg67Y7+F8Rhvv+YXsIiGX0TkIwHwYD
# VR0jBBgwFoAU7NfjgtJxXWRM3y5nP+e6mK4cD08wDgYDVR0PAQH/BAQDAgGGMBMG
# A1UdJQQMMAoGCCsGAQUFBwMDMHcGCCsGAQUFBwEBBGswaTAkBggrBgEFBQcwAYYY
# aHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEEGCCsGAQUFBzAChjVodHRwOi8vY2Fj
# ZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVzdGVkUm9vdEc0LmNydDBDBgNV
# HR8EPDA6MDigNqA0hjJodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRU
# cnVzdGVkUm9vdEc0LmNybDAcBgNVHSAEFTATMAcGBWeBDAEDMAgGBmeBDAEEATAN
# BgkqhkiG9w0BAQwFAAOCAgEAOiNEPY0Idu6PvDqZ01bgAhql+Eg08yy25nRm95Ry
# sQDKr2wwJxMSnpBEn0v9nqN8JtU3vDpdSG2V1T9J9Ce7FoFFUP2cvbaF4HZ+N3HL
# IvdaqpDP9ZNq4+sg0dVQeYiaiorBtr2hSBh+3NiAGhEZGM1hmYFW9snjdufE5Btf
# Q/g+lP92OT2e1JnPSt0o618moZVYSNUa/tcnP/2Q0XaG3RywYFzzDaju4ImhvTnh
# OE7abrs2nfvlIVNaw8rpavGiPttDuDPITzgUkpn13c5UbdldAhQfQDN8A+KVssIh
# dXNSy0bYxDQcoqVLjc1vdjcshT8azibpGL6QB7BDf5WIIIJw8MzK7/0pNVwfiThV
# 9zeKiwmhywvpMRr/LhlcOXHhvpynCgbWJme3kuZOX956rEnPLqR0kq3bPKSchh/j
# wVYbKyP/j7XqiHtwa+aguv06P0WmxOgWkVKLQcBIhEuWTatEQOON8BUozu3xGFYH
# Ki8QxAwIZDwzj64ojDzLj4gLDb879M4ee47vtevLt/B3E+bnKD+sEq6lLyJsQfmC
# XBVmzGwOysWGw/YmMwwHS6DTBwJqakAwSEs0qFEgu60bhQjiWQ1tygVQK+pKHJ6l
# /aCnHwZ05/LWUpD9r4VIIflXO7ScA+2GRfS0YW6/aOImYIbqyK+p/pQd52MbOoZW
# eE4wggbxMIIE2aADAgECAhAEsSgBLTihunyVCRWVxj4QMA0GCSqGSIb3DQEBCwUA
# MGkxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjFBMD8GA1UE
# AxM4RGlnaUNlcnQgVHJ1c3RlZCBHNCBDb2RlIFNpZ25pbmcgUlNBNDA5NiBTSEEz
# ODQgMjAyMSBDQTEwHhcNMjQwMjI5MDAwMDAwWhcNMjYwNjAzMjM1OTU5WjB5MQsw
# CQYDVQQGEwJVUzEQMA4GA1UECBMHR2VvcmdpYTEUMBIGA1UEBxMLSm9obnMgQ3Jl
# ZWsxIDAeBgNVBAoTF0JleW9uZFRydXN0IENvcnBvcmF0aW9uMSAwHgYDVQQDExdC
# ZXlvbmRUcnVzdCBDb3Jwb3JhdGlvbjCCAaIwDQYJKoZIhvcNAQEBBQADggGPADCC
# AYoCggGBAIsYAZ3eUiiN3Gh3DLSwCbJcoJS7/NN8RmYwtX5IzMm1J344WZ+Yeths
# 9Ivdc63KuJjqf7RfhRAe27m4QkxnsiM04NgjbS2wgmrp5curexnikDsJo/C5PJt4
# wr5KIzO//iMQXlZQXjT61PZKshZ7FAagH0LS8QB6GgE0omU4V0/kUlNZ5Hq0u3J+
# FURecNmaWqWgp2kmewgu4r6j3qvUic+6NWSIaBG6/ZyNTaqIerjLFYA0COGVFP4f
# D9lRMSybiPJE03WyL/i9uhXH8O/PyU6xhT0yuaazSf1JoaKRCMrC7w3qNiyoVCna
# ICcm1JRsO+MGq587WM8z6ooq8vId5QZe1+XJnnxF9VZtBKF8e5loHYDg3vKH3RQ7
# MVDqi9mih46dl8i4EFdVeT2ONXC95JCU5abs2cwFTo0v4HNZahk/fKDbpX/ChAip
# DSicX96g897NosYsqAbuM1r9fxpxuRgbVitfeOx7rNVVQ68xUVHQD2vZ40ZvSePv
# NDyKfhBiuQIDAQABo4ICAzCCAf8wHwYDVR0jBBgwFoAUaDfg67Y7+F8Rhvv+YXsI
# iGX0TkIwHQYDVR0OBBYEFFBOU1CDdVIXqGQlgxZpmAkuq9GHMD4GA1UdIAQ3MDUw
# MwYGZ4EMAQQBMCkwJwYIKwYBBQUHAgEWG2h0dHA6Ly93d3cuZGlnaWNlcnQuY29t
# L0NQUzAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwgbUGA1Ud
# HwSBrTCBqjBToFGgT4ZNaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
# VHJ1c3RlZEc0Q29kZVNpZ25pbmdSU0E0MDk2U0hBMzg0MjAyMUNBMS5jcmwwU6BR
# oE+GTWh0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRHNENv
# ZGVTaWduaW5nUlNBNDA5NlNIQTM4NDIwMjFDQTEuY3JsMIGUBggrBgEFBQcBAQSB
# hzCBhDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMFwGCCsG
# AQUFBzAChlBodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVz
# dGVkRzRDb2RlU2lnbmluZ1JTQTQwOTZTSEEzODQyMDIxQ0ExLmNydDAJBgNVHRME
# AjAAMA0GCSqGSIb3DQEBCwUAA4ICAQCW5v3LdSFFi+ceYtfqndtH3eXrvdM4c6CN
# i/1+zSI63QdWWr/anj0sZY50VzNn1U3uyqZZBZN+6YpCMpZ4Iw6rjAA/L1aF776J
# IYbLjuWTkAnb8bnqygPbclN0CY3i/mW47QP0tyDm28YmMr7EmKNBtRgBqOVGWgAo
# pqQIUJFXG+J8v89MWn8tl7wqss7Bxg42pZUOUIn4NfqkVbIgEeyQiY7mtz9c2Mjd
# AZqGsXQv3k0zoKTWnzyKpQVf+PnmdDY8LWeYZIwaGLRjV0arUUJ+nIaWfH7uqsM2
# BCTb03wHcHasOMoOpt5aNlkF0E/ZuEAI3t6kYqDB1ZR+Skz5Y7/8LdYoZ6qVEMMD
# 9QsavKGulGncGL/FW5xmDAu+eYo6252SLjYWgxKNqiH7Fk8TQmrAdEk4A5W1oSB5
# 4RUJ8hhfiaicvEAibn3dTV+NJrnFwAVbJgO5Oe4Bd0Axr5qcbOBTnrQQAMQgnt7b
# P/dkecnb473hbpnfGBwWDHuesFrTRb6zqCd85rJFQw1bKRImKR5xJ8ikGSzgiY56
# sUikZPocV3K/GBwOa+F7NQq7mqPmjlZlAwBLmxv9urUxi5juW7GQO/32wYBuDYYh
# wbf9TGdsYM1tAPvuQFpPLmiRt6MnZhB0+slKPhXvW1nReLZbgU6Nio+IvvWzCr7F
# Jfpr0VLyQjGCGfMwghnvAgEBMH0waTELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRp
# Z2lDZXJ0LCBJbmMuMUEwPwYDVQQDEzhEaWdpQ2VydCBUcnVzdGVkIEc0IENvZGUg
# U2lnbmluZyBSU0E0MDk2IFNIQTM4NCAyMDIxIENBMQIQBLEoAS04obp8lQkVlcY+
# EDANBglghkgBZQMEAgEFAKCBhDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkG
# CSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEE
# AYI3AgEVMC8GCSqGSIb3DQEJBDEiBCByj0Nt2dsypr7+ROsmN+h1Mxnrk1fgRfcP
# RZ9nXwu79jANBgkqhkiG9w0BAQEFAASCAYBh8KYebmpbC5Vq6iQED85FfH6++OLX
# pXyc1AsoOITlDgRjNUG7DQjrinhYlKgtZUAEsSHBAAd+sZTZfaDskaoTNJ3L0RK+
# baxPbaGuVifymswsbM6iSZCFi/cap0zVzly64AMtLS1xZVuCRCkT8zPx9Kc7YpcH
# TeSF6395HY7QJ0/0nsqyKYkfiEfvLX6RvRU2OnyattT5VrWldlD4k1V5z2O0B5Ph
# hHXgTASi9mVrGO5XTfa223TFsv8pn0gWwNTMK1QiVAOcxXMadkXhK/vu6+CzxsCE
# aa+YwqCtqNy4v2p7nZA2vn31gVohtxtlIiNuD/cjPTSXiUY98hk585j7tfDeORQ8
# KedvNCcMzzlQa3cakrNk92uDUYxowKAV4lIzZ0pOBzdl1Ny/3i7AWMCEuBKl7k4s
# 1KlGO2EbD4oob3rfNXwK58YO6mQr2JyrPC3r9RyEMbvKzRMHPhfRPZgHWmN/LBJs
# VTGXiOUs1DwlBh37aBJ+d3KVnO4oY1QwET2hghdAMIIXPAYKKwYBBAGCNwMDATGC
# FywwghcoBgkqhkiG9w0BBwKgghcZMIIXFQIBAzEPMA0GCWCGSAFlAwQCAQUAMHgG
# CyqGSIb3DQEJEAEEoGkEZzBlAgEBBglghkgBhv1sBwEwMTANBglghkgBZQMEAgEF
# AAQgBqKr3KK3DyHefCOQoEn9EHq2Z279iet2LO7X0iv39PsCEQDpkqpkJ0Zk/RdN
# obMCx1wLGA8yMDI0MDUxNDE4NTgzNlqgghMJMIIGwjCCBKqgAwIBAgIQBUSv85Sd
# CDmmv9s/X+VhFjANBgkqhkiG9w0BAQsFADBjMQswCQYDVQQGEwJVUzEXMBUGA1UE
# ChMORGlnaUNlcnQsIEluYy4xOzA5BgNVBAMTMkRpZ2lDZXJ0IFRydXN0ZWQgRzQg
# UlNBNDA5NiBTSEEyNTYgVGltZVN0YW1waW5nIENBMB4XDTIzMDcxNDAwMDAwMFoX
# DTM0MTAxMzIzNTk1OVowSDELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0
# LCBJbmMuMSAwHgYDVQQDExdEaWdpQ2VydCBUaW1lc3RhbXAgMjAyMzCCAiIwDQYJ
# KoZIhvcNAQEBBQADggIPADCCAgoCggIBAKNTRYcdg45brD5UsyPgz5/X5dLnXaEO
# CdwvSKOXejsqnGfcYhVYwamTEafNqrJq3RApih5iY2nTWJw1cb86l+uUUI8cIOrH
# mjsvlmbjaedp/lvD1isgHMGXlLSlUIHyz8sHpjBoyoNC2vx/CSSUpIIa2mq62DvK
# Xd4ZGIX7ReoNYWyd/nFexAaaPPDFLnkPG2ZS48jWPl/aQ9OE9dDH9kgtXkV1lnX+
# 3RChG4PBuOZSlbVH13gpOWvgeFmX40QrStWVzu8IF+qCZE3/I+PKhu60pCFkcOvV
# 5aDaY7Mu6QXuqvYk9R28mxyyt1/f8O52fTGZZUdVnUokL6wrl76f5P17cz4y7lI0
# +9S769SgLDSb495uZBkHNwGRDxy1Uc2qTGaDiGhiu7xBG3gZbeTZD+BYQfvYsSzh
# Ua+0rRUGFOpiCBPTaR58ZE2dD9/O0V6MqqtQFcmzyrzXxDtoRKOlO0L9c33u3Qr/
# eTQQfqZcClhMAD6FaXXHg2TWdc2PEnZWpST618RrIbroHzSYLzrqawGw9/sqhux7
# UjipmAmhcbJsca8+uG+W1eEQE/5hRwqM/vC2x9XH3mwk8L9CgsqgcT2ckpMEtGlw
# Jw1Pt7U20clfCKRwo+wK8REuZODLIivK8SgTIUlRfgZm0zu++uuRONhRB8qUt+JQ
# ofM604qDy0B7AgMBAAGjggGLMIIBhzAOBgNVHQ8BAf8EBAMCB4AwDAYDVR0TAQH/
# BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAgBgNVHSAEGTAXMAgGBmeBDAEE
# AjALBglghkgBhv1sBwEwHwYDVR0jBBgwFoAUuhbZbU2FL3MpdpovdYxqII+eyG8w
# HQYDVR0OBBYEFKW27xPn783QZKHVVqllMaPe1eNJMFoGA1UdHwRTMFEwT6BNoEuG
# SWh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRHNFJTQTQw
# OTZTSEEyNTZUaW1lU3RhbXBpbmdDQS5jcmwwgZAGCCsGAQUFBwEBBIGDMIGAMCQG
# CCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wWAYIKwYBBQUHMAKG
# TGh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRHNFJT
# QTQwOTZTSEEyNTZUaW1lU3RhbXBpbmdDQS5jcnQwDQYJKoZIhvcNAQELBQADggIB
# AIEa1t6gqbWYF7xwjU+KPGic2CX/yyzkzepdIpLsjCICqbjPgKjZ5+PF7SaCinEv
# GN1Ott5s1+FgnCvt7T1IjrhrunxdvcJhN2hJd6PrkKoS1yeF844ektrCQDifXcig
# LiV4JZ0qBXqEKZi2V3mP2yZWK7Dzp703DNiYdk9WuVLCtp04qYHnbUFcjGnRuSvE
# xnvPnPp44pMadqJpddNQ5EQSviANnqlE0PjlSXcIWiHFtM+YlRpUurm8wWkZus8W
# 8oM3NG6wQSbd3lqXTzON1I13fXVFoaVYJmoDRd7ZULVQjK9WvUzF4UbFKNOt50MA
# cN7MmJ4ZiQPq1JE3701S88lgIcRWR+3aEUuMMsOI5ljitts++V+wQtaP4xeR0arA
# VeOGv6wnLEHQmjNKqDbUuXKWfpd5OEhfysLcPTLfddY2Z1qJ+Panx+VPNTwAvb6c
# Kmx5AdzaROY63jg7B145WPR8czFVoIARyxQMfq68/qTreWWqaNYiyjvrmoI1VygW
# y2nyMpqy0tg6uLFGhmu6F/3Ed2wVbK6rr3M66ElGt9V/zLY4wNjsHPW2obhDLN9O
# TH0eaHDAdwrUAuBcYLso/zjlUlrWrBciI0707NMX+1Br/wd3H3GXREHJuEbTbDJ8
# WC9nR2XlG3O2mflrLAZG70Ee8PBf4NvZrZCARK+AEEGKMIIGrjCCBJagAwIBAgIQ
# BzY3tyRUfNhHrP0oZipeWzANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEV
# MBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29t
# MSEwHwYDVQQDExhEaWdpQ2VydCBUcnVzdGVkIFJvb3QgRzQwHhcNMjIwMzIzMDAw
# MDAwWhcNMzcwMzIyMjM1OTU5WjBjMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGln
# aUNlcnQsIEluYy4xOzA5BgNVBAMTMkRpZ2lDZXJ0IFRydXN0ZWQgRzQgUlNBNDA5
# NiBTSEEyNTYgVGltZVN0YW1waW5nIENBMIICIjANBgkqhkiG9w0BAQEFAAOCAg8A
# MIICCgKCAgEAxoY1BkmzwT1ySVFVxyUDxPKRN6mXUaHW0oPRnkyibaCwzIP5WvYR
# oUQVQl+kiPNo+n3znIkLf50fng8zH1ATCyZzlm34V6gCff1DtITaEfFzsbPuK4CE
# iiIY3+vaPcQXf6sZKz5C3GeO6lE98NZW1OcoLevTsbV15x8GZY2UKdPZ7Gnf2ZCH
# RgB720RBidx8ald68Dd5n12sy+iEZLRS8nZH92GDGd1ftFQLIWhuNyG7QKxfst5K
# fc71ORJn7w6lY2zkpsUdzTYNXNXmG6jBZHRAp8ByxbpOH7G1WE15/tePc5OsLDni
# pUjW8LAxE6lXKZYnLvWHpo9OdhVVJnCYJn+gGkcgQ+NDY4B7dW4nJZCYOjgRs/b2
# nuY7W+yB3iIU2YIqx5K/oN7jPqJz+ucfWmyU8lKVEStYdEAoq3NDzt9KoRxrOMUp
# 88qqlnNCaJ+2RrOdOqPVA+C/8KI8ykLcGEh/FDTP0kyr75s9/g64ZCr6dSgkQe1C
# vwWcZklSUPRR8zZJTYsg0ixXNXkrqPNFYLwjjVj33GHek/45wPmyMKVM1+mYSlg+
# 0wOI/rOP015LdhJRk8mMDDtbiiKowSYI+RQQEgN9XyO7ZONj4KbhPvbCdLI/Hgl2
# 7KtdRnXiYKNYCQEoAA6EVO7O6V3IXjASvUaetdN2udIOa5kM0jO0zbECAwEAAaOC
# AV0wggFZMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFLoW2W1NhS9zKXaa
# L3WMaiCPnshvMB8GA1UdIwQYMBaAFOzX44LScV1kTN8uZz/nupiuHA9PMA4GA1Ud
# DwEB/wQEAwIBhjATBgNVHSUEDDAKBggrBgEFBQcDCDB3BggrBgEFBQcBAQRrMGkw
# JAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBBBggrBgEFBQcw
# AoY1aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZFJv
# b3RHNC5jcnQwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybDMuZGlnaWNlcnQu
# Y29tL0RpZ2lDZXJ0VHJ1c3RlZFJvb3RHNC5jcmwwIAYDVR0gBBkwFzAIBgZngQwB
# BAIwCwYJYIZIAYb9bAcBMA0GCSqGSIb3DQEBCwUAA4ICAQB9WY7Ak7ZvmKlEIgF+
# ZtbYIULhsBguEE0TzzBTzr8Y+8dQXeJLKftwig2qKWn8acHPHQfpPmDI2AvlXFvX
# bYf6hCAlNDFnzbYSlm/EUExiHQwIgqgWvalWzxVzjQEiJc6VaT9Hd/tydBTX/6tP
# iix6q4XNQ1/tYLaqT5Fmniye4Iqs5f2MvGQmh2ySvZ180HAKfO+ovHVPulr3qRCy
# Xen/KFSJ8NWKcXZl2szwcqMj+sAngkSumScbqyQeJsG33irr9p6xeZmBo1aGqwpF
# yd/EjaDnmPv7pp1yr8THwcFqcdnGE4AJxLafzYeHJLtPo0m5d2aR8XKc6UsCUqc3
# fpNTrDsdCEkPlM05et3/JWOZJyw9P2un8WbDQc1PtkCbISFA0LcTJM3cHXg65J6t
# 5TRxktcma+Q4c6umAU+9Pzt4rUyt+8SVe+0KXzM5h0F4ejjpnOHdI/0dKNPH+ejx
# mF/7K9h+8kaddSweJywm228Vex4Ziza4k9Tm8heZWcpw8De/mADfIBZPJ/tgZxah
# ZrrdVcA6KYawmKAr7ZVBtzrVFZgxtGIJDwq9gdkT/r+k0fNX2bwE+oLeMt8EifAA
# zV3C+dAjfwAL5HYCJtnwZXZCpimHCUcr5n8apIUP/JiW9lVUKx+A+sDyDivl1vup
# L0QVSucTDh3bNzgaoSv27dZ8/DCCBY0wggR1oAMCAQICEA6bGI750C3n79tQ4ghA
# GFowDQYJKoZIhvcNAQEMBQAwZTELMAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lD
# ZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTEkMCIGA1UEAxMbRGln
# aUNlcnQgQXNzdXJlZCBJRCBSb290IENBMB4XDTIyMDgwMTAwMDAwMFoXDTMxMTEw
# OTIzNTk1OVowYjELMAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZ
# MBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTEhMB8GA1UEAxMYRGlnaUNlcnQgVHJ1
# c3RlZCBSb290IEc0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAv+aQ
# c2jeu+RdSjwwIjBpM+zCpyUuySE98orYWcLhKac9WKt2ms2uexuEDcQwH/MbpDgW
# 61bGl20dq7J58soR0uRf1gU8Ug9SH8aeFaV+vp+pVxZZVXKvaJNwwrK6dZlqczKU
# 0RBEEC7fgvMHhOZ0O21x4i0MG+4g1ckgHWMpLc7sXk7Ik/ghYZs06wXGXuxbGrzr
# yc/NrDRAX7F6Zu53yEioZldXn1RYjgwrt0+nMNlW7sp7XeOtyU9e5TXnMcvak17c
# jo+A2raRmECQecN4x7axxLVqGDgDEI3Y1DekLgV9iPWCPhCRcKtVgkEy19sEcypu
# kQF8IUzUvK4bA3VdeGbZOjFEmjNAvwjXWkmkwuapoGfdpCe8oU85tRFYF/ckXEaP
# ZPfBaYh2mHY9WV1CdoeJl2l6SPDgohIbZpp0yt5LHucOY67m1O+SkjqePdwA5EUl
# ibaaRBkrfsCUtNJhbesz2cXfSwQAzH0clcOP9yGyshG3u3/y1YxwLEFgqrFjGESV
# GnZifvaAsPvoZKYz0YkH4b235kOkGLimdwHhD5QMIR2yVCkliWzlDlJRR3S+Jqy2
# QXXeeqxfjT/JvNNBERJb5RBQ6zHFynIWIgnffEx1P2PsIV/EIFFrb7GrhotPwtZF
# X50g/KEexcCPorF+CiaZ9eRpL5gdLfXZqbId5RsCAwEAAaOCATowggE2MA8GA1Ud
# EwEB/wQFMAMBAf8wHQYDVR0OBBYEFOzX44LScV1kTN8uZz/nupiuHA9PMB8GA1Ud
# IwQYMBaAFEXroq/0ksuCMS1Ri6enIZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjB5Bggr
# BgEFBQcBAQRtMGswJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNv
# bTBDBggrBgEFBQcwAoY3aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lD
# ZXJ0QXNzdXJlZElEUm9vdENBLmNydDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8v
# Y3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsMBEG
# A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAQEAcKC/Q1xV5zhfoKN0
# Gz22Ftf3v1cHvZqsoYcs7IVeqRq7IviHGmlUIu2kiHdtvRoU9BNKei8ttzjv9P+A
# ufih9/Jy3iS8UgPITtAq3votVs/59PesMHqai7Je1M/RQ0SbQyHrlnKhSLSZy51P
# pwYDE3cnRNTnf+hZqPC/Lwum6fI0POz3A8eHqNJMQBk1RmppVLC4oVaO7KTVPeix
# 3P0c2PR3WlxUjG/voVA9/HYJaISfb8rbII01YBwCA8sgsKxYoA5AY8WYIsGyWfVV
# a88nq2x2zm8jLfR+cWojayL/ErhULSd+2DrZ8LaHlv1b0VysGMNNn3O3AamfV6pe
# KOK5lDGCA3YwggNyAgEBMHcwYzELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lD
# ZXJ0LCBJbmMuMTswOQYDVQQDEzJEaWdpQ2VydCBUcnVzdGVkIEc0IFJTQTQwOTYg
# U0hBMjU2IFRpbWVTdGFtcGluZyBDQQIQBUSv85SdCDmmv9s/X+VhFjANBglghkgB
# ZQMEAgEFAKCB0TAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQAQQwHAYJKoZIhvcN
# AQkFMQ8XDTI0MDUxNDE4NTgzNlowKwYLKoZIhvcNAQkQAgwxHDAaMBgwFgQUZvAr
# MsLCyQ+CXc6qisnGTxmcz0AwLwYJKoZIhvcNAQkEMSIEINYBKCphqMmMi6SMo7Zu
# XCy15it8VmoKGL9MTWJq/b60MDcGCyqGSIb3DQEJEAIvMSgwJjAkMCIEINL25G3t
# dCLM0dRAV2hBNm+CitpVmq4zFq9NGprUDHgoMA0GCSqGSIb3DQEBAQUABIICAIII
# LkTN34g0tLo8XxHYSz3uZcY4dq1ByoiOpfYEOY9C3wGbgpctNywXVc9lS8skxpmy
# i2ICoFI6dMcst/LoXhIwJ6+yK6DDUFejBfiXMHLzlTHvYG8C97eHr1XciFzoLfkL
# 5GZw8bQsRWFJ2AG+1IfZJPx+Zs5B1O+yzvWFU2mrO2fFP709ITEmbDss3n+Ve3B4
# pKcP5eafmkqFyqsLxO5sIeACDruEwyUJxYtMzOQwYcEiLFrkLU8jh4hfcfxEqFHp
# tE06+RJTkQtiVOBFApd+j5qozzYycR39ZiQGtFgtKbYJ+VX1pM21dz2t5HScfBeu
# Hr4WRBBaXXH8Bf1DShlaFI8+Cs/xv1YZwVQRSPel8/lZr+UlA2QQ98LVWclQnfub
# B/tvpYzXo1jDUm7HwcVu5wktvqCN5RI2C1640EfvUziLoQlRYR9h0S+90feZCU2y
# aRBClEy4inq65eW32p0XaUh94YZwneumnv5r3HVbfEVljB9RhY2vxlJu2VhtKcaK
# TCudhjr8tp32DnsCWCI8vZKAr+50yn5XNDZhWNGYT8uKD6RHQGKqqHG5/yMgd53+
# 7aBQaMfGBcwfS4d3wL9AAUpVEyhyzHJCyduY0JMFImPiGtiTyE1sCYth7PFfflBR
# CIzwt3yWYkZFqm1ayEVyuElKFlo+o8sIYlnqA4d1
# SIG # End signature block
