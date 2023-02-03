unit batMX7800ScanDevice;

interface

uses
  System.SysUtils, System.Classes, batBroadcastReceiver

  {$IFDEF ANDROID}
  ,Androidapi.JNI.mx7800
  ,Androidapi.JNI.Embarcadero
  ,Androidapi.JNI.GraphicsContentViewText
  ,Androidapi.Helpers
  ,Androidapi.JNIBridge
  ,Androidapi.JNI.JavaTypes
  ,Androidapi.JNI.App
  {$ENDIF}
  ;

const
  cSCAN_ACTION = 'scan.rcv.message';
  cBROADCAST_MODE = 0;
  cEDITBOX_MODE   = 1;
  cKEYBOARD_MODE  = 2;

type

  TOnBarcodeRead = procedure(barcode: String) of Object;


  TMX7800ScanDevice = class(TAndroidBroadcastReceiver)
  private
    { Private declarations }
    FOnBarcodeRead: TOnBarcodeRead;
    FActive: Boolean;
    FBeepOnScan: Boolean;
    FVibrateOnScan: Boolean;
    FInitialized: Boolean;

    {$IFDEF ANDROID}
    FOnReceive: TOnReceive;
    FScanner: JScanDevice;


    {$ENDIF}
    procedure doOnReceive(csContext: JContext; csIntent: JIntent);

  protected
    { Protected declarations }
    procedure setScanActive(value: Boolean);
    procedure setBeep(value: boolean);
    procedure setVibration(value: boolean);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function InitReader: Boolean;
    function ResetScanner: Boolean;
  published
    { Published declarations }
    property OnBarcodeRead: TOnBarcodeRead read FOnBarcodeRead write FOnBarcodeRead;
    property Active: Boolean read FActive write setScanActive;
    property BeepOnScan: Boolean read FBeepOnScan write setBeep;
    property VibrateOnScan: Boolean read FVibrateOnScan write setVibration;


  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('BAT_Tecnologia', [TMX7800ScanDevice]);
end;

{ TMX7800ScanDevice }

constructor TMX7800ScanDevice.Create(AOwner: TComponent);
begin
  inherited;
  RegisterReceive; //register the listener
  Add(cSCAN_ACTION); //register scan message
  FInitialized:= False;
  FActive:= False;
end;

destructor TMX7800ScanDevice.Destroy;
begin
  //remove listener
  Delete(0);
  {$IFDEF ANDROID}
  if Assigned(FScanner) then
  begin
    setScanActive(False);
    FScanner:= nil;
  end;
  {$ENDIF}
  inherited;
end;

procedure TMX7800ScanDevice.doOnReceive(csContext: JContext; csIntent: JIntent);
var
  barcodeStr: String;
  barocode: System.TArray<System.Byte>;
begin

{$IFDEF ANDROID}
  //receive barcode from reader and do a event
  if JStringToString(csIntent.getAction).Equals('scan.rcv.message') then
  begin
    barocode:= TAndroidHelper.TJavaArrayToTBytes(csIntent.getByteArrayExtra(StringToJString('barocode')));
    barcodeStr:= StringFromByteArray(barocode);

    if (not barcodeStr.trim.isEmpty) and Assigned(FOnBarcodeRead) then
    begin
      FOnBarcodeRead(barcodeStr);
    end;

  end;

{$ENDIF}
end;

function TMX7800ScanDevice.InitReader: Boolean;
//initialize the reader, set broadcast mode, beep and vibration
begin
  FActive:= False;
  FInitialized:= False;
  {$IFDEF ANDROID}
  try
    FScanner:= TJScanDevice.Create;
    OnReceive:= doOnReceive; //set listener

    if FScanner.openScan then  //turn scanner on
    begin
      FActive:= True;
      //read scan and vibrate values from device
      FBeepOnScan:= FScanner.getScanBeepState;
      FVibrateOnScan:= FScanner.getScanVibrateState;

      FScanner.setOutScanMode(cBROADCAST_MODE);  //set scanner to broadcast mode
      FInitialized:= true;
    end;
  except on E: Exception do
    begin
      FBeepOnScan:= False;
      FVibrateOnScan:= False;
      FActive:= False;
      FInitialized:= False;
    end;
  end;
  {$ENDIF}
  Result:= FActive;
end;

function TMX7800ScanDevice.ResetScanner: Boolean;
begin
  //reset Scanner
  {$IFDEF ANDROID}
  if FActive then
    Result:= FScanner.resetScan
  else
    Result:= False;
  {$ENDIF}
end;

procedure TMX7800ScanDevice.setBeep(value: boolean);
begin
  {$IFDEF ANDROID}
  //set beep on scan on or off
  if FActive then
  begin
    if value then
      FScanner.setScanBeep
    else
      FScanner.setScanUnBeep;
    FBeepOnScan:= FScanner.getScanBeepState;
  end;
  {$ENDIF}
end;

procedure TMX7800ScanDevice.setScanActive(value: Boolean);
begin
 {$IFDEF ANDROID}
 if(FActive) then //turn off scanner
 begin
   FScanner.closeScan;
   FActive:= False;
 end
 else
 begin
  if FInitialized and value then
  begin
    FScanner.openScan;
    FActive:= True;
  end
  else
  begin
    if value then
      InitReader;
  end;
 end;
 {$ENDIF}
end;

procedure TMX7800ScanDevice.setVibration(value: boolean);
begin
  //set beep on scan on or off
  {$IFDEF ANDROID}
  if FActive then
  begin
    if value then
      FScanner.setScanVibrate
    else
      FScanner.setScanUnVibrate;
    FBeepOnScan:= FScanner.getScanVibrateState;
  end;
  {$ENDIF}
end;

end.
