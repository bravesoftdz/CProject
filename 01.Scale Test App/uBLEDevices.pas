unit uBLEDevices;
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
//      8) OnVolume       : ü���� �߻� ��
//      9) OnBarcode      : ���ڵ尪 �߻� ��
//      10)OnCalibration  : ü�� Calibration �� ����� �߻� ��
//  ����
//  1. TDeviceConnection   : TComponent
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
//  2. TDeviceLE           : TClass
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
  TScaleCommand = (cmdAU, cmdRW, cmdMZ, cmdMT, cmdCT, cmdMG, cmdMN, cmdRT, cmdTM, cmdTR, cmdTW, cmdST, cmdVO, cmdBC, cmdCA, cmdBX);
  TWeightStatus = (wsStable, wsUnStable, wsOverLoad, wsError);
  TTMCode = (tmEvent=0, tmNormal, tmRepeat);
  TDeviceKind = (dNone=-1, dScale, dVolume, dBarcode);

  TReadEvent = procedure(const S: string) of Object;
  TDiscoveryEndEvent = procedure(Sender: TObject; ADevices: TBluetoothLEDeviceList) of Object;
  TDeviceConnection = class;

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

  TVolumeMessage = record
  private
    FText: string;
    FWidth: integer;
    FLength: integer;
    FHeight: integer;
    FVolume: integer;

    procedure Init;
    procedure SetText(const Value: string);
  public
    property Text: string read FText write SetText;
    property Width: integer read FWidth;
    property Length: integer read FLength;
    property Height: integer read FHeight;
    property Volume: integer read FVolume;
  end;

  TCalibrationMessage = record
  private
    FText: string;
    FVelocity: integer;
    FLength: integer;

    procedure Init;
    procedure SetText(const Value: string);
  public
    property Text: string read FText write SetText;
    property Velocity: integer read FVelocity;
    property Length: integer read FLength;
  end;

  TBarcodeMessage = record
  private
    FText: string;
    FBarcode: string;

    procedure Init;
    procedure SetText(const Value: string);
  public
    property Text: string read FText write SetText;
    property Barcode: string read FBarcode;
  end;

  TWeightEvent = procedure(const AWeight: TWeightMessage) of Object;
  TWeightChangeEvent = procedure(const Weight: Double) of object;

  TVolumeEvent = procedure(const AVolume: TVolumeMessage) of Object;
  TCalibrationEvent = procedure(const ACalibration: TCalibrationMessage) of object;
  TBarcodeEvent = procedure(const ABarcode: TBarcodeMessage) of object;

  TDeviceLE = class
  private
    oParent: TDeviceConnection;
    oLEDevice: TBluetoothLEDevice;
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
    procedure MakingString(AKind: TDeviceKind; msg: TBytes);

    procedure DoConnected(Sender: TObject);
    procedure DoDisconnected(Sender: TObject);
    procedure DoAuthorized(Sender: TObject);
    procedure DoNotAuthorized(Sender: TObject);
    procedure DoCharacteristicRead(const Sender: TObject;
      const ACharacteristic: TBluetoothGattCharacteristic;
      AGattStatus: TBluetoothGattStatus);
    function GetConnectedCharacteristic: Boolean;
    function GetUsingCertification: Boolean;
    function GetUsingEncryption: Boolean;
    function GetDeviceKind: TdeviceKind;

  public
    constructor Create(AParent: TDeviceConnection);
    function SetScale(const Value: TBluetoothLEDevice): Boolean;
    function GetService: Boolean;
    procedure SendtoDevice(Cmd: TScaleCommand; Code: TTMCode=tmEvent; TagString: string='');

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

    property DeviceKind: TdeviceKind read GetDeviceKind;
    property usingCertification: Boolean read GetUsingCertification;
    property usingEncryption: Boolean read GetUsingEncryption;    
  end;

  TDeviceProperty = record
    DeviceKind: TDeviceKind;  // 0: Scale, 1: Volumn, 2: Barcode
    DeviceName: string;
    Service: TBluetoothUUID;
    Read: TBluetoothUUID;
    Write: TBluetoothUUID;
    usingCertification: Boolean;
    usingEncryption: Boolean;
  end;

  TDeviceInfo = record
    DeviceName: string;
    Address: string;
  public
    procedure Clear;
    function IsAssigned: Boolean;
    function IsSame(sName, sAddress: string): Boolean;
  end;

  TDeviceConnection = class(TComponent)
  private
    FBluetoothLEManager: TBluetoothLEManager;

    FLastConnectedDevice: TDeviceInfo;

    oDevice: TDeviceLE;

    FOnConnected: TNotifyEvent;
    FOnDisconnected: TNotifyEvent;
    FOnAuthorized: TNotifyEvent;
    FOnNotAuthorized: TNotifyEvent;

    FOnRead: TReadEvent;
    FOnReadWeight: TWeightEvent;
    FOnReadWeightChanged: TWeightEvent;
    FOnReadVolume: TVolumeEvent;
    FOnReadCalibration: TCalibrationEvent;
    FOnReadBarcode: TBarcodeEvent;

    oReadTimer: TTimer;
    oWeightChangeTimer: TTimer;
    oAuthorityTimer: TTimer;

    function FindDevice(const ADevices: TBluetoothLEDeviceList; DeviceName, DeviceMacAddress: string): TBluetoothLEDevice;
    procedure DevicesDiscoveryLEEnd(const Sender: TObject; const ADevices: TBluetoothLEDeviceList);
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
    FReceivedStrings: TStringList;
