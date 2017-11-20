unit uGlobal;

interface
uses uCPScale, System.Classes, System.Bluetooth, System.Bluetooth.Components,
  FMX.Dialogs, System.SysUtils;

type
  TFacebookUser = record
    id: string;
    name: string;
    birthday: string;
    email: string;
    gender: string;
    picture: string;
  public
    procedure Clear;
  end;

  TGlobal = class(TComponent)
  private
    const
      cTIME_Discover = 500;

    procedure EndDiscoverDevices(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
  public
    BluetoothLE: TBluetoothLE;
    FacebookUser: TFacebookUser;
    Scale: TScaleConnection;

    constructor Create(AOwner: TComponent);
    procedure BluetoothLEInit(AComponent: TComponent);
    function BluetoothDiscoverDevices: Boolean;
  end;

function IsBackKey(var Key: Word): Boolean;
// BluetoothLE


var
  _Global: TGlobal;

implementation
uses FMX.VirtualKeyboard, FMX.Platform, FMX.Types, System.UITypes;

{ BlueetoothLE Functions }

//  블루투스 초기화
procedure TGlobal.BluetoothLEInit(AComponent: TComponent);
begin
  if Assigned(BluetoothLE) then
    BluetoothLE.DisposeOf;

  BluetoothLE := TBluetoothLE.Create(AComponent);
  BluetoothLE.OnEndDiscoverDevices := EndDiscoverDevices;
  BluetoothLE.Enabled := True;
end;

constructor TGlobal.Create(AOwner: TComponent);
begin
  inherited;

  // Facebook oAuth2 사용자정보 초기화
  FacebookUser.Clear;
  // Bluetoot LE 초기화
  BluetoothLEInit(self);
  // 전자저울 초기화
  Scale := TScaleConnection.Create(self);
end;

// 블루트스 DisverDivices
function TGlobal.BluetoothDiscoverDevices: Boolean;
begin
  if Assigned(BluetoothLE) then
    result := BluetoothLE.DiscoverDevices(cTIME_Discover)
  else
    result := False;
end;

// 블루투스 Discoverty & Connect;
procedure TGlobal.EndDiscoverDevices(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
var
  i, k: integer;
begin
  try
    if Assigned(Scale) then
    begin
      if ADeviceList.Count < 1 then
        Scale.ResponseError('전자저울을 찾을 수 없습니다!')
      else
      begin
        for i:=0 to ADeviceList.Count-1 do
          for k := 0 to Length(BLE)-1 do
          begin
            if Uppercase(ADeviceList.Items[i].DeviceName) = UpperCase(BLE[k].DeviceName) then
            begin
              Scale.DisconnectDevice;
              Scale.ConnectDevice(ADeviceList.Items[i]);
              Exit;
            end;
          end;

        Scale.ResponseError('전자저울을 찾을 수 없습니다!');
      end;
    end
    else
      Scale.ResponseError('전자저울이 초기화 되지 않았습니다!');
  except
    Scale.ResponseError('전자저울 연결에 문제가 발생했습니다!');
  end;
end;

{ TFacebookUser }
procedure TFacebookUser.Clear;
begin
  id := '';
  name := '';
  birthday := '';
  email := '';
  gender := '';
  picture := '';
end;

function IsBackKey(var Key: Word): Boolean;
var
  FService : IFMXVirtualKeyboardService;  // FMX.Platform, FMX.VirtualKeyboard;
begin
  result := False;

  if Key = vkHardwareBack Then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

    // 키보드 뜬상태가 아닐때 : 키보드 뜬상태면 키보드 자체종료 시킴.
    if not ( (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) ) then
    begin
      Key :=  0 ;  // 기본액션인 앱 종료를 방지함.

      result := True;
    end;
  end;
end;

end.
