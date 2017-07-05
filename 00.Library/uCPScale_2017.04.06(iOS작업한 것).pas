unit uCPScale_test;
//------------------------------------------------------------------------------
//  Created by GreenScale Co, Inc.
//  Created Date: 2016.02.05
//
//  ����
//  1. ��������� �����Ͽ� ���￡ ����� ������
//  2. �������� ������ Reponse�� �ؼ��Ͽ� Event�� �߻���
//      1) OnConnected    : ���￡ ����Ǿ��� ��
//      2) OnDisconnected : ������ ������ �����Ǿ��� ��
//      3) OnAuthorized   : ����� ���� �������� �޾��� ��
//      4) OnNotAuthorized: ������ �� ������ ������ ������ ��ҵǾ��� ��
//      5) OnRead         : ���￡�� ���� ��� Reponse�� String ���� �ٲپ� ��
//      6) OnWeight       : ���￡�� ���� ���԰��� �˷� ��
//      7) OnWeightChanged: ������ ���԰��� ����Ǿ��� ��� �˷���
//                          ���ǵ� interval �ð��ȿ� ������ ���� ��� �̺�Ʈ �߻�
//  ����
//  1. TScaleConnection   : TComponent
//      1) �ٸ� Class ���� ������ ����Ϸ��� �� ��� �̿���
//      2) OnConnected, OnWeight �� �̺�Ʈ�� �߻����Ѽ� �����͸� �ٸ� Class �� ����
//      3) Timer�� �̿��Ͽ� ���������� Response�� �ؼ��� �� Event�� �߻���
//          - OnReadTimer : ��������� ������ Response �� ���԰��� ������
//                          onRead, onWeight �̺�Ʈ �߻�
//          - OnWeightChangeTimer : ���԰��� ����� �� ���ǵ� interval �ð��ȿ�
//                                  ���԰� ������ ���� ��� onWeightChangeTimer �̹��� �߻�
//          - OnAuthorityTimer    : �ݺ������� ������ ���ӵǰ� �ִ��� Ȯ���ϸ�,
//                                  ������ ���� ���� ������ ���
//                                  ���԰� ���� ��尡 Event ��尡 �ƴ� ��� TM Command �� �۽�
//              > ����� �����̸�, AU Command �� ��������� �۽�
//              > ����� ���°� �ƴϸ�, �� ���ӽõ��� ������ �� ����Ǹ� Au Command�� �۽�
//  2. TScaleLE           : TClass
//      1) ��������� ���� ����Ǵ� Class
//      2) �������� _ReceivedString �� ���������� ��� Response�� ������
//      3) �������� _ReceivedWeightStrings �� ���������� ��� ���԰��� ������
//  3. TWieghtMessage     : record
//      1) �������� ���� �����ϴ� �ִ� Record
//
//------------------------------------------------------------------------------


interface
uses System.Bluetooth, System.SysUtils, System.Types, System.Classes,
  FMX.Dialogs, FMX.Forms, FMX.Types, System.Diagnostics;

