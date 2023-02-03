# TMX7800Scan

🇺🇸 Delphi Component for ScanDevice SDK for use on devices .BAT MX7800 Series.
With this component you can easily control the basic functions of barcode scanner of the device (open, close, set beep, vibration, etc).

🇧🇷 Componente Delphi para acesso direto ao leitor de barras dos equipamentos da série MX7800 ou compatíves com API ScanDevice 2.1.1. Com esse componente você pode facilmente controlar funções básicas como escanear o código, beep, vibração, etc através de mensagens broadcast.


## Supported

- [x] MX7800-A
- [x] MX7800-X
- [x] MX7800-XR

- [x] Maybe work on your PDA with SDK version 2.1.1 or later. Test and enjoy!


## Installation

1) Install the dependency TAndroidBroadcastReceiver component in https://github.com/nilcemar/DelphiAndroidBroadcastReceiver

2) Install this component on your Delphi

3) Add the search paths on Delphi Options


## Usage

- See example app

```delphi
MX78001.init; //init scanner or set active=true
MX78001.active= false; // close scan
MX78001.beepOnScan:= true; //set beep on scan completes on 
MX78001.vibrateOnScan:= true; // set vibration on or off when read
```

- When barcode is read, the event "OnBarcodeRead" will fire;

## Contribute

We would ❤️ to see your contribution!
If it help you, please give us a 🌟

## Donate
Did you like this plugin? Give me a coffee 😍
https://www.paypal.com/donate/?hosted_button_id=C7W7WEY2HXEHU

## About

Created by Nilcemar Ferreira - .BAT Tecnologia
Made in Brazil 🇧🇷

instagram: @battecnologia
site: https://www.battecnologia.com
