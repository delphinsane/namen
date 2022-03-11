unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.IniFiles,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Hash, CipherRC4;

type
  TForm1 = class(TForm)
    Edit_Name1: TEdit;
    Label_Name1: TLabel;
    Edit_Name2: TEdit;
    Label_Name2: TLabel;
    Edit_Strasse: TEdit;
    Label_Strasse: TLabel;
    Edit_Ort: TEdit;
    Label_Ort: TLabel;
    Edit_HWCode: TEdit;
    Label_HWCode: TLabel;
    Edit_Datum: TEdit;
    Label_Datum: TLabel;
    Edit_SerienNr: TEdit;
    Label_SerienNr: TLabel;
    Label_Lizenz1: TLabel;
    Edit_Lizenz1: TEdit;
    Edit_Lizenz2: TEdit;
    Label_Lizenz2: TLabel;
    Edit_Lizenz3: TEdit;
    Label_Lizenz3: TLabel;
    Label_Version: TLabel;
    Edit_Version: TEdit;
    Label_Code1: TLabel;
    Edit_Code1: TEdit;
    Label_Code2: TLabel;
    Edit_Code2: TEdit;
    Label_Code3: TLabel;
    Edit_Code3: TEdit;
    Button_Laden: TButton;
    Memo_RC4_Enc: TMemo;
    Memo_RC4_Dec: TMemo;
    Label_Enc: TLabel;
    Label_Dec: TLabel;
    Button_Laden_RC4: TButton;
    Button_Passwort: TButton;
    procedure Button_LadenClick(Sender: TObject);
    procedure Edit_Name1Change(Sender: TObject);
    procedure Edit_Name2Change(Sender: TObject);
    procedure Edit_StrasseChange(Sender: TObject);
    procedure Edit_OrtChange(Sender: TObject);
    procedure Edit_HWCodeChange(Sender: TObject);
    procedure Edit_DatumChange(Sender: TObject);
    procedure Edit_SerienNrChange(Sender: TObject);
    procedure Edit_Lizenz1Change(Sender: TObject);
    procedure Edit_Lizenz2Change(Sender: TObject);
    procedure Edit_Lizenz3Change(Sender: TObject);
    procedure Edit_VersionChange(Sender: TObject);
    procedure Edit_Code1Change(Sender: TObject);
    procedure Button_Laden_RC4Click(Sender: TObject);
    procedure Button_PasswortClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function GetPropertyValue(aFile, Key: string): string;
var
  properties: TStringList;
begin
  properties := TStringList.Create;
  try
    properties.LoadFromFile(aFile);
    Result := properties.Values[key];
  finally
    properties.free;
  end;
end;

procedure Calc_Code2_Code3();
var
    Name1 : String;
    Name2 : String;
    Strasse : String;
    Ort : String;
    HWCode : String;
    Datum : String;
    SerienNr : String;
    Lizenz1 : String;
    Lizenz2 : String;
    Lizenz3 : String;
    Version : String;
    Code1 : String;
    v41 : String;
    v40 : Integer;
    v39 : Integer;
    v38 : Integer;
    v37 : Integer;
    v36 : Integer;
    v35 : Integer;
    v34 : Integer;
    v3 : Integer;
    v4 : Integer;
    v5 : Integer;
    v6 : Integer;
    v7 : Integer;
    v8 : Integer;
    v9 : Integer;
    v10 : Integer;
    v11 : Integer;
    v12 : Integer;
    v13 : Integer;
    v14 : Integer;
    v15 : Integer;
    v16 : Integer;
    v17 : Integer;
    v18 : Integer;
    v19 : Integer;
