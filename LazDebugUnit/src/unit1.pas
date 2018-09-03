{ Version 1.0 - Author jasc2v8 at yahoo dot com

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org> }

unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  FileCtrl, EditBtn, strutils, lclintf, DebugUnit;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnHelp: TButton;
    btnRemove: TButton;
    btnAdd: TButton;
    btnDemo: TButton;
    DirectoryEdit: TDirectoryEdit;
    FileListBox: TFileListBox;
    procedure btnHelpClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnDemoClick(Sender: TObject);
    procedure DirectoryEditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  end;
const
  DS=DirectorySeparator;
  LE=LineEnding;
var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.btnHelpClick(Sender: TObject);
begin
  lclintf.OpenURL('help.html');
end;

procedure TfrmMain.btnDemoClick(Sender: TObject);
begin

  DebugForm.Show;

  { if true then show examples }
  if true then begin
    Debugln('string=Debugln');
    Debugln('decimal=%d', 1000);
    Debugln('float=%10.4f', 1.31415927);
    Debugln('hex=%x', 16);
    Debugln('number=%n', 1.314);
    Debugln('unsigned=%u', 1000);

    Debugln(LineEnding+'Boolean as String:');
    Debugln('boolean=%s', true);
    Debugln('boolean=%s', false);

    Debugln(LineEnding+'Boolean as String:');
    Debugln('boolean'+BoolToStr(true,true) );
    Debugln('boolean'+BoolToStr(false,true) );

    Debugln(LineEnding+'Boolean as String Signed Decimal:');
    Debugln('boolean'+BoolToStr(true) );
    Debugln('boolean'+BoolToStr(false) );

    Debugln(LineEnding+'Boolean as Decimal:');
    Debugln('boolean=%i', Byte(true));
    Debugln('boolean=%d', Ord(false));

    Debugln(LineEnding+'Boolean as Decimal String:');
    Debugln('boolean='+true.ToString);
    Debugln('boolean='+false.ToString);

  end;

end;
procedure TfrmMain.DirectoryEditChange(Sender: TObject);
var
  i: integer;
begin
  FileListBox.Sorted:=false;
  FileListBox.Mask:='*.lpr;*.pas;*.pp';

  FileListBox.Directory:=DirectoryEdit.Text;

  for i:=0 to FileListBox.Items.Count-1 do begin
    if not (FileListBox.Items[i]='debugunit.pas') then
      FileListBox.Selected[i]:=true;
  end;
end;
procedure TfrmMain.btnAddClick(Sender: TObject);
var
  i,j: integer;
  aFilename, aFilepath: string;
  OldFile, NewFile: TStringList;
  inUses: boolean;
  aLine: string;
begin

  if FileListBox.Count=0 then Exit;

  OldFile:=TStringList.Create;
  NewFile:=TStringList.Create;

  for i:=0 to FileListBox.Count-1 do begin

    if not FileListBox.Selected[i] then
      Continue;

    aFileName:=FileListBox.Directory+DS+FileListBox.Items[i];

    Debugln('aFilename='+aFilename);

    OldFile.LoadFromFile(aFilename);

    if AnsiContainsText(OldFile.Text, 'DebugUnit') then begin
      ShowMessage('DebugUnit already added to: '+LE+LE+aFilename);
      Continue;
    end;

    if not AnsiContainsText(OldFile.Text, 'uses') then begin
      ShowMessage('DebugUnit can''t be added, no uses section in: '+LE+LE+aFilename);
      Continue;
    end;

    CopyFile(aFilename, aFilename+'.bak', [cffOverwriteFile]);

    inUses:=false;
    j:=0;

    repeat

      if AnsiContainsText(OldFile[j],'uses') then begin
        inUses:=true;
      end;

      { will not detect a missing ';' after the uses statement }

      if inUses and OldFile[j].EndsWith(';') then begin
        aLine:=StringReplace(OldFile[j],';',', DebugUnit;',[]);
        OldFile[j]:=aLine;
        inUses:=false;
      end;

      if AnsiContainsText(OldFile[j],'Application.Run') then
        NewFile.Append('  Application.CreateForm(TDebugForm, DebugForm);');

      NewFile.Append(OldFile[j]);

      Inc(j);

    until j=OldFile.Count;

    NewFile.SaveToFile(aFilename);

    ShowMessage('DebugUnit added in: '+LE+LE+aFilename);

    OldFile.Clear;
    NewFile.Clear;

  end;

  aFilepath:=ExtractFilePath(aFilename);

  aFilename:='debugunit.pas';
  if not FileExists(aFilePath+aFilename) then
    if FileExists(aFilename) then
      CopyFile(aFilename, aFilepath+aFilename)
    else
      ShowMessage('Error: debugunit.pas not in current directory');

  aFilename:='debugunit.lfm';
  if not FileExists(aFilePath+aFilename) then
    if FileExists(aFilename) then
      CopyFile(aFilename, aFilepath+aFilename)
    else
    ShowMessage('Error: debugunit.lfm not in current directory');

  FileListBox.UpdateFileList;
  DirectoryEditChange(nil);

  OldFile.Free;
  NewFile.Free;

end;
procedure TfrmMain.btnRemoveClick(Sender: TObject);
var
  i,j: integer;
  aFilename: string;
  OldFile, NewFile: TStringList;
  aLine: string;
begin

  if FileListBox.Count=0 then Exit;

  OldFile:=TStringList.Create;
  NewFile:=TStringList.Create;

  for i:=0 to FileListBox.Count-1 do begin

    if not FileListBox.Selected[i] then
      Continue;

    aFileName:=FileListBox.Directory+DS+FileListBox.Items[i];

    OldFile.LoadFromFile(aFilename);

    if not AnsiContainsText(OldFile.Text, 'DebugUnit') then begin
      ShowMessage('DebugUnit already removed from: '+LE+LE+aFilename);
      Continue;
    end;

    CopyFile(aFilename, aFilename+'.bak', [cffOverwriteFile]);

    j:=0;

    repeat

      if AnsiContainsText(OldFile[j],', DebugUnit;') then begin
        aLine:=StringReplace(OldFile[j],', DebugUnit;',';',[]);
        OldFile[j]:=aLine;
        ShowMessage('DebugUnit removed from: '+LE+LE+aFilename);
      end;

      if AnsiContainsText(OldFile[j],',DebugUnit;') then begin
        aLine:=StringReplace(OldFile[j],',DebugUnit;',';',[]);
        OldFile[j]:=aLine;
        ShowMessage('DebugUnit removed from: '+LE+LE+aFilename);
      end;

      if AnsiContainsText(OldFile[j],
        'Application.CreateForm(TDebugForm, DebugForm);') then begin
          //don't repeat ShowMessage('DebugUnit removed from: '+LE+LE+aFilename);
        end
      else
        NewFile.Append(OldFile[j]);

      Inc(j);

    until j=OldFile.Count;

    NewFile.SaveToFile(aFilename);

    OldFile.Clear;
    NewFile.Clear;

  end;

  aFilename:=ExtractFilePath(aFilename)+'debugunit.pas';
  if FileExists(aFilename) then
    DeleteFile(aFilename);

  aFilename:=ExtractFilePath(aFilename)+'debugunit.lfm';
  if FileExists(aFilename) then
    DeleteFile(aFilename);

  FileListBox.UpdateFileList;
  DirectoryEditChange(nil);

  OldFile.Free;
  NewFile.Free;

end;
procedure TfrmMain.FormShow(Sender: TObject);
begin
  //DebugForm.Show;
  //Debugln('Ready');
  FileListBox.Clear;
end;

end.