//    FReceivedHexaStrings: TStringList;
    FReceivedWeightStrings: TStringList;
    FReceivedVolumeStrings: TStringList;
    FReceivedCalibrationStrings: TStringList;
    FReceivedBarcodeStrings: TStringList;

    FLastWeight: TWeightMessage;
    FVolume: TVolumeMessage;
    FCalibration: TCalibrationMessage;
    FBarcode: TBarcodeMessage;

    procedure SendtoDevice(Cmd: TScaleCommand=cmdAU; Code: TTMCode=tmEvent; TagString: string='');
    procedure SendToDeviceCalibration;
    constructor Create(AOwner: TComponent); override;
    function IsAuthorizedScale(sDeviceName: string): Boolean;
    function ConnectDevice(SelectedDevice: TBluetoothLEDevice): Boolean;
    procedure DisconnectDevice;
    function IsConnected: Boolean;
    procedure GetWeight;
    procedure GetCalibration;

    function WhatKindof(sDeviceName: string): TDeviceKind;

    property LastConnectedScale: TDeviceInfo read FLastConnectedDevice;
    property ScaleName: string read GetScaleName;
    property ScaleAddress: string read GetScaleAddress;
    property OnConnected: TNotifyEvent read FOnConnected write FOnConnected;
    property OnDisconnected: TNotifyEvent read FOnDisconnected write FOnDisconnected;
    property OnAuthorized: TNotifyEvent read FOnAuthorized write FOnAuthorized;
    property OnNotAuthorized: TNotifyEvent read FOnNotAuthorized write FOnNotAuthorized;

    property OnRead: TReadEvent read FOnRead write FOnRead;
    property OnReadWeight: TWeightEvent read FOnReadWeight write FOnReadWeight;
    property OnReadWeightChanged: TWeightEvent read FOnReadWeightChanged write FOnReadWeightChanged;
    property OnReadVolume: TVolumeEvent read FOnReadVolume write FOnReadVolume;
    property OnReadCalibration: TCalibrationEvent read FOnReadCalibration write FOnReadCalibration;
    property OnReadBarcode: TBarcodeEvent read FOnReadBarcode write FOnReadBarcode;
  end;

function GetServiceGUID(sDeviceName: string): TBluetoothUUID;
function GetReadGUID(sDeviceName: string): TBluetoothUUID;
function GetWriteGUID(sDeviceName: string): TBluetoothUUID;

