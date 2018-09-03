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

unit debugunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  { TDebugForm }

  TDebugForm = class(TForm)
    Memo: TMemo;
    ButtonClear: TButton;
    procedure ButtonClearClick(Sender: TObject);
  private

  public

  end;

var
  DebugForm: TDebugForm;

  procedure Debugln(aLine: string);
  procedure Debugln(aFormat:string; aNumber: integer);
  procedure Debugln(aFormat:string; aDouble: double);
  procedure Debugln(aFormat:string; aBoolean: boolean);

implementation

{$R *.lfm}

{ TDebugForm }

procedure Debugln(aLine: string);
begin
  DebugForm.Memo.Append(aLine);
end;
procedure Debugln(aFormat:string; aNumber: integer);
begin
  DebugForm.Memo.Append(Format(aFormat, [aNumber]));
end;
procedure Debugln(aFormat:string; aDouble: double);
begin
  DebugForm.Memo.Append(Format(aFormat, [aDouble]));
end;
procedure Debugln(aFormat:string; aBoolean: boolean);
begin
  DebugForm.Memo.Append(Format(aFormat, [BoolToStr(aBoolean, true)]));
end;
procedure TDebugForm.ButtonClearClick(Sender: TObject);
begin
  Memo.Clear;
end;

end.

