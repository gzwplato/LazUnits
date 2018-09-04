# DebugUnit
![Environment](https://img.shields.io/badge/Windows-XP,%20Vista,%207,%208,%2010-brightgreen.svg)
[![License](https://img.shields.io/badge/license-unlicense-yellow.svg)](https://unlicense.org)
[![Donate](https://img.shields.io/badge/Donate-PayPal-red.svg)](https://www.paypal.me/JimDreherHome)

Adds or Removes a debug window with a debug Memo to the project.

Makes it easier to debug FPC/Lazarus projects under Windows.

## Methods
	
  procedure Debugln(Arg1: Variant);
  procedure Debugln(Arg1, Arg2: Variant);
  procedure Debugln(Arg1, Arg2, Arg3: Variant);
  procedure Debugln(Arg1, Arg2, Arg3, Arg4: Variant);
  procedure Debugln(Arg1, Arg2, Arg3, Arg4, Arg5: Variant);
  procedure Debugln(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6: Variant);
  procedure Debugln(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7: Variant);
  procedure Debugln(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8: Variant);

  procedure Debugln(Args: array of Variant);

  procedure Debugln(Fmt:string; Args: array of Const);


## Development Tools

This utility was developed using the Lazarus IDE version 1.8.4 with Free Pascal version 3.0.4.

It has been tested on both 32 and 64 bit versions of WinXP, Win7, and Win10 using Virtualbox.

### Donations

If this utility is useful, or if the source code helps you in some way, then a small donation would be appreciated.  Just click on the "donation" button above.

Your donation is not tax deductible, but will be used to help promote freeware from myself and other software authors.  