type
{$define V20}
  //---
  // AU : �������� ������
  // RW : �����Ϳ䱸
  // MZ : ���ε���
  // MT : �������
  // CT : ��� Ŭ����
  // MG : ���߷�ǥ��
  // MN : ���߷�ǥ��
  // RT : RFID ī�� ���� ���� �� ��⼳��
  // TM : ������ ���޹�� ���� (00: Stop, 01: Normal, 02: Repeat)
  // TR : �������� �ν�ǥ ����Ȯ��
  // TW : �������� �ν�ǥ �����Է�
  //---
  TScaleCommand = (cmdAU, cmdRW, cmdMZ, cmdMT, cmdCT, cmdMG, cmdMN, cmdRT, cmdTM, cmdTR, cmdTW, cmdST, cmdNT);
  TWeightStatus = (wsStable, wsUnStable, wsOverLoad, wsError);
  TTMCode = (tmEvent=0, tmNormal, tmRepeat);

  TReadEvent = procedure(const S: string) of Object;
  TWriteEvent = procedure(const S: string) of Object;
  TDiscoveryEndEvent = procedure(Sender: TObject; ADevices: TBluetoothLEDeviceList) of Object;

  TWeightMessage = record
  private
    FText: string;
    FCmd: string;
    FStatus: TWeightStatus;
    FWeightString: string;
    FBeforeWeight: double;
    FWeight: double;

    procedure Init;
    procedure SetText(const Value: string);
    function GetDifferenceSize: double;
  public
    property Text: string read FText write SetText;
    property Status: TWeightStatus read FStatus;
    property Weight: double read FWeight;
    property BeforeWeight: double read FBeforeWeight write FBeforeWeight;
    property WeightString: string read FWeightString;
    property DifferenceSize: double read GetDifferenceSize;
  end;

  TWeightEvent = procedure(const AWeight: TWeightMessage) of Object;
  TWeightChangeEvent = procedure(const Weight: Double) of object;

  TScaleConnectionInfo = record
    DeviceName: string;
    ServiceUUID: TBluetoothUUID;
    ReadUUID: TBluetoothUUID;
    WriteUUID: TBluetoothUUID;
    SendAU: Boolean;  // Authorize Mode
    SendTM: Boolean;  // Transfer Mode
    SendST: Boolean;  // ���۽��� ���
    UseEncryption: Boolean;
  end;

  TScaleInfo = record
    DeviceName: string;
    Address: string;
  public
    procedure Clear;
    function IsAssigned: Boolean;
    function IsSame(sName, sAddress: string): Boolean;
  end;

  TScaleLE = class
  private
    oDevice: TBluetoothLEDevice;
    FScaleConnectionInfo: TScaleConnectionInfo;

    FMacString: string;
    FKey: BYTE;
    FKeyString: string;
    FReceivedBytes: TBytes;

    FOnConnected: TNotifyEvent;
    FOnDisconnected: TNotifyEvent;
    FOnAuthorized: TNotifyEvent;
    FOnNotAuthorized: TNotifyEvent;

    FConnectedService: Boolean;
    FAuthorized: Boolean;
    FEventMode: Boolean;

    FWeightGattService: TBluetoothGattService;
    FWeightReadCharacteristic: TBluetoothGattCharacteristic;
    FWeightWriteCharacteristic: TBluetoothGattCharacteristic;

    function GetConnected: Boolean;
    procedure MakingString(msg: TBytes);

    procedure DoConnected(Sender: TObject);
    procedure DoDisconnected(Sender: TObject);
    procedure DoAuthorized(Sender: TObject);
    procedure DoNotAuthorized(Sender: TObject);
    procedure DoCharacteristicRead(const Sender: TObject;
      const ACharacteristic: TBluetoothGattCharacteristic;
      AGattStatus: TBluetoothGattStatus);
    function GetConnectedCharacteristic: Boolean;
  public
    function SetScale(Value: TBluetoothLEDevice): Boolean;
    function GetService: Boolean;
    function SendtoDevice(Cmd: TScaleCommand; Code: TTMCode=tmEvent; TagString: string=''): string;
    function SendtoDeviceString(str: string): string;
    property IsConnected: Boolean read GetConnected;
    property IsConnectedCharacteristic: Boolean read GetConnectedCharacteristic;
    property IsAuthorized: Boolean read FAuthorized;
    property IsEventMode: Boolean read FEventMode;
    property MacString: string read FMacString write FMacString;
    property KeyString: string read FKeyString;
    property OnConnected: TNotifyEvent read FOnConnected write FOnConnected;
    property OnDisconnected: TNotifyEvent read FOnDisconnected write FOnDisconnected;
    property OnAuthorized: TNotifyEvent read FOnAuthorized write FOnAuthorized;
    property OnNotAuthorized: TNotifyEvent read FOnNotAuthorized write FOnNotAuthorized;
  end;

  TScaleConnection = class(TComponent)
  private
    FLastConnectedScale: TScaleInfo;

    oScale: TScaleLE;

    FOnConnected: TNotifyEvent;
    FOnDisconnected: TNotifyEvent;
    FOnAuthorized: TNotifyEvent;
    FOnNotAuthorized: TNotifyEvent;
    FOnRead: TReadEvent;
    FOnWrite: TWriteEvent;
    FOnWeight: TWeightEvent;
    FOnWeightChanged: TWeightEvent;
    FOnNextButton: TNotifyEvent;

    oReadTimer: TTimer;
    oWeightChangeTimer: TTimer;
    oAuthorityTimer: TTimer;

    function SetConnectionInfo(SelectedDevice: TBluetoothLEDevice): Boolean;
    procedure SetProtocol;
    procedure DoConnected(Sender: TObject);
    procedure DoDisconnected(Sender: TObject);
    procedure DoAuthorized(Sender: TObject);
    procedure DoNotAuthorized(Sender: TObject);
    procedure DoReadTimer(Sender: TObject);
    procedure DoWeightChangeTimer(Sender: TObject);
    procedure DoAuthorityTimer(Sender: TObject);
    function GetScaleAddress: string;
    function GetScaleName: string;
  public
    constructor Create(AOwner: TComponent); override;
    function IsCertifiedScale(sDeviceName: string): Boolean;
    function ConnectDevice(SelectedDevice: TBluetoothLEDevice): Boolean;
    procedure DisconnectDevice;
    function IsConnected: Boolean;
    procedure GetWeight;
    procedure SendtoDevice(Cmd: TScaleCommand);
    procedure SendtoDeviceString(str: string);
    property LastConnectedScale: TScaleInfo read FLastConnectedScale;
    property ScaleName: string read GetScaleName;
    property ScaleAddress: string read GetScaleAddress;
    property OnConnected: TNotifyEvent read FOnConnected write FOnConnected;
    property OnDisconnected: TNotifyEvent read FOnDisconnected write FOnDisconnected;
    property OnAuthorized: TNotifyEvent read FOnAuthorized write FOnAuthorized;
    property OnNotAuthorized: TNotifyEvent read FOnNotAuthorized write FOnNotAuthorized;
    property OnWrite: TWriteEvent read FOnWrite write FOnWrite;
    property OnRead: TReadEvent read FOnRead write FOnRead;
    property OnWeight: TWeightEvent read FOnWeight write FOnWeight;
    property OnWeightChanged: TWeightEvent read FOnWeightChanged write FOnWeightChanged;
    property OnNextButton: TNotifyEvent read FOnNextButton write FOnNextButton;
  end;

