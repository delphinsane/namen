unit CipherRC4;

interface

uses
  SysUtils;

type
  RC4 = class
    protected
    private
    public
      class function Encrypt(Key, Text: String): String;
      class function Decrypt(Key, Text: String): String;
  end;

implementation

{ RC4 }

class function RC4.Encrypt(Key, Text: String): String;
var
  i,j,x,y: Integer;
  s: array[0..255] of Integer;

  charCode: Integer;

  ct: String;
  ctInt: Integer;
begin

  for i := 0 to 255 do
  begin
    s[i] := i;
  end;

  j := 0;

  for i := 0 to 255 do
  begin
    charCode := Ord(Char(Key[(i MOD Length(Key)) + 1]));
    j := (j + s[i] + charCode) MOD 256;

    x := s[i];
    s[i] := s[j];
    s[j] := x;
  end;

  // Reset variables
  i := 0;
  j := 0;

  ct := '';

  for y:= 0 to (Length(Text) - 1) do
  begin
    i := (i + 1) MOD 256;
    j := (j + s[i]) MOD 256;
    x := s[i];

    s[i] := s[j];
    s[j] := x;

    ctInt := Ord(Char(Text[y + 1])) xor (s[((s[i] + s[j]) MOD 256)]);

    ct := concat(ct, IntToHex(ctInt, 2));
  end;

  Result := UpperCase(ct);
end;

class function RC4.Decrypt(Key, Text: String): String;
var
  c,i,j,k,x,y: Integer;
  s: array[0..255] of Integer;

  copyText: String;

  charCode: Integer;

  ct: String;
begin
  for i := 0 to 255 do
  begin
    s[i] := i;
  end;

  j := 0;

  for i := 0 to 255 do
  begin
    charCode := Ord(Char(Key[(i MOD Length(Key)) + 1]));
    j := (j + s[i] + charCode) MOD 256;

    x := s[i];
    s[i] := s[j];
    s[j] := x;
  end;

  // Reset variables
  i := 0;
  j := 0;
  k := 0;

  ct := '';

  if (0 = (Length(Text) and 1)) and (Length(Text) > 0) then
  begin
    c := 0;
    y := 0;

    while y < (Length(Text)) do
    begin
      i := (i + 1) MOD 256;
      j := (j + s[i]) MOD 256;
      x := s[i];

      s[i] := s[j];
      s[j] := x;

      copyText := Copy(Text,c,2);

      // Convert previous text
      charCode := StrToInt('$' + copyText) xor (s[((s[i] + s[j]) MOD 256)]);

      ct := concat(ct, String(Chr(charCode)));

      // Increasing loop counter
      y := y + 2;
      // Increasing copy counter
      c := y + 1;
      // Increasing byte counter
      k := k + 1;
      // Bug in RC4 implementation: Ray Marron has reported a bug in the
      // RC4 implementation in DCPcrypt that means that when encrypting data
      // sets over 8192 bytes in size the results will non-standard
      // using not DCPcrypt will only decrypt the first 8KBytes
      // I found the bug, but it is in DCPCrypt 2.0's DCPrc4.pas.
      // It uses an 8K buffer when encrypting, but it fails to keep
      // the state of the I & J values between chunks.
      // this emulates DCPCrypt behaviour but is non-standard:
      if k = 8192 then
      begin
        i := 0;
        j := 0;
        k := 0;
      end;
    end;
  end;

  Result := ct;
end;

end.