begin
    Name1 := Form1.Edit_Name1.Text;
    Name2 := Form1.Edit_Name2.Text;
    Strasse := Form1.Edit_Strasse.Text;
    Ort := Form1.Edit_Ort.Text;
    HWCode := Form1.Edit_HWCode.Text;
    Datum := Form1.Edit_Datum.Text;
    SerienNr := Form1.Edit_SerienNr.Text;
    Lizenz1 := Form1.Edit_Lizenz1.Text;
    Lizenz2 := Form1.Edit_Lizenz2.Text;
    Lizenz3 := Form1.Edit_Lizenz3.Text;
    Version := Form1.Edit_Version.Text;
    Code1 := Form1.Edit_Code1.Text;
    v41 := Name1 +'|'+ Name2 +'||'+ Strasse +'|||'+ Ort +'||'+ HWCode +'|'+ Datum +'|'+ SerienNr +'|'+ Lizenz1 + Lizenz2 + Lizenz3 +'|'+ Version +'|'+ Code1 +'|';
    v40 := 0;
    v39 := 0;
    v38 := 0;
    v37 := 0;
    v36 := Length(v41);
    v35 := v36;
    v34 := 0;
    while v35 > 0 do begin
        v3 := v37 * Ord(Copy(v41,v37+1,1)[1]);
        v4 := Ord(Copy(v41,v37+1,1)[1]);
        v6 := v4 + v3;
        v7 := v6 - v37;
        v8 := 37 * v37;
        v9 := v8 + v7;
        if v9 > 32768 then begin
            v34 := v34 + 1; //count downcasts to signed __int16 (-65536)
        end;
        v39 := v39 + v9;
        v10 := v36 - v37;
        v11 := v10 - 1;
        v13 := Ord(Copy(v41,v11+1,1)[1]);
        v12 := v37 * v13;
        v14 := v36 - v37 - 1;
        v15 := Ord(Copy(v41,v14+1,1)[1]);
        v16 := v15 + v12;
        v17 := v16 - v37;
        v18 := 71 * v37;
        v19 := v18 + v17;
        if v19 > 32768 then begin
            v40 := v40 + 1; //count downcasts to signed __int16 (-65536)
        end;
        v38 := v38 + v19;
        v37 := v37 + 1;
        v35 := v35 - 1;
    end;
    v39 := v39 - v34 * 65536; //substract counted downcasts to signed __int16 (-65536)
    v39 := v39 * 37;
    v38 := v38 - v40 * 65536; //substract counted downcasts to signed __int16 (-65536)
    v38 := v38 * 21;
    if v39 < 999999 then begin
        v39 := v39 * 21;
    end;
    if v38 < 999999 then begin
        v38 := v38 * 37;
    end;
    if v39 > 99999999 then begin
        v39 := v39 div 11;
    end;
    if v38 > 99999999 then begin
        v38 := v38 div 17;
    end;
    Form1.Edit_Code2.Text := IntToStr(v39);
    Form1.Edit_Code3.Text := IntToStr(v38);
end;

procedure TForm1.Button_LadenClick(Sender: TObject);
var
    openDialog : topendialog;
begin
    openDialog := TOpenDialog.Create(self);
    openDialog.InitialDir := GetCurrentDir;
    openDialog.Options := [ofFileMustExist];
    openDialog.Filter := 'GDI namen Dateien|*.namen';
    openDialog.FilterIndex := 1;
    if openDialog.Execute
    then begin
        Edit_Name1.Text := GetPropertyValue(openDialog.FileName,'Name1');
        Edit_Name2.Text := GetPropertyValue(openDialog.FileName,'Name2');
        Edit_Strasse.Text := GetPropertyValue(openDialog.FileName,'Strasse');
        Edit_Ort.Text := GetPropertyValue(openDialog.FileName,'Ort');
        Edit_HWCode.Text := GetPropertyValue(openDialog.FileName,'HWCode');
        Edit_Datum.Text := GetPropertyValue(openDialog.FileName,'Datum');
        Edit_SerienNr.Text := GetPropertyValue(openDialog.FileName,'ProgrammNr');
        Edit_Lizenz1.Text := Trim(Copy(GetPropertyValue(openDialog.FileName,'Lizenz'),1,30));
        Edit_Lizenz2.Text := Trim(Copy(GetPropertyValue(openDialog.FileName,'Lizenz'),31,30));
        Edit_Lizenz3.Text := Trim(Copy(GetPropertyValue(openDialog.FileName,'Lizenz'),61,30));
        Edit_Version.Text := GetPropertyValue(openDialog.FileName,'Version');
        Edit_Code1.Text := GetPropertyValue(openDialog.FileName,'Code1');
        Calc_Code2_Code3();
    end
    else ShowMessage('Datei öffnen wurde abgebrochen.');
    openDialog.Free;
end;

procedure TForm1.Edit_Code1Change(Sender: TObject);
begin
    Calc_Code2_Code3();
