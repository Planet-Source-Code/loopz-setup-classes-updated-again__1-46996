VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cSetup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'////////////////////////////////////////////////////////////////
'
' Riferimenti richiesti : Microsoft Scripting Runtime
'                         VB 5  - IShellLinkA Interface (ANSI)
'
' Dll Richieste :         UnRAR.dll
'
'////////////////////////////////////////////////////////////////
Const ERAR_END_ARCHIVE = 10
Const ERAR_NO_MEMORY = 11
Const ERAR_BAD_DATA = 12
Const ERAR_BAD_ARCHIVE = 13
Const ERAR_UNKNOWN_FORMAT = 14
Const ERAR_EOPEN = 15
Const ERAR_ECREATE = 16
Const ERAR_ECLOSE = 17
Const ERAR_EREAD = 18
Const ERAR_EWRITE = 19
Const ERAR_SMALL_BUF = 20
 
Const RAR_OM_LIST = 0
Const RAR_OM_EXTRACT = 1
 
Const RAR_SKIP = 0
Const RAR_TEST = 1
Const RAR_EXTRACT = 2
 
Const RAR_VOL_ASK = 0
Const RAR_VOL_NOTIFY = 1

Enum RarOperations
    OP_EXTRACT = 0
    OP_TEST = 1
    OP_LIST = 2
End Enum

Private Type LUID
         UsedPart As Long
         IgnoredForNowHigh32BitPart As Long
End Type

Private Type TOKEN_PRIVILEGES
        PrivilegeCount As Long
        TheLuid As LUID
        Attributes As Long
End Type

Private Const EWX_SHUTDOWN As Long = 1
Private Const EWX_FORCE As Long = 4
Private Const EWX_REBOOT = 2
Private Const EWX_FORCEIFHUNG As Long = &H10
Private Const EWX_LOGOFF As Long = 0
Private Const EWX_POWEROFF As Long = &H8

Private Type RARHeaderData
    ArcName As String * 260
    FileName As String * 260
    Flags As Long
    PackSize As Long
    UnpSize As Long
    HostOS As Long
    FileCRC As Long
    FILETIME As Long
    UnpVer As Long
    Method As Long
    FileAttr As Long
    CmtBuf As String
    CmtBufSize As Long
    CmtSize As Long
    CmtState As Long
End Type
 
Private Type RAROpenArchiveData
    ArcName As String
    OpenMode As Long
    OpenResult As Long
    CmtBuf As String
    CmtBufSize As Long
    CmtSize As Long
    CmtState As Long
End Type
Private Type SHELLITEMID
    cb As Long
    abID As Byte
End Type
Private Type ITEMIDLIST
    mkid As SHELLITEMID
End Type
Public Enum SHOWCMDFLAGS
    SHOWNORMAL = 5
    SHOWMAXIMIZE = 3
    SHOWMINIMIZE = 7
End Enum

Public Enum SpecialFolderTypes
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

Const HEAP_ZERO_MEMORY = &H8
Const HEAP_GENERATE_EXCEPTIONS = &H4
Dim hOpen As Long, hConnection As Long
Dim dwType As Long
Private bactivesession As Boolean
Const MAX_PATH = 260
Const NO_ERROR = 0
Const FILE_ATTRIBUTE_READONLY = &H1
Const FILE_ATTRIBUTE_HIDDEN = &H2
Const FILE_ATTRIBUTE_SYSTEM = &H4
Const FILE_ATTRIBUTE_DIRECTORY = &H10
Const FILE_ATTRIBUTE_ARCHIVE = &H20
Const FILE_ATTRIBUTE_NORMAL = &H80
Const FILE_ATTRIBUTE_TEMPORARY = &H100
Const FILE_ATTRIBUTE_COMPRESSED = &H800
Const FILE_ATTRIBUTE_OFFLINE = &H1000
Const scUserAgent = "vb wininet"
Const INTERNET_OPEN_TYPE_PRECONFIG = 0
Const INTERNET_OPEN_TYPE_DIRECT = 1
Const INTERNET_OPEN_TYPE_PROXY = 3
Const INTERNET_INVALID_PORT_NUMBER = 0