const
  BLE: array[0..5] of TScaleConnectionInfo = (
    ( // 0 - GS_BLE - HM10
     DeviceName     : 'GS_BLE';
     ServiceUUID    : '{0000FFE0-0000-1000-8000-00805F9B34FB}';
     ReadUUID       : '{0000FFE1-0000-1000-8000-00805F9B34FB}';
     WriteUUID      : '{0000FFE1-0000-1000-8000-00805F9B34FB}';
     SendAU         : True;  // Authorize Mode
     SendTM         : True;  // Transfer Mode
     SendST         : True;  // ���۽��� ���
     UseEncryption  : True;
    ),
   ( // 1 - GREENSCALE - Nordic
     DeviceName     : 'GREENSCALE';
     ServiceUUID    : '{6E400001-B5A3-F393-E0A9-E50E24DCCA9E}';
     ReadUUID       : '{6E400003-B5A3-F393-E0A9-E50E24DCCA9E}';
     WriteUUID      : '{6E400002-B5A3-F393-E0A9-E50E24DCCA9E}';
     SendAU         : True;  // Authorize Mode
     SendTM         : True;  // Transfer Mode
     SendST         : True;  // ���۽��� ���
     UseEncryption  : True;
   ),
   ( // 2 - DAEPUNG-E - Nordic
     DeviceName     : 'DAEPUNG-E';
     ServiceUUID    : '{6E400001-B5A3-F393-E0A9-E50E24DCCA9E}';
     ReadUUID       : '{6E400003-B5A3-F393-E0A9-E50E24DCCA9E}';
     WriteUUID      : '{6E400002-B5A3-F393-E0A9-E50E24DCCA9E}';
     SendAU         : True;  // Authorize Mode
     SendTM         : True;  // Transfer Mode
     SendST         : True;  // ���۽��� ���
     UseEncryption  : True;
   ),
    ( // 3 - CookPlay - HM10
     DeviceName     : 'COOKPLAY';
     ServiceUUID    : '{0000FFE0-0000-1000-8000-00805F9B34FB}';
     ReadUUID       : '{0000FFE1-0000-1000-8000-00805F9B34FB}';
     WriteUUID      : '{0000FFE1-0000-1000-8000-00805F9B34FB}';
     SendAU         : True;  // Authorize Mode
     SendTM         : True;  // Transfer Mode
     SendST         : True;  // ���۽��� ���
     UseEncryption  : True;
    ),
   ( // 4- CookPlayQ1 - Nordic
     DeviceName     : 'COOKPLAYQ1';
     ServiceUUID    : '{6E400001-B5A3-F393-E0A9-E50E24DCCA9E}';
     ReadUUID       : '{6E400003-B5A3-F393-E0A9-E50E24DCCA9E}';
     WriteUUID      : '{6E400002-B5A3-F393-E0A9-E50E24DCCA9E}';
     SendAU         : False;  // Authorize Mode
     SendTM         : False;  // Transfer Mode
     SendST         : True;  // ���۽��� ���
     UseEncryption  : False;
   ),
   ( // 5- CookPlayQ2 - Nordic
     DeviceName     : 'COOKPLAYQ2';
     ServiceUUID    : '{6E400001-B5A3-F393-E0A9-E50E24DCCA9E}';
     ReadUUID       : '{6E400003-B5A3-F393-E0A9-E50E24DCCA9E}';
     WriteUUID      : '{6E400002-B5A3-F393-E0A9-E50E24DCCA9E}';
     SendAU         : False;  // Authorize Mode
     SendTM         : False;  // Transfer Mode
     SendST         : True;  // ���۽��� ���
     UseEncryption  : False;
   )
  );

  READING_INTERVAL = 50;
  CHANGE_INTERVAL = 200;
  AUTHORITY_INTERVAL = 3000;
  EVENTMODE_INTERVAL = 100;