const
    BLE_CNT = 4;
  BLE: array[0..BLE_CNT] of TDeviceProperty = (
    // MH-10
    (
     DeviceKind : dScale;
     DeviceName : 'GS_BLE';
     Service    : '{0000FFE0-0000-1000-8000-00805F9B34FB}';
     Read       : '{0000FFE1-0000-1000-8000-00805F9B34FB}';
     Write      : '{0000FFE1-0000-1000-8000-00805F9B34FB}';
     usingCertification : True;
     usingEncryption    : True;
    ),
    // Nordic
    (
     DeviceKind : dScale;
     DeviceName : 'GREENSCALE';
     Service    : '{6E400001-B5A3-F393-E0A9-E50E24DCCA9E}';
     Read       : '{6E400003-B5A3-F393-E0A9-E50E24DCCA9E}';
     Write      : '{6E400002-B5A3-F393-E0A9-E50E24DCCA9E}';
     usingCertification : True;
     usingEncryption    : True;
    ),
    // Nordic
    (
     DeviceKind : dScale;
     DeviceName : 'DAEPUNG-E';
     Service    : '{6E400001-B5A3-F393-E0A9-E50E24DCCA9E}';
     Read       : '{6E400003-B5A3-F393-E0A9-E50E24DCCA9E}';
     Write      : '{6E400002-B5A3-F393-E0A9-E50E24DCCA9E}';
     usingCertification : True;
     usingEncryption    : True;
    ),
    // MH-10
    (
     DeviceKind : dVolume;
     DeviceName : 'GS_Volume';
     Service    : '{0000FFE0-0000-1000-8000-00805F9B34FB}';
     Read       : '{0000FFE1-0000-1000-8000-00805F9B34FB}';
     Write      : '{0000FFE1-0000-1000-8000-00805F9B34FB}';
     usingCertification : False;
     usingEncryption    : False;
    ),
    // MH-10
    (
     DeviceKind : dBarcode;
     DeviceName : 'GS_Barcode';
     Service    : '{0000FFE0-0000-1000-8000-00805F9B34FB}';
     Read       : '{0000FFE1-0000-1000-8000-00805F9B34FB}';
     Write      : '{0000FFE1-0000-1000-8000-00805F9B34FB}';
     usingCertification : False;
     usingEncryption    : False;
    )
  );

  READING_INTERVAL = 50;
  CHANGE_INTERVAL = 200;
  AUTHORITY_INTERVAL = 3000;
  EVENTMODE_INTERVAL = 100;

implementation
//uses uMain;

function GetServiceGUID(sDeviceName: string): TBluetoothUUID;
var
  i: integer;
begin
  result := StringToGUID('{00000000-0000-0000-0000-000000000000}');

  for i := 0 to Length(BLE)-1 do
    if Uppercase(BLE[i].DeviceName) = Uppercase(sDeviceName) then
    begin
      result := BLE[i].Service;
      break;
    end;
end;

function GetReadGUID(sDeviceName: string): TBluetoothUUID;
var
  i: integer;
begin
  result := StringToGUID('{00000000-0000-0000-0000-000000000000}');

  for i := 0 to Length(BLE)-1 do
    if Uppercase(BLE[i].DeviceName) = Uppercase(sDeviceName) then
    begin
      result := BLE[i].Read;
      break;
    end;
end;

function GetWriteGUID(sDeviceName: string): TBluetoothUUID;
var
  i: integer;
begin
  result := StringToGUID('{00000000-0000-0000-0000-000000000000}');

  for i := 0 to Length(BLE)-1 do
    if Uppercase(BLE[i].DeviceName) = Uppercase(sDeviceName) then
    begin
      result := BLE[i].Write;
      break;
    end;
end;

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

constructor TDeviceConnection.Create(AOwner: TComponent);
begin
  inherited;

  FBluetoothLEManager := TBluetoothLEManager.Current;
  FBluetoothLEManager.OnDiscoveryEnd := DevicesDiscoveryLEEnd;

  FReceivedStrings := TStringList.Create;
//  FReceivedHexaStrings := TStringList.Create;
  FReceivedWeightSTrings := TStringList.Create;
  FReceivedVolumeStrings := TStringList.Create;
  FReceivedCalibrationStrings := TStringList.Create;
  FReceivedBarcodeStrings := TStringList.Create;

  FLastWeight.Init;
  FVolume.Init;
  FCalibration.Init;
  FBarcode.Init;

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

