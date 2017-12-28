unit uTimer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Ani;

type
  TfrmTimer = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    layoutClose: TLayout;
    imgClose: TImage;
    ScaleScaledLayout: TScaledLayout;
    arcBase: TArc;
    arcPosition: TArc;
    FloatAnimationArc: TFloatAnimation;
    Circle2: TCircle;
    txtScaleWeight: TText;
    lineMaxPosition: TLine;
    linePosition: TLine;
    circlePosition: TCircle;
    FloatAnimationLine: TFloatAnimation;
    txtIngredientExplain: TText;
    Text1: TText;
    Timer: TTimer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTimer: TfrmTimer;

implementation

{$R *.fmx}

end.