var
  _ReceivedWeightStrings: TStringList;
  _ReceivedStrings: TStringList;
  _LastWeight: TWeightMessage;

implementation
{ TDeviceInfo }

procedure Delay(ms: integer);
var
  StopWatch: TStopWatch;
begin
  StopWatch := TStopWatch.Create;

  StopWatch.Start;
  repeat
    Application.ProcessMessages;
    Sleep(1);
  until StopWatch.ElapsedMilliseconds >= ms;
end;

constructor TScaleConnection.Create(AOwner: TComponent);
begin
  inherited;

  _ReceivedWeightStrings := TStringList.Create;
  _ReceivedStrings := TStringList.Create;

  _LastWeight.Init;

  oReadTimer := TTimer.Create(self);
  oReadTimer.Enabled := False;
  oReadTimer.Interval := READING_INTERVAL;
  oReadTimer.OnTimer := DoReadTimer;

  oWeightChangeTimer := TTimer.Create(self);
  oWeightChangeTimer.Enabled := False;
  oWeightChangeTimer.Interval := CHANGE_INTERVAL;
  oWeightChangeTimer.OnTimer := DoWeightChangeTimer;

  oAuthorityTimer := TTimer.Create(self);
  oAuthorityTimer.Enabled := False;
  oAuthorityTimer.Interval := AUTHORITY_INTERVAL;
  oAuthorityTimer.OnTimer := DoAuthorityTimer;
end;

procedure TScaleConnection.DisconnectDevice;
//------------------------------------------------------------------------------
//  DisconnectDevice : ����ڰ� ������ Device ������ ���´�
//------------------------------------------------------------------------------
begin
  if Assigned(oScale) and Assigned(oScale.oDevice) then
  begin
    oScale.oDevice.Disconnect;
//      oScale.FOnDisconnected(self);
  end;
end;

procedure TScaleConnection.DoAuthorityTimer(Sender: TObject);
//------------------------------------------------------------------------------
//  �ֱ������� ������ �Ǿ����� Ȯ�� �� ���α��� �����Ѵ�
//  Event ���� �ڵ� ��ȯ ��Ų��
//
//  1. AuthorityTimer �� ����Ǵ� ���� ��������� ������ �̷�������ٴ� ���� �ǹ��Ѵ�
//  2. ������ ���� ������ ������ ������ ����
//      1) Characteristic ������ �Ǿ� �ְ�, ���θ� ���� ���� ���
//          - Weight Timer ON
//          - Authority Timer ON
//      2) Disconnect �� ���Ͽ� oScale.Free �� ����
//          - Weight Timer OFF
//          - oScale = nil
//          - FAuthorized = False
//------------------------------------------------------------------------------
var
  str: string;
begin
  if (not Assigned(oScale)) or (not oScale.IsConnectedCharacteristic) then
    Exit;

  if (not oScale.IsAuthorized) and oScale.FScaleConnectionInfo.SendAU then
  begin
    str := oScale.SendtoDevice(cmdAU);
    if (str <> '') and Assigned(FOnWrite) then
      FOnWrite(str);
    delay(50);

    str := oScale.SendtoDevice(cmdAU);
    if (str <> '') and Assigned(FOnWrite) then
      FOnWrite(str);
    delay(50);
  end;

  if (not oScale.IsEventMode) and oScale.FScaleConnectionInfo.SendTM then
  begin
    str := oScale.SendtoDevice(cmdTM, tmEvent);
    if (str <> '') and Assigned(FOnWrite) then
      FOnWrite(str);
  end;
end;

procedure TScaleConnection.DoAuthorized(Sender: TObject);
begin
  if Assigned(FOnAuthorized) then
    FOnAuthorized(self);
end;

procedure TScaleConnection.DoConnected(Sender: TObject);
var
  str: string;
begin
  // ������ ����� ���� ������ �����Ѵ�
  FLastConnectedScale.DeviceName := oScale.oDevice.DeviceName;
  FlastConnectedScale.Address := oScale.oDevice.Address;

  if Assigned(FOnConnected) then
    FOnConnected(self);
end;