Const FTP_TRANSFER_TYPE_ASCII = &H1
Const FTP_TRANSFER_TYPE_BINARY = &H1
Const INTERNET_FLAG_PASSIVE = &H8000000
                
Const ERROR_INTERNET_EXTENDED_ERROR = 12003
Const INTERNET_DEFAULT_FTP_PORT = 21
Const INTERNET_DEFAULT_GOPHER_PORT = 70
Const INTERNET_DEFAULT_HTTP_PORT = 80
Const INTERNET_DEFAULT_HTTPS_PORT = 443
Const INTERNET_DEFAULT_SOCKS_PORT = 1080

Const INTERNET_OPTION_CONNECT_TIMEOUT = 2
Const INTERNET_OPTION_RECEIVE_TIMEOUT = 6
Const INTERNET_OPTION_SEND_TIMEOUT = 5

Const INTERNET_OPTION_USERNAME = 28
Const INTERNET_OPTION_PASSWORD = 29
Const INTERNET_OPTION_PROXY_USERNAME = 43
Const INTERNET_OPTION_PROXY_PASSWORD = 44
Const INTERNET_SERVICE_FTP = 1
Const INTERNET_SERVICE_GOPHER = 2
Const INTERNET_SERVICE_HTTP = 3
Const INTERNET_FLAG_RELOAD = &H80000000
Const INTERNET_FLAG_KEEP_CONNECTION = &H400000
Const INTERNET_FLAG_MULTIPART = &H200000
Const GENERIC_READ = &H80000000
Const GENERIC_WRITE = &H40000000
Const HTTP_QUERY_CONTENT_TYPE = 1
Const HTTP_QUERY_CONTENT_LENGTH = 5
Const HTTP_QUERY_EXPIRES = 10
Const HTTP_QUERY_LAST_MODIFIED = 11
Const HTTP_QUERY_PRAGMA = 17
Const HTTP_QUERY_VERSION = 18
Const HTTP_QUERY_STATUS_CODE = 19
Const HTTP_QUERY_STATUS_TEXT = 20
Const HTTP_QUERY_RAW_HEADERS = 21
Const HTTP_QUERY_RAW_HEADERS_CRLF = 22
Const HTTP_QUERY_FORWARDED = 30
Const HTTP_QUERY_SERVER = 37
Const HTTP_QUERY_USER_AGENT = 39
Const HTTP_QUERY_SET_COOKIE = 43
Const HTTP_QUERY_REQUEST_METHOD = 45
Const HTTP_STATUS_DENIED = 401
Const HTTP_STATUS_PROXY_AUTH_REQ = 407
Const HTTP_QUERY_FLAG_REQUEST_HEADERS = &H80000000
Const HTTP_QUERY_FLAG_NUMBER = &H20000000

Const INTERNET_OPTION_VERSION = 40
Private Type tWinInetDLLVersion
    lMajorVersion As Long
    lMinorVersion As Long
End Type

Const HTTP_ADDREQ_FLAG_ADD_IF_NEW = &H10000000
Const HTTP_ADDREQ_FLAG_ADD = &H20000000
Const HTTP_ADDREQ_FLAG_REPLACE = &H80000000
Private Type FILETIME
        dwLowDateTime As Long
        dwHighDateTime As Long
End Type

Private Type WIN32_FIND_DATA
        dwFileAttributes As Long
        ftCreationTime As FILETIME
        ftLastAccessTime As FILETIME
        ftLastWriteTime As FILETIME
        nFileSizeHigh As Long
        nFileSizeLow As Long
        dwReserved0 As Long
        dwReserved1 As Long
        cFileName As String * MAX_PATH
        cAlternate As String * 14
End Type

Const ERROR_NO_MORE_FILES = 18


