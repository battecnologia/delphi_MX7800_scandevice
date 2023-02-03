
unit Androidapi.JNI.mx7800;

interface

{$IFDEF ANDROID}

uses

  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes;

type
// ===== Forward declarations =====

  JScanDevice = interface;//android.device.ScanDevice
  JSystemManager = interface;//android.device.SystemManager
  JSerialPortServiceManager = interface;//android.os.SerialPortServiceManager

// ===== Interface declarations =====

  JScanDeviceClass = interface(JObjectClass)
    ['{89745A76-1F3D-4B6C-9B8D-5161BBC64BC2}']
    {class} function init: JScanDevice; cdecl;
  end;

  [JavaSignature('android/device/ScanDevice')]
  JScanDevice = interface(JObject)
    ['{62B1BAE7-F0A4-4501-94E7-AE132DCC6C5D}']
    function closeScan: Boolean; cdecl;
    function getIndicatorLightMode: Integer; cdecl;
    function getOutScanMode: Integer; cdecl;
    function getScanBeepState: Boolean; cdecl;
    function getScanCodeValue: JString; cdecl;
    function getScanLaserMode: Integer; cdecl;
    function getScanVibrateState: Boolean; cdecl;
    function getScannerType: Integer; cdecl;
    function isScanOpened: Boolean; cdecl;
    function openScan: Boolean; cdecl;
    function resetScan: Boolean; cdecl;
    procedure setIndicatorLightMode(i: Integer); cdecl;
    function setOutScanMode(i: Integer): Boolean; cdecl;
    function setScanBeep: Boolean; cdecl;
    procedure setScanLaserMode(i: Integer); cdecl;
    function setScanUnBeep: Boolean; cdecl;
    function setScanUnVibrate: Boolean; cdecl;
    function setScanVibrate: Boolean; cdecl;
    function startScan: Boolean; cdecl;
    function stopScan: Boolean; cdecl;
  end;
  TJScanDevice = class(TJavaGenericImport<JScanDeviceClass, JScanDevice>) end;

  JSystemManagerClass = interface(JObjectClass)
    ['{B6B1ADAE-3C53-45EB-847B-8DA49377E13E}']
    {class} function init: JSystemManager; cdecl;
  end;

  [JavaSignature('android/device/SystemManager')]
  JSystemManager = interface(JObject)
    ['{4776D986-4DE4-4789-A30A-9D50DFF4A0F2}']
    function deleteAPN(string_: JString): Boolean; cdecl;
    function getForbiddenHome: Boolean; cdecl;
    function getHideRecentApps: Boolean; cdecl;
    function getHideSlideStatusBar: Boolean; cdecl;
    function queryAPN(string_: JString): JString; cdecl;
    function setAPN(string_: JString; string_1: JString; string_2: JString; string_3: JString; string_4: JString; string_5: JString; string_6: JString; string_7: JString; string_8: JString; string_9: JString; string_10: JString; string_11: JString; i: Integer; string_12: JString; string_13: JString; i1: Integer; string_14: JString; b: Boolean; b1: Boolean): Boolean; cdecl;
    procedure setForbiddenHome(b: Boolean); cdecl;
    procedure setHideRecentApps(b: Boolean); cdecl;
    procedure setHideSlideStatusBar(b: Boolean); cdecl;
    procedure setSelectedApn(string_: JString); cdecl;
    procedure setSysTime(i: Integer; i1: Integer; i2: Integer; i3: Integer; i4: Integer; i5: Integer); cdecl;
  end;
  TJSystemManager = class(TJavaGenericImport<JSystemManagerClass, JSystemManager>) end;

  JSerialPortServiceManagerClass = interface(JObjectClass)
    ['{E8218ECC-FEBC-4B0B-8DF9-64461B792041}']
    {class} function init: JSerialPortServiceManager; cdecl; overload;
    {class} function init(i: Integer): JSerialPortServiceManager; cdecl; overload;
  end;

  [JavaSignature('android/os/SerialPortServiceManager')]
  JSerialPortServiceManager = interface(JObject)
    ['{B153B692-C59F-4271-A5A0-F9B3AEC8C9C0}']
    function close: Integer; cdecl;
    function cmd(i: Integer; b: TJavaArray<Byte>): Integer; cdecl;
    function isReady: Integer; cdecl;
    function open(b: TJavaArray<Byte>; i: Integer; i1: Integer; i2: Integer): Integer; cdecl;
    function read(b: TJavaArray<Byte>; i: Integer; i1: Integer): Integer; cdecl;
    function wait_data: Integer; cdecl;
    function write(b: TJavaArray<Byte>; i: Integer): Integer; cdecl;
  end;
  TJSerialPortServiceManager = class(TJavaGenericImport<JSerialPortServiceManagerClass, JSerialPortServiceManager>) end;
{$ENDIF}


implementation

{$IFDEF ANDROID}
procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.mx7800.JScanDevice', TypeInfo(Androidapi.JNI.mx7800.JScanDevice));
  TRegTypes.RegisterType('Androidapi.JNI.mx7800.JSystemManager', TypeInfo(Androidapi.JNI.mx7800.JSystemManager));
  TRegTypes.RegisterType('Androidapi.JNI.mx7800.JSerialPortServiceManager', TypeInfo(Androidapi.JNI.mx7800.JSerialPortServiceManager));
end;

initialization
  RegisterTypes;

{$ENDIF}

end.

