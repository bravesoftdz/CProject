unit uSetupFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Effects, FMX.ListBox, FMX.Layouts;

type
  TframeSetup = class(TFrame)
    Layout1: TLayout;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    txtLoginLogout: TText;
    lineLoginTop: TLine;
    ListBoxItem2: TListBoxItem;
    Text2: TText;
    Line1: TLine;
    ListBoxItem3: TListBoxItem;
    Text3: TText;
    Layout2: TLayout;
    roundAlaram: TRoundRect;
    circleAlaram: TCircle;
    ShadowEffect1: TShadowEffect;
    Line2: TLine;
    ListBoxItem4: TListBoxItem;
    Text4: TText;
    Line3: TLine;
    Layout3: TLayout;
    roundScreenOn: TRoundRect;
    circleScreen: TCircle;
    ShadowEffect2: TShadowEffect;
    ListBoxItem5: TListBoxItem;
    Text5: TText;
    Line4: TLine;
    Rectangle1: TRectangle;
    layoutBackButton: TLayout;
    Image1: TImage;
    procedure layoutBackButtonClick(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure roundAlaramClick(Sender: TObject);
    procedure roundScreenOnClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetAlaram;
    procedure SetScreen;
  public
    { Public declarations }
    procedure Init;
  end;

implementation
uses uMain, uGlobal, FMX.Ani, ClientModuleUnit, Data.DB;
{$R *.fmx}

{ TframeSetup }

procedure TframeSetup.Init;
begin
  SetAlaram;
  SetScreen;

  if CM.memUser.IsEmpty then
    txtLoginLogout.Text := '로그인 / 회원가입'
  else
    txtLoginLogout.Text := '로그아웃';
end;

procedure TframeSetup.layoutBackButtonClick(Sender: TObject);
begin
  frmMain.tabControlMain.ActiveTab := frmMain.tabMain;
  _info.login.SaveInfo;
end;

procedure TframeSetup.ListBoxItem1Click(Sender: TObject);
begin
  if CM.memUser.IsEmpty then
    frmMain.actLogin.Execute
  else
    frmMain.actLogout.Execute;

  frmMain.tabControlMain.ActiveTab := frmMain.tabMain;
end;

procedure TframeSetup.roundAlaramClick(Sender: TObject);
begin
  _info.login.setup.AlaramOn := not _info.login.setup.AlaramOn;
  SetAlaram;
end;

procedure TframeSetup.roundScreenOnClick(Sender: TObject);
begin
  _info.login.setup.ScreenOn := not _info.login.setup.ScreenOn;
  SetScreen;
end;

procedure TframeSetup.SetAlaram;
begin
  if _info.login.setup.AlaramOn then
  begin
    roundAlaram.Fill.Color := COLOR_ACTIVE_SWITCH;
    TAnimator.Create.AnimateFloat(circleAlaram, 'Position.X', 21, 0.1 );
  end
  else
  begin
    roundAlaram.Fill.Color := COLOR_INACTIVE_SWITCH;
    TAnimator.Create.AnimateFloat(circleAlaram, 'Position.X', 2, 0.1 );
  end;
end;

procedure TframeSetup.SetScreen;
begin
  if _info.login.setup.ScreenOn then
  begin
    roundScreenOn.Fill.Color := COLOR_ACTIVE_SWITCH;
    TAnimator.Create.AnimateFloat(circleScreen, 'Position.X', 21, 0.1 );
  end
  else
  begin
    roundScreenOn.Fill.Color := COLOR_INACTIVE_SWITCH;
    TAnimator.Create.AnimateFloat(circleScreen, 'Position.X', 2, 0.1 );
  end;
end;

end.
