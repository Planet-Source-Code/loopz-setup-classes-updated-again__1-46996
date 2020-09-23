VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cExtendedSpecial"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'////////////////////////////////////////////////////////////////
'
' Riferimenti richiesti : VB 5  - IShellLinkA Interface (ANSI)
'
'////////////////////////////////////////////////////////////////
Private Type SHELLITEMID
    cb As Long
    abID As Byte
End Type
Private Type ITEMIDLIST
    mkid As SHELLITEMID
End Type

Private Enum SpecialFolderTypes
sfpADMINTOOLS = &H30
sfpALTSTARTUP = &H1D
sfpAPPDATA = &H1A
sfpBITBUCKET = &HA
sfpCOMMON_ADMINTOOLS = &H2F
sfpCOMMON_ALTSTARTUP = &H1E
sfpCOMMON_APPDATA = &H23
sfpCOMMON_DESKTOPDIRECTORY = &H19
sfpCOMMON_DOCUMENTS = &H2E
sfpCOMMON_PROGRAMS = &H17
sfpCOMMON_FAVORITES = &H1F
sfpCOMMON_STARTMENU = &H16
sfpCOMMON_STARTUP = &H18
sfpCOMMON_TEMPLATES = &H2D
sfpCONNECTIONS = &H31
sfpCONTROLS = &H3
sfpCOOKIES = &H21
sfpDESKTOP = &H0
sfpDESKTOPDIRECTORY = &H10
sfpFAVORITES = &H6
sfpDRIVES = &H11
sfpFONTS = &H14
sfpHISTORY = &H22
sfpINTERNET = &H1
sfpINTERNET_CACHE = &H20
sfpLOCAL_APPDATA = &H1C
sfpMYPICTURES = &H27
sfpNETHOOD = &H13
sfpNETWORK = &H12
sfpPERSONAL = &H5
sfpPRINTERS = &H4
sfpPRINTHOOD = &H1B
sfpPROFILE = &H28
sfpPROGRAM_FILES = &H26
sfpPROGRAM_FILES_COMMON = &H2B
sfpPROGRAM_FILES_COMMONX86 = &H2C
sfpPROGRAM_FILESX86 = &H2A
sfpPROGRAMS = &H2
sfpRECENT = &H8
sfpSENDTO = &H9
sfpSTARTMENU = &HB
sfpSTARTUP = &H7
sfpSYSTEM = &H25
sfpSYSTEMX86 = &H29
sfpTEMPLATES = &H15
sfpWindows = &H24
End Enum

Private Declare Function SHGetSpecialFolderLocation Lib "Shell32.dll" (ByVal hwndOwner As Long, ByVal nFolder As Long, pidl As ITEMIDLIST) As Long
Private Declare Function SHGetPathFromIDList Lib "Shell32.dll" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal pszPath As String) As Long

Private Function SpecialFolderPath(ByVal lngFolderType As SpecialFolderTypes) As String
  Dim MAX_PATH As Integer
    MAX_PATH = 255
    Dim strPath As String
    Dim IDL As ITEMIDLIST
    SpecialFolderPath = ""


    If SHGetSpecialFolderLocation(0&, lngFolderType, IDL) = 0& Then
        strPath = Space$(MAX_PATH)


        If SHGetPathFromIDList(ByVal IDL.mkid.cb, ByVal strPath) Then
            SpecialFolderPath = Left(strPath, InStr(1, strPath, vbNullChar) - 1&) & "\"
        End If
    End If
End Function

Public Property Get Admintools() As String
Admintools = SpecialFolderPath(sfpADMINTOOLS)
End Property

Public Property Get Altstartup() As String
Altstartup = SpecialFolderPath(sfpALTSTARTUP)
End Property

Public Property Get Appdata() As String
Appdata = SpecialFolderPath(sfpAPPDATA)
End Property

Public Property Get Bitbucket() As String
Bitbucket = SpecialFolderPath(sfpBITBUCKET)
End Property

Public Property Get Common_Admintools() As String
Common_Admintools = SpecialFolderPath(sfpCOMMON_ADMINTOOLS)
End Property

Public Property Get Common_Altstartup() As String
Common_Altstartup = SpecialFolderPath(sfpCOMMON_ALTSTARTUP)
End Property

Public Property Get Common_Appdata() As String
Common_Appdata = SpecialFolderPath(sfpCOMMON_APPDATA)
End Property

Public Property Get Common_Desktopdirectory() As String
Common_Desktopdirectory = SpecialFolderPath(sfpCOMMON_DESKTOPDIRECTORY)
End Property

