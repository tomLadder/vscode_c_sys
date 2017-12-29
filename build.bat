@echo off
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64    

set compilerflags=/c %includes% /Zi /W4 /WX /Ox /Os /Oy- /D _WIN64 /D _AMD64_ /D AMD64 /D _WIN32_WINNT=0x0A00 /D WINVER=0x0A00 /D WINNT=1 /D NTDDI_VERSION=0x0A000004 /D KMDF_VERSION_MAJOR=1 /D KMDF_VERSION_MINOR=15 /GF /Gm- /Zp8 /GS /Gy /fp:precise /Zc:wchar_t- /Zc:forScope /Zc:inline /GR- /Fo"build\\" /Fd"build\\vc141.pdb" /Gz /wd4603 /wd4627 /wd4986 /wd4987 /wd4996 /FI"C:\Program Files (x86)\Windows Kits\10\Include\10.0.16299.0\shared\warning.h" /errorReport:prompt /kernel -cbstring -d2epilogunwind  /d1nodatetime /d1import_no_registry /d2AllowCompatibleILVersions /d2Zi+
set includes=-I "C:\Program Files (x86)\Windows Kits\10\Include\10.0.16299.0\km"
set files="C:\Dev\vscode_c_sys\src\EntryPoint.c"
cl.exe %compilerflags% %files%

::LINKING
set outflags=/OUT:".\\build\\output.sys"
set linkerflags="/VERSION:10.0" /INCREMENTAL:NO /WX "/SECTION:INIT,d" "C:\Program Files (x86)\Windows Kits\10\lib\10.0.16299.0\km\x64\BufferOverflowFastFailK.lib" "C:\Program Files (x86)\Windows Kits\10\lib\10.0.16299.0\km\x64\ntoskrnl.lib" "C:\Program Files (x86)\Windows Kits\10\lib\10.0.16299.0\km\x64\hal.lib" "C:\Program Files (x86)\Windows Kits\10\lib\10.0.16299.0\km\x64\wmilib.lib" "C:\Program Files (x86)\Windows Kits\10\lib\wdf\kmdf\x64\1.15\WdfLdr.lib" "C:\Program Files (x86)\Windows Kits\10\lib\wdf\kmdf\x64\1.15\WdfDriverEntry.lib" /NODEFAULTLIB /MANIFEST:NO /DEBUG "/PDB:C:\Users\Thomas\source\repos\TestDriver\x64\Release\TestDriver.pdb" "/SUBSYSTEM:NATIVE,10.00" /Driver /OPT:REF /OPT:ICF "/ENTRY:FxDriverEntry" /RELEASE "/IMPLIB:C:\Users\Thomas\source\repos\TestDriver\x64\Release\TestDriver.lib" "/MERGE:_TEXT=.text;_PAGE=PAGE" /MACHINE:X64 /PROFILE /kernel /IGNORE:4198,4010,4037,4039,4065,4070,4078,4087,4089,4221,4108,4088,4218,4218,4235 /osversion:10.0 /pdbcompress /debugtype:pdata
set files=./build/EntryPoint.obj
link.exe %outflags% %linkerflags% %files%