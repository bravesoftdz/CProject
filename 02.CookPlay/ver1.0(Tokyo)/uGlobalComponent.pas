unit uGlobalComponent;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ImageList, FMX.ImgList, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.Gestures, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo;

type
  TfrmGlobalComponent = class(TForm)
    ImageListMyhome: TImageList;
    MyhomeGestureManager: TGestureManager;
    memoTemp: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetString(aStr: string; aLine, aMaxLength: integer): string;
  end;

var
  frmGlobalComponent: TfrmGlobalComponent;

implementation

{$R *.fmx}

{ TfrmGlobalComponent }

function TfrmGlobalComponent.GetString(aStr: string; aLine, aMaxLength: integer): string;
var
  rstr: string;
  i, cnt, nLen: integer;
  nLineCount: integer;
begin
  memoTemp.Lines.Clear;
  memoTemp.Lines.Text := aStr.Trim;

  cnt := 0;
  while (cnt < memotemp.Lines.Count) do
  begin
    if memoTemp.Lines[cnt].Trim = '' then
      memoTemp.Lines.Delete(cnt)
    else
      cnt := cnt + 1;
  end;

  nLineCount := 0;
  nLen := 0;
  for i := 0 to memotemp.Lines.Count-1 do
    if i < aLine then
    begin
      nLen := nLen + memoTemp.Lines[i].Length;
      nLineCount := nLineCount + 1;
    end;

  if nLen < aMaxLength then
    result := copy(memoTemp.Text, 1, nLen + nLineCount - 1) + '...'
  else
    result := copy(memoTemp.Text, 1, aMaxLength) + '...';
end;

end.
