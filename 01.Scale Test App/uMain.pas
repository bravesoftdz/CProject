unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.DateUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects, FMX.Edit,
  System.Bluetooth, System.Bluetooth.Components, FMX.ListBox, FMX.ScrollBox,
  FMX.Memo, cookplay.Scale, System.Math, FMX.Media, System.IOUtils,
  System.Inifiles, FMX.TabControl, FMX.Platform, IdMessage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP;

type
  TBox = record
    W: integer;
    D: integer;
    H: integer;
  end;

  TfrmMain = class(TForm)
    lotBody: TLayout;
    BLE_Scale: TBluetoothLE;
    btnScanScale: TButton;
    btnScaleConnect: TButton;
    btnDisconnectScale: TButton;
    lblScaleConnected: TLabel;
    lblScaleAuthorized: TLabel;
    cboScale: TComboBox;
    lblStable: TLabel;
    Rectangle1: TRectangle;
    lblKg: TLabel;
    Label8: TLabel;
    btnClearScale: TButton;
    chkViewWeight: TCheckBox;
    memoScale: TMemo;
    chkViewReceivedString: TCheckBox;
    chkViewSendString: TCheckBox;
    btnRW: TButton;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    btnSendmail: TButton;
    procedure btnScanScaleClick(Sender: TObject);
    procedure btnScaleConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnClearScaleClick(Sender: TObject);
    procedure btnDisconnectScaleClick(Sender: TObject);
    procedure BLE_ScaleEndDiscoverDevices(const Sender: TObject;
      const ADeviceList: TBluetoothLEDeviceList);
    procedure btnRWClick(Sender: TObject);
    procedure btnSendmailClick(Sender: TObject);
  private
    { Private declarations }
    oScale: TScaleConnection;

    procedure SendMail(AMemo: TMemo; ATitle: string);

    procedure DoScaleConnected(Sender: TObject);
    procedure DoScaleDisconnected(Sender: TObject);
    procedure DoScaleAuthorized(Sender: TObject);
    procedure DoNotScaleAuthorized(Sender: TObject);
    procedure DoScaleRead(const s: string);
    procedure DoscaleWrite(const s: string);
    procedure DoScaleReadWeight(const AMessage: TWeightMessage);
    procedure DoScaleReadWeightChanged(const AMessage: TWeightMessage);
  public
    { Public declarations }
  end;

const
  MSG_NotFoundDevice = '���������� ã�� �� �����ϴ�!';
  TIME_Discover = 1000;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.BLE_ScaleEndDiscoverDevices(const Sender: TObject;
  const ADeviceList: TBluetoothLEDeviceList);
var
  i: integer;
begin
  cboScale.Clear;

  if ADeviceList.Count < 1 then
    memoScale.Lines.Insert(0, 'Scale - * BLE ��� ã�� �� �����ϴ�!')
  else
  begin
    for i:=0 to ADeviceList.Count-1 do
      cboScale.Items.Add(ADeviceList.Items[i].DeviceName + ' [' + ADeviceList.Items[i].Address + ']');

    cboScale.ItemIndex := 0;
  end;
end;

procedure TfrmMain.btnClearScaleClick(Sender: TObject);
begin
  memoScale.Lines.Clear;
end;

procedure TfrmMain.btnScaleConnectClick(Sender: TObject);
begin
  if oScale.IsConnected then
  begin
    ShowMessage('���������� �����Ͻ� �� �����Ͻʽÿ�!');
    exit;
  end;

  if cboScale.ItemIndex < 0 then
  begin
    ShowMessage('���������� ���õ��� �ʾҽ��ϴ�!');
    Exit;
  end;

  if not oScale.IsCertifiedScale(BLE_Scale.DiscoveredDevices[cboScale.ItemIndex].DeviceName) then
    ShowMessage('CookPlay ���������� �ƴմϴ�!')
  else
  begin
    if not oScale.ConnectDevice(BLE_Scale.DiscoveredDevices.Items[cboScale.ItemIndex]) then
      ShowMessage('������ ������ �� �����ϴ�!');
  end;
end;

procedure TfrmMain.btnScanScaleClick(Sender: TObject);
begin
  cboScale.Clear;

  if oScale.IsConnected then
    ShowMessage('����� ���������� ���� �Ͻ� �� �õ��Ͻʽÿ�!')
  else
    BLE_Scale.DiscoverDevices(TIME_Discover);
end;

procedure TfrmMain.btnSendmailClick(Sender: TObject);
begin
  SendMail(memoScale, 'Cookplay - Scale Data');
end;

procedure TfrmMain.btnDisconnectScaleClick(Sender: TObject);
begin
  if oScale.IsConnected then
  begin
    oScale.DisconnectDevice;
    cboScale.Clear;
    BLE_Scale.Enabled := False;
    BLE_Scale.Enabled := True;
  end;
end;

procedure TfrmMain.btnRWClick(Sender: TObject);
begin
  oScale.SendtoDevice(cmdRW);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(oScale) then
    oScale.DisconnectDevice;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  lblKg.Text := '0.00';

  // �������� ���
  oScale := TScaleConnection.Create(self);
  oScale.OnConnected := DoScaleConnected;
  oScale.OnDisconnected := DoScaleDisconnected;
  oScale.OnAuthorized := DoScaleAuthorized;
  oScale.OnNotAuthorized := DoNotScaleAuthorized;

  oScale.OnRead := DoScaleRead;
  oScale.OnWrite := DoScaleWrite;
  oScale.OnWeight := DoScaleReadWeight;
  oScale.OnWeightChanged := DoScaleReadWeightChanged;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  cboScale.Clear;

  BLE_Scale.Enabled := True;
