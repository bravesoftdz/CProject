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

//  ������� �ʱ�ȭ
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

  // Facebook oAuth2 ��������� �ʱ�ȭ
  FacebookUser.Clear;
  // Bluetoot LE �ʱ�ȭ
  BluetoothLEInit(self);
  // �������� �ʱ�ȭ
  Scale := TScaleConnection.Create(self);
end;

// ���Ʈ�� DisverDivices
function TGlobal.BluetoothDiscoverDevices: Boolean;
begin
  if Assigned(BluetoothLE) then
    result := BluetoothLE.DiscoverDevices(cTIME_Discover)
  else
    result := False;
end;

// ������� Discoverty & Connect;
procedure TGlobal.EndDiscoverDevices(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
var
  i, k: integer;
begin
  try
    if Assigned(Scale) then
    begin
      if ADeviceList.Count < 1 then
        Scale.ResponseError('���������� ã�� �� �����ϴ�!')
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

        Scale.ResponseError('���������� ã�� �� �����ϴ�!');
      end;
    end
    else
      Scale.ResponseError('���������� �ʱ�ȭ ���� �ʾҽ��ϴ�!');
  except
    Scale.ResponseError('�������� ���ῡ ������ �߻��߽��ϴ�!');
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

    // Ű���� ����°� �ƴҶ� : Ű���� ����¸� Ű���� ��ü���� ��Ŵ.
    if not ( (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) ) then
    begin
      Key :=  0 ;  // �⺻�׼��� �� ���Ḧ ������.

      result := True;
    end;
  end;
end;

end.
