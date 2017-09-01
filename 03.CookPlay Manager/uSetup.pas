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
    oSysInfo.Database.DriverName := Trim(cboDrivername.Items[cboDrivername.ItemIndex]);
    oSysInfo.Database.Server := Trim(edtServer.Text);
    oSysInfo.Database.Database := Trim(edtDatabase.Text);
    oSysInfo.Database.UserID := Trim(edtUserID.Text);
    oSysInfo.Database.Password := Trim(edtPassword.Text);
    oSysInfo.Database.Port := StrToInt(edtPort.Text);

    if oSysInfo.SaveSystemInformation then
    begin
      ShowMessage('�����Ͽ����ϴ�!'+#13+#10+#13+#10+'���α׷��� �����մϴ�!');
      Application.Terminate;
    end
    else
      ShowMessage('���忡 �����Ͽ����ϴ�!');
  except
    ShowMessage('���忡 �����߽��ϴ�!');
  end;

end;

procedure TfrmSetup.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmSetup.FormShow(Sender: TObject);
begin
  oSysInfo.LoadSystemInformation;

  cboDrivername.ItemIndex := cboDrivername.Items.IndexOf(oSysInfo.Database.DriverName);
  edtServer.Text := oSysInfo.Database.Server;
  edtDatabase.Text := oSysInfo.Database.Database;
  edtUserID.Text := oSysInfo.Database.UserID;
  edtPassword.Text := oSysInfo.Database.Password;
  edtPort.Text := oSysInfo.Database.Port.ToString;
end;

end.