procedure TScaleConnection.DoReadTimer(Sender: TObject);
//------------------------------------------------------------------------------
//  �߻��� ������ �� ���԰��� ���� Event�� �߻��Ѵ�
//------------------------------------------------------------------------------
begin
  // ���� �� ó��
  while _ReceivedStrings.Count > 0 do
  begin
    if Assigned(FOnRead) then
      FOnRead(_ReceivedStrings[0]);

    // Next Button Event ó��
    if Assigned(FOnNextButton) and (copy(_ReceivedStrings[0], 1, 2) = 'NT') then
      FOnNextButton(Sender);

    _ReceivedStrings.Delete(0);
  end;

  // ���԰��� �Ѱ��ش�
  while _ReceivedWeightStrings.Count > 0 do
  begin
    oWeightChangeTimer.Enabled := False;  // ���԰� ���� Timer OFF, 0.2�� �ȿ� ���� ����Ǹ� �ٽ� reset

    _LastWeight.Text := _ReceivedWeightStrings.Strings[0];

    if Assigned(FOnWeight) then
      FOnWeight(_LastWeight);

    _ReceivedWeightStrings.Delete(0);
    oWeightChangeTimer.Enabled := True; // ���԰� ���� Timer ON, 0.2�� �ȿ� �� ������ ������ timer �ߵ�
  end;
end;

function TScaleConnection.GetScaleAddress: string;
begin
  if Assigned(oScale) and Assigned(oScale.oDevice) then
    result := oScale.oDevice.Address
  else
    result := '';
end;

function TScaleConnection.GetScaleName: string;
begin
  if Assigned(oScale) and Assigned(oScale.oDevice) then
    result := oScale.oDevice.DeviceName
  else
    result := '';
end;

procedure TScaleConnection.GetWeight;
var
  str: string;
begin
  if Assigned(oScale) then
  begin
    str := oScale.SendtoDevice(cmdRW);
    if (str <> '') and Assigned(FOnWrite) then
      FOnWrite(str);
  end;
end;

function TScaleConnection.IsCertifiedScale(sDeviceName: string): Boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to Length(BLE)-1 do
    if Uppercase(BLE[i].DeviceName) = Uppercase(sDeviceName) then
    begin
      result := True;
      break;
    end;
end;

function TScaleConnection.IsConnected: Boolean;
begin
  if ( not Assigned(oScale) ) or ( not Assigned(oScale.oDevice) ) then
    result := false
  else
    result := oScale.oDevice.IsConnected;
end;

procedure TScaleConnection.SendtoDevice(Cmd: TScaleCommand);
var
  str: string;
begin
  if Assigned(oScale) and Assigned(oScale.oDevice) then
  begin
    str := oScale.SendtoDevice(Cmd);

    if (str <> '') and Assigned(FOnWrite) then
      FOnWrite(str);
  end;
end;

procedure TScaleConnection.SendtoDeviceString(str: string);
var
  s: string;
begin
  s := oScale.SendtoDeviceString(str);
  if (s <> '') and Assigned(FOnWrite) then
    FOnWrite(s);
end;

function TScaleConnection.SetConnectionInfo(
  SelectedDevice: TBluetoothLEDevice): Boolean;
var
  i: integer;
begin
  // �������� ���������� �����Ѵ�.
  result := false;
  for i := 0 to Length(BLE)-1 do
    if Uppercase(BLE[i].DeviceName) = Uppercase(SelectedDevice.DeviceName) then
    begin
      oScale.FScaleConnectionInfo.DeviceName := Uppercase(BLE[i].DeviceName);
      oScale.FScaleConnectionInfo.ServiceUUID := BLE[i].ServiceUUID;
      oScale.FScaleConnectionInfo.ReadUUID := BLE[i].ReadUUID;
      oScale.FScaleConnectionInfo.WriteUUID := BLE[i].WriteUUID;
      oScale.FScaleConnectionInfo.SendAU := BLE[i].SendAU;
      oScale.FScaleConnectionInfo.SendTM := BLE[i].SendTM;
      oScale.FScaleConnectionInfo.SendST := BLE[i].SendST;
      oScale.FScaleConnectionInfo.UseEncryption := BLE[i].UseEncryption;

      result := True;
    end;
end;

procedure TScaleConnection.SetProtocol;
var
  str: string;
begin
  // �����õ�
  if oScale.FScaleConnectionInfo.SendAU then
  begin
    str := oScale.SendtoDevice(cmdAU);
    if (str <> '') and Assigned(FOnWrite) then
      FOnWrite(str);
    delay(50);

    str := oScale.SendtoDevice(cmdAU);
    if (str <> '') and Assigned(FOnWrite) then
      FOnWrite(str);
    delay(50);
  end;

  // Event���� ����
  if oScale.FScaleConnectionInfo.SendTM then
  begin
    str := oScale.SendtoDevice(cmdTM, tmEvent);
    if (str <> '') and Assigned(FOnWrite) then
      FOnWrite(str);
    delay(50);
  end;

  // �������￡ ���� ���� ��� ����
  if oScale.FScaleConnectionInfo.SendST then
  begin
    str := oScale.SendtoDevice(cmdST);
    if (str <> '') and Assigned(FOnWrite) then
      FOnWrite(str);
    delay(50);

    str := oScale.SendtoDevice(cmdST);
    if (str <> '') and Assigned(FOnWrite) then
      FOnWrite(str);
    delay(50);
  end;

  // Timer �� �����Ѵ�    // 2016.04.29
  oReadTimer.Enabled := True;
  oWeightChangeTimer.Enabled := True;

  // ������ �ʿ��� ��� Ÿ�̸Ӹ� �����Ų��
  if oScale.FScaleConnectionInfo.SendAU then
    oAuthorityTimer.Enabled := True;