Public Property Get Common_Documents() As String
Common_Documents = SpecialFolderPath(sfpCOMMON_DOCUMENTS)
End Property

Public Property Get Common_Programs() As String
Common_Programs = SpecialFolderPath(sfpCOMMON_PROGRAMS)
End Property

Public Property Get Common_Favorites() As String
Common_Favorites = SpecialFolderPath(sfpCOMMON_FAVORITES)
End Property

Public Property Get Common_Startmenu() As String
Common_Startmenu = SpecialFolderPath(sfpCOMMON_STARTMENU)
End Property

Public Property Get Common_Startup() As String
Common_Startup = SpecialFolderPath(sfpCOMMON_STARTUP)
End Property

Public Property Get Common_Templates() As String
Common_Templates = SpecialFolderPath(sfpCOMMON_TEMPLATES)
End Property

Public Property Get Connections() As String
Connections = SpecialFolderPath(sfpCONNECTIONS)
End Property

Public Property Get Controls() As String
Controls = SpecialFolderPath(sfpCONTROLS)
End Property

Public Property Get Cookies() As String
Cookies = SpecialFolderPath(sfpCOOKIES)
End Property

Public Property Get Desktop() As String
Desktop = SpecialFolderPath(sfpDESKTOP)
End Property

Public Property Get Desktopdirectory() As String
Desktopdirectory = SpecialFolderPath(sfpDESKTOPDIRECTORY)
End Property

Public Property Get Favorites() As String
Favorites = SpecialFolderPath(sfpFAVORITES)
End Property

Public Property Get Drives() As String
Drives = SpecialFolderPath(sfpDRIVES)
End Property

Public Property Get Fonts() As String
Fonts = SpecialFolderPath(sfpFONTS)
End Property

Public Property Get History() As String
History = SpecialFolderPath(sfpHISTORY)
End Property

Public Property Get Internet() As String
Internet = SpecialFolderPath(sfpINTERNET)
End Property

Public Property Get Internet_Cache() As String
Internet_Cache = SpecialFolderPath(sfpINTERNET_CACHE)
End Property

Public Property Get Local_Appdata() As String
Local_Appdata = SpecialFolderPath(sfpLOCAL_APPDATA)
End Property

Public Property Get Mypictures() As String
Mypictures = SpecialFolderPath(sfpMYPICTURES)
End Property

Public Property Get Nethood() As String
Nethood = SpecialFolderPath(sfpNETHOOD)
End Property

Public Property Get Network() As String
Network = SpecialFolderPath(sfpNETWORK)
End Property

Public Property Get Personal() As String
Personal = SpecialFolderPath(sfpPERSONAL)
End Property

Public Property Get Printers() As String
Printers = SpecialFolderPath(sfpPRINTERS)
End Property

Public Property Get Printhood() As String
Printhood = SpecialFolderPath(sfpPRINTHOOD)
End Property

Public Property Get Profile() As String
Profile = SpecialFolderPath(sfpPROFILE)
End Property

Public Property Get Program_Files() As String
Program_Files = SpecialFolderPath(sfpPROGRAM_FILES)
End Property

Public Property Get Program_Files_Common() As String
Program_Files_Common = SpecialFolderPath(sfpPROGRAM_FILES_COMMON)
End Property

Public Property Get Program_Files_Commonx86() As String
Program_Files_Commonx86 = SpecialFolderPath(sfpPROGRAM_FILES_COMMONX86)
End Property

Public Property Get Program_Filesx86() As String
Program_Filesx86 = SpecialFolderPath(sfpPROGRAM_FILESX86)
End Property

Public Property Get Programs() As String
Programs = SpecialFolderPath(sfpPROGRAMS)
End Property

Public Property Get Recent() As String
Recent = SpecialFolderPath(sfpRECENT)
End Property

Public Property Get Sendto() As String
Sendto = SpecialFolderPath(sfpSENDTO)
End Property

Public Property Get Startmenu() As String
Startmenu = SpecialFolderPath(sfpSTARTMENU)
End Property

Public Property Get Startup() As String
Startup = SpecialFolderPath(sfpSTARTUP)
End Property

Public Property Get System() As String
System = SpecialFolderPath(sfpSYSTEM)
End Property

Public Property Get Systemx86() As String
Systemx86 = SpecialFolderPath(sfpSYSTEMX86)
End Property

Public Property Get Templates() As String
Templates = SpecialFolderPath(sfpTEMPLATES)
End Property

Public Property Get Windows() As String
Windows = SpecialFolderPath(sfpWindows)
End Property
