VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cScripting"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'////////////////////////////////////////////////////////////////
'
' Riferimenti richiesti : NONE
'
'////////////////////////////////////////////////////////////////

Option Compare Text             ' SoMeThInG = SOMETHING = something ... not case sensitive
Dim tS As New cSetup            ' We'll need this:
                                ' So many functions are called from the cSetup class.

Public Function RunScript(ScriptFile As String)

Dim jBuffer As String

Open ScriptFile For Input Lock Read Write As #1     ' Open the specified filename for reading, and lock its Read/Write features for other programs ;)

While Not EOF(1)                                    ' If we're not at the end of the file
    Input #1, jBuffer                               ' Read the current line into read buffer
    
    Execute sCheckForVariables(jBuffer)             ' Execute the current string, once the variables have been replaced

Wend                                                ' End Statement for the While Loop

End Function

Private Function Execute(ByVal Cmd As String) 'This is used to see what command was given
If Left(Cmd, 6) = "shell " Then sShell Cmd
If Left(Cmd, 7) = "msgbox " Then sMsgBox Cmd
If Left(Cmd, 9) = "filecopy " Then sFileCopy Cmd
If Left(Cmd, 13) = "shellandwait " Then sShellAndWait Cmd
If Left(Cmd, 8) = "shutdown" Then sShutDown Cmd
If Left(Cmd, 6) = "reboot" Then sReboot Cmd
If Left(Cmd, 6) = "unrar " Then sUnRAR Cmd
If Left(Cmd, 11) = "createlink " Then sCreateLink Cmd
If Left(Cmd, 10) = "buildpath " Then sBuildPath Cmd
If Left(Cmd, 11) = "ftpconnect " Then sFTPconnect Cmd
If Left(Cmd, 13) = "ftpdisconnect" Then sFTPdisconnect Cmd
If Left(Cmd, 7) = "ftpput " Then sFTPput Cmd
If Left(Cmd, 7) = "ftpget " Then sFTPget Cmd
If Left(Cmd, 9) = "getinput " Then sGetInput Cmd
If Left(Cmd, 14) = "clearvariables" Then sClearVariables Cmd
End Function

Private Function sShell(ByVal Cmd As String)
'
' Syntax Help : Shell File.exe Hide|Normal|Max
'
Dim tArr() As String        ' Create an array
tArr() = Split(Cmd, " ")    ' And use it to split the instruction

Select Case tArr(2)
    Case Is = "hide"
        Shell tArr(1), vbHide
    Case Is = "normal"
        Shell tArr(1), vbNormalFocus
    Case Is = "max"
        Shell tArr(1), vbMaximizedFocus
    Case Is = ""
        Shell tArr(1), vbNormalFocus
End Select

End Function

Private Function sMsgBox(ByVal Cmd As String)
'
' Syntax Help : MsgBox Text__Title__Info|Exclamation|Critical|Question
'
Dim tArr() As String        ' Create an array
tArr() = Split(Right(Cmd, Len(Cmd) - 7), "__") ' And use it to split the instruction

Select Case tArr(2)
    Case Is = "info"
        MsgBox tArr(0), vbInformation, tArr(1)
    Case Is = "exclamation"
        MsgBox tArr(0), vbExclamation, tArr(1)
    Case Is = "critical"
        MsgBox tArr(0), vbCritical, tArr(1)
    Case Is = "question"
        MsgBox tArr(0), vbQuestion, tArr(1)
    Case Is = ""
        MsgBox tArr(0), vbInformation, tArr(1)
End Select

End Function

Private Function sFileCopy(ByVal Cmd As String)
'
' Syntax Help : FileCopy Original__Destination
'
Dim tArr() As String        ' Create an array
tArr() = Split(Right(Cmd, Len(Cmd) - 9), "__") ' And use it to split the instruction

FileCopy tArr(0), tArr(1)

End Function

Private Function sShellAndWait(ByVal Cmd As String)
'
' Syntax Help : ShellAndWait File.exe
'
tS.ShellAndWait (Right(Cmd, Len(Cmd) - 13)) ' Get the filename and run it

End Function

Private Function sShutDown(Optional ByVal Cmd As String = "")
'
' Syntax Help : ShutDown
'
tS.ShutDown
End Function