end;

procedure TScaleConnection.DoWeightChangeTimer(Sender: TObject);
begin
  oWeightChangeTimer.Enabled := False;

  if Assigned(FOnWeightChanged) and (_LastWeight.DifferenceSize > 0) then
  begin
    FOnWeightChanged(_LastWeight);

    _LastWeight.BeforeWeight := _LastWeight.Weight;
  end;
end;

procedure TScaleConnection.DoDisconnected(Sender: TObject);
begin
  // ��� Timer�� �����Ѵ�
  oReadTimer.Enabled := False;
  oWeightChangeTimer.Enabled := False;
  oAuthorityTimer.Enabled := False;

  // ���� ������ ���ְ�, Event �� �߻���Ų��
  if oScale.IsAuthorized then
    oScale.DoNotAuthorized(self);

  // �ֱ� ���� ���¸� Clear �Ѵ�
  FLastConnectedScale.Clear;

  if Assigned(oScale) and oScale.IsConnected then
  begin
//    oScale.oDevice.Disconnect;
    oScale.oDevice.OnDisconnect := nil;
    oScale.oDevice.OnConnect := nil;
    oScale.oDevice.OnCharacteristicRead := nil;

    oScale.FWeightReadCharacteristic := nil;
    oScale.FWeightWriteCharacteristic := nil;
    oSCale.FWeightGattService := nil;

    oScale.oDevice := nil;
  end;

  // ���������� Free �Ѵ�
  oScale.Free;

  if Assigned(FOnDisconnected) then
    FOnDisconnected(self);
end;

procedure TScaleConnection.DoNotAuthorized(Sender: TObject);
begin
  if Assigned(FOnNotAuthorized) then
    FOnNotAuthorized(self);
end;

//------------------------------------------------------------------------------
//  ConnectDevice : ����� �����ϱ� ���Ͽ� ȣ��ȴ�
//
//  1. ȣ��Ǵ� ����
//      - ó�� ���￡ ������ ��
//      - �߰��� Disconnect �Ǿ� �ٽ� ���� �� ��
//      - �������� �ߺ��Ͽ� ȣ�� �� ��
//------------------------------------------------------------------------------
function TScaleConnection.ConnectDevice(SelectedDevice: TBluetoothLEDevice): Boolean;
begin
  if not Assigned(SelectedDevice) then
  begin
    result := False;
    exit;
  end;

  // ���� �۵����� ����� ���� ������ ��� ���� ���� �������� �ʴ´�
  if Assigned(oScale) and oScale.IsAuthorized
    and FLastConnectedScale.IsSame(SelectedDevice.DeviceName, SelectedDevice.Address) then
  begin
    result := True;
    Exit;
  end;

  // ���� ���������� �Ҵ�Ǿ� ������, ���� ���� �Ѵ�
  if Assigned(oScale) then
    DisconnectDevice;

  // ���������� �����Ѵ�
  if not Assigned(oScale) then
  begin
    oScale := TScaleLE.Create;
    oScale.FOnConnected := DoConnected;
    oScale.FOnDisconnected := DoDisconnected;
    oScale.FOnAuthorized := DoAuthorized;
    oScale.FOnNotAuthorized := DoNotAuthorized;
  end;

  // �������� ���������� �����ϰ�, ������ �õ��Ѵ�
  if SetConnectionInfo(SelectedDevice) and oScale.SetScale(SelectedDevice) then
  begin
    SetProtocol;
    result := True
  end
  else
  begin
    if Assigned(oScale.oDevice) then
      oScale.oDevice.Disconnect;

    result := False;
  end;
end;

{ TLastWeightMessage }

function TWeightMessage.GetDifferenceSize: double;
begin
  result := Abs(FBeforeWeight - FWeight);
end;

procedure TWeightMessage.Init;
begin
  FText := '';
  FCmd := '';
  FStatus := wsUnStable;
  FWeightString := '';
  FWeight := 0;
end;

procedure TWeightMessage.SetText(const Value: string);
var
  sStatus: string;
begin
  StringReplace(Value, Chr($0D), '', [rfReplaceAll]);
  StringReplace(Value, Chr($0A), '', [rfReplaceAll]);

  if Value.Length = 17 then
  begin
    FText := Value;
    FCmd := copy(FText, 1, 2);
    sStatus := copy(FText, 4,2);
    if sStatus = 'ST' then
      FStatus := wsStable
    else if sStatus = 'US' then
      FStatus := wsUnStable
    else if sStatus = 'OL' then
      FStatus := wsOverLoad
    else
      FStatus := wsError;

    FWeightString := copy(FText, 10, 8);
    FWeight := FWeightString.ToDouble;
  end;