Private Declare Function SHGetSpecialFolderLocation Lib "Shell32.dll" (ByVal hwndOwner As Long, ByVal nFolder As Long, pidl As ITEMIDLIST) As Long
Private Declare Function SHGetPathFromIDList Lib "Shell32.dll" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal pszPath As String) As Long
Private Declare Sub Sleep Lib "kernel32.dll" (ByVal dwMilliseconds As Long)
Private Declare Function RAROpenArchive Lib "unrar.dll" (ByRef ArchiveData As RAROpenArchiveData) As Long
Private Declare Function RARCloseArchive Lib "unrar.dll" (ByVal hArcData As Long) As Long
Private Declare Function RARReadHeader Lib "unrar.dll" (ByVal hArcData As Long, ByRef HeaderData As RARHeaderData) As Long
Private Declare Function RARProcessFile Lib "unrar.dll" (ByVal hArcData As Long, ByVal Operation As Long, ByVal DestPath As String, ByVal DestName As String) As Long
Private Declare Sub RARSetChangeVolProc Lib "unrar.dll" (ByVal hArcData As Long, ByVal Mode As Long)
Private Declare Sub RARSetPassword Lib "unrar.dll" (ByVal hArcData As Long, ByVal Password As String)
Private Declare Function ExitWindowsEx Lib "user32" (ByVal dwOptions As Long, ByVal dwReserved As Long) As Long
Private Declare Function GetCurrentProcess Lib "kernel32" () As Long
Private Declare Function OpenProcessToken Lib "advapi32" (ByVal ProcessHandle As Long, ByVal DesiredAccess As Long, TokenHandle As Long) As Long
Private Declare Function LookupPrivilegeValue Lib "advapi32" Alias "LookupPrivilegeValueA" (ByVal lpSystemName As String, ByVal lpName As String, lpLuid As LUID) As Long
Private Declare Function AdjustTokenPrivileges Lib "advapi32" (ByVal TokenHandle As Long, ByVal DisableAllPrivileges As Long, NewState As TOKEN_PRIVILEGES, ByVal BufferLength As Long, PreviousState As TOKEN_PRIVILEGES, ReturnLength As Long) As Long
Private Declare Function InternetReadFile Lib "wininet.dll" (ByVal hFile As Long, ByVal sBuffer As String, ByVal lNumBytesToRead As Long, lNumberOfBytesRead As Long) As Integer
Private Declare Function InternetWriteFile Lib "wininet.dll" (ByVal hFile As Long, ByVal sBuffer As String, ByVal lNumberOfBytesToRead As Long, lNumberOfBytesRead As Long) As Integer
Private Declare Function FtpOpenFile Lib "wininet.dll" Alias "FtpOpenFileA" (ByVal hFtpSession As Long, ByVal sFileName As String, ByVal lAccess As Long, ByVal lFlags As Long, ByVal lContext As Long) As Long
Private Declare Function FtpDeleteFile Lib "wininet.dll" Alias "FtpDeleteFileA" (ByVal hFtpSession As Long, ByVal lpszFileName As String) As Boolean
Private Declare Function InternetSetOption Lib "wininet.dll" Alias "InternetSetOptionA" (ByVal hInternet As Long, ByVal lOption As Long, ByRef sBuffer As Any, ByVal lBufferLength As Long) As Integer
Private Declare Function InternetSetOptionStr Lib "wininet.dll" Alias "InternetSetOptionA" (ByVal hInternet As Long, ByVal lOption As Long, ByVal sBuffer As String, ByVal lBufferLength As Long) As Integer
Private Declare Function InternetCloseHandle Lib "wininet.dll" (ByVal hInet As Long) As Integer
Private Declare Function InternetQueryOption Lib "wininet.dll" Alias "InternetQueryOptionA" (ByVal hInternet As Long, ByVal lOption As Long, ByRef sBuffer As Any, ByRef lBufferLength As Long) As Integer
Private Declare Function HttpAddRequestHeaders Lib "wininet.dll" Alias "HttpAddRequestHeadersA" (ByVal hHttpRequest As Long, ByVal sHeaders As String, ByVal lHeadersLength As Long, ByVal lModifiers As Long) As Integer
Private Declare Function HttpSendRequest Lib "wininet.dll" Alias "HttpSendRequestA" (ByVal hHttpRequest As Long, ByVal sHeaders As String, ByVal lHeadersLength As Long, ByVal sOptional As String, ByVal lOptionalLength As Long) As Integer
Private Declare Function HttpQueryInfo Lib "wininet.dll" Alias "HttpQueryInfoA" (ByVal hHttpRequest As Long, ByVal lInfoLevel As Long, ByRef sBuffer As Any, ByRef lBufferLength As Long, ByRef lIndex As Long) As Integer
Private Declare Function HttpOpenRequest Lib "wininet.dll" Alias "HttpOpenRequestA" (ByVal hHttpSession As Long, ByVal sVerb As String, ByVal sObjectName As String, ByVal sVersion As String, ByVal sReferer As String, ByVal something As Long, ByVal lFlags As Long, ByVal lContext As Long) As Long
Private Declare Function InternetGetLastResponseInfo Lib "wininet.dll" Alias "InternetGetLastResponseInfoA" (lpdwError As Long, ByVal lpszBuffer As String, lpdwBufferLength As Long) As Boolean
Private Declare Function InternetConnect Lib "wininet.dll" Alias "InternetConnectA" (ByVal hInternetSession As Long, ByVal sServerName As String, ByVal nServerPort As Integer, ByVal sUsername As String, ByVal sPassword As String, ByVal lService As Long, ByVal lFlags As Long, ByVal lContext As Long) As Long
Private Declare Function InternetFindNextFile Lib "wininet.dll" Alias "InternetFindNextFileA" (ByVal hFind As Long, lpvFindData As WIN32_FIND_DATA) As Long
Private Declare Function FtpFindFirstFile Lib "wininet.dll" Alias "FtpFindFirstFileA" (ByVal hFtpSession As Long, ByVal lpszSearchFile As String, lpFindFileData As WIN32_FIND_DATA, ByVal dwFlags As Long, ByVal dwContent As Long) As Long
Private Declare Function FtpGetFile Lib "wininet.dll" Alias "FtpGetFileA" (ByVal hFtpSession As Long, ByVal lpszRemoteFile As String, ByVal lpszNewFile As String, ByVal fFailIfExists As Boolean, ByVal dwFlagsAndAttributes As Long, ByVal dwFlags As Long, ByVal dwContext As Long) As Boolean
Private Declare Function FtpPutFile Lib "wininet.dll" Alias "FtpPutFileA" (ByVal hFtpSession As Long, ByVal lpszLocalFile As String, ByVal lpszRemoteFile As String, ByVal dwFlags As Long, ByVal dwContext As Long) As Boolean
Private Declare Function FtpSetCurrentDirectory Lib "wininet.dll" Alias "FtpSetCurrentDirectoryA" (ByVal hFtpSession As Long, ByVal lpszDirectory As String) As Boolean
Private Declare Function InternetOpen Lib "wininet.dll" Alias "InternetOpenA" (ByVal sAgent As String, ByVal lAccessType As Long, ByVal sProxyName As String, ByVal sProxyBypass As String, ByVal lFlags As Long) As Long
Private Declare Function GetProcessHeap Lib "kernel32" () As Long
Private Declare Function HeapAlloc Lib "kernel32" (ByVal hHeap As Long, ByVal dwFlags As Long, ByVal dwBytes As Long) As Long
Private Declare Function HeapFree Lib "kernel32" (ByVal hHeap As Long, ByVal dwFlags As Long, lpMem As Any) As Long
Private Declare Sub CopyMemory1 Lib "kernel32" Alias "RtlMoveMemory" (hpvDest As Any, ByVal hpvSource As Long, ByVal cbCopy As Long)
Private Declare Sub CopyMemory2 Lib "kernel32" Alias "RtlMoveMemory" (hpvDest As Long, hpvSource As Any, ByVal cbCopy As Long)

