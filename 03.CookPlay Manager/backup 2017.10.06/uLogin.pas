unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Vcl.StdCtrls, cxTextEdit, cxLabel, cxMaskEdit,
  Registry;

type
  TfrmLogin = class(TForm)
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxID: TcxTextEdit;
    cxPassword: TcxTextEdit;
    btnLogin: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure cxPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure LoadUserID;
    procedure WriteUserID;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation
uses uDB, cookplay.Global;
{$R *.dfm}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  if dmDB.FindUser(trim(cxID.Text), trim(cxPassword.Text)) then
  begin
    WriteUserID;
    ModalResult := mrOK;
  end
  else
    ShowMessage('사용자를 찾을 수 없습니다!');
end;

procedure TfrmLogin.Button2Click(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure TfrmLogin.cxPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnLogin.Click;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  cxID.Text := '';
  cxPassword.Text := '';

  LoadUserID;
end;

procedure TfrmLogin.LoadUserID;
var
  r: TRegistry;
begin
  r := TRegistry.Create;

  try
    cxID.Text := '';
    r.RootKey := HKEY_CURRENT_USER;

    if not r.OpenKey(cKEY_NAME, true) then
      raise Exception.Create('저장된 사용자 ID 가 없습니다');

    cxID.Text := r.ReadString('UserID');
  finally
    r.CloseKey;
    r.Free;

    if trim(cxID.Text) = '' then
      cxID.SetFocus
    else
      cxPassword.SetFocus;
  end;
end;

procedure TfrmLogin.WriteUserID;
var
  r: TRegistry;
begin
  r := TRegistry.Create;

  try
    r.RootKey := HKEY_CURRENT_USER;

    r.OpenKey(cKEY_NAME, True);

    r.WriteString('UserID', cxID.Text);
  finally
    r.CloseKey;
    r.Free;
  end;
end;

end.
