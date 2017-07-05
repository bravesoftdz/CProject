unit uBLEDevices;
//------------------------------------------------------------------------------
//  Created by GreenScale Co, Inc.
//  Created Date: 2016.02.05
//
//  역할
//  1. 전자저울과 연결하여 저울에 명령을 전달함
//  2. 저울으로 부터의 Reponse를 해석하여 Event를 발생함
//      1) OnConnected    : 저울에 연결되었을 때
//      2) OnDisconnected : 저울의 연결이 해제되었을 때
//      3) OnAuthorized   : 저울로 부터 사용승인을 받았을 때
//      4) OnNotAuthorized: 사용승인 후 연결이 끊어져 승인이 취소되었을 때
//      5) OnRead         : 저울에서 오는 모든 Reponse를 String 으로 바꾸어 줌
//      6) OnWeight       : 저울에서 오늘 무게값을 알려 줌
//      7) OnWeightChanged: 저울의 무게값이 변경되었을 경우 알려줌
//                          정의된 interval 시간안에 변경이 없을 경우 이벤트 발생
//      8) OnVolume       : 체적값 발생 시
//      9) OnBarcode      : 바코드값 발생 시
//      10)OnCalibration  : 체적 Calibration 시 결과값 발생 시
//  구조
//  1. TDeviceConnection   : TComponent
//      1) 다른 Class 에서 저울을 사용하려고 할 경우 이용함
//      2) OnConnected, OnWeight 등 이벤트를 발생시켜서 데이터를 다른 Class 에 전달
//      3) Timer를 이용하여 전자저울의 Response를 해석한 후 Event를 발생함
//          - OnReadTimer : 전자저울로 부터의 Response 와 무게값이 있으면
//                          onRead, onWeight 이벤트 발생
//          - OnWeightChangeTimer : 무게값이 변경된 후 정의된 interval 시간안에
//                                  무게값 변경이 없을 경우 onWeightChangeTimer 이번테 발생
//          - OnAuthorityTimer    : 반복적으로 승인이 지속되고 있는지 확인하며,
//                                  승인이 되지 않은 상태일 경우
//                                  무게값 전달 모드가 Event 모드가 아닐 경우 TM Command 를 송신
//              > 연결된 상태이면, AU Command 를 전자저울로 송신
//              > 연결된 상태가 아니면, 재 접속시도를 지속한 후 연결되면 Au Command를 송신
//  2. TDeviceLE           : TClass
//      1) 전자저울과 직접 연결되는 Class
//      2) 전역변수 _ReceivedString 에 전자저울의 모든 Response를 저장함
//      3) 전역변수 _ReceivedWeightStrings 에 전자저울의 모든 무게값을 저장함
//  3. TWieghtMessage     : record
//      1) 전자저울 값을 저장하는 있는 Record
//
//------------------------------------------------------------------------------


interface
uses System.Bluetooth, System.SysUtils, System.Types, System.Classes,
  FMX.Dialogs, FMX.Forms, FMX.Types, System.Diagnostics;

type
{$define V20}
  //---
  // AU : 전자저울 사용승인
  // RW : 데이터요구
  // MZ : 제로동작
  // MT : 용기지정
  // CT : 용기 클리어
  // MG : 총중량표시
  // MN : 순중량표시
  // RT : RFID 카드 접촉 상태 시 용기설정
  // TM : 데이터 전달방식 결정 (00: Stop, 01: Normal, 02: Repeat)
  // TR : 전자저울 인식표 내용확인
  // TW : 전자저울 인식표 내용입력
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
//  중간에 Disconnect 된 경우 호출 된다
//
//  1. 현재상태 oScale = nil
//------------------------------------------------------------------------------
var
  Device: TBluetoothLEDevice;
begin
  if FLastConnectedDevice.IsAssigned then
  begin
    Device := FindDevice(ADevices, FLastConnectedDevice.DeviceName, FLastConnectedDevice.Address);

    // 이전에 실행했던 전자저울이 다시 살아 났으면 재 접속한다
    if Assigned(Device) then
      ConnectDevice(Device);
  end;
end;

procedure TDeviceConnection.DisconnectDevice;
//------------------------------------------------------------------------------
//  DisconnectDevice : 사용자가 강제로 Device 연결을 끊는다
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
//  주기적으로 승인이 되었는지 확인 후 승인까지 진행한다
//  Event 모드로 자동 전환 시킨다
//
//  1. AuthorityTimer 가 실행되는 것은 전자저울과 연결이 이루어졌었다는 것을 의미한다
//  2. 현재의 저울 상태의 종류는 다음과 같다
//      1) Characteristic 연결은 되어 있고, 승인만 되지 않은 경우
//          - Weight Timer ON
//          - Authority Timer ON
//      2) Disconnect 로 인하여 oScale.Free 된 상태
//          - Weight Timer OFF
//          - oScale = nil
//          - FAuthorized = False
//------------------------------------------------------------------------------
begin
  // Event 모드를 확인한다
  if Assigned(oDevice) and oDevice.IsAuthorized and (not oDevice.IsEventMode) then
    oDevice.SendtoDevice(cmdTM, tmEvent);

  // 전자저울이 있고, Characteristic 연결 되어 있고, 승인이 안된 경우
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
    // 마지막 연결된 저울 정보를 저장한다
    FLastConnectedDevice.DeviceName := Uppercase(trim(oDevice.oLEDevice.DeviceName));
    FLastConnectedDevice.Address := oDevice.oLEDevice.Address;

    // 인증작업 및 데이터 전송모드를 Event 방식으로 바꾼다
    if oDevice.usingCertification then
    begin    
      oDevice.SendtoDevice(cmdAU);
      delay(50);
      oDevice.SendtoDevice(cmdAU);
      delay(50);
      oDevice.SendtoDevice(cmdTM, tmEvent);
    end;

    // Timer 를 실행한다    // 2016.04.29
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
    ShowMessage('장비에 연결할 수 없습니다!');
    oDevice.oLEDevice.Disconnect;
  end;