Public Event RARFileChange(NewFileName As String)
Public Event RARComment(Comment As String)
Public Event RAROpenArchive(Archive As String)
Public Event RARCloseArchive(Archive As String)
Public Event RAROverallProgress(Percentage As Long)

Private CurrentFile As Long
Private FileCount As Long

Private Function SpecialFolderPath(ByVal lngFolderType As SpecialFolderTypes) As String ' Get the path to a special folder.
  Dim MAX_PATH As Integer
    MAX_PATH = 255
    Dim strPath As String
    Dim IDL As ITEMIDLIST
    SpecialFolderPath = ""


    If SHGetSpecialFolderLocation(0&, lngFolderType, IDL) = 0& Then
        strPath = Space$(MAX_PATH)


        If SHGetPathFromIDList(ByVal IDL.mkid.cb, ByVal strPath) Then
            SpecialFolderPath = Left(strPath, InStr(1, strPath, vbNullChar) - 1&) & "\" ' Add a slash to the found path
        End If
    End If
End Function

Public Function FileExists(FileName$) As Boolean
On Error GoTo hell ':D

Open FileName$ For Input As #1 ' Try to read the file, if an error occours, the file doesn't exist ;)

Close #1
    FileExists = True
    Exit Function
    
hell:

FileExists = False
End Function

