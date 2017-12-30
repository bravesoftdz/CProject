unit uGetTime;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uGlobal,
  FMX.StdCtrls, FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.EditBox,
  FMX.NumberBox;

type
  TfrmGetTime = class(TForm)
    recBackground: TRectangle;
    recTimer: TRectangle;
    Rectangle22: TRectangle;
    numHour: TNumberBox;
    Rectangle23: TRectangle;
    numMin: TNumberBox;
    Rectangle24: TRectangle;
    numSec: TNumberBox;
    Text15: TText;
    Text16: TText;
    Text17: TText;
    Text18: TText;
    Text19: TText;
    btnTimerOK: TSpeedButton;
    procedure recBackgroundMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnTimerOKClick(Sender: TObject);
  private
    { Private declarations }
    FCallback: TCallbackRefFunc;
  public
    { Public declarations }
    procedure init(aTime: String; aCallback: TCallbackRefFunc);
  end;

var
  frmGetTime: TfrmGetTime;

implementation

{$R *.fmx}

{ TfrmGetTime }

procedure TfrmGetTime.btnTimerOKClick(Sender: TObject);
var
  aList: TStringList;
begin
  aList := TStringList.Create;
  aList.Add(Format('%.2d:%.2d:%.2d', [round(numHour.Value), round(numMin.Value), round(numSec.Value)]));

  if Assigned(FCallback) then
    FCallback(aList);

  Close;
end;

procedure TfrmGetTime.init(aTime: String; aCallback: TCallbackRefFunc);
  procedure GetHourMinSec(str: string; var h, m, s: integer);
  begin
    try
      if (not str.IsEmpty) and (Length(str)=8) then
      begin
        h := strtoint(copy(str, 1, 2));
        m := strtoint(copy(str, 4, 2));
        s := strtoint(copy(str, 7, 2));
      end;
    except
      h := 0; m := 0; s := 0;
    end;
  end;

var
  h, m, s: integer;
begin
  FCallback := aCallback;

  HideVirtualKeyboard;

  h := 0;
  m := 0;
  s := 0;

  GetHourMinSec(aTime, h, m, s);

  numHour.Value := h;
  numMin.Value := m;
  numSec.Value := s;
end;

procedure TfrmGetTime.recBackgroundMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  close;
end;

end.
