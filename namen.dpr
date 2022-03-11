program namen;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  CipherRC4 in 'CipherRC4.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
