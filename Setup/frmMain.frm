VERSION 5.00
Begin VB.Form frmMain 
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.ListBox Variables 
      Height          =   2010
      Left            =   600
      TabIndex        =   0
      Top             =   120
      Width           =   3615
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim WithEvents cSetup As cSetup
Attribute cSetup.VB_VarHelpID = -1

Private Sub Form_Load()
'Me.Show
'DoEvents
    Set cSetup = New cSetup
    
    Dim Scripting As New cScripting
    
    Scripting.RunScript Command$ ' so we can pass it as an argument!
    
    Unload Me
    
End Sub

