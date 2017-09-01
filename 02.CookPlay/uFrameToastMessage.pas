unit uFrameToastMessage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Effects, FMX.Layouts;

type
  TframeToastMessage = class(TFrame)
    ToastLayout: TLayout;
    MessageRect: TRoundRect;
    ShadowEffect1: TShadowEffect;
    MsgText: TText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