end;

procedure TDeviceConnection.DoReadTimer(Sender: TObject);
//------------------------------------------------------------------------------
//  발생된 읽은값 과 무게값에 대한 Event를 발생한다
//------------------------------------------------------------------------------
begin
  // 읽은 값 처리
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

    // 무게값을 넘겨준다
    while(FReceivedWeightStrings.Count > 0) do
    begin
      oWeightChangeTimer.Enabled := False;  // 무게값 변경 Timer OFF, 00.2초 안에 값이 변경되면 다시 reset

      FlastWeight.Text := FReceivedWeightStrings.Strings[0];

//      if Assigned(FOnReadWeight) and frmMain.chkViewWeight.IsChecked then
      if Assigned(FOnReadWeight) then
        FOnReadWeight(FLastWeight);

      FReceivedWeightStrings.Delete(0);
      oWeightChangeTimer.Enabled := True; // 무게값 변경 Timer ON, 0.2초 안에 값 변경이 없으면 timer 발동
    end;

    // 체적값을 넘겨준다
    while (FReceivedVolumeStrings.Count > 0) do
    begin
      FVolume.Text := FReceivedVolumeStrings.Strings[0];
      if Assigned(FOnReadVolume) then
        FOnReadVolume(FVolume);

      FReceivedVolumeStrings.Delete(0);
    end;

    // 캘리브레이션 값을 넘겨준다
    while (FReceivedCalibrationStrings.Count > 0) do
    begin
      FCalibration.Text := FReceivedCalibrationStrings.Strings[0];

      if Assigned(FOnReadCalibration) then
        FOnReadCalibration(FCalibration);

      FReceivedCalibrationStrings.Delete(0);
    end;

    // 바코드값을 넘겨준다
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
  // 모든 Timer를 정지한다
  oReadTimer.Enabled := False;
  oWeightChangeTimer.Enabled := False;
  oAuthorityTimer.Enabled := False;

  // 승인 내역을 없애고, Event 를 발생시킨다
  if oDevice.IsAuthorized then
    oDevice.DoNotAuthorized(self);

  // 최근 연결 상태를 Clear 한다
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

  // 전자저울을 Free 한다
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
//  ConnectDevice : 저울과 연결하기 위하여 호출된다
//
//  1. 호출되는 경우는
//      - 처음 저울에 연결할 때
//      - 중간에 Disconnect 되어 다시 연결 할 때
//      - 상위에서 중복하여 호출 될 때
//------------------------------------------------------------------------------
function TDeviceConnection.ConnectDevice(SelectedDevice: TBluetoothLEDevice): Boolean;
begin
  if not Assigned(SelectedDevice) then
  begin
    result := False;
    exit;
  end;

  // 현재 작동중인 저울과 같은 저울이 들어 왔을 때는 동작하지 않는다
  if Assigned(oDevice) and FLastConnectedDevice.IsSame(SelectedDevice.DeviceName, SelectedDevice.Address) then
  begin
    result := True;
    Exit;
  end;

  // 현재 전자저울이 할당되어 있으면, 강제 해제 한다
  if Assigned(oDevice) then
    DisconnectDevice;

  // 전자저울을 생성한다
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
    ShowMessage('장비를 연결할 수 없습니다!');
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
    cmdAU: CmdStr := 'AU,' + KeyString + ',' + MACString;    // AU : 전자저울 사용승인
    cmdRW: CmdStr := 'RW,' + KeyString;  // RW : 데이터요구
    cmdMZ: CmdStr := 'MZ,' + KeyString;  // MZ : 제로동작
    cmdMT: CmdStr := 'MT,' + KeyString;  // MT : 용기지정
    cmdCT: CmdStr := 'CT,' + KeyString;  // CT : 용기 클리어
    cmdMG: CmdStr := 'MG,' + KeyString;  // MG : 총중량표시
    cmdMN: CmdStr := 'MN,' + KeyString;  // MN : 순중량표시
    cmdRT: CmdStr := 'RT,' + KeyString;  // RT : RFID 카드 접촉 상태 시 용기설정
    {$IfDef V20}
      cmdTM: CmdStr := 'TM,' + KeyString + ',' + CodeStr + ',0100';  // TM : 데이터 전달방식 결정 (00: Stop, 01: Normal, 02: Repeat)
    {$Else}
      cmdTM: CmdStr := 'TM,' + KeyString + ',' + CodeStr;  // TM : 데이터 전달방식 결정 (00: Stop, 01: Normal, 02: Repeat)
    {$EndIf}
    cmdTR: CmdStr := 'TR,' + KeyString + ',' + CodeStr;  // TR : 전자저울 인식표 내용확인
    cmdTW: CmdStr := 'TW,' + CodeStr + ',' + TagString;  // TW : 전자저울 인식표 내용입력
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