Private Function sReboot(Optional ByVal Cmd As String = "")
'
' Syntax Help : Reboot
'
tS.ReBoot
End Function

Private Function sUnRAR(ByVal Cmd As String)
'
' Syntax Help : UnRAR RARFile__Destination__Password  //note: if password is empty, put "UnRAR file.rar__C:\__ "
'
Dim tArr() As String                           ' Create an array
tArr() = Split(Right(Cmd, Len(Cmd) - 6), "__") ' And use it to split the instruction

tS.UnRAR tArr(0), tArr(1), tArr(2)

End Function

Private Function sCreateLink(ByVal Cmd As String)
'
' Syntax Help : CreateLink OriginalFile.exe__LinkFile.lnk
'
Dim tArr() As String                            ' Create an array
tArr() = Split(Right(Cmd, Len(Cmd) - 11), "__") ' And use it to split the instruction

tS.CreateShellLink tArr(0), tArr(1)

End Function

Private Function sBuildPath(ByVal Cmd As String)
'
' Syntax Help : BuildPath Path
'
tS.BuildPath Right(Cmd, Len(Cmd) - 10)

End Function

Private Function sFTPconnect(ByVal Cmd As String)
'
' Syntax Help : FTPconnect Server User Password
'
Dim tArr() As String        ' Create an array
tArr() = Split(Cmd, " ")    ' And use it to split the instruction

tS.ftpCONNECT tArr(1), tArr(2), tArr(3)

End Function

Private Function sFTPdisconnect(Optional ByVal Cmd As String = "")
'
' Syntax Help : FTPdisconnect
'

tS.ftpDISCONNECT

End Function

Private Function sFTPput(ByVal Cmd As String)
'
' Syntax Help : FTPput LocalFile__RemoteFile
'
Dim tArr() As String                           ' Create an array
tArr() = Split(Right(Cmd, Len(Cmd) - 7), "__") ' And use it to split the instruction

tS.ftpPUT tArr(0), tArr(1)

End Function

Private Function sFTPget(ByVal Cmd As String)
'
' Syntax Help : FTPget LocalDirectory__RemoteFile
'
Dim tArr() As String                           ' Create an array
tArr() = Split(Right(Cmd, Len(Cmd) - 7), "__") ' And use it to split the instruction

tS.ftpGET tArr(0), tArr(1)

End Function

Private Function sGetInput(ByVal Cmd As String)
'
' Syntax Help : GetInput Text__Title__TargetVariable  //note: for the use of the variables, see the Variables Scripting Help file.
'
Dim tArr() As String                           ' Create an array
tArr() = Split(Right(Cmd, Len(Cmd) - 9), "__") ' And use it to split the instruction

Dim TMPvar As Variant

TMPvar = InputBox(tArr(0), tArr(1))

Variables.Add tArr(2) & "==" & TMPvar
End Function

Private Function sClearVariables(Optional ByVal Cmd As String = "")
'
' Syntax Help : ClearVariables
'
For i = 0 To frmMain.Variables.ListCount - 1
frmMain.Variables.Remove i
Next i

End Function

Private Function sCheckForVariables(ByVal Cmd As String) As String
Dim a() As String
For i = 0 To frmMain.Variables.ListCount - 1
    a() = Split(frmMain.Variables.List(i), "==")               ' For every variable, separate its value and its name
    Cmd = Replace(Cmd, "var[" & a(0) & "]", a(1)) ' And check if it exists. If so, replace it with its value
Next i

sCheckForVariables = Cmd
End Function

Private Function AddMainVariables()
Dim v As New cExtendedSpecial
frmMain.Variables.AddItem "desktop==" & v.Desktop
frmMain.Variables.AddItem "windows==" & v.Windows
frmMain.Variables.AddItem "autoexec==" & v.Startup
frmMain.Variables.AddItem "system==" & v.System
frmMain.Variables.AddItem "programs==" & v.Programs
frmMain.Variables.AddItem "program_files==" & v.Program_Files
frmMain.Variables.AddItem "currentdir==" & App.Path & "\"
End Function

Private Sub Class_Initialize()
AddMainVariables
End Sub