Public Function FolderFromPath(Path As String) As String
FolderFromPath = Left(Path, InStrRev(Path, "\")) ' Read the chars before the last "\"
End Function

Public Function FileFromPath(Path As String) As String
FileFromPath = Right(Path, Len(Path) - InStrRev(Path, "\")) ' Read the chars after the last "\"
End Function

Public Function CreateShellLink(sExeFile As String, Optional sLnkFile As String = "LinkOnDesktop", Optional sIconFile As String = "", Optional sWorkDir As String = "", Optional sExeArgs As String = "", Optional lIconIdx As Long = 0, Optional ShowCmd As SHOWCMDFLAGS = SHOWNORMAL) As Long

    Dim cShellLink   As ShellLinkA ' VB5 Type Library. Included.
    Dim cPersistFile As IPersistFile
    Dim FileName As String
    
    If sExeFile = "" Then
        Exit Function
    End If
    If sLnkFile = "" Or sLnkFile = "LinkOnDesktop" Then ' Set to create a link on the Desktop (Default)
    FileName = FileFromPath(sExeFile)
    sLnkFile = SpecialFolderPath(sfpDESKTOP) & Left(FileName, InStrRev(FileName, ".")) & "lnk" ' Get the filename and add ".lnk"
    End If

    On Error GoTo fCreateShellLinkError
    Set cShellLink = New ShellLinkA
    Set cPersistFile = cShellLink
    
    With cShellLink ' Set the shell link props as indicated in the Function's args.
        .SetPath sExeFile
        If sWorkDir <> "" Then .SetWorkingDirectory sWorkDir
        If sExeArgs <> "" Then .SetArguments sExeArgs
        .SetDescription "Access Shortcut" & vbNullChar
        If sIconFile <> "" Then .SetIconLocation sIconFile, lIconIdx
        .SetShowCmd ShowCmd
    End With

    cShellLink.Resolve 0, SLR_UPDATE
    cPersistFile.Save StrConv(sLnkFile, vbUnicode), 0
    CreateShellLink = True
fCreateShellLinkError: ' Shit happened...try again!
    Set cPersistFile = Nothing
    Set cShellLink = Nothing
End Function

Function ShellAndWait(FileName As String) As Boolean
Dim objScript
On Error GoTo ERR_OpenForEdit
Set objScript = CreateObject("WScript.Shell") ' Set the object as scripting shell
ShellApp = objScript.Run(FileName, 1, True) ' Run the program and wait for it to finish.
ShellAndWait = True
EXIT_OpenForEdit:
Exit Function
ERR_OpenForEdit: ' Error  :(
MsgBox Err.Description
GoTo EXIT_OpenForEdit
End Function

Public Property Get SFolder(ByVal Folder As SpecialFolderTypes)
SFolder = SpecialFolderPath(Folder) ' Just a callback
End Property

Public Sub Pause(Milliseconds As Long)
Sleep Milliseconds ' No need to explain this...I think...
End Sub

Public Function BuildPath(cPath As String) As String
    Dim k As New FileSystemObject, a() As String, pPath As String ' Create an FSO
    a() = Split(cPath, "\") ' Split the path by "\"'s

For i = 0 To UBound(a()) ' For every item in the array a()
    pPath = "" ' Clear the temp path
    For n = 0 To i
        pPath = pPath & a(n) & "\"
    Next n
    '
    ' Now we've found the path to build.
    '
    If k.FolderExists(pPath) = False Then ' If it doesn't exist,
        k.CreateFolder pPath              ' Create it!!
    End If
Next i
BuildPath = cPath
End Function

Public Sub UnRAR(RarFile As String, Optional Destination As String = "", Optional Password As String = "")

'
' This is just a little modification from the original example given with the UnRAR.dll files.
'       Credits to Pedro Lamas : sniper@hotpop.com / www.terravista.pt/portosanto/3723/
'

    Dim lHandle As Long
    Dim iStatus As Integer
    Dim uRAR As RAROpenArchiveData
    Dim uHeader As RARHeaderData
    Dim sStat As String, Ret As Long
    
    BuildPath Destination ' Make sure the destination is available for decompressing :D
    
    RaiseEvent RAROpenArchive(RarFile)
    RARList RarFile, Password ' Get the file count for the archive so we can define the progress...more or less...
     
        CurrentFile = 0 ' ...easy
     
    uRAR.ArcName = RarFile          ' Set archive name
    uRAR.CmtBuf = Space(16384)      ' Create comment buffer
    uRAR.CmtBufSize = 16384         ' Set its size
    uRAR.OpenMode = RAR_OM_EXTRACT  ' Set the operation
    
    lHandle = RAROpenArchive(uRAR)  ' Open the archive

    If Password <> "" Then RARSetPassword lHandle, Password ' Password detected, set it
    
    If (uRAR.CmtState = 1) Then RaiseEvent RARComment(uRAR.CmtBuf) ' Comment found
    
    iStatus = RARReadHeader(lHandle, uHeader) ' Get the status
    Do Until iStatus <> 0
        sStat = Left(uHeader.FileName, InStr(1, uHeader.FileName, vbNullChar) - 1): RaiseEvent RARFileChange(uHeader.FileName) ' File changed
        Ret = RARProcessFile(lHandle, RAR_EXTRACT, Destination, ""): CurrentFile = CurrentFile + 1 ' Unpack the current file and go on counting
        RaiseEvent RAROverallProgress(CurrentFile / FileCount * 100) ' Give the percentage
        iStatus = RARReadHeader(lHandle, uHeader) ' Read status
    Loop

    RARCloseArchive lHandle             ' Close archive...
    RaiseEvent RARCloseArchive(RarFile) ' ...and let us know it
End Sub

Public Function Text2List(Text As String, List As ListBox)

Dim a() As String
a() = Split(Text, Chr(13)) ' Split the text by the Line Feed char

For i = 0 To UBound(a()) ' For every item in the array
    List.AddItem Replace(a(i), Chr(10), "") ' Replace the half/line feed with "" and add to the list
Next i
End Function

Public Sub RARList(RarFile As String, Optional Password As String = "") ' Same as before but to count files...see UnRAR
    Dim lHandle As Long
    Dim iStatus As Integer
    Dim uRAR As RAROpenArchiveData
    Dim uHeader As RARHeaderData
    Dim sStat As String, Ret As Long
     
        FileCount = 0
     
    uRAR.ArcName = RarFile
    uRAR.CmtBuf = Space(16384)
    uRAR.CmtBufSize = 16384
    uRAR.OpenMode = RAR_OM_LIST
    
    lHandle = RAROpenArchive(uRAR)

    If Password <> "" Then RARSetPassword lHandle, Password
    
    If (uRAR.CmtState = 1) Then RaiseEvent RARComment(uRAR.CmtBuf)
    
    iStatus = RARReadHeader(lHandle, uHeader)
    Do Until iStatus <> 0
        sStat = Left(uHeader.FileName, InStr(1, uHeader.FileName, vbNullChar) - 1)
        Ret = RARProcessFile(lHandle, RAR_SKIP, "", ""): FileCount = FileCount + 1
        
        iStatus = RARReadHeader(lHandle, uHeader)
    Loop
    
    RARCloseArchive lHandle
End Sub

Private Sub AdjustToken()
         Const TOKEN_ADJUST_PRIVILEGES = &H20 ' Set ShutDown Privilege in Windows XP
         Const TOKEN_QUERY = &H8
         Const SE_PRIVILEGE_ENABLED = &H2
         Dim hdlProcessHandle As Long
         Dim hdlTokenHandle As Long
         Dim tmpLuid As LUID
         Dim tkp As TOKEN_PRIVILEGES
         Dim tkpNewButIgnored As TOKEN_PRIVILEGES
         Dim lBufferNeeded As Long
         hdlProcessHandle = GetCurrentProcess()
         OpenProcessToken hdlProcessHandle, (TOKEN_ADJUST_PRIVILEGES Or _
            TOKEN_QUERY), hdlTokenHandle
         LookupPrivilegeValue "", "SeShutdownPrivilege", tmpLuid
         tkp.PrivilegeCount = 1
         tkp.TheLuid = tmpLuid
         tkp.Attributes = SE_PRIVILEGE_ENABLED
         AdjustTokenPrivileges hdlTokenHandle, False, _
         tkp, Len(tkpNewButIgnored), tkpNewButIgnored, lBufferNeeded
End Sub
 
Public Function ShutDown()
 AdjustToken
 ExitWindowsEx (EWX_SHUTDOWN), &HFFFF ' Some params....not hard.
End Function

Public Function ReStart()
  AdjustToken
  ExitWindowsEx (EWX_FORCE), &HFFFF
End Function
Public Function ReBoot()
  AdjustToken
  ExitWindowsEx (EWX_REBOOT), &HFFFF
End Function

Public Function Poweroff()
  AdjustToken
  ExitWindowsEx (EWX_POWEROFF), &HFFFF
End Function

Public Function ftpCONNECT(Server As String, User As String, Password As String)
Dim nFlag As Long
hOpen = InternetOpen(scUserAgent, INTERNET_OPEN_TYPE_DIRECT, vbNullString, vbNullString, 0) ' Open the session
nFlag = INTERNET_FLAG_PASSIVE
hConnection = InternetConnect(hOpen, Server, INTERNET_INVALID_PORT_NUMBER, User, Password, INTERNET_SERVICE_FTP, nFlag, 0) ' And connect to the server
End Function

Public Function ftpPUT(fileLocal As String, fileRemote As String)
FtpPutFile hConnection, fileLocal, fileRemote, dwType, 0 ' Put the file
End Function

Public Function ftpDISCONNECT()
InternetCloseHandle hConnection ' Close the connection
End Function

Public Function ftpGET(dirLocal As String, fileRemote As String)
FtpGetFile hConnection, fileRemote, dirLocal & "\" & fileRemote, False, INTERNET_FLAG_RELOAD, dwType, 0 ' Get a file
End Function

Public Property Get Connected() As Boolean
If hConnection = 0 Then ' If the connection number is 0, nothing happens
Connected = False       ' So we're not connected
Else
Connected = True        ' Else....
End If
End Property

