unit uTemp2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  uScaleFrame;

type
  TfrmTemp2 = class(TForm)
    Rectangle1: TRectangle;
    frameScale1: TframeScale;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTemp2: TfrmTemp2;

implementation
uses uGlobal, cookplay.scale, cookplay.StatusBar;
{$R *.fmx}

procedure TfrmTemp2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FullScreen := False;
end;

procedure TfrmTemp2.FormShow(Sender: TObject);
begin
  frameScale1.OpenScale(TScaleMeasureType.smPlay, '양파1개 100.3g', 100.3, TIngredientUnit.wuG);

  // Status Bar 색을 바꾼다
  Fill.Color := $FFFFDF77;
  StatusBarSetColor(Fill.Color);

  FullScreen := True;
end;

end.