procedure TDeviceConnection.DevicesDiscoveryLEEnd(const Sender: TObject;
  const ADevices: TBluetoothLEDeviceList);
//------------------------------------------------------------------------------
//  �߰��� Disconnect �� ��� ȣ�� �ȴ�
//
//  1. ������� oScale = nil
//------------------------------------------------------------------------------
var
  Device: TBluetoothLEDevice;
begin
  if FLastConnectedDevice.IsAssigned then
  begin
    Device := FindDevice(ADevices, FLastConnectedDevice.DeviceName, FLastConnectedDevice.Address);

    // ������ �����ߴ� ���������� �ٽ� ��� ������ �� �����Ѵ�
    if Assigned(Device) then
      ConnectDevice(Device);
  end;
end;

procedure TDeviceConnection.DisconnectDevice;
//------------------------------------------------------------------------------
//  DisconnectDevice : ����ڰ� ������ Device ������ ���´�
//------------------------------------------------------------------------------
begin
  if Assigned(oDevice) and Assigned(oDevice.oLEDevice) then
  begin
    oDevice.oLEDevice.Disconnect;
//      oScale.FOnDisconnected(self);
  end;
end;

procedure TDeviceConnection.DoAuthorityTimer(Sender: TObject);
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
begin
  // Event ��带 Ȯ���Ѵ�
  if Assigned(oDevice) and oDevice.IsAuthorized and (not oDevice.IsEventMode) then
    oDevice.SendtoDevice(cmdTM, tmEvent);

  // ���������� �ְ�, Characteristic ���� �Ǿ� �ְ�, ������ �ȵ� ���
  if Assigned(oDevice) and oDevice.IsConnectedCharacteristic and (not oDevice.IsAuthorized) then
  begin
    oDevice.SendtoDevice(cmdAU);
    delay(50);
    oDevice.SendtoDevice(cmdAU);
    delay(50);
    oDevice.SendtoDevice(cmdTM, tmEvent);
  end
end;

procedure TDeviceConnection.DoAuthorized(Sender: TObject);
begin
  if Assigned(FOnAuthorized) then
    FOnAuthorized(self);
end;

procedure TDeviceConnection.DoConnected(Sender: TObject);
begin
  if oDevice.GetService then
  begin
    // ������ ����� ���� ������ �����Ѵ�
    FLastConnectedDevice.DeviceName := Uppercase(trim(oDevice.oLEDevice.DeviceName));
    FLastConnectedDevice.Address := oDevice.oLEDevice.Address;

    // �����۾� �� ������ ���۸�带 Event ������� �ٲ۴�
    if oDevice.usingCertification then
    begin    
      oDevice.SendtoDevice(cmdAU);
      delay(50);
      oDevice.SendtoDevice(cmdAU);
      delay(50);
      oDevice.SendtoDevice(cmdTM, tmEvent);
    end;

    // Timer �� �����Ѵ�    // 2016.04.29
    oReadTimer.Enabled := True;

    if oDevice.DeviceKind = dSCale then
      oWeightChangeTimer.Enabled := True;

    if oDevice.usingCertification then
      oAuthorityTimer.Enabled := True;

    if Assigned(FOnConnected) then
      FOnConnected(self);
  end
  else
  begin
    ShowMessage('��� ������ �� �����ϴ�!');
    oDevice.oLEDevice.Disconnect;
  end;
end;

procedure TDeviceConnection.DoReadTimer(Sender: TObject);
//------------------------------------------------------------------------------
//  �߻��� ������ �� ���԰��� ���� Event�� �߻��Ѵ�
//------------------------------------------------------------------------------
begin
  // ���� �� ó��
    while FReceivedStrings.Count > 0 do
    begin
      if Assigned(FOnRead) then
      begin
//        if (frmMain.chkViewEncryption.IsChecked) and (oDevice.DeviceKind = dScale) then
//          FOnRead(FReceivedHexaStrings[0]);

//        if frmMain.chkViewReceivedString.isChecked then
        FOnRead(FReceivedStrings[0]);
      end;