end;

{ TScaleDevice }

procedure TScaleLE.DoAuthorized(Sender: TObject);
begin
  FAuthorized := True;

  if Assigned(FOnAuthorized) then
    FOnAuthorized(self);
end;

procedure TScaleLE.DoCharacteristicRead(const Sender: TObject;
  const ACharacteristic: TBluetoothGattCharacteristic;
  AGattStatus: TBluetoothGattStatus);
var
  FromReceived: TBytes;
  Del0D, Del0A: BYTE;
  FromSize, ReceivedSize: integer;
begin
  if (AGattStatus <> TBluetoothGattStatus.Success) then
    Exit;

  FromReceived := ACharacteristic.GetValue;


  FromSize := Length(FromReceived);

  if FromSize < 1 then
    Exit;

  FReceivedBytes := FReceivedBytes + FromReceived;

  ReceivedSize := Length(FReceivedBytes);

  if ReceivedSize > 2 then
  begin
    Del0D := FReceivedBytes[ReceivedSize-2];
    Del0A := FReceivedBytes[ReceivedSize-1];

    if (Del0D = $0D) and (Del0A = $0A) then
    begin
      MakingString(FReceivedBytes);
      SetLength(FReceivedBytes, 0);
    end;
  end;
end;

procedure TScaleLE.DoConnected(Sender: TObject);
begin
  if Assigned(FOnConnected) then
    FOnConnected(self);
end;

procedure TScaleLE.DoDisconnected(Sender: TObject);
begin
  if Assigned(FOnDisconnected) then
    FOnDisconnected(Sender);
end;

procedure TScaleLE.DoNotAuthorized(Sender: TObject);
begin
  FAuthorized := False;
  FEventMode := False;

  if Assigned(FOnNotAuthorized) then
    FOnNotAuthorized(self);
end;

function TScaleLE.GetConnected: Boolean;
begin
  result := Assigned(oDevice) and oDevice.IsConnected;
end;

function TScaleLE.GetConnectedCharacteristic: Boolean;
begin
  result := Assigned(FWeightReadCharacteristic);
end;

function TScaleLE.GetService: Boolean;
begin
  result := False;

  if IsConnected and oDevice.DiscoverServices then
  begin
    FWeightGattService := oDevice.GetService(FScaleConnectionInfo.ServiceUUID);// GetServiceGUID(oDevice.DeviceName));
    delay(20);

    if Assigned(FWeightGattService) and (FWeightGattService.Characteristics.Count > 0) then
    begin
      FWeightReadCharacteristic := FWeightGattService.GetCharacteristic(FScaleConnectionInfo.ReadUUID);// GetReadGUID(oDevice.DeviceName));
      delay(20);
      FWeightWriteCharacteristic := FWeightGattService.GetCharacteristic(FScaleConnectionInfo.WriteUUID);// GetWriteGUID(oDevice.DeviceName));
      delay(20);
      if FWeightReadCharacteristic <> nil then
      begin
        oDevice.OnCharacteristicRead := DoCharacteristicRead;
        delay(20);
        if oDevice.SetCharacteristicNotification(FWeightReadCharacteristic, True) then
        begin
          FConnectedService := True;
          result := True;
        end;
      end;
    end;
  end;
end;

procedure TScaleLE.MakingString(msg: TBytes);
var
  i: integer;
  str: string;
begin
  SetLength(msg, length(msg)-2); // Delete 0x0D, 0x0A

  str := '';
  for i := 0 to Length(msg)-1 do
  begin
    if FScaleConnectionInfo.UseEncryption then
      msg[i] := msg[i] xor FKey;

    if (msg[i] > $20) and (msg[i] < $7F) then
      str := str + char(msg[i])
    else
      str := str + '0';
  end;

  if str.Length > 0 then
  begin
    _ReceivedStrings.Add(str);

    if copy(str, 1, 2) = 'RW' then
      _ReceivedWeightStrings.Add(str)
    else if copy(str, 1, 4) = 'AU,A'  then
      DoAuthorized(self)
    else if copy(str, 1, 4) = 'TM,A' then
      FEventMode := True;
  end;
end;

function TScaleLE.SendtoDevice(Cmd: TScaleCommand; Code: TTMCode;
  TagString: string): string;
var
  CmdStr: string;
  CodeStr: string;
