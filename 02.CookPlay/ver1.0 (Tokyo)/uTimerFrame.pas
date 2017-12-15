unit uTimerFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Ani, FMX.Layouts;

type
  TframeTimer = class(TFrame)
    Layout1: TLayout;
    ScaleScaledLayout: TScaledLayout;
    arcBase: TArc;
    arcPosition: TArc;
    FloatAnimationArc: TFloatAnimation;
    Circle2: TCircle;
    txtScaleWeight: TText;
    Text1: TText;
    lineMaxPosition: TLine;
    linePosition: TLine;
    circlePosition: TCircle;
    FloatAnimationLine: TFloatAnimation;
    Layout2: TLayout;
    txtIngredientExplain: TText;
    layoutClose: TLayout;
    imgClose: TImage;
    Timer: TTimer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
