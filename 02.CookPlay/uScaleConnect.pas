unit uScaleConnect;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Ani;

type
  TFrame1 = class(TFrame)
    RectBackground: TRectangle;
    txtMessage: TText;
    FloatAni_Con: TFloatAnimation;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Start(AMsg: string = '');
    procedure Stop;
    procedure Write(AMsg: string);
  end;

implementation

{$R *.fmx}

{ TFrame1 }

procedure TFrame1.Stop;
begin
  FloatAni_Con.Stop;

  self.Visible := False;
end;

procedure TFrame1.Start(AMsg: string = '');
begin
  Self.Left := 0;
  Self.Top := 0;
  RectBackground.Align := TAlignLayout.Client;
  txtMessage.Text := AMsg;

  FloatAni_Con.Start;

  self.Visible := True;
end;

procedure TFrame1.Write(AMsg: string);
begin
  txtMessage.Text := AMsg;
end;

end.