end;

function TestEmailIsValid(EmailAddress: String): Boolean;
var
  AtSymbolIndex : Integer;
  PeriodIndex   : Integer;
begin
  AtSymbolIndex := EmailAddress.IndexOf('@');
  PeriodIndex   := EmailAddress.IndexOf('.', AtSymbolIndex);
  Result := (AtSymbolIndex > 0) and
            (PeriodIndex > AtSymbolIndex) and
            (PeriodIndex < (EmailAddress.Length-1));
end;

procedure TfrmMain.SendMail(AMemo: TMemo; ATitle: string);
var
  ASyncService : IFMXDialogServiceASync;
  aEmail: string;
begin
  if not Assigned(AMemo) then
    Exit;

  if TPlatformServices.Current.SupportsPlatformService (IFMXDialogServiceAsync, IInterface (ASyncService)) then
  begin
    ASyncService.InputQueryAsync( '�̸����ּ�', ['�̸��� �ּҸ� �Է��ϼ���'], aEmail,
      procedure (const AResult : TModalResult; const AValues : array of string)
      begin
        case AResult of
           mrOk:
              begin
                if not TestEmailIsValid(AValues[0]) then
                begin
                  ShowMessage('�߸��� �̸��� �ּ��Դϴ�!');
                  Exit;
                end;

                aEmail := AValues[0];

                MessageDlg('���� �ϰڽ��ϱ�?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
                   procedure(const AResult: TModalResult)
                   var
                    SL: TStringList;
                   begin
                      case AResult of
                        mrYES : begin
                                  try
                                    if IdSMTP1.Connected then IdSMTP1.Disconnect;

                                    IdMessage1.Recipients.Clear;
                                    IdMessage1.Recipients.Add.Address := aEmail;
                                    IdMessage1.Subject := ATitle;
                                    IdMessage1.MessageParts.Clear;
                                    IdMessage1.Body.Text := AMemo.Lines.Text;
                                    IdSMTP1.Connect;

                                    if IdSMTP1.Authenticate then
                                    begin
                                      IdSMTP1.Send(IdMessage1);
                                      Showmessage('���Ϸ� �����Ͽ����ϴ�!');
                                    end
                                    else
                                      showmessage('���ϼ����� ������� ���Ͽ����ϴ�!' + #13 + #10 + '�ٽ� �õ��� �ֽʽÿ�!');
                                  except
                                      showmessage('���ϼ����� ������� ���Ͽ����ϴ�!' + #13 + #10 + '�ٽ� �õ��� �ֽʽÿ�!');
                                  end;

                                  if IdSMTP1.Connected then
                                    IdSMTP1.Disconnect;
                              end;
                   end;
                   SL.Free;
                end);
                end;
           mrCancel: Exit;
        end;
      end );
  end;end;

procedure TfrmMain.DoScaleAuthorized(Sender: TObject);
begin
  lblScaleAuthorized.FontColor := TAlphaColorRec.Red;
end;

procedure TfrmMain.DoScaleConnected(Sender: TObject);
begin
  lblScaleConnected.FontColor := TAlphaColorRec.Red;
end;

procedure TfrmMain.DoScaleDisconnected(Sender: TObject);
begin
  lblScaleConnected.FontColor := TAlphaColorRec.Gray;
end;

procedure TfrmMain.DoNotScaleAuthorized(Sender: TObject);
begin
  lblScaleAuthorized.FontColor := TAlphaColorRec.Gray;
end;

procedure TfrmMain.DoScaleRead(const s: string);
begin
  if chkViewReceivedString.IsChecked then
  begin
    if memoScale.Lines.Count > 100 then
      memoScale.Lines.Clear;

    memoScale.Lines.Insert(0, s);
  end;
end;

procedure TfrmMain.DoScaleReadWeight(const AMessage: TWeightMessage);
begin
  if chkViewWeight.IsChecked then
  begin
    if memoScale.Lines.Count > 100 then
      memoScale.Lines.Clear;

    // ǥ�� Kg
//    lblKg.Text := Format('%3.03f', [AMessage.Weight]);
    // 0.1g ¥��
    lblKg.Text := Format('%4.01f', [AMessage.Weight * 100]);

    memoScale.Lines.Insert(0, lblKg.Text + ' - ' + FormatDateTime('hh:nn:ss.zzz', Now));

    if AMessage.Status = wsStable then
      lblStable.TextSettings.FontColor := TAlphaColorRec.Red
    else
      lblStable.TextSettings.FontColor := TAlphaColorRec.Gray;
  end;
end;

procedure TfrmMain.DoScaleReadWeightChanged(const AMessage: TWeightMessage);
begin
  //
end;

procedure TfrmMain.DoscaleWrite(const s: string);
begin
  if chkViewSendString.IsChecked then
  begin
    if memoScale.Lines.Count > 100 then
      memoScale.Lines.Clear;

    memoScale.Lines.Insert(0, s);
  end;
end;

end.