begin
  result := '';

  if FWeightReadCharacteristic = nil then
    Exit;

  CodeStr := IntToHex(BYTE(Code), 2);

  case cmd of
    cmdAU: CmdStr := 'AU,' + KeyString + ',' + MACString;    // AU : �������� ������
    cmdRW:  // RW : �����Ϳ䱸
      begin
        if FScaleConnectionInfo.SendAU then
          CmdStr := 'RW,' + KeyString
        else
          CmdStr := 'RW,00'
      end;
    cmdMZ:  // MZ : ���ε���
      begin
        if FScaleConnectionInfo.SendAU then
          CmdStr := 'MZ,' + KeyString
        else
          CmdStr := 'MZ,00'
      end;
    cmdMT: CmdStr := 'MT,' + KeyString;  // MT : �������
    cmdCT: CmdStr := 'CT,' + KeyString;  // CT : ��� Ŭ����
    cmdMG: CmdStr := 'MG,' + KeyString;  // MG : ���߷�ǥ��
    cmdMN: CmdStr := 'MN,' + KeyString;  // MN : ���߷�ǥ��
    cmdRT: CmdStr := 'RT,' + KeyString;  // RT : RFID ī�� ���� ���� �� ��⼳��
    {$IfDef V20}
      cmdTM: CmdStr := 'TM,' + KeyString + ',' + CodeStr + ',0100';  // TM : ������ ���޹�� ���� (00: Stop, 01: Normal, 02: Repeat)
    {$Else}
      cmdTM: CmdStr := 'TM,' + KeyString + ',' + CodeStr;  // TM : ������ ���޹�� ���� (00: Stop, 01: Normal, 02: Repeat)
    {$EndIf}
    cmdTR: CmdStr := 'TR,' + KeyString + ',' + CodeStr;  // TR : �������� �ν�ǥ ����Ȯ��
    cmdTW: CmdStr := 'TW,' + CodeStr + ',' + TagString;  // TW : �������� �ν�ǥ �����Է�
    cmdST: CmdStr := 'ST,00';
    else
      CmdStr := '';
  end;

  if CmdStr <> '' then
  begin
    CmdStr := CmdStr + #13 + #10;

    FWeightWriteCharacteristic.SetValueAsString(CmdStr);
    oDevice.WriteCharacteristic(FWeightWriteCharacteristic);

    result := CmdStr;
  end;
end;

function TScaleLE.SendtoDeviceString(str: string): string;
begin
  result := '';
  if str <> '' then
  begin
    str := str + #13 + #10;

    FWeightWriteCharacteristic.SetValueAsString(str);
    oDevice.WriteCharacteristic(FWeightWriteCharacteristic);

    result := str;
  end;
end;

function TScaleLE.SetScale(Value: TBluetoothLEDevice): Boolean;
var
  i: integer;
  sTemp: string;
  aMAC: array [0..6] of BYTE;
begin
  if Assigned(Value) then
  begin
    oDevice := Value;
    oDevice.OnDisconnect := DoDisconnected;
    oDevice.OnConnect := DoConnected;

    if FScaleConnectionInfo.SendAU then
    begin
      FMACString := StringReplace(oDevice.Address, ':', '', [rfReplaceAll]);

      for i := 0 to 5 do
      begin
        sTemp := copy(FMACString, i*2+1, 2);
        aMac[i] := BYTE(strtoint('$'+sTemp));
        FKey := FKey xor aMac[i];
        FKeyString := char((FKey shr 4) + $30) + char((FKey and $0F) + $30);
      end;
    end
    else
    begin
      FMACString := '000000000000';
      FKey := 0;
      FKeyString := '00';
    end;
  end;

  if Assigned(oDevice) and oDevice.Connect and oDevice.DiscoverServices then
  begin
    FWeightGattService := oDevice.GetService(FScaleConnectionInfo.ServiceUUID);

    if Assigned(FWeightGattService) and (FWeightGattService.Characteristics.Count > 0) then
    begin
      FWeightReadCharacteristic := FWeightGattService.GetCharacteristic(FScaleConnectionInfo.ReadUUID);
      FWeightWriteCharacteristic := FWeightGattService.GetCharacteristic(FScaleConnectionInfo.WriteUUID);
      if FWeightReadCharacteristic <> nil then
      begin
        oDevice.OnCharacteristicRead := DoCharacteristicRead;

        if oDevice.SetCharacteristicNotification(FWeightReadCharacteristic, True) then
        begin
          FConnectedService := True;
          result := True;
        end
        else
          result := false;
      end;
    end
    else
      result := true;
  end
  else
    result := false;
end;

{ TScaleInfo }

procedure TScaleInfo.Clear;
begin
  DeviceName := '';
  Address := '';
end;

function TScaleInfo.IsAssigned: Boolean;
begin
  result := DeviceName <> '';
end;

function TScaleInfo.IsSame(sName, sAddress: string): Boolean;
begin
  result := (sName = DeviceName) and (sAddress = Address);
end;

end.