//      FReceivedHexaStrings.Delete(0);
      FReceivedStrings.Delete(0);
    end;

    // ���԰��� �Ѱ��ش�
    while(FReceivedWeightStrings.Count > 0) do
    begin
      oWeightChangeTimer.Enabled := False;  // ���԰� ���� Timer OFF, 00.2�� �ȿ� ���� ����Ǹ� �ٽ� reset

      FlastWeight.Text := FReceivedWeightStrings.Strings[0];

//      if Assigned(FOnReadWeight) and frmMain.chkViewWeight.IsChecked then
      if Assigned(FOnReadWeight) then
        FOnReadWeight(FLastWeight);

      FReceivedWeightStrings.Delete(0);
      oWeightChangeTimer.Enabled := True; // ���԰� ���� Timer ON, 0.2�� �ȿ� �� ������ ������ timer �ߵ�
    end;

    // ü������ �Ѱ��ش�
    while (FReceivedVolumeStrings.Count > 0) do
    begin
      FVolume.Text := FReceivedVolumeStrings.Strings[0];
      if Assigned(FOnReadVolume) then
        FOnReadVolume(FVolume);

      FReceivedVolumeStrings.Delete(0);
    end;

    // Ķ���극�̼� ���� �Ѱ��ش�
    while (FReceivedCalibrationStrings.Count > 0) do
    begin
      FCalibration.Text := FReceivedCalibrationStrings.Strings[0];

      if Assigned(FOnReadCalibration) then
        FOnReadCalibration(FCalibration);

      FReceivedCalibrationStrings.Delete(0);
    end;

    // ���ڵ尪�� �Ѱ��ش�
    while (FReceivedBarcodeStrings.Count > 0) do
    begin
      FBarcode.Text := FReceivedBarcodeStrings.Strings[0];
      if Assigned(FOnReadBarcode) then
        FOnReadBarcode(FBarcode);

      FReceivedBarcodeStrings.Delete(0);
    end;
end;

function TDeviceConnection.FindDevice(const ADevices: TBluetoothLEDeviceList; DeviceName, DeviceMacAddress: string): TBluetoothLEDevice;
var
  i: integer;
begin
  result := nil;

  for i := 0 to ADevices.Count-1 do
  begin
    if (Uppercase(DeviceName) = Uppercase(ADevices.Items[i].DeviceName)) and (DeviceMacAddress = ADevices.Items[i].Address) then
    begin
      result := ADevices.Items[i];
      break;
    end;
  end;
end;

procedure TDeviceConnection.GetCalibration;
begin
  if Assigned(oDevice) then
    oDevice.SendtoDevice(cmdCA);
end;

function TDeviceConnection.GetScaleAddress: string;
begin
  if Assigned(oDevice) and Assigned(oDevice.oLEDevice) then
    result := oDevice.oLEDevice.Address
  else
    result := '';
end;

function TDeviceConnection.GetScaleName: string;
begin
  if Assigned(oDevice) and Assigned(oDevice.oLEDevice) then
    result := Uppercase(trim(oDevice.oLEDevice.DeviceName))
  else
    result := '';
end;

procedure TDeviceConnection.GetWeight;
begin
  if Assigned(oDevice) then
    oDevice.SendtoDevice(cmdRW);
end;

function TDeviceConnection.IsAuthorizedScale(sDeviceName: string): Boolean;
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

function TDeviceConnection.IsConnected: Boolean;
begin
  if ( not Assigned(oDevice) ) or ( not Assigned(oDevice.oLEDevice) ) then
    result := false
  else
    result := oDevice.oLEDevice.IsConnected;
end;

procedure TDeviceConnection.SendtoDevice(Cmd: TScaleCommand=cmdAU; Code: TTMCode=tmEvent; TagString: string='');
begin
  oDevice.SendtoDevice(Cmd, Code, TagString);
end;

procedure TDeviceConnection.SendToDeviceCalibration;
begin
  if oDevice.IsConnected and (oDevice.DeviceKind = dVolume) then
    oDevice.SendtoDevice(cmdCA);
end;

function TDeviceConnection.WhatKindof(sDeviceName: string): TDeviceKind;
var
  i: integer;
  sName: string;
