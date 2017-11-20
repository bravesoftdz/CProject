unit uEncryption;

interface
uses SysUtils;

function GetSizeString(wSource: WORD; num: integer): string;
function Encoding(sSource: string): string;
function Decoding(sSource: string): string;

const
  cPara : array[0..9] of word = (21,44,87,56,99,11,13, 77, 12, 33);
  cDigiSize = 5;

implementation

function GetSizeString(wSource: WORD; num: integer): string;
var
  i: integer;
begin
  result := inttostr(wSource);

  for i := length(inttostr(wSource))+1 to num do
    result := '0' + result;
end;

function Encoding(sSource: string): string;
var
  wSource : WORD;
  len, t, nParaNum : integer;
begin
  sSource := trim(sSource);
  len := length(sSource);

  if len = 0 then
  begin
    result := '';
    exit;
  end;

  result := GetSizeString(len+273, cDigiSize);
  for t := 1 to len do
  begin
    wSource := word(sSource[t]);
    nParaNum := (t-1) mod 10;

    result := result + GetSizeString(wSource + cPara[nParaNum], cDigiSize);
  end;
end;

function Decoding(sSource: string): string;
var
  len, cnt, i, nParaNum : integer;
  wSource : WORD;
  s : string;
begin
  sSource := trim(sSource);
  len := length(sSource);

  result := '';

  if len = 0 then Exit;
  if (len mod cDigiSize) <> 0 then  Exit;

  cnt := strtoint(copy(sSource, 1, cDigiSize)) - 273;

  s := ' ';
  for i := 1 to cnt do
  begin
    nParaNum := (i-1) mod 10;

    wSource := strtoint(copy(sSource, i*cDigiSize+1, cDigiSize)) - cPara[nParaNum];

    s[1] := char(wSource);

    result := result + s;
  end;
end;

end.
