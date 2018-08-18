unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DebugUnit;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonOK: TButton;
    Memo1: TMemo;
    procedure ButtonOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;
const
  DS=DirectorySeparator;
  LE=LineEnding;
var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ButtonOKClick(Sender: TObject);
begin

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


procedure TForm1.FormShow(Sender: TObject);
begin
  DebugForm.Show;
  Debugln('Ready');

end;

end.

