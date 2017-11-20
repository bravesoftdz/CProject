unit uSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxTextEdit, cxMaskEdit, cxDropDownEdit;

type
  TfrmSetup = class(TForm)
    edtServer: TLabeledEdit;
    edtUserID: TLabeledEdit;
    edtPassword: TLabeledEdit;
    edtPort: TLabeledEdit;
    btnSave: TButton;
    btnClose: TButton;
    edtDatabase: TLabeledEdit;
    Label1: TLabel;
    cboDrivername: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetup: TfrmSetup;

implementation
uses CookPlay.Global;
{$R *.dfm}

procedure TfrmSetup.btnSaveClick(Sender: TObject);
begin
  try
    _SysInfo.Database.DriverName := Trim(cboDrivername.Items[cboDrivername.ItemIndex]);
    _SysInfo.Database.Server := Trim(edtServer.Text);
    _SysInfo.Database.Database := Trim(edtDatabase.Text);
    _SysInfo.Database.UserID := Trim(edtUserID.Text);
    _SysInfo.Database.Password := Trim(edtPassword.Text);
    _SysInfo.Database.Port := StrToInt(edtPort.Text);

    if _SysInfo.SaveSystemInformation then
    begin
      ShowMessage('저장하였습니다!'+#13+#10+#13+#10+'프로그램을 종료합니다!');
      Application.Terminate;
    end
    else
      ShowMessage('저장에 실패하였습니다!');
  except
    ShowMessage('저장에 실패했습니다!');
  end;

end;

procedure TfrmSetup.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmSetup.FormShow(Sender: TObject);
begin
  _SysInfo.LoadSystemInformation;

  cboDrivername.ItemIndex := cboDrivername.Items.IndexOf(_SysInfo.Database.DriverName);
  edtServer.Text := _SysInfo.Database.Server;
  edtDatabase.Text := _SysInfo.Database.Database;
  edtUserID.Text := _SysInfo.Database.UserID;
  edtPassword.Text := _SysInfo.Database.Password;
  edtPort.Text := _SysInfo.Database.Port.ToString;
end;

end.
