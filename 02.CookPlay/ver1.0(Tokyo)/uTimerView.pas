unit uTimerView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uTimerFrame;

type
  TForm3 = class(TForm)
    frameTimer1: TframeTimer;
    procedure FormShow(Sender: TObject);
    procedure frameTimer1layoutCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
uses uGlobal;
{$R *.fmx}

procedure TForm3.FormShow(Sender: TObject);
begin
  frameTimer1.Clear;
  frameTimer1.Resize(TScaleMeasureType.smViewMeasure);
end;

procedure TForm3.frameTimer1layoutCloseClick(Sender: TObject);
begin
  Close;
end;

end.
