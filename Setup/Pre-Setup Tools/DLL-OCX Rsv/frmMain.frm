VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   3090
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4680
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.FileListBox File1 
      Height          =   1650
      Left            =   1320
      TabIndex        =   0
      Top             =   720
      Width           =   2175
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()

File1.Pattern = "*.dll,*.ocx" ' Set the pattern to OCX's and DLL's
File1.Refresh                 ' Refresh, to get the list

For i = 0 To File1.ListCount - 1 ' For every file
    Shell "regsvr32.exe -s " & File1.List(i), vbHide ' Run regsvr32.exe -s, so no message will appear
    
    DoEvents
Next i

Unload Me
End Sub
