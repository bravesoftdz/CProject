unit uSetup;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Ani;

type
  TfrmSetup = class(TForm)
    Rectangle1: TRectangle;
    layoutBackButton: TLayout;
    Image1: TImage;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    txtLoginLogout: TText;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    Text5: TText;
    Layout1: TLayout;
    roundAlaram: TRoundRect;
    circleAlaram: TCircle;
    ShadowEffect1: TShadowEffect;
    lineLoginTop: TLine;
    Line1: TLine;
    Line2: TLine;
    Line3: TLine;
    Line4: TLine;
    Layout2: TLayout;
    roundScreenOn: TRoundRect;
    circleScreen: TCircle;
    ShadowEffect2: TShadowEffect;
    procedure FormShow(Sender: TObject);
    procedure layoutBackButtonClick(Sender: TObject);
    procedure roundAlaramClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure roundScreenOnClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetAlaram;
    procedure SetScreen;
  public
    { Public declarations }
  end;

var
  frmSetup: TfrmSetup;

implementation
uses uGlobal, cookplay.StatusBar, ClientModuleUnit, uMain, Data.DB;
{$R *.fmx}

procedure TfrmSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  _info.login.SaveInfo;
end;

procedure TfrmSetup.FormShow(Sender: TObject);
begin
  // Status Bar 색을 바꾼다
  Fill.Color := GetColor(COLOR_BACKGROUND);
  StatusBarSetColor(Fill.Color);

  SetAlaram;
  SetScreen;

  if CM.memUser.IsEmpty then
    txtLoginLogout.Text := '로그인 / 회원가입'
  else
    txtLoginLogout.Text := '로그아웃';
end;

procedure TfrmSetup.layoutBackButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSetup.ListBoxItem1Click(Sender: TObject);
begin
  if CM.memUser.IsEmpty then
    frmMain.CallLoginForm
  else
    frmMain.actLogout.Execute;

  Close;
end;

procedure TfrmSetup.roundAlaramClick(Sender: TObject);
begin
  _info.login.setup.AlaramOn := not _info.login.setup.AlaramOn;
  SetAlaram;
end;

procedure TfrmSetup.roundScreenOnClick(Sender: TObject);
begin
  _info.login.setup.ScreenOn := not _info.login.setup.ScreenOn;
  SetScreen;
end;

procedure TfrmSetup.SetAlaram;
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

procedure TfrmSetup.SetScreen;
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