begin
  sName := Uppercase(trim(sDeviceName));

  result := dNone;

  for i := 0 to Length(BLE)-1 do
  begin
    if UpperCase(BLE[i].DeviceName) = Uppercase(sName) then
    begin
       result := BLE[i].DeviceKind;
       break;
    end;
  end;
end;

procedure TDeviceConnection.DoWeightChangeTimer(Sender: TObject);
begin
  oWeightChangeTimer.Enabled := False;

  if Assigned(FOnReadWeightChanged) and (FLastWeight.DifferenceSize > 0) then
  begin
    FOnReadWeightChanged(FLastWeight);

    FLastWeight.BeforeWeight := FLastWeight.Weight;
  end;
end;

procedure TDeviceConnection.DoDisconnected(Sender: TObject);
begin
  // ��� Timer�� �����Ѵ�
  oReadTimer.Enabled := False;
  oWeightChangeTimer.Enabled := False;
  oAuthorityTimer.Enabled := False;

  // ���� ������ ���ְ�, Event �� �߻���Ų��
  if oDevice.IsAuthorized then
    oDevice.DoNotAuthorized(self);

  // �ֱ� ���� ���¸� Clear �Ѵ�
  FLastConnectedDevice.Clear;

  if Assigned(oDevice) and oDevice.IsConnected then
  begin
//    oScale.oDevice.Disconnect;
    oDevice.oLEDevice.OnDisconnect := nil;
    oDevice.oLEDevice.OnConnect := nil;
    oDevice.oLEDevice.OnCharacteristicRead := nil;

    oDevice.FWeightReadCharacteristic := nil;
    oDevice.FWeightWriteCharacteristic := nil;
    oDevice.FWeightGattService := nil;

    oDevice.oLEDevice := nil;
  end;

  // ���������� Free �Ѵ�
  oDevice.Free;

  if Assigned(FOnDisconnected) then
    FOnDisconnected(self);
end;

procedure TDeviceConnection.DoNotAuthorized(Sender: TObject);
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
function TDeviceConnection.ConnectDevice(SelectedDevice: TBluetoothLEDevice): Boolean;
begin
  if not Assigned(SelectedDevice) then
  begin
    result := False;
    exit;
  end;

  // ���� �۵����� ����� ���� ������ ��� ���� ���� �������� �ʴ´�
  if Assigned(oDevice) and FLastConnectedDevice.IsSame(SelectedDevice.DeviceName, SelectedDevice.Address) then
  begin
    result := True;
    Exit;
  end;

  // ���� ���������� �Ҵ�Ǿ� ������, ���� ���� �Ѵ�
  if Assigned(oDevice) then
    DisconnectDevice;

  // ���������� �����Ѵ�
  if not Assigned(oDevice) then
  begin
    oDevice := TDeviceLE.Create(self);
    oDevice.FOnConnected := DoConnected;
    oDevice.FOnDisconnected := DoDisconnected;
    oDevice.FOnAuthorized := DoAuthorized;
    oDevice.FOnNotAuthorized := DoNotAuthorized;
  end;

  if Assigned(SelectedDevice) and oDevice.SetScale(SelectedDevice) then
  begin
    result := True;
  end
  else
  begin
    ShowMessage('��� ������ �� �����ϴ�!');
    oDevice.oLEDevice.Disconnect;
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

constructor TDeviceLE.Create(AParent: TDeviceConnection);
begin
  oParent := AParent;
end;

procedure TDeviceLE.DoAuthorized(Sender: TObject);
begin
  FAuthorized := True;

  if Assigned(FOnAuthorized) then
    FOnAuthorized(self);
end;

