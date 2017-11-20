unit ServerContainerUnit;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  IPPeerServer, IPPeerAPI, Datasnap.DSAuth;

type
  TServerContainer1 = class(TDataModule)
    DSServer: TDSServer;
    DSTCPServerTransport: TDSTCPServerTransport;
    DSServerClass: TDSServerClass;
    procedure DSServerClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSServerConnect(DSConnectEventObject: TDSConnectEventObject);
    procedure DSServerDisconnect(DSConnectEventObject: TDSConnectEventObject);
  private
    { Private declarations }
  public
  end;

var
  ServerContainer1: TServerContainer1;

implementation


{$R *.dfm}

uses
  ServerMethodsUnit, uMain;

procedure TServerContainer1.DSServerConnect(
  DSConnectEventObject: TDSConnectEventObject);
begin
  frmMain.AddingLog('++ Connect :' + DSConnectEventObject.ChannelInfo.ClientInfo.IpAddress  + ' : ' +
                    FormatDateTime( 'YYYY-MM-DD hh:mm:ss', now ) );
end;

procedure TServerContainer1.DSServerDisconnect(
  DSConnectEventObject: TDSConnectEventObject);
begin
  frmMain.AddingLog('++ Disconnect :' + DSConnectEventObject.ChannelInfo.ClientInfo.IpAddress  + ' : ' +
                    FormatDateTime( 'YYYY-MM-DD hh:mm:ss', now ) );
end;

procedure TServerContainer1.DSServerClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit.TServerMethods1;
end;

end.

