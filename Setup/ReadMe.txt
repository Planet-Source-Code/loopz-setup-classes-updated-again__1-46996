Setup Classes ReadMe file                        by loopz
---------------------------------------------------------
				  | last edited: 16.07.03
                                  *----------------------

Before using this, you'll need to get the unrar.dll from www.rarlabs.com


Name         : cSetup, cExtendedSpecial by loopz (c 2003)

Description  : cSetup - This class provides most of the functions you may use for an installation, even if web based.
               cExtendedSpecial - This class is an extension for cSetup. It provides all the special folders as properties.

Contents     : cSetup


// Functions and subs.
 
			[Private] SpecialFolderPath : Get the path to a special folder (see SpecialFolderTypes [type])
			
			FileExists : Determines whether a file exists or not.
						
						Arguments: FileName$   - The file you want to check

			FolderFromPath : Returns a folder from a certain path. ex. C:\myfile.exe = C:\
						
						Arguments: Path        - The Path...
		

			FileFromPath : Same as folder from path, but it returns a filename.
						
						Arguments: Path        - The Path...

			CreateShellLink : Creates a shell link for a file. 
						
						Arguments: sExeFile    - The exe-filename
							   sLinkFile   - The link-filename (the default creates a link on the desktop with the same name as the exe)
							   sIconFile   - The icon-filename
							   sWorkDir    - Working directory
							   sExeArgs    - Exe commandline arguments
							   lIconIdx    - Icon file index
							   ShowCmd     - Show property

			ShellAndWait : Runs a program and waits for it to finish.
						
						Arguments: FileName     - The program you want to run

			Pause : Stops the execution.
						
						Arguments: Milliseconds - Time to stop in ms

			BuildPath : Builds an external path.
						
						Arguments: cPath        - Path to build

			UnRAR : Decompresses a RAR file (c RarLabs www.rarlabs.com).
						
						Arguments: RarFile      - The file to unpack
							   Destination  - The destination path
							   Password     - Password for opening archive

			Text2List : Adds every line of a text to a listbox.
						
						Arguments: Text         - Text to read
							   List         - Target Listbox

			RARList : Lists the files in a RAR archive (c RarLabs www.rarlabs.com).
						
						Arguments: RarFile      - The file to read
							   Password     - Password for opening archive


			[Private] AdjustToken : Sets the needed parameters to shutdown XP.

			ShutDown : Shuts down the computer.

			ReStart : Restarts the computer.

			ReBoot : Reboots the computer.

			PowerOff : Turns the computer off.

			ftpCONNECT : Connects to an FTP server.
						
						Arguments: Server        - Server's address
							   User          - User name for logging in
						           Password      - Password for logging in

			ftpPUT : Puts a file into an FTP server (must connect to it).
						
						Arguments: fileLocal     - Local filename
							   fileRemote    - Remote filename

			ftpDISCONNECT : Disconnects from an FTP server.

			ftpGET : Gets a file from an FTP server (must connect to it).
						
						Arguments: dirLocal      - Local directory to get the file into
							   fileRemote    - Remote filename



// Properties


			Connected : Detects whether you're connected or not to an FTP server.

			SFolder(...) : Gets the path to the special folder you specify.

// Events

			RARFileChange : Detects the change of the rar file being processed.
						
						Arguments: NewFileName    - File Name
						
			RARComment : RAR file contains a comment.
						
						Arguments: Comment        - Comment

			RAROpenArchive : A RAR archive is opened.
						
						Arguments: Archive        - Archive Name

			RARCloseArchive : A RAR archive is closed.
						
						Arguments: Archive        - Archive Name

			RAROverallProgress : Progress in unpacking changed.
					
						Arguments: Percentage     - Progress in %


// Events usage example

			Dim WithEvents cSetup as cSetup

			Private Sub Form_Load()
				Set cSetup = New cSetup
			End Sub

			Private Sub cSetup_RARFileChange(NewFileName As String)

			End Sub

			Private Sub cSetup_RARComment(Comment As String)

			End Sub

			Private Sub cSetup_RAROpenArchive(Archive As String)

			End Sub

			Private Sub cSetup_RARCloseArchive(Archive As String)

			End Sub

			Private Sub cSetup_RAROverallProgress(Percentage As Long)

			End Sub	