procedure TDeviceLE.DoCharacteristicRead(const Sender: TObject;
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
      MakingString(DeviceKind, FReceivedBytes);
      SetLength(FReceivedBytes, 0);
    end;
  end;
end;

procedure TDeviceLE.DoConnected(Sender: TObject);
begin
  if Assigned(FOnConnected) then
    FOnConnected(self);
end;

procedure TDeviceLE.DoDisconnected(Sender: TObject);
begin
  if Assigned(FOnDisconnected) then
    FOnDisconnected(Sender);
end;

procedure TDeviceLE.DoNotAuthorized(Sender: TObject);
begin
  FAuthorized := False;
  FEventMode := False;

  if Assigned(FOnNotAuthorized) then
    FOnNotAuthorized(self);
end;

function TDeviceLE.GetConnected: Boolean;
begin
  result := Assigned(oLEDevice) and oLEDevice.IsConnected;
end;

function TDeviceLE.GetConnectedCharacteristic: Boolean;
begin
  result := Assigned(FWeightReadCharacteristic);
end;

function TDeviceLE.GetDeviceKind: TdeviceKind;
var
  i: integer;
begin
  result := dNone;
  
  if Assigned(oLEDevice) then
  begin
    for i := 0 to Length(BLE) do
      if UpperCase(BLE[i].DeviceName) = UpperCase(trim(oLEDevice.DeviceName)) then
      begin
         result := BLE[i].DeviceKind;
         break;
      end;
  end;    
end;

function TDeviceLE.GetService: Boolean;
begin
  result := False;

  if IsConnected and oLEDevice.DiscoverServices then
  begin
    FWeightGattService := oLEDevice.GetService(GetServiceGUID(Uppercase(trim(oLEDevice.DeviceName))));
    delay(20);

    if (FWeightGattService <> nil) and (FWeightGattService.Characteristics.Count > 0) then
    begin
      FWeightReadCharacteristic := FWeightGattService.GetCharacteristic(GetReadGUID(Uppercase(trim(oLEDevice.DeviceName))));
      delay(20);
      FWeightWriteCharacteristic := FWeightGattService.GetCharacteristic(GetWriteGUID(Uppercase(trim(oLEDevice.DeviceName))));
      delay(20);
      if FWeightReadCharacteristic <> nil then
      begin
        oLEDevice.OnCharacteristicRead := DoCharacteristicRead;
        delay(20);
        if oLEDevice.SetCharacteristicNotification(FWeightReadCharacteristic, True) then
        begin
          FConnectedService := True;
          result := True;
        end;
      end;
    end;
  end;
end;

function TDeviceLE.GetUsingCertification: Boolean;
var
  i: integer;
begin
  result := true;
  
  if Assigned(oLEDevice) then
  begin
    for i := 0 to Length(BLE) do
      if Uppercase(BLE[i].DeviceName) = Uppercase(trim(oLEDevice.DeviceName)) then
      begin
         result := BLE[i].usingCertification;
         break;
      end;
  end;    
end;

function TDeviceLE.GetUsingEncryption: Boolean;
var
  i: integer;
begin
  result := true;
  
  if Assigned(oLEDevice) then
  begin
    for i := 0 to Length(BLE) do
      if Uppercase(BLE[i].DeviceName) = Uppercase(trim(oLEDevice.DeviceName)) then
      begin
         result := BLE[i].usingEncryption;
         break;
      end;
  end;
end;

procedure TDeviceLE.MakingString(AKind: TDeviceKind; msg: TBytes);
var
  i: integer;
  str, HexaString: string;
begin
  SetLength(msg, length(msg)-2); // Delete 0x0D, 0x0A

  str := '';
  for i := 0 to Length(msg)-1 do
  begin
    HexaString := HexaString + inttohex(msg[i], 2);

    if usingEncryption then
      msg[i] := msg[i] xor FKey;

    if (msg[i] > $20) and (msg[i] < $7F) then
      str := str + char(msg[i])
    else
      str := str + '0';
  end;

  if str.Length > 0 then
  begin
    oParent.FReceivedStrings.Add(str);
//    oParent.FReceivedHexaStrings.Add(HexaString);

    if copy(str, 1, 2) = 'RW' then
      oParent.FReceivedWeightStrings.Add(str)
    else if copy(str, 1, 4) = 'AU,A'  then
      DoAuthorized(self)
    else if copy(str, 1, 4) = 'TM,A' then
      FEventMode := True
    else if copy(str, 1, 2) = 'VO' then
      oParent.FReceivedVolumeStrings.Add(str)
    else if copy(str, 1, 2) = 'CA' then
      oParent.FReceivedCalibrationStrings.Add(str)
    else if copy(str, 1, 2) = 'BC' then
      oParent.FReceivedBarcodeStrings.Add(str);
  end;
end;

procedure TDeviceLE.SendtoDevice(Cmd: TScaleCommand; Code: TTMCode;
  TagString: string);
var
  CmdStr: string;
  CodeStr: string;
begin
  if FWeightReadCharacteristic = nil then
    Exit;

  CodeStr := IntToHex(BYTE(Code), 2);

  case cmd of
    cmdAU: CmdStr := 'AU,' + KeyString + ',' + MACString;    // AU : �������� ������
    cmdRW: CmdStr := 'RW,' + KeyString;  // RW : �����Ϳ䱸
    cmdMZ: CmdStr := 'MZ,' + KeyString;  // MZ : ���ε���
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
    cmdCA: CmdStr := 'CA,00';
    cmdBX: CmdStr := 'BX,' + TagString;
    else
      CmdStr := '';
  end;

  if CmdStr <> '' then
  begin
//    if frmMain.chkViewSendString.IsChecked and Assigned(oParent.FOnRead) then
//      oParent.FOnRead('send -> ' + CmdStr);

    CmdStr := CmdStr + #13 + #10;

    FWeightWriteCharacteristic.SetValueAsString(CmdStr);
    oLEDevice.WriteCharacteristic(FWeightWriteCharacteristic);
  end;
end;

function TDeviceLE.SetScale(const Value: TBluetoothLEDevice): Boolean;
var
  i: integer;
  sTemp: string;
  aMAC: array [0..6] of BYTE;
begin
  result := false;

  if Value = nil then Exit;

  oLEDevice := Value;
  oLEDevice.OnDisconnect := DoDisconnected;
  oLEDevice.OnConnect := DoConnected;

  FMACString := StringReplace(oLEDevice.Address, ':', '', [rfReplaceAll]);

  for i := 0 to 5 do
  begin
    sTemp := copy(FMACString, i*2+1, 2);
    aMac[i] := BYTE(strtoint('$'+sTemp));
    FKey := FKey xor aMac[i];
    FKeyString := char((FKey shr 4) + $30) + char((FKey and $0F) + $30);
  end;

  result := oLEDevice.Connect;
end;

{ TScaleInfo }

procedure TDeviceInfo.Clear;
begin
  DeviceName := '';
  Address := '';
end;

function TDeviceInfo.IsAssigned: Boolean;
begin
  result := DeviceName <> '';
end;

function TDeviceInfo.IsSame(sName, sAddress: string): Boolean;
begin
  result := (Uppercase(sName) = Uppercase(DeviceName)) and (sAddress = Address);
end;

{ TVolumeMessage }

procedure TVolumeMessage.Init;
begin
  FText := '';
  FWidth := 0;
  FLength := 0;
  FHeight := 0;
  FVolume := 0;
end;

procedure TVolumeMessage.SetText(const Value: string);
begin
  if System.Length(Value) <> 21 then
    Init
  else
  begin
    FWidth := strtoint(copy(Value, 4, 3));
    FLength := strtoint(copy(Value, 7, 3));
    FHeight := strtoint(copy(Value, 10, 3));
    FVolume := strtoint(copy(Value, 13, 9));
  end;
end;

{ TCalibratinMessage }

procedure TCalibrationMessage.Init;
begin
  FText := '';
  FVelocity := 0;
  FLength := 0;
end;

procedure TCalibrationMessage.SetText(const Value: string);
begin
  if System.Length(Value) <> 13 then
    Init
  else
  begin
    FVelocity := strtoint(copy(Value, 4, 5));
    FLength := strtoint(copy(Value, 9, 5));
  end;
end;

{ FBarcodeMessage }

procedure TBarcodeMessage.Init;
begin
  FText := '';
  FBarcode := '';
end;

procedure TBarcodeMessage.SetText(const Value: string);
var
  len: integer;
begin
  len := System.Length(Value);
  if len < 4 then
    Init
  else
    FBarcode := copy(Value, 4, len-3);
end;

end.
