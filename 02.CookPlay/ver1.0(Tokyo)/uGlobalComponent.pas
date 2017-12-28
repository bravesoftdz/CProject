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
    function GetString(aStr: string; aLength: integer): string;
  end;

var
  frmGlobalComponent: TfrmGlobalComponent;

implementation

{$R *.fmx}

{ TfrmGlobalComponent }

function TfrmGlobalComponent.GetString(aStr: string; aLength: integer): string;
var
  s: string;
  i, nLen: integer;
begin
  memoTemp.Lines.Clear;
  memoTemp.Lines.Text := aStr.Trim;

  nLen := 0;
  for i := 0 to memotemp.Lines.Count-1 do
    if i < 3 then
      nLen := nLen + memoTemp.Lines[i].Length;

  if nLen < aLength then
    result := copy(aStr, 1, nLen)
  else
    result := copy(aStr, 1, aLength);
end;

end.