end;

procedure TForm1.Edit_DatumChange(Sender: TObject);
begin
    Calc_Code2_Code3();
end;

procedure TForm1.Edit_HWCodeChange(Sender: TObject);
begin
    Calc_Code2_Code3();
end;

procedure TForm1.Edit_Lizenz1Change(Sender: TObject);
begin
    Calc_Code2_Code3();
end;

procedure TForm1.Edit_Lizenz2Change(Sender: TObject);
begin
    Calc_Code2_Code3();
end;

procedure TForm1.Edit_Lizenz3Change(Sender: TObject);
begin
    Calc_Code2_Code3();
end;

procedure TForm1.Edit_Name1Change(Sender: TObject);
begin
    Calc_Code2_Code3();
end;

procedure TForm1.Edit_Name2Change(Sender: TObject);
begin
    Calc_Code2_Code3();
end;

procedure TForm1.Edit_OrtChange(Sender: TObject);
begin
    Calc_Code2_Code3();
end;

procedure TForm1.Edit_SerienNrChange(Sender: TObject);
begin
    Calc_Code2_Code3();
end;

procedure TForm1.Edit_StrasseChange(Sender: TObject);
begin
    Calc_Code2_Code3();
end;

procedure TForm1.Edit_VersionChange(Sender: TObject);
begin
    Calc_Code2_Code3();
end;

function String2Hex(const Buffer: AnsiString): string;
begin
  SetLength(Result, Length(Buffer) * 2);
  BinToHex(PAnsiChar(Buffer), PChar(Result), Length(Buffer));
end;

function Hex2String(const Buffer: string): AnsiString;
begin
  SetLength(Result, Length(Buffer) div 2);
  HexToBin(PChar(Buffer), PAnsiChar(Result), Length(Result));
end;

function GetBinToHex(Value: TStream): string;
var
  Stream: TMemoryStream;
begin
  SetLength(Result, (Value.Size - Value.Position) * 2);
  if Length(Result) > 0 then
  begin
    Stream := TMemoryStream.Create;
    try
      Stream.CopyFrom(Value, Value.Size - Value.Position);
      Stream.Position := 0;
      BinToHex(PChar(Integer(Stream.Memory) + Stream.Position), PChar(Result),
        Stream.Size - Stream.Position);
    finally
      Stream.Free;
    end;
  end;
end;

function BinToHexFromFile(const FileName: string): string;
var
  FileStream: TFileStream;
begin
  Result := '';
  if FileExists(FileName) then
  begin
    FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      FileStream.Position := 8; // skip the first 8 characters @Crypt#@
      Result := GetBinToHex(FileStream);
    finally
      FileStream.Free;
    end;
  end;
end;

procedure TForm1.Button_Laden_RC4Click(Sender: TObject);
var
    openDialog : topendialog;
    Rc4Key: String;
    ValEnc: String;
    ValDec: String;
begin
    openDialog := TOpenDialog.Create(self);
    openDialog.InitialDir := GetCurrentDir;
    openDialog.Options := [ofFileMustExist];
    openDialog.Filter := 'GDI Masken Dateien|*.txt';
    openDialog.FilterIndex := 1;
    if openDialog.Execute
    then begin
        // decrypted file starts with "@Crypt#@" so skip first 8 Bytes
        // Delphi's LoadFromFile inserts LF linefeeds so use own method
        ValEnc := BinToHexFromFile(openDialog.FileName);
        Rc4Key := Hex2String(THashSHA1.GetHashString('FACT-Factur'));
        ValDec := RC4.Decrypt(Rc4Key,ValEnc);
        Form1.Memo_RC4_Enc.Lines.Text := Hex2String(ValEnc);
        Form1.Memo_RC4_Dec.Lines.Clear;
        Form1.Memo_RC4_Dec.Lines.Add(ValDec);
    end
    else ShowMessage('Datei öffnen wurde abgebrochen.');
    openDialog.Free;
end;

procedure TForm1.Button_PasswortClick(Sender: TObject);
var
  Search : String;
  Start : String;
begin
    Search := Form1.Memo_RC4_Dec.Lines.Text;
    Start := Copy(Search,Pos('Passwort =',Search),Length(Search));
    ShowMessage(Copy(Start,0,Pos(#13,Start)));
end;

end.
