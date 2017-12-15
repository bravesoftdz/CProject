unit uTemp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uScaleFrame,
  FMX.Objects;

type
  TfrmTemp = class(TForm)
    frameScale1: TframeScale;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frameScale1layoutCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTemp: TfrmTemp;

implementation
uses uGlobal, cookplay.scale, cookplay.StatusBar;
{$R *.fmx}

procedure TfrmTemp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frameScale1.CloseScale;
end;

procedure TfrmTemp.FormShow(Sender: TObject);
begin
  frameScale1.OpenScale(TScaleMeasureType.smView, '양파1개 100.3g', 100.3, TIngredientUnit.wuG);

  // Status Bar 색을 바꾼다
  Fill.Color := $FFFFDF77;
  StatusBarSetColor(Fill.Color);
end;

procedure TfrmTemp.frameScale1layoutCloseClick(Sender: TObject);
begin
  Close;
end;

end.
