unit tdrmcammain;

interface                 

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DSUtil, DirectShow9,Dialogs, DSPack, StdCtrls, ExtCtrls, Buttons, DB,
  ADODB, Menus,math, AviWriter_2,Jpeg, VCLUnZip, VCLZip,ComCtrls,ColorGrd,registry, Mask,
  IdMessage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase,
  IdNNTP, IdSMTP, inifiles,IdAttachmentFile,
  DateUtils, IdPOP3,ShlObj,FileCtrl,URLMon,WinInet, MPlayer,Tlhelp32,
  ToolWin,StrUtils, ShellAPI,IdText, OleCtrls, SHDocVw,mshtml,ActiveX;

const WM_NID = WM_User + 1000;    //????ʹ??
formwidth=693;
formheight=530;
WM_zipfile = WM_USER + 100;


type
  TtdrmcammainForm = class(TForm)
    nowkImg: TImage;
    setchncountPopM: TPopupMenu;
    setMemo: TMemo;
    timefontFod: TFontDialog;
    capfontFod: TFontDialog;
    menuPanel: TPanel;
    commacCob: TComboBox;
    Timer2: TTimer;
    Timer3: TTimer;
    Timer4: TTimer;
    verLbl: TLabel;
    regynLbl: TLabel;
    upgraLbl: TLabel;
    regLbl: TLabel;
    ModifypwdLbl: TLabel;
    developLbl: TLabel;
    camaddrfontFod: TFontDialog;
    rightPM: TPopupMenu;
    closesoft: TMenuItem;
    showmain: TMenuItem;
    channelcountsetBtn: TSpeedButton;
    channelcountsetImg: TImage;
    publicsetBtn: TSpeedButton;
    publicsetImg: TImage;
    restartBtn: TSpeedButton;
    restartImg: TImage;
    fullscreenBtn: TSpeedButton;
    fullscreenImg: TImage;
    HideBtn: TSpeedButton;
    HideImg: TImage;
    exitsoftBtn: TSpeedButton;
    exitsoftImg: TImage;
    titlePanel: TPanel;
    Image1: TImage;
    viewBtn: TSpeedButton;
    viewImg: TImage;
    timedoDTP: TDateTimePicker;
    dotypeCob: TComboBox;
    timedoSBt: TSpeedButton;
    MediaPlayer1: TMediaPlayer;
    Timer1: TTimer;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure camtimerTimer(Sender: TObject);
    procedure addimage(Sender: TObject);
    procedure DeleteMe;                                     //??????ɾ??
    function DownloadFile(Source, Dest: string): Boolean;   //?????ļ?
    function GetUrlContent(var urlcon:string;url: string; TimeOut:integer=3000): boolean;   //??ȡ??ҳ????
    function CheckUrl(url: string; TimeOut:integer=3000): boolean;                          //?ж?URL?Ƿ?????
    function ComponentToString(Component:TComponent):string;//????ת??Ϊ?ַ?
    function StringToComponent(Value:string):TComponent;//?ַ?ת??Ϊ????
    function fontTostr(V:Tfont):string;//????ת??Ϊ?ַ?
    function strTofont(V:string;font:Tfont):boolean;//?ַ?ת??Ϊ????
    function GetFileSizem(const FileName: string):integer;//??ȡ?ļ???С???˷???ִ?????ɻ??Զ??ر??ļ?
//    function ZipFileAndPath(const ASrcFilenamelist:Tstringlist;const ASrcFilepath,ADestFilename: string; const APassword: string): Boolean;    //ѹ???ļ????ɺ??ļ???
    function KillTask(ExeFileName:string):boolean;//?رս???
    function Getparafromreg(j:integer): boolean;   //??ע??????ȡ?ؼ?????????ֵ
    procedure PutParatoshow(Sender: TObject{;var canput:Boolean});//???ؼ?????????ֵ?????ؼ???????
    function GetSystemPath:String; //???ò???ϵͳsystem32·??
//    function DeleteDirectory(NowPath: string): Boolean; // ɾ??????Ŀ¼
    function getupdateinfo: Boolean; // ??ȡ??????Ϣ
    procedure Startcam(imgi:integer);                //????????ͷ??ʼ¼??
    procedure Stopcam(proi:integer);                //?ر?????ͷֹͣ¼??
    procedure startvoice(Sender: TObject);           //??ʼ¼??
    procedure stopvoice(Sender: TObject);            //ֹͣ¼??
    function randomizesl(var ressl:Tstringlist;sl:Tstringlist):boolean;        //??stringlist?????ַ???˳??????????????
    function fullwin: boolean;        //ȫ??
    function numwin: boolean;        //????
    function icowin: boolean;        //??Ϊͼ??
    procedure upgraLblClick(Sender: TObject);
    procedure regLblClick(Sender: TObject);
    procedure ModifypwdLblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgselect(Sender: TObject);
    procedure publicsetBtnClick(Sender: TObject);
    procedure channelcountsetBtnClick(Sender: TObject);
    procedure exitsoftBtnClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Softrestart(Sender: TObject);
    procedure restartBtnClick(Sender: TObject);
    procedure closesoftClick(Sender: TObject);
    procedure showmainClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure HideBtnClick(Sender: TObject);
    procedure fullscreenBtnClick(Sender: TObject);
    procedure titlePanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure menuPanelClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);        //????????
    function MakePathList(Path:string):TStringList;
    procedure viewBtnClick(Sender: TObject);
    procedure timedoSBtClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FilterGraphGraphDeviceLost(sender: TObject;
      Device: IInterface; Removed: Boolean);              //??ȡĿ¼?µ??????ļ???

  private
    { Private declarations }
//    procedure SysCommand(var SysMsg: TMessage); message WM_SYSCOMMAND;            //??׽??С????????
    procedure WMNID(var msg:TMessage); message WM_NID;
    procedure EndMsg(var nMsg: TWMQueryEndSession); Message WM_QUERYENDSESSION;     //???عػ???Ϣ
//    procedure WMzipfile(var msg: TMessage); message WM_zipfile;
    procedure CreateWav( channels : word; { 1(????)????2(??????) }
    resolution : word; { 8????16,????8λ??16λ???? }
    rate : longint; { ????Ƶ??,??11025,22050, 44100}
    fn : string { ??Ӧ???ļ????? } );
  public
    { Public declarations }
  end;
type
TWavHeader = record //????һ??Wav?ļ?ͷ??ʽ 
rId : longint; 
rLen : longint; 
wId : longint; 
fId : longint; 
fLen : longint; 
wFormatTag : word; 
nChannels : word; 
nSamplesPerSec : longint; 
nAvgBytesPerSec : longint; 
nBlockAlign : word; 
wBitsPerSample : word; 
dId : longint; 
wSampleLength : longint; 
end;

type
  Tcampro=record                  //????ͷ?ṹ??
  camname:string;                 //????ͷ????
  camaddr:string;                 //????ͷ???ڵص?            ???ֿ⣬???ſڣ???????
  camid:integer;                 //??ʾ????????????ͷ??id
  isload:boolean;                 //?Ƿ??Ѿ?????
  todayvideopath:string;          //????¼?񱣴?·??
  todaycampath:string;            //????????ͷ????·??
  todayalapath:string;            //???쾯??ͼƬ????·??
  commac:string;                  //ѹ????????
  captext:string;                 //??Ļ????
  smtptxt:string;                 //????smtp??????
  pop3txt:string;                 //????pop3??????
  smtpporttxt:string;             //????smtp?˿?
  pop3porttxt:string;             //????pop3?˿?
  mailuser:string;                //?????û???
  mailpassword:string;            //????????
  recuser:string;                 //?ʼ??ռ???
  alasasedstr:string;             //???????ƣ????ھ???ͼƬ???ƺ;???ѹ???ļ????ƣ?
  alasasedstrlist:Tstringlist;    //?????????б??????ھ???ͼƬ???ƺ;???ѹ???ļ????ƣ?
  filepassword:string;            //ѹ???ļ?????
  musicpath:string;               //????????·??
  frawid:integer;                 //ÿ֡????
  frahei:integer;                 //ÿ֡?߶?
  commaci:integer;                //¼??ѹ????????
  comqua:integer;                 //¼??ѹ??????
  capx:integer;                   //??Ļ??ʾ????X
  capy:integer;                   //??Ļ??ʾ????Y
  timex:integer;                  //ʱ????ʾ????X
  timey:integer;                  //ʱ????ʾ????Y
  camaddrx:integer;               //????ͷ?ص???ʾ????X
  camaddry:integer;               //????ͷ?ص???ʾ????Y
  savedays:integer;               //????????
  poselx:integer;                 //ͼƬѡ??????????X
  posely:integer;                 //ͼƬѡ??????????Y
  pohei:integer;                  //ͼƬѡ???????߶?
  powid:integer;                  //ͼƬѡ??????????
  heiwid:double;                  //100????ѡ???ĸ߿?
  blueturn:integer;               //???仯ֵ
  greenturn:integer;              //?̱仯ֵ
  redturn:integer;                //???仯ֵ
  pointturn:integer;              //?????仯ֵ
  turnqua:integer;                //?????仯ֵ
  alastrlist:Tstringlist;         //ʱ???仯?б?
  nowsetid:string;                //??ǰ????ͷ???þ??????ô?id
  alapiclast:integer;             //????ͼƬ??Χ????ȡ????????ǰ??alapiclast????ͼƬ
  nalapiclast:integer;            //????ͼƬ??Χ????ȡ????????ǰ??nalapiclast??ͼƬ
  alamodel:integer;               //????ģʽ
  alapiclisti:integer;            //ͼƬ?ۻ????????ã??ھ???????????ʼ??ɾ??ͼƬ??ÿ????һ??ͼƬ?????????Լ?1??ֱ???????ݵ???trunc(alapiclast*1000/40)??????ͼƬ??Χ??
  iniyn:boolean;                  //?Ƿ??Ѿ???ʼѹ??¼??
  flycomyn:boolean;               //?Ƿ???ʱѹ??
  capyn:boolean;                  //?Ƿ???ʾ??Ļ
  timeyn:boolean;                 //?Ƿ???ʾʱ??
  camaddryn:boolean;              //?Ƿ???ʾ????ͷ?ص?
  videosaveyn:boolean;            //?Ƿ񱣴?¼??
  mostartyn:boolean;              //?Ƿ???????????????¼??
  sendalapicyn:boolean;           //?Ƿ????;???ͼƬ
  alamusicyn:boolean;             //?Ƿ񲥷ž???????
  alamsgyn:boolean;               //?Ƿ񵯳???????ʾ
  alayn:boolean;                  //?Ƿ?????????
  oldimayn:boolean;               //?Ƿ??Ѿ????뵱ǰͼƬ??Ӧ?ĶԱ?ͼƬ??ֵ
  alapiclistyn:boolean;           //?Ƿ????????ɾ???ͼƬ?б?
  alapiclist:Tstringlist;         //????ͼƬ?б?
  capfont:Tfont;                  //??Ļ????
  timefont:Tfont;                 //ʱ??????
  camaddrfont:Tfont;              //????ͷ?ص?????
  todayvideoname:string;          //????¼???ļ?????
  stopok:boolean;                 //?Ƿ?????¼??????
  bitmap:Tbitmap;                 //ԭʼ??ȡ??ͼƬ
  timecapbitmap:Tbitmap;          //????ʱ????ͼƬ
  whtempbitmap:Tbitmap;           //???????ߺ???ͼƬ
  oldbitmap:Tbitmap;              //?뵱ǰͼƬ??Ӧ?ĶԱ?ͼƬ
  canputshow:boolean;             //?Ƿ????Ը????ؼ?
  setshowyn:boolean;              //???ý????Ƿ?????
  alajpg:TJpegImage;              //???ڰ?bmpͼƬת????jpgͼƬ
  todaypath:string;                //???????ļ?????·??
  getjpgyn:boolean;               //?Ƿ???ͼ
  getjpgname:string;              //??ͼ????
  sendjpgyn:boolean;              //?Ƿ????ͽ?ͼ
  isnurcon:boolean;              //?Ƿ?????????
end;
const
  channellimit:integer=36;        //·??????
  channelque:array[1..9] of String=(
  '2??2=4 ·',
  '3??2=6 ·',
  '3??3=9 ·',
  '4??3=12 ·',
  '4??4=16 ·',
  '5??4=20 ·',
  '5??5=25 ·',
  '6??5=30 ·',
  '6??6=36 ·');  //????ͷ?ṹ??????
var
  tdrmcammainForm: TtdrmcammainForm;
  apppath:string;                  //????·??
  mattas:string;                   //MAC??ַ
  softstartyn:boolean;             //?Ƿ񿪻??Զ?????
  softstarttime:Tdatetime;         //????????ʱ??ʱ??
  ustim:integer;                   //ʹ??ʱ?䣨?̶?ֵ(Timer???ж????ļ???ʱ??)??????????
  SysDev:TSysDevEnum;              //ϵͳ?豸
  campro:array[0..37] of Tcampro;  //????ͷ?ṹ??????
  camimage:Timage;                 //????ͷ??ʾ?õ?image
  camwhimg:Timage;                 //?????߿??õ?image
  camFilterGraph:TFilterGraph;     //????ͷ??׽ͼƬ?ؼ?01
  camVideoWindow:TVideoWindow;     //????ͷ??׽ͼƬ?ؼ?02
  camFilter:TFilter;               //????ͷ??׽ͼƬ?ؼ?03
  camSampleGrabber:TSampleGrabber; //????ͷ??׽ͼƬ?ؼ?04
  camAviWriter:TAviWriter_2;       //¼??ѹ?ƿؼ?
  camtimer:Ttimer;                 //¼??ͼƬ??׽?????ؼ?
  camnamelist:Tstringlist;         //ϵͳ?豸???ƺͱ????б???ȫ????
  camnamelistleft:Tstringlist;     //ϵͳ?豸???ƺͱ????б?????ǰ???ã?
  campdproyn:boolean;              //?Ƿ????????뱣??
  vioceyn:boolean;                 //?Ƿ?????¼??
  ziping:boolean;                  //ѹ????????
  alapicsendi:integer;             //?????еľ???ͼƬ??????????ͷ????
  alapicsendingyn:boolean;         //????ͼƬ??????
  raqyn:boolean;                   //ע??????1
  zrcyn:boolean;                   //ע??????2
  iebyn:boolean;                   //ע??????3
  clistr:string;                   //??MACת???ɵ?clistr?ִ???????ע????·??????
  ziplist:Tstringlist;             //??ѹ??????ͼƬ???ڽṹ???????б?
  zipsendlist:Tstringlist;         //?????;???ͼƬѹ???ļ??б?
  sendmailalapichrd: Thandle;      //????ͼƬ?????߳̾???
  sendmailalapicTrdID: DWord;      //????ͼƬ?????߳?id
  sendmailavoiclohrd: Thandle;     //???ر??ʼ??????߳̾???
  sendmailavoicloTrdID: DWord;     //???ر??ʼ??????߳?id
  zipfilehrd: Thandle;     //???ر??ʼ??????߳̾???
  zipfileTrdID: DWord;     //???ر??ʼ??????߳?id
//  Critical1,Critical2,Critical3:TRTLCriticalSection;
  regedyn:boolean;                 //?Ƿ?ע??
  pbshow:integer;                  //??ʾ??????
  ver:string;                      //?????汾
  ossyspath:string;                //????ϵͳsystem32·??
  spgetbmppath:string;             //????ȡͼ·??
  upd:Tstringlist;                 //??????Ϣ?б?
  prodllhandle:thandle ;           //???????̱???dll
  hloopHandle:Thandle ;            //?????????߳̾???
  dloopThreadID:DWORD ;            //?????????߳?id
  prosta:procedure(pid: DWORD); stdcall;  //??ʼ???̱???
  proend:procedure(); stdcall;            //???????̱???
  alamsgshowyn:boolean;            //?Ƿ??Ѿ???ʾ??????ʾ
  spgetbmp:boolean;                //?Ƿ????ڿ???ȡͼ״̬
  commaclist:Tstringlist;          //ѹ?????б?
  rOld:TRect;                      //ѡ??????ʱ?ľɻ???
  channelselectstr:string;         //ͨ??ѡ???ִ?
  channelshowcount:integer;        //??????ʾ??·??
  hchannel:integer;                //??·??
  vchannel:integer;                //??·??
  savepath:string;                 //?ļ?????·??
  runlog:Tstringlist;              //??????־
  runlogcount:integer;             //??????־??Ŀ
  oldsysdatetime:Tdatetime;        //??ϵͳʱ??
  wrongdtin:integer;               //ϵͳʱ?????Ĵ???
  restarting:boolean;              //?????Ƿ???????????
  softskin:integer;                //????Ƥ??????
  scrtime:integer;                 //??ʱ??ͼʱ??????
  camproyn:boolean;                //?Ƿ?Զ?̱???
  camorderyn:boolean;                //?Ƿ?Զ??ָ??
  prosendnum:integer;              //Զ?̱??????Ƽ???
  NotifyIcon: TNotifyIconData;     //????ͼ??
  orderlist:Tstringlist;           //ָ???б?
  doordering:boolean;              //?Ƿ?????ִ??ָ??
  fullscreenyn:boolean;            //?Ƿ?ȫ??
  lasttime:string;                 //?ϴα?????¼??ʱ??
  sendhelp:boolean;                //?Ƿ?????ָ?????÷???
  getscryn:boolean;                //?Ƿ??Ѿ?????
  getscrfi:string;                 //??????ȡ??ͼƬ·??
  timedo:string;                   //??ʱ????ִ??ʱ??
  dotype:integer;                  //??ʱ????????
  dostext:string;                  //ִ?е???????
  exedos:boolean;                  //ִ????????
  backdostext:string;              //ִ?е??????з??ؽ???
  backdosfilets:Tstringlist;       //ִ?е??????з??ؽ???????
  backdos:boolean;                 //ִ????????
  cmding:boolean;                  //??ִ????????
  batpath:string;                  //ִ?е????????ļ???
  smtptype:string;                 //SMTP????״̬
  todayvoicename:string;           //¼??????
  alamodelTS:Tstringlist;          //????ģʽ?б?
  testconnecting:boolean;          //?Ƿ?????̽??????ͷ????
  timer3i:integer;                 //timer3ִ?д???

implementation

uses controlpas, PBar, alamsg, reg,EnDestr,md5, Cammain, view;


{$R *.dfm}
procedure TtdrmcammainForm.CreateWav( channels : word; { 1(????)????2(??????) }
resolution : word; { 8????16,????8λ??16λ???? }
rate : longint; { ????Ƶ??,??11025,22050, 44100}
fn : string { ??Ӧ???ļ????? } );
var
wf : file of TWavHeader;
wh : TWavHeader;
begin
wh.rId := $46464952; 
wh.rLen := 36; 
wh.wId := $45564157; 
wh.fId := $20746d66; 
wh.fLen := 16; 
wh.wFormatTag := 1; 
wh.nChannels := channels; 
wh.nSamplesPerSec := rate; 
wh.nAvgBytesPerSec := channels*rate*(resolution div 8);
wh.nBlockAlign := channels*(resolution div 8);
wh.wBitsPerSample := resolution;
wh.dId := $61746164; 
wh.wSampleLength := 0; 

assignfile(wf,fn); {?򿪶?Ӧ?ļ? } 
rewrite(wf); {?ƶ?ָ?뵽?ļ?ͷ} 
write(wf,wh); {д???ļ?ͷ } 
closefile(wf); {?ر??ļ? } 
end;

procedure TtdrmcammainForm.EndMsg(var nMsg: TWMQueryEndSession);
begin
  //0 ????ȡ???ػ?????
  //nMsg.Result := 1;
  nMsg.Result := 0;
  ShowMessage('???ȹرձ????????ٽ???ע???????????ػ???????лл??');
end;

{procedure CheckResult(b: Boolean);
begin
if not b then
Raise Exception.Create(SysErrorMessage(GetLastError));
end;

function RunDOS(const CommandLine: String): String;
var
HRead,HWrite:THandle;
StartInfo:TStartupInfo;
ProceInfo:TProcessInformation;
b:Boolean;
sa:TSecurityAttributes;
inS:THandleStream;
sRet:TStrings;
begin
Result := '';
FillChar(sa,sizeof(sa),0); 
//?????????̳У???????NT??2000???޷?ȡ??????????
sa.nLength := sizeof(sa);
sa.bInheritHandle := True;
sa.lpSecurityDescriptor := nil; 
b := CreatePipe(HRead,HWrite,@sa,0); 
CheckResult(b);

FillChar(StartInfo,SizeOf(StartInfo),0); 
StartInfo.cb := SizeOf(StartInfo);
StartInfo.wShowWindow := SW_HIDE; 
//ʹ??ָ???ľ?????Ϊ??׼???????????ļ?????,ʹ??ָ??????ʾ??ʽ 
StartInfo.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
StartInfo.hStdError := HWrite; 
StartInfo.hStdInput := GetStdHandle(STD_INPUT_HANDLE);//HRead; 
StartInfo.hStdOutput := HWrite;

b := CreateProcess(nil,//lpApplicationName: PChar 
PChar(CommandLine), //lpCommandLine: PChar
nil, //lpProcessAttributes: PSecurityAttributes 
nil, //lpThreadAttributes: PSecurityAttributes 
True, //bInheritHandles: BOOL
CREATE_NEW_CONSOLE, 
nil, 
nil,
StartInfo, 
ProceInfo );

CheckResult(b);
WaitForSingleObject(ProceInfo.hProcess,INFINITE);

inS := THandleStream.Create(HRead);
if inS.Size>0 then
begin
    sRet := TStringList.Create;
    sRet.LoadFromStream(inS);
    Result := sRet.Text;
    sRet.Free;
end; 
inS.Free;

CloseHandle(HRead);
CloseHandle(HWrite); 
end;}

function ExecCommands(commands: array of string): string;                           //ִ???????У?????ȡ?????ı?
var
  vSecurityAttributes: TSecurityAttributes;
  vReadPipe, vWriteFile, vWritePipe, vReadFile: THandle;
  vStartupInfo: TStartupInfo;
  vProcessInfo: TProcessInformation;
  I: Integer;
  vBuffer: array[0..4096] of char;
  vSize: Longword;
begin
  try
    Result := '';
    
    FillChar(vSecurityAttributes, SizeOf(TSecurityAttributes), 0);
    vSecurityAttributes.nLength := SizeOf(TSecurityAttributes);
    vSecurityAttributes.bInheritHandle := True;
    vSecurityAttributes.lpSecurityDescriptor := nil;
    CreatePipe(vReadPipe, vWriteFile, @vSecurityAttributes, 0);
    CreatePipe(vReadFile, vWritePipe, @vSecurityAttributes, 0);

    FillChar(vStartupInfo,Sizeof(StartupInfo), #0);
    vStartupInfo.cb := Sizeof(StartupInfo);
    vStartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
    vStartupInfo.wShowWindow := SW_HIDE;
    vStartupInfo.hStdInput := vReadPipe;
    vStartupInfo.hStdOutput := vWritePipe;
    vStartupInfo.hStdError := vWritePipe;

    if not CreateProcess(nil, 'cmd.exe', @vSecurityAttributes,
      @vSecurityAttributes, True, NORMAL_PRIORITY_CLASS,
      nil, nil, vStartupInfo, vProcessInfo) then Exit;

    for I := Low(commands) to High(commands) do
    begin
      WriteFile(vWriteFile, PChar(commands[I])^, Length(commands[I]), vSize, nil);
      WriteFile(vWriteFile, #13#10, 2, vSize, nil);
    end;
    WriteFile(vWriteFile, 'exit'#13#10#0, 7, vSize, nil);
    WaitforSingleObject(vProcessInfo.hProcess, INFINITE);
    repeat
      ReadFile(vReadFile, vBuffer, SizeOf(vBuffer), vSize, nil);
      Result := Result + Copy(vBuffer, 1, vSize);
    until vSize < SizeOf(vBuffer);
    CloseHandle(vProcessInfo.hProcess);
    CloseHandle(vProcessInfo.hThread);
    CloseHandle(vReadFile);
    CloseHandle(vWriteFile);
    CloseHandle(vReadPipe);
    CloseHandle(vWritePipe);
  except
  end;
end;

function IsFileInUse(AName: string): boolean;                                 //?ж??ļ??Ƿ???ռ??
var
  hFileRes: HFILE;
begin
  try
    Result := False;
    if not FileExists(AName) then exit;
    hFileRes := CreateFile(PChar(AName), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    Result := hFileRes = INVALID_HANDLE_VALUE;
    if not Result then
      CloseHandle(hFileRes);
  except
  end;
end;

function GetSoftList(nameyn,versionyn,pathyn,fullnameyn,pubcomyn:boolean;var sl:Tstringlist):boolean;
var
  myreg:TRegistry;
  myList:TStringList;
  i:integer;
  curkey,SName:string;
begin
  try
    result:=false;
    sl.Clear;
    myreg:=TRegistry.Create;
    MyList:=TStringList.Create;
    myreg.RootKey:=HKEY_LOCAL_MACHINE;
    if myreg.OpenKey('Software\Microsoft\Windows\CurrentVersion\uninstall',False) then
    Begin
      myreg.GetKeyNames(myList);
      curkey:=myreg.CurrentPath;
      myreg.CloseKey;
      for i:=0 to MyList.Count-1 do
      if myreg.OpenKey(curKey+'\'+MyList.Strings[i],False) then
      Begin
        if nameyn then
        Begin
          if myreg.ValueExists('DisplayName') then
            Sname:='???????ƣ?'+myreg.ReadString('DisplayName')
          else
            SName:=MyList.Strings[i];
        end;
        if versionyn then
        Begin
          if myreg.ValueExists('DisplayVersion') then
            Sname:=Sname+'?汾??'+myreg.ReadString('DisplayVersion')
          else
            SName:=MyList.Strings[i];
        end;
        if pathyn then
        Begin
        if myreg.ValueExists('InstallLocation') then
          Sname:=Sname+'·????'+myreg.ReadString('InstallLocation')
        else
          SName:=MyList.Strings[i];
        end;
        if fullnameyn then
        Begin
        if myreg.ValueExists('DisplayIcon') then
          Sname:=Sname+'ȫ???ƣ?'+myreg.ReadString('DisplayIcon')
        else
          SName:=MyList.Strings[i];
        end;
        if pubcomyn then
        Begin
        if myreg.ValueExists('Publisher') then
          Sname:=Sname+'?????ߣ?'+myreg.ReadString('Publisher')
        else
          SName:=MyList.Strings[i];
        end;
        sl.Add(SName);
        myreg.CloseKey;
      end;
    end;
    result:=true;
  except
    result:=false;
  end;
end;

function rarfile(desfilename,sorpath,pass:string):boolean;                           //????winrarѹ???ļ?
var
i:integer;
winrarpath:string;
softlist:Tstringlist;
begin
  //Memo1.Text := ExecCommands(['cd C:\Program Files\WinRAR\', 'start /wait WinRAR.exe a c:\p123.rar D:\??¼\ -r -ibck']);
  //showmessage('????');
  try
    Result:=false;
    winrarpath:='';
    softlist:=Tstringlist.Create;
    softlist.Clear;
    GetSoftList(true,false,true,true,false,softlist);
    for i:=0 to softlist.Count-1 do
      if pos('WINRAR.EXE',uppercase(softlist.Strings[i]))>0 then
        winrarpath:=copy(softlist.Strings[i],pos('·????',softlist.Strings[i])+6,pos('ȫ???ƣ?',softlist.Strings[i])-pos('·????',softlist.Strings[i])-6);
    if length(winrarpath)=0 then
      Exit;
    if winrarpath[length(winrarpath)]<>'\' then
      winrarpath:=winrarpath+'\';
    ExecCommands(['cd '+winrarpath, 'start /wait WinRAR.exe a '+desfilename+' '+sorpath+' -ibck -hp'+pass+' -ep']);//
    Result:=true;
  except
    Result:=false;
  end;
end;

function TtdrmcammainForm.randomizesl(var ressl:Tstringlist;sl:Tstringlist):boolean;  //??stringlist?????ַ???˳??????????????
var
i,j:integer;
aladd,standstr:string;
resuts:Tstringlist;
allin:boolean;
begin
  try
    allin:=false;
    aladd:='';
    standstr:='';
    resuts:=Tstringlist.Create;
    resuts.Clear;
    for i:=4 to upd.Count-1 do
     standstr:=standstr+inttostr(i)+',';
    randomize;
    j:=random(upd.Count);
    while not allin do
    begin
      allin:=true;
      for i:=4 to upd.Count-1 do
        if (pos(inttostr(i)+',',aladd)=0) then
        begin
          allin:=false;
        end;
      if allin then
        break;
      if (pos(inttostr(j)+',',aladd)=0)and(pos(inttostr(j)+',',standstr)>0) then
      begin
        resuts.Add(upd.Strings[j]);
        aladd:=aladd+inttostr(j)+',';
      end;
      randomize;
      j:=random(upd.Count);
    end;
    ressl.Clear;
    for i:=0 to resuts.Count-1 do
     ressl.Add(resuts.Strings[i]);
    resuts.Free;
  except
  end;
end;

function TtdrmcammainForm.CheckUrl(url: string; TimeOut:integer=3000): boolean;        //?ж?????????
var
hSession, hfile, hRequest: hInternet;
dwindex, dwcodelen: dword;
dwcode: array[1..20] of char;
res: pchar;
re: integer;
Err1: integer;
j: integer;
begin
  try
    if pos('http://', lowercase(url)) = 0 then
      url := 'http://' + url;
    Result := false;
    hSession := InternetOpen('Mozilla/4.0', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
    InternetSetOption(hSession, Internet_OPTION_CONNECT_TIMEOUT, @TimeOut, 4);
    if assigned(hsession) then
    begin
      j := 1;
      while true do
      begin
        hfile := InternetOpenUrl(hsession, pchar(url), nil, 0, INTERNET_FLAG_RELOAD, 0);
        if hfile = nil then
        begin
          j := j + 1;
          Err1 := GetLastError;
          if j > 5 then
            break;
          if (Err1 <> 12002) or (Err1 <> 12152) then
            break;
          sleep(2000);
        end
        else
          break;
      end;
      dwIndex := 0;
      dwCodeLen := 10;
      HttpQueryInfo(hfile, HTTP_QUERY_STATUS_CODE, @dwcode, dwcodeLen, dwIndex);
      res := pchar(@dwcode);
      re := strtointdef(res, 404);
      case re of
        200..299: result := True;
        401..403: result := True;
      else
        result := False;
      end;
      if assigned(hfile) then
      InternetCloseHandle(hfile);
    InternetCloseHandle(hsession);
    end;
  except
    result := False;
  end;
end;

function TtdrmcammainForm.GetUrlContent(var urlcon:string;url: string; TimeOut:integer=3000): boolean;        //??ȡ??ҳ????
var
  Content: string;
  NetHandle: HINTERNET;
  UrlHandle: HINTERNET;
  BytesRead: DWORD;
  Buffer: array[1..1024] of Char;
begin
  try
    Result:=false;
    urlcon:='';
    NetHandle := InternetOpen('htmlcopy 0.4b', INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
    InternetSetOption(NetHandle, Internet_OPTION_CONNECT_TIMEOUT, @TimeOut, 4);
    if Assigned(NetHandle) then
    begin
      UrlHandle := InternetOpenUrl(NetHandle, PChar(url), nil, 0, INTERNET_FLAG_RELOAD, 0);
      if Assigned(UrlHandle) then
      begin
        urlcon := '';
        repeat
          FillChar(Buffer, SizeOf(Buffer), 0);
          InternetReadFile(UrlHandle, @Buffer[1], SizeOf(Buffer), BytesRead);
          Content := Content + Copy(Buffer, 1, BytesRead);
        until BytesRead = 0;
        urlcon := Content;
      end;
      InternetCloseHandle(UrlHandle);
    end;
    InternetCloseHandle(NetHandle);
    Result:=true;
    if (Result=false)or(length(urlcon)=0) then
    begin
      Result:=false;
      urlcon:='';
    end;
  except
    Result:=false;
    urlcon:='';
  end;
end;

function TtdrmcammainForm.DownloadFile(Source, Dest: string): Boolean;          //?????ļ?
begin
try
 Result := UrlDownloadToFile(nil, PChar(source), PChar(Dest), 0, nil) = 0;
except
 Result := False;
end;
end;

procedure TtdrmcammainForm.DeleteMe;
var
  BatchFile: TextFile;
  BatchFileName: string;
  ProcessInfo: TProcessInformation;
  StartUpInfo: TStartupInfo;
begin
  try
    BatchFileName := ExtractFilePath(ParamStr(0)) + '_deleteme.bat';
    AssignFile(BatchFile, BatchFileName);
    Rewrite(BatchFile);

    Writeln(BatchFile, ':try');
    Writeln(BatchFile, 'del "' + ParamStr(0) + '"');
    Writeln(BatchFile,
      'if exist "' + ParamStr(0) + '"' + ' goto try');
    Writeln(BatchFile, 'del %0');
    CloseFile(BatchFile);

    FillChar(StartUpInfo, SizeOf(StartUpInfo), $00);
    StartUpInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartUpInfo.wShowWindow := SW_HIDE;
    if CreateProcess(nil, PChar(BatchFileName), nil, nil,
      False, IDLE_PRIORITY_CLASS, nil, nil, StartUpInfo,
      ProcessInfo) then
    begin
      CloseHandle(ProcessInfo.hThread);
      CloseHandle(ProcessInfo.hProcess);
    end;
  except
  end;
end;

function TtdrmcammainForm.ComponentToString(Component:TComponent):string;//????ת??Ϊ?ַ?
var
BinStream:TMemoryStream;
StrStream:TStringStream;
s:string;
begin
    BinStream:=TMemoryStream.Create;
    try
        StrStream:=TStringStream.Create(s);
        try
            BinStream.WriteComponent(Component);
            BinStream.Seek(0,soFromBeginning);
            ObjectBinaryToText(BinStream,StrStream);
            StrStream.Seek(0,soFromBeginning);
            Result:=StrStream.DataString;
        finally
            freeandnil(StrStream);
        end;
    finally
        freeandnil(BinStream)
    end; 
end;

function TtdrmcammainForm.StringToComponent(Value:string):TComponent;//?ַ?ת??Ϊ????
var
StrStream:TStringStream;
BinStream:TMemoryStream;
begin
    StrStream:=TStringStream.Create(Value);
    try
        BinStream:=TMemoryStream.Create;
        try
            ObjectTextToBinary(StrStream,BinStream);
            BinStream.Seek(0,soFromBeginning);
            Result:=BinStream.ReadComponent(nil);
        finally
            freeandnil(BinStream);
        end;
    finally
        freeandnil(StrStream);
    end;
end;
function TtdrmcammainForm.fontTostr(V:Tfont):string;//????ת??Ϊ?ַ?
var 
    fd:TFontDialog;
begin 
  try
    fd:=TFontDialog.Create(nil);
    fd.Font.Assign(v);
    Result:=ComponentToString(fd);
    FreeAndNil(fd);
    Result:=StringReplace(Result,#13,' ',[rfReplaceAll]);
    Result:=StringReplace(Result,#13,'; ',[rfReplaceAll]);
  except
  end;
end;

function TtdrmcammainForm.strTofont(V:string;font:Tfont):boolean;//?ַ?ת??Ϊ????
var 
    fd:TFontDialog;
begin 
    Result:=false;
    if v=' ' then
        exit;
    try 
        V:=StringReplace(v,'; ',#13,[rfReplaceAll]);
        fd:=TFontDialog(StringToComponent(V));
        font.Assign(fd.Font);
        FreeAndNil(fd);
        Result:=true;
    except;
    end;
end;

function TtdrmcammainForm.GetFileSizem(const FileName: string):integer;//??ȡ?ļ???С???˷???ִ?????ɻ??Զ??ر??ļ?
var
f: TFileStream;
begin 
  try
   if FileExists(FileName) then
   begin
      f:=TFileStream.Create(FileName,fmOpenRead or fmShareDenyNone);
      Result:=f.Size;
      F.Free;
   end
   else
      Result:=0;
  except
  end;
end;

function {TtdrmcammainForm.}DeleteDirectory(NowPath: string): Boolean; // ɾ??????Ŀ¼
var
  search: TSearchRec;
  ret: integer;
  key: string;
begin
  try
    if NowPath[Length(NowPath)] <> '\' then
      NowPath := NowPath + '\';
    key := NowPath + '*.*';
    ret := findFirst(key, faanyfile, search);
    while ret = 0 do
    begin
      if ((search.Attr and fadirectory) = fadirectory) then
      begin
        if (search.Name <> '.') and (search.name <> '..') then
          DeleteDirectory(NowPath + search.name);
      end
      else
      begin
        if ((search.Attr and fadirectory) <> fadirectory) then
        begin
          deletefile(NowPath + search.name);
        end;
      end;
      ret := FindNext(search);
    end;
    findClose(search);
    removedir(NowPath); //??????Ҫɾ???ļ?????????
    result := True;
  except
  end;
end;

function {TtdrmcammainForm.}ZipFileAndPath(const ASrcFilenamelist:Tstringlist;const ASrcFilepath,ADestFilename: string; const APassword: string): Boolean;    //ѹ???ļ????ɺ??ļ???
var
  VCLZip: TVCLZip;
begin
  VCLZip := TVCLZip.Create(nil);
  with VCLZip do
  try
    try
      ZipName:=ADestFilename;
      RootDir:=ASrcFilepath;    //?ļ???????·??
      OverwriteMode:=Always;//???Ǹ???
      AddDirEntriesOnRecurse:=true;
      DoAll:=true;//ѹ???????ļ?
      RelativePaths:=true;//?Ƿ񱣳?Ŀ¼?ṹ
      Password := APassword;
      RecreateDirs := True;
      StorePaths := true;
      MultiZipInfo.MultiMode   :=   mmNone;
      FilesList.Text:=ASrcFilenamelist.Text;
      //?ļ?????Ҫѹ?????ļ???????Ҫȫ??????ֱ????'*.*' ????ֱ?Ӱ?RootDir????Ϊ?ļ???·??????????????û???ļ???
      Recurse := True;
      Zip;
      Result := True;
    except
      Result := False;
    end;
  finally
    Free;
  end;
end;

function TtdrmcammainForm.KillTask(ExeFileName:string):boolean;     //?رս???
const
 PROCESS_TERMINATE = $0001;
var
 ContinueLoop: BOOLean;
 clotryn:integer;
 FSnapshotHandle: THandle;
 FProcessEntry32: TProcessEntry32;
begin
 try
   Result:=false;
   clotryn:=0;
   FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
   FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
   ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
   while Integer(ContinueLoop) <> 0 do
   begin
     if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=UpperCase(ExeFileName))or(UpperCase(FProcessEntry32.szExeFile)=UpperCase(ExeFileName)))then
       clotryn := Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE,BOOL(0),FProcessEntry32.th32ProcessID),0));
     if clotryn<>0 then
       Result:=true;
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
   end;
   CloseHandle(FSnapshotHandle);
 except
 end;
end;

function TtdrmcammainForm.GetSystemPath:String; //???ò???ϵͳsystem32·??
var
  iLen:Integer;
begin
  try
    iLen:=GetSystemDirectory(@Result[1],0);
    SetLength(Result,iLen);
    GetSystemDirectory(@Result[1],iLen);
    Result[iLen]:='\';
  except
  end;
end;

procedure TtdrmcammainForm.Softrestart(Sender: TObject);        //????????
begin
  if restarting then
    Exit;
  restarting:=true;
  tdrmcammainForm.FormDestroy(nil);
  tdrmcammainForm.FormCreate(nil);
  tdrmcammainForm.FormShow(nil);
  restarting:=false;
end;
function TtdrmcammainForm.getupdateinfo: Boolean; // ??ȡ??????Ϣ
var
resfile:TResourceStream;
dllhandle:thandle ;
Tempsl:Tstringlist;
i,StartPos,EndPos,Len:integer;
urlcontent,Tempstr,yesstr:string;
begin
   try
     Result:=false;
     ver:='';
     urlcontent:='';
     Tempstr:='';
     yesstr:='';
     ver:=tdrmcammainForm.verLbl.Hint;
     upd:=Tstringlist.Create;
     Tempsl:=Tstringlist.Create;
     if fileexists(apppath+'setting.ini')then
     begin
       upd.LoadFromFile(apppath+'setting.ini');
       ver:=upd.Strings[0];
     end;
     upd.Clear;
     if GetUrlContent(urlcontent,'http://www.taiderui.com/cam/100/verup.html',3000)  then
     begin    //showmessage(urlcontent);
        Tempsl.Text:=urlcontent;
        for i:=0 to Tempsl.Count-1 do
        begin
          if AnsiPos('>?ڲ??汾??<',Tempsl.Strings[i]) > 0 then
          begin
            yesstr:=yesstr+'?ڲ??汾';
            Tempstr:=Tempsl.Strings[i+1];
            StartPos:=AnsiPos('>&nbsp;', Tempstr) + Length('>&nbsp;');
            EndPos:=AnsiPos('</td>', Tempstr);
            Len:=EndPos-StartPos;
            Tempstr:=Copy(Tempstr,StartPos,Len);
            Tempstr:=Trim(Tempstr);
            upd.Add(Tempstr);
          end
          else if AnsiPos('>?????汾??<',Tempsl.Strings[i]) > 0 then
          begin
            yesstr:=yesstr+'?????汾';
            Tempstr:=Tempsl.Strings[i+1];
            StartPos:=AnsiPos('>&nbsp;', Tempstr) + Length('>&nbsp;');
            EndPos:=AnsiPos('</td>', Tempstr);
            Len:=EndPos-StartPos;
            Tempstr:=Copy(Tempstr,StartPos,Len);
            Tempstr:=Trim(Tempstr);
            upd.Add(Tempstr);
          end
          else if AnsiPos('>?? ?? ?ߣ?<',Tempsl.Strings[i]) > 0 then
          begin
            yesstr:=yesstr+'?? ?? ??';
            Tempstr:=Tempsl.Strings[i+1];
            StartPos:=AnsiPos('>&nbsp;', Tempstr) + Length('>&nbsp;');
            EndPos:=AnsiPos('</td>', Tempstr);
            Len:=EndPos-StartPos;
            Tempstr:=Copy(Tempstr,StartPos,Len);
            Tempstr:=Trim(Tempstr);
            upd.Add(Tempstr);
          end
          else if AnsiPos('>???????ڣ?<',Tempsl.Strings[i]) > 0 then
          begin
            yesstr:=yesstr+'????????';
            Tempstr:=Tempsl.Strings[i+1];
            StartPos:=AnsiPos('>&nbsp;', Tempstr) + Length('>&nbsp;');
            EndPos:=AnsiPos('</td>', Tempstr);
            Len:=EndPos-StartPos;
            Tempstr:=Copy(Tempstr,StartPos,Len);
            Tempstr:=Trim(Tempstr);
            upd.Add(Tempstr);
          end
          else if AnsiPos('>??????ַ??<',Tempsl.Strings[i]) > 0 then
          begin
            yesstr:=yesstr+'??????ַ';
            Tempstr:=Tempsl.Strings[i+1];
            StartPos:=AnsiPos('>&nbsp;', Tempstr) + Length('>&nbsp;');
            EndPos:=AnsiPos('</td>', Tempstr);
            Len:=EndPos-StartPos;
            Tempstr:=Copy(Tempstr,StartPos,Len);
            Tempstr:=Trim(Tempstr);
            upd.Add(Tempstr);
          end;
        end;
        if (pos('?ڲ??汾?????汾?? ?? ?߸?????????????ַ',yesstr)>0) then
          Result:=true;
     end;
  except
  end;
end;

function TtdrmcammainForm.Getparafromreg(j:integer): boolean;   //??ע??????ȡ?ؼ?????????ֵ
var
reg:Tregistry;
macstr:string;
i,k,l:integer;
begin
  try
    if j>channellimit then
    begin
      k:=0;
      l:=channellimit;
    end
    else
    begin
      k:=j;
      l:=j;
    end;
    result:=false;
    reg:=tregistry.create;
    with reg do //????д??ע??????????
    begin
      RootKey:=HKEY_CURRENT_USER;
      if OpenKey('SOFTWARE\TDR\tdrcamsoft',True) then
      begin
      if not ValueExists('softstartyn')then
        WriteString('softstartyn',Enstr1('0'));
      if (Destr1(ReadString('softstartyn'))='1')then
         softstartyn:=true
      else
         softstartyn:=false;
      if not ValueExists('savepath')then
        WriteString('savepath',Enstr1(apppath+'?????????ļ?\'));
      savepath:=Destr1(ReadString('savepath'));


      for i:=k to l do
        with campro[i] do
        begin
          if not ValueExists('frawid'+inttostr(i))then
             WriteString('frawid'+inttostr(i),Enstr1('400'));
          frawid:=strtoint(Destr1(ReadString('frawid'+inttostr(i))));
          if not ValueExists('frahei'+inttostr(i))then
             WriteString('frahei'+inttostr(i),Enstr1('300'));
          frahei:=strtoint(Destr1(ReadString('frahei'+inttostr(i))));
          if not ValueExists('flycomyn'+inttostr(i))then
             WriteString('flycomyn'+inttostr(i),Enstr1('1'));
          if (Destr1(ReadString('flycomyn'+inttostr(i)))='1')then
             flycomyn:=true
          else
             flycomyn:=false;
          if not ValueExists('comqua'+inttostr(i))then
             WriteString('comqua'+inttostr(i),Enstr1('2'));
          comqua:=strtoint(Destr1(ReadString('comqua'+inttostr(i))));
          if not ValueExists('videosaveyn'+inttostr(i))then
             WriteString('videosaveyn'+inttostr(i),Enstr1('0'));
          if (Destr1(ReadString('videosaveyn'+inttostr(i)))='1')then
             videosaveyn:=true
          else
             videosaveyn:=false;
          if not ValueExists('camproyn')then
             WriteString('camproyn',Enstr1('0'));
          if (Destr1(ReadString('camproyn'))='1')then
             camproyn:=true
          else
             camproyn:=false;

          if not ValueExists('camorderyn')then
             WriteString('camorderyn',Enstr1('0'));
          if (Destr1(ReadString('camorderyn'))='1')then
             camorderyn:=true
          else
             camorderyn:=false;
          if not ValueExists('mostartyn'+inttostr(i))then
             WriteString('mostartyn'+inttostr(i),Enstr1('0'));
          if (Destr1(ReadString('mostartyn'+inttostr(i)))='1')then
             mostartyn:=true
          else
             mostartyn:=false;
          if not ValueExists('capyn'+inttostr(i))then
             WriteString('capyn'+inttostr(i),Enstr1('0'));
          if (Destr1(ReadString('capyn'+inttostr(i)))='1')then
             capyn:=true
          else
             capyn:=false;
          if not ValueExists('capfont'+inttostr(i))then
             WriteString('capfont'+inttostr(i),Enstr1(fontTostr(capfontFod.Font)));
          strTofont(Destr1(ReadString('capfont'+inttostr(i))),capfont);
          if not ValueExists('capx'+inttostr(i))then
             WriteString('capx'+inttostr(i),Enstr1('60'));
          capx:=strtoint(Destr1(ReadString('capx'+inttostr(i))));
          if not ValueExists('capy'+inttostr(i))then
             WriteString('capy'+inttostr(i),Enstr1('60'));
          capy:=strtoint(Destr1(ReadString('capy'+inttostr(i))));
          if not ValueExists('captext'+inttostr(i))then
             WriteString('captext'+inttostr(i),Enstr1('????????Ļ'));
          captext:=Destr1(ReadString('captext'+inttostr(i)));
          if not ValueExists('camaddryn'+inttostr(i))then
             WriteString('camaddryn'+inttostr(i),Enstr1('0'));
          if (Destr1(ReadString('camaddryn'+inttostr(i)))='1')then
             camaddryn:=true
          else
             camaddryn:=false;
          if not ValueExists('camaddrfont'+inttostr(i))then
             WriteString('camaddrfont'+inttostr(i),Enstr1(fontTostr(camaddrfontFod.Font)));
          strTofont(Destr1(ReadString('camaddrfont'+inttostr(i))),camaddrfont);
          if not ValueExists('camaddrx'+inttostr(i))then
             WriteString('camaddrx'+inttostr(i),Enstr1('0'));
          camaddrx:=strtoint(Destr1(ReadString('camaddrx'+inttostr(i))));
          if not ValueExists('camaddry'+inttostr(i))then
             WriteString('camaddry'+inttostr(i),Enstr1('0'));
          camaddry:=strtoint(Destr1(ReadString('camaddry'+inttostr(i))));
          if not ValueExists('camaddr'+inttostr(i))then
             WriteString('camaddr'+inttostr(i),Enstr1('ͨ??'+formatdatetime('yyyymmddhhnnsszzz',now)));
          camaddr:=Destr1(ReadString('camaddr'+inttostr(i)));
          Timage(Self.FindComponent('camimage'+inttostr(i))).Hint:='????????̽ͷ'+inttostr(i)+',λ?ã?'+camaddr;
          if not ValueExists('camname'+inttostr(i))then
             WriteString('camname'+inttostr(i),Enstr1('û??'));
          camname:=Destr1(ReadString('camname'+inttostr(i)));
          if not ValueExists('timeyn'+inttostr(i))then
             WriteString('timeyn'+inttostr(i),Enstr1('1'));
          if (Destr1(ReadString('timeyn'+inttostr(i)))='1')then
             timeyn:=true
          else
             timeyn:=false;
          if not ValueExists('timefont'+inttostr(i))then
             WriteString('timefont'+inttostr(i),Enstr1(fontTostr(timefontFod.Font)));
          strTofont(Destr1(ReadString('timefont'+inttostr(i))),timefont);
          if not ValueExists('timex'+inttostr(i))then
             WriteString('timex'+inttostr(i),Enstr1('10'));
          timex:=strtoint(Destr1(ReadString('timex'+inttostr(i))));
          if not ValueExists('timey'+inttostr(i))then
             WriteString('timey'+inttostr(i),Enstr1('10'));
          timey:=strtoint(Destr1(ReadString('timey'+inttostr(i))));
          if not ValueExists('commaci'+inttostr(i))then
             WriteString('commaci'+inttostr(i),Enstr1('1'));
          commaci:=strtoint(Destr1(ReadString('commaci'+inttostr(i))));
          if not ValueExists('commac'+inttostr(i))then
             WriteString('commac'+inttostr(i),Enstr1(commaclist.Strings[commaci]));
          commac:=Destr1(ReadString('commac'+inttostr(i)));
          if not ValueExists('softskin')then
             WriteString('softskin',Enstr1('1'));
          softskin:=strtoint(Destr1(ReadString('softskin')));
          if not ValueExists('scrtime')then
             WriteString('scrtime',Enstr1('0'));
          scrtime:=strtoint(Destr1(ReadString('scrtime')));

          if not ValueExists('alayn'+inttostr(i))then
             WriteString('alayn'+inttostr(i),Enstr1('0'));
          if (Destr1(ReadString('alayn'+inttostr(i)))='1')then
             alayn:=true
          else
             alayn:=false;
          if not ValueExists('poselx'+inttostr(i))then
             WriteString('poselx'+inttostr(i),Enstr1('0'));
          poselx:=strtoint(Destr1(ReadString('poselx'+inttostr(i))));
          if not ValueExists('posely'+inttostr(i))then
             WriteString('posely'+inttostr(i),Enstr1('0'));
          posely:=strtoint(Destr1(ReadString('posely'+inttostr(i))));
          if not ValueExists('powid'+inttostr(i))then
             WriteString('powid'+inttostr(i),Enstr1('400'));
          powid:=strtoint(Destr1(ReadString('powid'+inttostr(i))));
          if not ValueExists('pohei'+inttostr(i))then
             WriteString('pohei'+inttostr(i),Enstr1('300'));
          pohei:=strtoint(Destr1(ReadString('pohei'+inttostr(i))));
          heiwid:=100/(powid*pohei);
          if not ValueExists('blueturn'+inttostr(i))then
             WriteString('blueturn'+inttostr(i),Enstr1('23'));
          blueturn:=strtoint(Destr1(ReadString('blueturn'+inttostr(i))));
          if not ValueExists('greenturn'+inttostr(i))then
             WriteString('greenturn'+inttostr(i),Enstr1('15'));
          greenturn:=strtoint(Destr1(ReadString('greenturn'+inttostr(i))));
          if not ValueExists('redturn'+inttostr(i))then
             WriteString('redturn'+inttostr(i),Enstr1('16'));
          redturn:=strtoint(Destr1(ReadString('redturn'+inttostr(i))));
          if not ValueExists('pointturn'+inttostr(i))then
             WriteString('pointturn'+inttostr(i),Enstr1('10'));
          pointturn:=strtoint(Destr1(ReadString('pointturn'+inttostr(i))));
          if not ValueExists('turnqua'+inttostr(i))then
             WriteString('turnqua'+inttostr(i),Enstr1('10'));
          turnqua:=strtoint(Destr1(ReadString('turnqua'+inttostr(i))));
          if not ValueExists('alastrlist'+inttostr(i))then
             WriteString('alastrlist'+inttostr(i),Enstr1('0000002359590010010000000000'));
          alastrlist.Text:=Destr1(ReadString('alastrlist'+inttostr(i)));
          if not ValueExists('alamodel'+inttostr(i))then
             WriteString('alamodel'+inttostr(i),Enstr1('0'));
          alamodel:=strtoint(Destr1(ReadString('alamodel'+inttostr(i))));
          if not ValueExists('alapiclast'+inttostr(i))then
             WriteString('alapiclast'+inttostr(i),Enstr1('10'));
          alapiclast:=strtoint(Destr1(ReadString('alapiclast'+inttostr(i))));
          nalapiclast:=alapiclast*25;
          if not ValueExists('campdproyn')then
             WriteString('campdproyn',Enstr1('1'));
          if not ValueExists('vioceyn')then
             WriteString('vioceyn',Enstr1('0'));
          if i=0 then
          begin
            if (Destr1(ReadString('campdproyn'))='1')then
               campdproyn:=true
            else
               campdproyn:=false;
            if (Destr1(ReadString('vioceyn'))='1')then
               vioceyn:=true
            else
               vioceyn:=false;
          end;
          if not ValueExists('filepassword'+inttostr(i))then
             WriteString('filepassword'+inttostr(i),Enstr1('123'));
          filepassword:=Destr1(ReadString('filepassword'+inttostr(i)));
          if not ValueExists('sendalapicyn'+inttostr(i))then
             WriteString('sendalapicyn'+inttostr(i),Enstr1('0'));
          if (Destr1(ReadString('sendalapicyn'+inttostr(i)))='1')then
             sendalapicyn:=true
          else
             sendalapicyn:=false;
          if not ValueExists('alamusicyn'+inttostr(i))then
             WriteString('alamusicyn'+inttostr(i),Enstr1('0'));
          if (Destr1(ReadString('alamusicyn'+inttostr(i)))='1')then
             alamusicyn:=true
          else
             alamusicyn:=false;
          if not ValueExists('alamsgyn'+inttostr(i))then
             WriteString('alamsgyn'+inttostr(i),Enstr1('0'));
          if (Destr1(ReadString('alamsgyn'+inttostr(i)))='1')then
             alamsgyn:=true
          else
             alamsgyn:=false;
          if not ValueExists('savedays'+inttostr(i))then
             WriteString('savedays'+inttostr(i),Enstr1('0'));
          savedays:=strtoint(Destr1(ReadString('savedays'+inttostr(i))));
          if not ValueExists('smtptxt'+inttostr(i))then
             WriteString('smtptxt'+inttostr(i),Enstr1('?˴???дSMTP??????'));
          smtptxt:=Destr1(ReadString('smtptxt'+inttostr(i)));
           if not ValueExists('pop3txt'+inttostr(i))then
             WriteString('pop3txt'+inttostr(i),Enstr1('?˴???дPOP3??????'));
          pop3txt:=Destr1(ReadString('pop3txt'+inttostr(i)));
          if not ValueExists('smtpporttxt'+inttostr(i))then
             WriteString('smtpporttxt'+inttostr(i),Enstr1('?˴???дSMTP?˿?'));
          smtpporttxt:=Destr1(ReadString('smtpporttxt'+inttostr(i)));
          if not ValueExists('pop3porttxt'+inttostr(i))then
             WriteString('pop3porttxt'+inttostr(i),Enstr1('?˴???дPOP3?˿?'));
          pop3porttxt:=Destr1(ReadString('pop3porttxt'+inttostr(i)));
          if not ValueExists('mailuser'+inttostr(i))then
             WriteString('mailuser'+inttostr(i),Enstr1('?˴???д?û???'));
          mailuser:=Destr1(ReadString('mailuser'+inttostr(i)));
          if not ValueExists('mailpassword'+inttostr(i))then
             WriteString('mailpassword'+inttostr(i),Enstr1('?˴???д????'));
          mailpassword:=Destr1(ReadString('mailpassword'+inttostr(i)));
          if not ValueExists('recuser'+inttostr(i))then
             WriteString('recuser'+inttostr(i),Enstr1('?˴???д?ռ??ˣ????û??ð??Ƕ??Ÿ???'));
          recuser:=Destr1(ReadString('recuser'+inttostr(i)));
          if not ValueExists('musicpath'+inttostr(i))then
             WriteString('musicpath'+inttostr(i),Enstr1(apppath+'alarm1.mp3'));
          musicpath:=Destr1(ReadString('musicpath'+inttostr(i)));
        end;
      end;
    end;
    reg.Free;
   asm
   db $EB,$10,'VMProtect begin',0
   end;
   mattas:=regForm.getmpstr(3);
   clistr:='{'+copy(mattas,1,8)+'-'+copy(mattas,10,4)+'-'+copy(mattas,2,4)+'-'+copy(mattas,5,4)+'-'+copy(mattas,3,12)+'}';
   reg:=tregistry.create;
   with reg do //????д??ע??????????
      begin
         RootKey:=HKEY_CLASSES_ROOT;
         if OpenKey('CLSID\'+clistr,True) then
         begin
            if not ValueExists('bfc')then
               WriteString('bfc',Enstr1('000'));
            if not ValueExists('tqr')then
               WriteString('tqr',Enstr1('000'));
            if not ValueExists('ebt')then
               WriteString('ebt',Enstr1('000'));
            if not ValueExists('orp')then
               WriteString('orp',Enstr1('000'));
            if not ValueExists('cst')then
               WriteString('cst',Enstr1('000'));
            if not ValueExists('zgk')then
               WriteString('zgk',Enstr1('000'));
               //showmessage('CLSID\'+clistr);
            if (length(ReadString('ebt'))>23)and(length(ReadString('bfc'))>9) then
              if copy(Destr1(ReadString('ebt')),2,23)+copy(Destr1(ReadString('bfc')),4,9)=uppercase(md5.MD5Print(md5.MD5String('LGX!@#'+mattas))) then
              begin
              raqyn:=true;
              zrcyn:=true;
              iebyn:=true;
              end;
         end;
         closekey;
         free;
      end;
   asm
   db $EB,$0E,'VMProtect end',0
   end;

   result:=true;
  except
  result:=false;
  end;
end;

{procedure TtdrmcammainForm.SysCommand(var SysMsg: TMessage);                                  //??׽??С????????
begin
  case SysMsg.WParam of
    SC_MINIMIZE: // ????С??ʱ
    begin
      SetWindowPos(Application.Handle, HWND_NOTOPMOST, 0, 0, 0, 0,SWP_HIDEWINDOW);
      Hide; // ???????????س???
      // ??????????ʾͼ??
      with NotifyIcon do
      begin
        cbSize := SizeOf(TNotifyIconData);
        Wnd := Handle;
        uID := 1;
        uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
        uCallBackMessage := WM_NID;
        hIcon := Application.Icon.Handle;
        szTip := '???̳???';
      end;
      Shell_NotifyIcon(NIM_ADD, @NotifyIcon); // ??????????ʾͼ??
    end;
    else
      inherited;
  end;
end;}
procedure TtdrmcammainForm.WMNID(var msg: TMessage);
var
mousepos: TPoint;
begin
  GetCursorPos(mousepos); //??ȡ????λ??
  case msg.LParam of
    WM_LBUTTONUP: // ??????????????????
    begin
      //tdrmcammainForm.Visible := not tdrmcammainForm.Visible; // ??ʾ??????????
      numwin;
      //tdrmcammainForm.Show; // ??ʾ??????
      //Shell_NotifyIcon(NIM_DELETE, @NotifyIcon); // ??ʾ????????ɾ??????????ͼ??
      //SetWindowPos(Application.Handle, HWND_TOP, 0, 0, 0, 0, SWP_SHOWWINDOW); //??????????ʾ????
    end;
    WM_RBUTTONUP: rightPM.Popup(mousepos.X, mousepos.Y); // ?????˵?
  end;
end;

procedure TtdrmcammainForm.PutParatoshow(Sender: TObject);//???ؼ?????????ֵ?????ؼ???????
var
i,j,k:integer;
camtempname:Pwidechar;
begin
  try
    if Sender=nil then
      i:=0
    else
      i:=strtoint(copy(Timage(Sender).Name,9,length(Timage(Sender).Name)));
    with campro[i],mainForm do
    begin
      camnameCoB.ItemIndex:=-1;
      frawidSdt.Value:=0;
      fraheiSdt.Value:=0;
      flycomynCkb.Checked:=false;
      commacCob.ItemIndex:=-1;
      comquaCob.ItemIndex:=-1;
      videosaveynCkb.Checked:=false;
      savepathEdt.Text:='';
      camproynCkb.Checked:=false;
      camorderynCkb.Checked:=false;
      softstartynCkb.Checked:=false;
      mostartynCkb.Checked:=false;
      capynCkb.Checked:=false;
      capxSdt.Value:=0;
      capySdt.Value:=0;
      captextEdt.Text:='';
      timeynCkb.Checked:=false;
      timexSdt.Value:=0;
      timeySdt.Value:=0;
      camaddrynCkb.Checked:=false;
      camaddrxSdt.Value:=0;
      camaddrySdt.Value:=0;
      camaddrEdt.Text:='';
      softskinCob.ItemIndex:=-1;
      scrtimeCob.ItemIndex:=-1;
      alaynCkb.Checked:=false;
      poselxSdt.Value:=0;
      poselySdt.Value:=0;
      powidEdt.Text:='';
      poheiEdt.Text:='';
      blueturnTcb.Position:=0;
      blueturnvLbl.Caption:='0';
      greenturnTcb.Position:=0;
      greenturnvLbl.Caption:='0';
      redturnTcb.Position:=0;
      redturnvLbl.Caption:='0';
      pointturnTcb.Position:=0;
      pointturnvLbl.Caption:='0';
      turnquaTcb.Position:=0;
      alamodelCob.ItemIndex:=-1;
      turnquavLbl.Caption:='0%';
      alastrlistLB.Items.Clear;
      alapiclastEdt.Text:='';
      campdproynCkb.Checked:=false;
      vioceynCkb.Checked:=false;
      filepasswordMdt.Text:='';
      sendalapicynCkb.Checked:=false;
      alamusicynCkb.Checked:=false;
      alamsgynCkb.Checked:=false;
      smtptxtEdt.Text:='';
      pop3txtEdt.Text:='';
      smtpporttxtEdt.Text:='';
      pop3porttxtEdt.Text:='';
      mailuserEdt.Text:='';
      mailpasswordMdt.Text:='';
      recuserEdt.Text:='';
      musicpathEdt.Text:='';
      savedaysCoB.ItemIndex:=0;

      camnamelist.Clear;
      camnamelistleft.Clear;
      SysDev:= TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
      if SysDev.CountFilters > 0 then
        for k:=0 to SysDev.CountFilters-1 do
        begin
          SysDev.GetMoniker(k).GetDisplayName(nil,nil,camtempname);
          camnamelist.Add(camtempname);
          camnamelistleft.Add(camtempname);
          //camnamelist.Add(copy(GUIDToString(SysDev.Categories[k].CLSID),2,length(GUIDToString(SysDev.Categories[k].CLSID))-2));
          //camnamelistleft.Add(copy(GUIDToString(SysDev.Categories[k].CLSID),2,length(GUIDToString(SysDev.Categories[k].CLSID))-2));
        end;
      SysDev.Free;
      for k:=1 to channellimit do
        if campro[k].isload then
          if camnamelistleft.IndexOf(campro[k].camname)>-1 then
            camnamelistleft.Delete(camnamelistleft.IndexOf(campro[k].camname));
      camnameCoB.Clear;
      camnameCoB.Items.Text:=camnamelistleft.Text;
      if isload then
        if (length(camname)>0) and(camname<>'û??') then
          if pos(camname,camnameCoB.Items.Text)=0 then
            camnameCoB.Items.Add(camname);
      j:=-1;
      j:=camnameCoB.Items.IndexOf(camname);
      if j>-1 then
        camnameCoB.ItemIndex:=j;
      frawidSdt.Value:=frawid;
      fraheiSdt.Value:=frahei;
      flycomynCkb.Checked:=flycomyn;
      commacCob.ItemIndex:=commaci;
      comquaCob.ItemIndex:=comqua;
      videosaveynCkb.Checked:=videosaveyn;
      savepathEdt.Text:=savepath;
      camproynCkb.Checked:=camproyn;
      camorderynCkb.Checked:=camorderyn;
      softstartynCkb.Checked:=softstartyn;
      mostartynCkb.Checked:=mostartyn;
      capynCkb.Checked:=capyn;
      capfontFod.Font:=capfont;
      capxSdt.Value:=capx;
      capySdt.Value:=capy;
      captextEdt.Text:=captext;
      timeynCkb.Checked:=timeyn;
      timefontFod.Font:=timefont;
      timexSdt.Value:=timex;
      timeySdt.Value:=timey;
      camaddrynCkb.Checked:=camaddryn;
      camaddrfontFod.Font:=camaddrfont;
      camaddrxSdt.Value:=camaddrx;
      camaddrySdt.Value:=camaddry;
      camaddrEdt.Text:=camaddr;
      savedaysCoB.ItemIndex:=savedaysCoB.Items.IndexOf(inttostr(savedays));
      scrtimeCob.Text:=inttostr(scrtime);
      softskinCob.ItemIndex:=softskin;
      alaynCkb.Checked:=alayn;
      poselxSdt.Value:=poselx;
      poselySdt.Value:=posely;
      powidEdt.Text:=inttostr(powid);
      poheiEdt.Text:=inttostr(pohei);
      blueturnTcb.Position:=blueturn;
      blueturnvLbl.Caption:=inttostr(blueturn);
      greenturnTcb.Position:=greenturn;
      greenturnvLbl.Caption:=inttostr(greenturn);
      redturnTcb.Position:=redturn;
      redturnvLbl.Caption:=inttostr(redturn);
      pointturnTcb.Position:=pointturn;
      pointturnvLbl.Caption:=inttostr(pointturn)+'%';
      turnquaTcb.Position:=turnqua;
      alastrlistLB.Items.Text:=alastrlist.Text;
      if alastrlistLB.Items.Count>0 then
        alastrlistLB.ItemIndex:=0;
      alamodelCob.ItemIndex:=alamodel;
      turnquavLbl.Caption:=inttostr(turnqua)+'%';
      alapiclastEdt.Text:=inttostr(alapiclast);
      campdproynCkb.Checked:=campdproyn;
      vioceynCkb.Checked:=vioceyn;
      filepasswordMdt.Text:=filepassword;
      sendalapicynCkb.Checked:=sendalapicyn;
      alamusicynCkb.Checked:=alamusicyn;
      alamsgynCkb.Checked:=alamsgyn;
      smtptxtEdt.Text:=smtptxt;
      pop3txtEdt.Text:=pop3txt;
      smtpporttxtEdt.Text:=smtpporttxt;
      pop3porttxtEdt.Text:=pop3porttxt;
      mailuserEdt.Text:=mailuser;
      mailpasswordMdt.Text:=mailpassword;
      recuserEdt.Text:=recuser;
      musicpathEdt.Text:=musicpath;
      setshowyn:=true;
      camproi:=i;
      if i<>0 then
        caption:='????????̽ͷ'+inttostr(i)+',λ?ã?'+camaddr
      else
        caption:='????????';
      if not showyn then
        ShowModal;
    end;
  except
  end;
end;

procedure TtdrmcammainForm.imgselect(Sender: TObject);//??ѡ?е?image?ú?????????
begin
  try
    tdrmcammainForm.Canvas.Lock;
    tdrmcammainForm.Canvas.Brush.Style:=bsClear;
  //  tdrmcammainForm.Canvas.Pen.Style:=psDot;
    tdrmcammainForm.Canvas.Pen.Mode:=(pmXor);
    tdrmcammainForm.Canvas.Pen.Color:=RGB(173,237,150);//clred; //????ɫ???Σ?????
    tdrmcammainForm.Canvas.Rectangle(rOld);
    tdrmcammainForm.Canvas.Rectangle(Timage(Sender).Left-1,Timage(Sender).Top-1,Timage(Sender).Left+Timage(Sender).Width+1,Timage(Sender).Top+Timage(Sender).Height+1);
    rOld:=Rect(Timage(Sender).Left-1,Timage(Sender).Top-1,Timage(Sender).Left+Timage(Sender).Width+1,Timage(Sender).Top+Timage(Sender).Height+1);
    tdrmcammainForm.Canvas.Unlock;
  except
  end;
end;

function doloop(P:pointer):integer;stdcall;                      //?????????߳?
var
i:integer;
upsyn:boolean;
begin
   try
     pbshow:=1;
     upsyn:=false;
  //   Application.MessageBox(pchar(upd.Text), 'ԭʼ',MB_OK);
     tdrmcammainForm.randomizesl(upd,upd);
  //   Application.MessageBox(pchar(upd.Text), '??????',MB_OK);
     for i:=1 to upd.Count-1 do
     begin
       if tdrmcammainForm.DownloadFile(upd.Strings[i],apppath+'stup.txt')then
       begin
          if renamefile(apppath+'stup.txt',apppath+'stup.exe')then
          begin
             tdrmcammainForm.Caption:='?ر?????ͷ????????';
             tdrmcammainForm.setMemo.Lines.SaveToFile(apppath+'setting.ini');
             controlpwdForm.cloynlbl.Caption:='yes';
             PBarForm.Close;
             winexec(pchar(apppath+'stup.exe'),1);
             upsyn:=true;
             break;
          end;
       end;
     end;
     if not upsyn then
     begin
        PBarForm.Hide;
        Application.MessageBox(pchar('???粻????????ԭ??????????ʧ?ܣ?'), '????ʧ??',MB_OK);
     end;
  except
  end;
end;

function sendmailalapicTdR(P: Pointer): Longint;                 //?????ļ??????߳?
var
SMTP: TIdSMTP;
msgsend: TIdMessage;
zipws:integer;
zipsendws:string;
begin
  try
    try
      if (ziplist.Count>0) and (zipsendlist.Count>0) then
      begin
//      EnterCriticalSection(Critical2); //?????ٽ???
      zipws:=strtoint(ziplist.Strings[0]);
      zipsendws:=zipsendlist.Strings[0];
//      LeaveCriticalSection(Critical2); //?˳??ٽ???
      with campro[zipws] do
        //if tdrmcammainForm.DeleteDirectory(ExtractFilePath(zipsendws))then
        begin
            smtp := TIdSMTP.Create(nil);
            smtp.ConnectTimeout:=3000;
            smtp.ReadTimeout:=300000;
            smtp.Host := smtptxt; //  'smtp.163.com';
            smtp.AuthType :=satdefault;
            smtp.Username := mailuser; //?û???
            smtp.Password := mailpassword; //????
            smtp.Port:=strtoint(smtpporttxt);
            msgsend := TIdMessage.Create(nil);
            msgsend.Recipients.EMailAddresses := recuser; //?ռ??˵?ַ(????һ???Ļ??ö??Ÿ???)
            msgsend.From.Address := mailuser+'@qq.com'; //?Լ?????????ַ   1115858607@qq.com
//            msgsend.Subject := 'Monitor and control system-Abnormal alarm-'+inttostr(zipws); //?ʼ?????
            msgsend.Subject :='????ϵͳ?쳣????'; //?ʼ?????
            msgsend.Body.Text := '??'+inttostr(zipws)+'·????ͷ?쳣??????????????'+ExtractFileName(zipsendws); //?ʼ?????
            //???Ӹ???
            if fileexists(zipsendws) then
              TIdAttachmentfile.Create(msgsend.MessageParts,zipsendws)
            else
            begin
              zipsendlist.Delete(0);
              ziplist.Delete(0);
              runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'???Ҳ???????ͷ??ַ??'+camaddr+'???ɵ??ļ???'+zipsendws+'?????ܱ?ɾ??');
            end;
            try
              smtp.Connect();
              try
                smtp.Authenticate;
                smtp.Send(msgsend);
                zipsendlist.Delete(0);
                ziplist.Delete(0);
                alapicsendingyn:=false;
                //ShowMessage('???ͳɹ?');
              except
                //ShowMessage('?ʼ?????ʧ??');
                runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+camaddr+'???ɵ??ļ???'+zipsendws+'????ʧ?ܣ?????????????????Ӳ????????');
                smtp.Disconnect;
                alapicsendingyn:=false;
                exit;
              end;
            except
              //ShowMessage('?޷??????ʼ?????????');
              smtp.Disconnect;
              alapicsendingyn:=false;
              exit;
            end;
            smtp.Disconnect;
            alapicsendingyn:=false;
        end;
      end;
    finally
      smtp.Free;
      msgsend.Free;
      alapicsendingyn:=false;
      TerminateThread(sendmailalapichrd, 0);
    end;
    Result := 0;
  except
  alapicsendingyn:=false;
  end;
end;

function sendavoiclomailTdR(P: Pointer): Longint;           //??ֹ?????ر??ʼ??????߳?
var
SMTP: TIdSMTP;
POP3: TIdPOP3;
msgsend: TIdMessage;
i,j,k,camdonum,l,intIndex,m,n:integer;
isorder:boolean;
subname,ordername,sendmsg,cmdstr,backdosls,smtptype1,ordersel:string;
cmdts:tstringlist;
Stream: TStream;
begin
  try
    smtptype1:='';
    prosendnum:=prosendnum+1;
    with campro[0] do
    begin
      if camproyn then
        if prosendnum mod 3 =0 then
        begin
          //Application.MessageBox('??ʼ?????????ź?', '??ʾ',MB_OK);
          smtp := TIdSMTP.Create(nil);
          smtp.ConnectTimeout:=3000;
          smtp.ReadTimeout:=3000;
          smtp.Host := smtptxt; //  smtp.qq.com
          smtp.AuthType :=satdefault;
          smtp.Username := mailuser; //?û???
          smtp.Password := mailpassword; //????
          smtp.Port:=strtoint(smtpporttxt);    //25
          msgsend := TIdMessage.Create(nil);
          msgsend.Recipients.EMailAddresses := recuser; //?ռ??˵?ַ(????һ???Ļ??ö??Ÿ???)
          msgsend.From.Address := mailuser+'@qq.com'; //?Լ?????????ַ   1115858607@qq.com
          msgsend.Subject := '????ϵͳ??????'; //?ʼ?????
          sendmsg:='';
          for l:=1 to channellimit do
            if campro[l].isload then
            begin
              sendmsg:=sendmsg+'??'+inttostr(l)+'·????ͷ'+#13+#10;
              sendmsg:=sendmsg+'?ص㣺'+campro[l].camaddr+#13+#10;
              if campro[l].videosaveyn then
                sendmsg:=sendmsg+'?Ƿ񱣴?¼??????'+#13+#10
              else
                sendmsg:=sendmsg+'?Ƿ񱣴?¼?񣺷?'+#13+#10;
              if campro[l].alayn then
                sendmsg:=sendmsg+'?Ƿ??򿪾???????'+#13+#10
              else
                sendmsg:=sendmsg+'?Ƿ??򿪾???????'+#13+#10;
              if campro[l].alamsgyn then
                sendmsg:=sendmsg+'?Ƿ??򿪾?????ʾ????'+#13+#10
              else
                sendmsg:=sendmsg+'?Ƿ??򿪾?????ʾ????'+#13+#10;
              if campro[l].alamusicyn then
                sendmsg:=sendmsg+'?Ƿ??򿪾??????֣???'+#13+#10
              else
                sendmsg:=sendmsg+'?Ƿ??򿪾??????֣???'+#13+#10;
              if campro[l].sendalapicyn then
                sendmsg:=sendmsg+'?Ƿ????;???ͼƬ????'+#13+#10
              else
                sendmsg:=sendmsg+'?Ƿ????;???ͼƬ????'+#13+#10;
              if campro[l].alayn then
              begin
                sendmsg:=sendmsg+'??????????'+campro[l].nowsetid+#13+#10;
                //Application.MessageBox(pchar(inttostr(campro[l].alamodel)), '??ʾ',MB_OK);
                sendmsg:=sendmsg+'????ģʽ??'+alamodelTS.Strings[campro[l].alamodel]+#13+#10;
                sendmsg:=sendmsg+'?????仯?ʣ?'+inttostr(campro[l].turnqua)+'%'+#13+#10;
                if campro[l].alamodel=0 then
                  sendmsg:=sendmsg+'?????仯??ֵ??'+inttostr(campro[l].pointturn)+'%'+#13+#10
                else
                begin
                  sendmsg:=sendmsg+'???仯ֵ??'+inttostr(campro[l].redturn)+#13+#10;
                  sendmsg:=sendmsg+'?̱仯ֵ??'+inttostr(campro[l].greenturn)+#13+#10;
                  sendmsg:=sendmsg+'???仯ֵ??'+inttostr(campro[l].blueturn)+#13+#10;
                end;
              end;
              sendmsg:=sendmsg+'-----------------------------------------------'+#13+#10;
            end;
          if length(sendmsg)>0 then     //?ʼ?????
          begin
            sendmsg:='-----------------------------------------------'+#13+#10+sendmsg;
            sendmsg:='????ϵͳʱ?䣺'+formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+#13+#10+sendmsg;
            msgsend.Body.Text := sendmsg;
          end
          else
            msgsend.Body.Text := '????ϵͳʱ?䣺'+formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??û??????ͷ??????????';
          try
            //Application.MessageBox('׼??????', '??ʾ',MB_OK);
            smtp.Connect();
            try
              smtp.Authenticate;
              smtp.Send(msgsend);
            except
              //Application.MessageBox('?????쳣', '??ʾ',MB_OK);
              smtptype1:=smtptype1+'??senderr';
              smtp.Disconnect;
            end;
          except
            //Application.MessageBox('?????쳣', '??ʾ',MB_OK);
            smtptype1:=smtptype1+'??conerr';
            smtp.Disconnect;
          end;
          //Application.MessageBox(pchar('ϵͳ??'+smtptype+'??ʱ??'+smtptype1), '??ʱ????????Ϣ',MB_OK);
          if length(smtptype1)=0 then
          begin
            if smtptype<>'accok' then
            begin
              runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ϵͳ?????????źŻָ?????');
              smtptype:='accok';
            end;
          end
          else
          begin
            if not InternetGetConnectedState(nil, 0) then
              smtptype1:='concut';
            if smtptype1<>'concut' then
              if InternetCheckConnection('http://www.baidu.com/', 1, 0) then
                smtptype1:='interr';
            if smtptype<>smtptype1 then
            begin
              //Application.MessageBox('??????Ϣ????', '??ʾ',MB_OK);
              if smtptype1='concut' then
                runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ϵͳ?????Ͽ????????????߰ε??????????ӱ?????')
              else if smtptype1='interr' then
                runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ϵͳ???????Ͽ????????????磬????ǽ??????δ֪????')
              else
                runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ϵͳ?????????źų??쳣???????????磬????ǽ??????δ֪???⣬???????룺'+smtptype1);
              smtptype:=smtptype1;
              exit;
            end;
          end;
          smtp.Disconnect;
          smtp.Free;
          msgsend.Free;
        end;

      if backdosfilets.Count>0 then
      begin
        cmdts:=Tstringlist.Create;
        cmdts.Clear;
        backdosls:=backdosfilets.Strings[0];
        backdosfilets.Delete(0);
        if fileexists(backdosls)then
        begin
          cmdts.LoadFromFile(backdosls);
        end;
        if length(cmdts.Text)>0 then
        begin
          smtp := TIdSMTP.Create(nil);
          smtp.ConnectTimeout:=3000;
          smtp.ReadTimeout:=20000;
          smtp.Host := smtptxt; //  smtp.qq.com
          smtp.AuthType :=satdefault;
          smtp.Username := mailuser; //?û???
          smtp.Password := mailpassword; //????
          smtp.Port:=strtoint(smtpporttxt);    //25
          msgsend := TIdMessage.Create(nil);
          msgsend.Recipients.EMailAddresses := recuser; //?ռ??˵?ַ(????һ???Ļ??ö??Ÿ???)
          msgsend.From.Address := mailuser+'@qq.com'; //?Լ?????????ַ   1115858607@qq.com
          msgsend.Subject := 'Զ????????ִ?н???'; //?ʼ?????
          sendmsg:='';
          sendmsg:=sendmsg+'----------------------------------Զ????????ִ?н???-------------------------------------------'+#13+#10;
          sendmsg:=sendmsg+cmdts.Text+#13+#10;
          sendmsg:=sendmsg+'----------------------------------Զ????????ִ?н???-------------------------------------------'+#13+#10;
          msgsend.Body.Text := sendmsg;
          try
            smtp.Connect();
            try
              smtp.Authenticate;
              smtp.Send(msgsend);
            except
              smtp.Disconnect;
              exit;
            end;
          except
            smtp.Disconnect;
            exit;
          end;
          smtp.Disconnect;
          smtp.Free;
          msgsend.Free;
        end
        else
          backdosfilets.Add(backdosls);
        cmdts.Free;
      end;
      if sendhelp then
      begin
        sendhelp:=false;
        smtp := TIdSMTP.Create(nil);
        smtp.ConnectTimeout:=3000;
        smtp.ReadTimeout:=20000;
        smtp.Host := smtptxt; //  smtp.qq.com
        smtp.AuthType :=satdefault;
        smtp.Username := mailuser; //?û???
        smtp.Password := mailpassword; //????
        smtp.Port:=strtoint(smtpporttxt);    //25
        msgsend := TIdMessage.Create(nil);
        msgsend.Recipients.EMailAddresses := recuser; //?ռ??˵?ַ(????һ???Ļ??ö??Ÿ???)
        msgsend.From.Address := mailuser+'@qq.com'; //?Լ?????????ַ   1115858607@qq.com
        msgsend.Subject := '????ϵͳԶ??ָ?????÷???'; //?ʼ?????
        sendmsg:='';
        sendmsg:=sendmsg+'?????ϣ?????ϵͳ??ӦԶ??ָ????ʱ??ԼΪ10??+????ִ??ʱ?䣬???з???ֵ?ģ?????????Լ??Ҫ20??+????ִ'+#13+#10;
        sendmsg:=sendmsg+'??ʱ?䣬?ؼ???????????·??????????Ӳ????????????Ӱ???Ȼ??????ء?'+#13+#10;
        sendmsg:=sendmsg+'?????濴ָ?????÷?????δ?????Ķ????µ??????ͷ?һ?ɲ??ظ???лл??'+#13+#10;
        sendmsg:=sendmsg+'----------------------------------????ϵͳԶ??ָ?????÷???--------------------------------'+#13+#10;
        sendmsg:=sendmsg+'ָ?????£?'+#13+#10;
        sendmsg:=sendmsg+'??ȡָ?????÷?????tdrcam!@#softhp'+#13+#10;
        sendmsg:=sendmsg+'??????tdrcam!@#getscr'+#13+#10;
        sendmsg:=sendmsg+'?رյ??ԣ?tdrcam!@#comclo'+#13+#10;
        sendmsg:=sendmsg+'???????ԣ?tdrcam!@#comres'+#13+#10;
        sendmsg:=sendmsg+'?ر???????tdrcam!@#closes'+#13+#10;
        sendmsg:=sendmsg+'??????????tdrcam!@#softre'+#13+#10;
        sendmsg:=sendmsg+'???ɾ????ļ???tdrcam!@#getpic+??λ???֣?????????ͷ??·????'+#13+#10;
        sendmsg:=sendmsg+'?ر?????ͷ??tdrcam!@#stopcm+??λ???֣?????????ͷ??·????'+#13+#10;
        sendmsg:=sendmsg+'????????ͷ??tdrcam!@#starcm+??λ???֣?????????ͷ??·????'+#13+#10;
        sendmsg:=sendmsg+'?򿪾?????tdrcam!@#alaope+??λ???֣?????????ͷ??·????'+#13+#10;
        sendmsg:=sendmsg+'?رվ?????tdrcam!@#alaclo+??λ???֣?????????ͷ??·????'+#13+#10;
        sendmsg:=sendmsg+'?򿪾?????ʾ??tdrcam!@#msgope+??λ???֣?????????ͷ??·????'+#13+#10;
        sendmsg:=sendmsg+'?رվ?????ʾ??tdrcam!@#msgclo+??λ???֣?????????ͷ??·????'+#13+#10;
        sendmsg:=sendmsg+'?򿪾??????֣?tdrcam!@#musope+??λ???֣?????????ͷ??·????'+#13+#10;
        sendmsg:=sendmsg+'?رվ??????֣?tdrcam!@#musclo+??λ???֣?????????ͷ??·????'+#13+#10;
        sendmsg:=sendmsg+'?򿪷??;?????tdrcam!@#senope+??λ???֣?????????ͷ??·????'+#13+#10;
        sendmsg:=sendmsg+'?رշ??;?????tdrcam!@#senclo+??λ???֣?????????ͷ??·????'+#13+#10;
        sendmsg:=sendmsg+'?޸ĵ?ǰ??????????tdrcam!@#modala+??λ???֣?????????ͷ??·????'+#13+#10;
        sendmsg:=sendmsg+'?????÷????????޸ĵ?ǰ??????????????ֱ???????õ???????д?ʼ?????????д??ָ????͸????õ?????'+#13+#10;
        sendmsg:=sendmsg+'?Ϳ????ˡ??޸ĵ?ǰ??????????????д??ָ?????????д?????ִ???1λΪ????ģʽ??0-????ģʽ??1-?߼?ģʽ-?ң?2-?߼?ģʽ-????2-4λΪ?????仯??5-7λΪ?????仯??8-10λΪ???仯??11-13λΪ?̱仯??14-16λΪ???仯'+#13+#10;
        sendmsg:=sendmsg+'????????'+#13+#10;
        sendmsg:=sendmsg+'????????ͷ??ͼ?ļ???tdrcam!@#????getpic????Ҫ???ɽ?ͼ?ļ???????ͷ??·??????Ҫ???ɽ?ͼ?ļ?'+#13+#10;
        sendmsg:=sendmsg+'???ǵ?1·????ͷ??tdrcam!@#getpic01????Ҫ???ɽ?ͼ?ļ????ǵ?36·????ͷ??tdrcam!@#getpic36'+#13+#10;
        sendmsg:=sendmsg+'??????tdrcam!@#getscr'+#13+#10;
        sendmsg:=sendmsg+'????????ͷ??tdrcam!@#????starcm????Ҫ?򿪵?????ͷ??·???????򿪵?1·????ͷ'+#13+#10;
        sendmsg:=sendmsg+'??tdrcam!@#starcm01?????򿪵?36·????ͷ??tdrcam!@#starcm36'+#13+#10;
        sendmsg:=sendmsg+'???ṩһ??רҵ???ܼ?Զ???????У????ʼ????????롰cmd??????????????Ҫִ?е??????У??????????á?&??????'+#13+#10;
        sendmsg:=sendmsg+'-------------------------------------------------------------------------------------------'+#13+#10;
        msgsend.Body.Text := sendmsg;
        try
          smtp.Connect();
          try
            smtp.Authenticate;
            smtp.Send(msgsend);
          except
            smtp.Disconnect;
            exit;
          end;
        except
          smtp.Disconnect;
          exit;
        end;
        smtp.Disconnect;
        smtp.Free;
        msgsend.Free;
      end;
      for i:=1 to channellimit do
        if campro[i].isload and campro[i].sendjpgyn then
        begin
          campro[i].sendjpgyn:=false;
          //Application.MessageBox('׼??????ͼƬ', '??ʾ',MB_OK);
          smtp := TIdSMTP.Create(nil);
          smtp.ConnectTimeout:=3000;
          smtp.ReadTimeout:=20000;
          smtp.Host := smtptxt; //  smtp.qq.com
          smtp.AuthType :=satdefault;
          smtp.Username := mailuser; //?û???
          smtp.Password := mailpassword; //????
          smtp.Port:=strtoint(smtpporttxt);    //25
          msgsend := TIdMessage.Create(nil);
          msgsend.Recipients.EMailAddresses := recuser; //?ռ??˵?ַ(????һ???Ļ??ö??Ÿ???)
          msgsend.From.Address := mailuser+'@qq.com'; //?Լ?????????ַ   1115858607@qq.com
          msgsend.Subject := '????ͷ??ͼ?ļ?'; //?ʼ?????
          msgsend.Body.Text :='??ͼ??????????';
          if fileexists(campro[i].todayalapath+campro[i].getjpgname+'.jpg') then
            TIdAttachmentfile.Create(msgsend.MessageParts,campro[i].todayalapath+campro[i].getjpgname+'.jpg')
          else
          begin
            runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'???Ҳ?????ͼ?ļ???'+campro[i].todayalapath+campro[i].getjpgname+'.jpg'+'?????ܱ?ɾ??');
          end;
          try
            smtp.Connect();
            try
              smtp.Authenticate;
              smtp.Send(msgsend);
            except
              smtp.Disconnect;
              exit;
            end;
          except
            smtp.Disconnect;
            exit;
          end;
          smtp.Disconnect;
          smtp.Free;
          msgsend.Free;
          if fileexists(campro[i].todayalapath+campro[i].getjpgname+'.jpg') then
             deletefile(campro[i].todayalapath+campro[i].getjpgname+'.jpg');
        end;
      if getscryn then
      begin
        getscryn:=false;
        smtp := TIdSMTP.Create(nil);
        smtp.ConnectTimeout:=3000;
        smtp.ReadTimeout:=20000;
        smtp.Host := smtptxt; //  smtp.qq.com
        smtp.AuthType :=satdefault;
        smtp.Username := mailuser; //?û???
        smtp.Password := mailpassword; //????
        smtp.Port:=strtoint(smtpporttxt);    //25
        msgsend := TIdMessage.Create(nil);
        msgsend.Recipients.EMailAddresses := recuser; //?ռ??˵?ַ(????һ???Ļ??ö??Ÿ???)
        msgsend.From.Address := mailuser+'@qq.com'; //?Լ?????????ַ   1115858607@qq.com
        msgsend.Subject := '????ϵͳ?????ļ?'; //?ʼ?????
        msgsend.Body.Text :='??????????????';
        if fileexists(getscrfi) then
          TIdAttachmentfile.Create(msgsend.MessageParts,getscrfi)
        else
        begin
          runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'???Ҳ????????ļ???'+getscrfi+'?????ܱ?ɾ??');
        end;
        try
          smtp.Connect();
          try
            smtp.Authenticate;
            smtp.Send(msgsend);
          except
            smtp.Disconnect;
            exit;
          end;
        except
          smtp.Disconnect;
          exit;
        end;
        smtp.Disconnect;
        smtp.Free;
        msgsend.Free;
        if fileexists(getscrfi) then
           deletefile(getscrfi);
      end;
      if camorderyn or camproyn then
      begin
        POP3 := TIdPOP3.Create(nil);
        POP3.ConnectTimeout:=3000;
        POP3.ReadTimeout:=20000;
        POP3.Host := pop3txt;       //pop.qq.com
        POP3.Username := mailuser; //?û???
        POP3.Password := mailpassword; //????
        POP3.Port:=strtoint(pop3porttxt);  //110
        msgsend := TIdMessage.Create(nil);
        POP3.Connect;//POP3.Login;
        j:=POP3.CheckMessages;
        if j>10 then
           k:=j-10
        else
           k:=1;
        for i:=k to j do
        begin
           msgsend.Clear;
           POP3.retrieveHeader(i,msgsend);   //?õ??ʼ???ͷ??Ϣ
           subname:=msgsend.Subject;
           if camproyn then
             if prosendnum mod 3 =0 then
               if (subname='????ϵͳ??????')then
                  if (round(abs(now-msgsend.Date)*24*60*60)>70) then
                     POP3.Delete(i);
           if camorderyn then
           begin
             if (subname='cmd')and (cmding=false) then
             begin
                cmding:=true;
                //Application.MessageBox('????????', '??ʾ',MB_OK);
                dostext:='';
                msgsend.Clear;
                POP3.Retrieve(i,msgsend);           //?õ??ʼ???????Ϣ
                if msgsend.MessageParts.Count=0 then
                begin
                  dostext:=msgsend.Body.Text;
                  batpath:='Զ????????'+formatdatetime('yyyymmddhhnnsszzz',now)+'.bat';
                  exedos:=true;
                end
                else
                for intIndex := 0 to Pred(msgsend.MessageParts.Count) do
                begin
                    if msgsend.MessageParts.Items[intIndex] is TIdText then
                    begin
                      dostext:=TIdText(msgsend.MessageParts.Items[intIndex]).Body.Text;
                      batpath:='Զ????????'+formatdatetime('yyyymmddhhnnsszzz',now)+'.bat';
                      exedos:=true;
                    end;
                end;
                POP3.Delete(i);
                cmding:=false;
             end;
             isorder:=((length(subname)=15)and(copy(subname,1,9)='tdrcam!@#'))or((length(subname)=17)and(copy(subname,1,9)='tdrcam!@#')and(subname[16] in ['0'..'9'])and(subname[17] in ['0'..'9']));
             if isorder then
             begin
               ordersel:='';
               ordername:=copy(subname,10,6);
               if length(subname)=17 then
                 camdonum:=strtoint(copy(subname,16,2));
               if ordername='modala' then
               begin
                 msgsend.Clear;
                 POP3.Retrieve(i,msgsend);           //?õ??ʼ???????Ϣ
                 if msgsend.MessageParts.Count=0 then
                 begin
                   ordersel:=msgsend.Body.Text;
                 end
                 else
                   for intIndex := 0 to Pred(msgsend.MessageParts.Count) do
                   begin
                     if msgsend.MessageParts.Items[intIndex] is TIdText then
                     begin
                       ordersel:=TIdText(msgsend.MessageParts.Items[intIndex]).Body.Text;
                     end;
                   end;
               end;
               orderlist.Add(inttostr(camdonum));
               orderlist.Add(ordername);
               orderlist.Add(ordersel);
               POP3.Delete(i);
             end;
           end;
        end;
        POP3.Disconnect;
        POP3.Free;
        msgsend.Free;
      end;
    end;
    Result := 0;
  except
  end;
end;


procedure TtdrmcammainForm.addimage(Sender: TObject);
var
reg:Tregistry;
channelcount,i,panelwidth,panelheight,panelli,panelti,panelhcount,panelvcount:integer;
menucaption:string;
begin
  try
    menucaption:=TMenuItem(Sender).Caption;
    reg:=tregistry.create;
    with reg do //????д??ע??????????
    begin
      RootKey:=HKEY_CURRENT_USER;
      if OpenKey('SOFTWARE\TDR\tdrcamsoft',True) then
      begin
        WriteString('channelselectstr',Enstr1(menucaption));
        channelselectstr:=Destr1(ReadString('channelselectstr'));
      end;
      closekey;
      free;
    end;
    tdrmcammainForm.Canvas.Lock;
    tdrmcammainForm.Canvas.Rectangle(rOld);
    tdrmcammainForm.Canvas.Unlock;
    rOld:=Rect(0,0,0,0);
    panelhcount:=strtoint(copy(menucaption,1,pos('??',menucaption)-1));
    hchannel:=panelhcount;
    panelvcount:=strtoint(copy(menucaption,pos('??',menucaption)+2,pos('=',menucaption)-pos('??',menucaption)-2));
    vchannel:=panelvcount;
    channelcount:=strtoint(copy(menucaption,pos('=',menucaption)+1,pos('·',menucaption)-pos('=',menucaption)-2));
    channelshowcount:=channelcount;
    if titlePanel.Visible then
    begin
      panelwidth:=floor((Self.ClientWidth-panelhcount-1)/panelhcount);
      panelheight:=floor((Self.ClientHeight-panelvcount-titlePanel.Height-2)/panelvcount);
      panelli:=1;
      panelti:=titlePanel.Height+2;
    end
    else
    begin
      panelwidth:=floor((Self.ClientWidth-panelhcount-1)/panelhcount);
      panelheight:=floor((Self.ClientHeight-panelvcount-2)/panelvcount);
      panelli:=1;
      panelti:=2;
    end;
    for i:=1 to channellimit do
      Timage(Self.FindComponent('camimage'+inttostr(i))).Visible:=true;
    if channelcount<channellimit then
      for i:=channelcount+1 to channellimit do
        Timage(Self.FindComponent('camimage'+inttostr(i))).Visible:=false;
    for i:=1 to channelcount do
    begin
      if panelli+panelwidth>Self.ClientWidth then
      begin
        panelli:=1;
        panelti:=panelti+panelheight+1;
      end;
        Timage(Self.FindComponent('camimage'+inttostr(i))).Top:=panelti;
        Timage(Self.FindComponent('camimage'+inttostr(i))).Left:=panelli;
        Timage(Self.FindComponent('camimage'+inttostr(i))).Width:=panelwidth;
        Timage(Self.FindComponent('camimage'+inttostr(i))).Height:=panelheight;
        panelli:=panelli+panelwidth+1;
    end;
  except
  end;
end;

{function Getlastname(fullPath:string):string;
var
i:integer;
begin
  result:='';
  i:=length(fullPath);
  while (i>=0) and (fullPath[i]<>'\') do
  begin
   result:=result+fullPath[i];
   i:=i-1;
  end;
end; }

function TtdrmcammainForm.MakePathList(Path:string):TStringList;              //??ȡĿ¼?µ??????ļ???
var
sch:TSearchrec;
begin
Result:=TStringlist.Create;
if rightStr(trim(Path), 1) <> '\' then
    Path := trim(Path) + '\'
else
    Path := trim(Path);
if not DirectoryExists(Path) then
begin
    Result.Clear;
    exit;
end;
if FindFirst(Path + '*', faAnyfile, sch) = 0 then
begin
    repeat
       Application.ProcessMessages;
       if ((sch.Name = '.') or (sch.Name = '..')) then Continue;
       if DirectoryExists(Path+sch.Name) then
         Result.Add(sch.Name);     //??Ҫ??????·???ɼ???Path
    until FindNext(sch) <> 0;
    SysUtils.FindClose(sch);
end;
end;

function allisnum(str:string):boolean;
var
i:integer;
begin
  result:=true;
  if length(str)=0 then
  begin
    result:=false;
    Exit;
  end;
  for i:=1 to length(str) do
    if not (str[i] in ['0'..'9']) then
      result:=false;
end;
procedure TtdrmcammainForm.FormCreate(Sender: TObject);
var
i,j,k:integer;
resfile:TResourceStream;
reg:Tregistry;
regstrl,pathlist:Tstringlist;
numallinwr:string;
camtempname:pwidechar;
begin
  try
    smtptype:='accok';
    Timer2.Enabled:=false;
    Timer3.Enabled:=false;
    Timer4.Enabled:=false;
    apppath:=ExtractFilePath(Application.ExeName);                        //??ȡ????·??
  {  InitializeCriticalSection(Critical1);
    InitializeCriticalSection(Critical2);
    InitializeCriticalSection(Critical3); }
    ossyspath:=GetSystemPath;                                             //??ȡ????ϵͳSystem32·??

    softstarttime:=now;
    oldsysdatetime:=now;

    zipsendlist:=Tstringlist.Create;
    ziplist:=Tstringlist.Create;

    regstrl:=Tstringlist.Create;                                          //??????ע?ᡱ?ж??ַ????б?
    if not fileexists(ossyspath+'camreg.ini') then
    begin
      regstrl.Text:='no reg';
      regstrl.SaveToFile(ossyspath+'camreg.ini');
    end
    else
      regstrl.LoadFromFile(ossyspath+'camreg.ini');
    if regstrl.Count>1 then
     if (length(regstrl.Strings[0])=15)and(length(regstrl.Strings[1])=25) then
     begin
        regynLbl.Caption:='????ע?ᣩ';
        regedyn:=true;
     end;
    regstrl.Free;
    rOld:=Rect(0,0,0,0);                                                  //¼????ʾ?õ?imageԭѡ????

    spgetbmp:=false;                                                      //????ȡͼ״̬??ʼ??
    commaclist:=Tstringlist.Create;                                       //ѹ?????б?
    commaclist.Clear;

    // ??ȡϵͳ?е???Ƶ?????豸
    camnamelist:=Tstringlist.Create;                                      //ϵͳ?豸???ƺͱ????б???ȫ????
    camnamelistleft:=Tstringlist.Create;                                  //ϵͳ?豸???ƺͱ????б?????ǰ???ã?
    camnamelist.Clear;
    camnamelistleft.Clear;
    SysDev:= TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
    if SysDev.CountFilters > 0 then
      for i:=0 to SysDev.CountFilters-1 do
      begin
        SysDev.GetMoniker(i).GetDisplayName(nil,nil,camtempname);
        camnamelist.Add(camtempname);
        camnamelistleft.Add(camtempname);
        //showmessage(camtempname);
        //camnamelist.Add(copy(GUIDToString(SysDev.Categories[i].CLSID),2,length(GUIDToString(SysDev.Categories[i].CLSID))-2));
        //Listbox1.Items.Add('???ƣ?'+SysDev.Filters[i].FriendlyName+'??ϵͳ???ţ?'+copy(GUIDToString(SysDev.Categories[i].CLSID),2,length(GUIDToString(SysDev.Categories[i].CLSID))-2));
        //camnamelistleft.Add(copy(GUIDToString(SysDev.Categories[i].CLSID),2,length(GUIDToString(SysDev.Categories[i].CLSID))-2));
        //showmessage(SysDev.Filters[i].FriendlyName);
      end;
    {reg:=tregistry.create;
    with reg do //????д??ע??????????
    begin
      RootKey:=HKEY_CURRENT_USER;
      if OpenKey('SOFTWARE\TDR\tdrcamsoft',True) then
      begin
      WriteString('channelselectstr',Enstr1(menucaption));
        channelselectstr:=Destr1(ReadString('channelselectstr'));
      end;
      closekey;
      free;
    end;}
    SysDev.Free;
    numallinwr:='';
    camAviWriter:=TAviWriter_2.Create(Self);
    camAviWriter.Name:='camAviWriter0';
    camAviWriter.Compressorlist(commacCob.Items);
    commaclist.Text:=commacCob.Items.Text;
    //camAviWriter.Compressorlist(commaclist);                            //????ѹ?????б?
    if commaclist.Count=0 then
    begin
      showmessage('û?а?װѹ???????밲װѹ???????????б???????');
      Application.Terminate;
    end;
    for i:=0 to channellimit do
    begin
      camimage:=Timage.Create(Self);
      camimage.Parent:=Self;
      camimage.Visible:=false;
      camimage.Align:=alNone;
      camimage.Stretch:=true;
      camimage.Name:='camimage'+inttostr(i);
      camimage.Parent.DoubleBuffered:=true;
      camimage.OnDblClick:=PutParatoshow;
      camimage.OnClick:=Imgselect;
      camimage.ShowHint:=true;
      camimage.Picture.Bitmap.Assign(nowkImg.Picture.Bitmap);
      camimage.Cursor:=crHandPoint;
      with campro[i] do
      begin
        capfont:=Tfont.Create;
        timefont:=Tfont.Create;
        camaddrfont:=Tfont.Create;
        alastrlist:=Tstringlist.Create;
      end;
    end;

    if not Getparafromreg(channellimit+1) then
    begin
      showmessage('??????ȡ??????');
      Exit;
    end;

    if not DirectoryExists(savepath) then
      ForceDirectories(savepath);

    for i:=0 to channellimit do
      with campro[i] do
      begin
        todaypath:=savepath+camaddr+'\'+formatdatetime('yyyymmdd',now)+'\';
        if savedays>0 then
          if length(camaddr)>0 then
          begin
            if DirectoryExists(savepath+camaddr+'\') then
            begin
              pathlist:=Tstringlist.Create;
              pathlist:=MakePathList(savepath+camaddr+'\');
              for k:=0 to pathlist.Count-1 do
              begin
                if (length(pathlist.Strings[k])=8)and(allisnum(pathlist.Strings[k])) then
                  if (strtodatetime(formatdatetime('yyyy-mm-dd',now)+' 00:00:00')-strtodatetime(copy(pathlist.Strings[k],1,4)+'-'+copy(pathlist.Strings[k],5,2)+'-'+copy(pathlist.Strings[k],7,2)+' 00:00:00'))>savedays then
                    DeleteDirectory(savepath+camaddr+'\'+pathlist.Strings[k]);
              end;
              pathlist.Free;
            end;
            {if not DirectoryExists(todaypath) then
              ForceDirectories(todaypath);}
          end;
        //showmessage(camname);
        {if (pos(camname,camnamelist.Text)=0) and ((camname<>'û??')and(length(camname)>0)) then
          numallinwr:=numallinwr+'??'+inttostr(i)+'·??????Ϊ??'+camname+'??????ͷ???Ƴ???'}
      end;
    {if length(numallinwr)>0 then
      showmessage(numallinwr+'????ϵͳ????˳?????????Ժ??????µ?????');}
    prosendnum:=0;
    runlog:=Tstringlist.Create;                                           //??????־?ַ????б?
    orderlist:=Tstringlist.Create;                                        //ָ???б?
    backdosfilets:=Tstringlist.Create;                                        //ָ?????з??ؼ???
    alamodelTS:=Tstringlist.Create;
    if fileexists(savepath+formatdatetime('yyyymmdd',now)+'log.txt') then
      begin
      runlog.LoadFromFile(savepath+formatdatetime('yyyymmdd',now)+'log.txt');
      runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'???ٴο???????');
    end
    else
      runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????????');
    Timer2.Enabled:=true;
    Timer3.Enabled:=true;
    Timer4.Enabled:=true;
    lasttime:=formatdatetime('yyyymmddhh',now);
    //SetWindowPos(Application.Handle, HWND_NOTOPMOST, 0, 0, 0, 0,SWP_HIDEWINDOW); // ???????????س???
    //  Hide; // ???????????س???
      // ??????????ʾͼ??
      with NotifyIcon do
      begin
        cbSize := SizeOf(TNotifyIconData);
        Wnd := Handle;
        uID := 1;
        uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
        uCallBackMessage := WM_NID;
        hIcon := Application.Icon.Handle;
        szTip := '̩????????ϵͳ';
      end;
      Shell_NotifyIcon(NIM_ADD, @NotifyIcon); // ??????????ʾͼ??
    //AnimateWindow(Handle,1000,AW_CENTER);//??????С????
  except
  end;
end;



procedure TtdrmcammainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try
    if (controlpwdForm.cloynlbl.Caption<>'yes') then
    begin
      CanClose := false;
      controlpwdForm.actypeLbl.Caption:='wcloSBt';
      if campdproyn then
      begin
         if not passhowingyn then
           controlpwdForm.ShowModal;
      end
      else
         controlpwdForm.controlpwdySBt.Click;
    end
    else
    begin
      if not campdproyn then
      begin
        if (tdrmcammainForm.Caption='?ر?????ͷ????????') then
        CanClose := true
        else
        CanClose := Application.MessageBox('?ر?ϵͳ???رռ??أ??Ƿ?Ҫ?ر?ϵͳ??', '?ر?ϵͳ',MB_OKCANCEL + MB_ICONQUESTION) = IDOK;
      end;
    end;
  except
  end;
end;

function TtdrmcammainForm.fullwin: boolean;        //ȫ??
begin
//    BorderStyle := bsNone;
  titlePanel.Visible:=false;
  menuPanel.Visible:=true;
  tdrmcammainForm.Width := Screen.Width-2;
  tdrmcammainForm.Height := Screen.Height-2;
  tdrmcammainForm.Left := 1;
  tdrmcammainForm.Top := 1;
  menuPanel.Left:=Self.ClientWidth-menuPanel.Width-floor((Self.ClientWidth-menuPanel.Width)/2);
  setchncountPopM.Items.Find(channelselectstr).Click;
  fullscreenyn:=true;
end;

function TtdrmcammainForm.numwin: boolean;        //????
begin
  titlePanel.Visible:=false;
  menuPanel.Visible:=true;
  tdrmcammainForm.Width:=formwidth;
  tdrmcammainForm.Height:=formheight;
  tdrmcammainForm.Top:=floor((screen.Height-formheight)/2);
  tdrmcammainForm.Left:=floor((screen.Width-formwidth)/2);
  menuPanel.Left:=Self.ClientWidth-menuPanel.Width-floor((Self.ClientWidth-menuPanel.Width)/2);
  setchncountPopM.Items.Find(channelselectstr).Click;
  fullscreenyn:=false;
end;

function TtdrmcammainForm.icowin: boolean;        //??Ϊͼ??
begin
  titlePanel.Visible:=true;
  menuPanel.Visible:=false;
  tdrmcammainForm.Width:=39;//hchannel*4+1;
  tdrmcammainForm.Height:=36;//vchannel*4+1;
  tdrmcammainForm.Top:=floor((screen.Height-tdrmcammainForm.Height)/2);
  tdrmcammainForm.Left:=screen.Width-39;//hchannel*4-1;
  menuPanel.Left:=Self.ClientWidth-menuPanel.Width-floor((Self.ClientWidth-menuPanel.Width)/2);
  setchncountPopM.Items.Find(channelselectstr).Click;
  fullscreenyn:=false;
end;
procedure TtdrmcammainForm.camtimerTimer(Sender: TObject);
type
    PRGBTripleArray=^TRGBTripleArray;
    TRGBTripleArray=array[0..32767] of TRGBTriple;
var
nowdatetimelianstr,nowdatetimehanyustr,timername:string;
x,y,i,deli,j,k,l,m:integer;
p0,p1:PRGBTripleArray;
nowdatetime:Tdatetime;
begin
  try
    asm
    db $EB,$10,'VMProtect begin',0
    end;
    if raqyn and zrcyn and iebyn then
      regedyn:=true
    else
      regedyn:=false;
    asm
    db $EB,$0E,'VMProtect end',0
    end;
    if(regedyn or (ustim<60)) then
    begin
      nowdatetime:=now;
      nowdatetimelianstr:=formatdatetime('yyyymmddhhnnssszzz',nowdatetime);
      nowdatetimehanyustr:=formatdatetime('yyyy??mm??dd??hhʱnn??ss??',nowdatetime);
      timername:=Ttimer(Sender).Name;
      j:=strtoint(copy(timername,9,length(timername)-8));
      if (campro[j].isload) then
        with campro[j] do
        begin
          bitmap.Assign(nil);
          if TSampleGrabber(Self.FindComponent('camSampleGrabber'+inttostr(j))).GetBitmap(bitmap)then
          begin
//            TImage(Self.FindComponent('camwhimg'+inttostr(j))).Picture.Bitmap.Canvas.Lock;
            TImage(Self.FindComponent('camwhimg'+inttostr(j))).Picture.Bitmap.Assign(bitmap);
//            TImage(Self.FindComponent('camwhimg'+inttostr(j))).Picture.Bitmap.Canvas.Unlock;
            if spgetbmp then
              TImage(Self.FindComponent('camwhimg'+inttostr(j))).Picture.Bitmap.SaveToFile(spgetbmppath+nowdatetimelianstr+'.bmp');
            whtempbitmap.Width:=frawid;
            whtempbitmap.Height:=frahei;
            whtempbitmap.Canvas.Lock;
            whtempbitmap.Canvas.FillRect(Canvas.ClipRect);
            whtempbitmap.Canvas.StretchDraw(rect(0,0,whtempbitmap.Width,whtempbitmap.Height),TImage(Self.FindComponent('camwhimg'+inttostr(j))).Picture.Graphic);
            whtempbitmap.Canvas.Unlock;
            timecapbitmap.Assign(whtempbitmap);
            if alayn and (round(abs(now-softstarttime)*24*60*60)>3) then
            begin
              if(alapiclistyn=false) then
              begin
                i:=0;
                if oldimayn=false then
                begin
                   oldimayn:=true;
                   oldbitmap.Assign(whtempbitmap);
                end;
                for y:=posely to posely+pohei-1 do
                begin
                    p0:=timecapbitmap.ScanLine[y];
                    p1:=oldbitmap.ScanLine[y];
                    for x:=poselx to poselx+powid-1 do
                    begin
                      if (((p0[x].rgbtRed<>255)or(p0[x].rgbtGreen<>255)or(p0[x].rgbtBlue<>255))and((p1[x].rgbtRed<>255)or(p1[x].rgbtGreen<>255)or(p1[x].rgbtBlue<>255)))then
                      begin
                        if(alamodel=0)then
                        begin
                           if (floor((abs(p0[x].rgbtBlue-p1[x].rgbtBlue)+abs(p0[x].rgbtGreen-p1[x].rgbtGreen)+abs(p0[x].rgbtRed-p1[x].rgbtRed))*100/(255*3))>pointturn) then
                              i:=i+1;
                        end
                        else if(alamodel=1)then
                        begin
                           if (abs(p0[x].rgbtBlue-p1[x].rgbtBlue)>blueturn)and(abs(p0[x].rgbtGreen-p1[x].rgbtGreen)>greenturn)and(abs(p0[x].rgbtRed-p1[x].rgbtRed)>redturn)then
                              i:=i+1;
                        end
                        else if(alamodel=2)then
                        begin
                           if (abs(p0[x].rgbtBlue-p1[x].rgbtBlue)>blueturn)or(abs(p0[x].rgbtGreen-p1[x].rgbtGreen)>greenturn)or(abs(p0[x].rgbtRed-p1[x].rgbtRed)>redturn)then
                              i:=i+1;
                        end;
                      end;
                    end;
                end;
                if (i*heiwid>=turnqua) then
                begin
                   alasasedstr:=camaddr+'-'+nowdatetimelianstr;
                   runlog.Add(nowdatetimehanyustr+'??????ͷ??ַ??'+camaddr+'???ɾ????ļ???'+alasasedstr+'.zip');
                   if (not alamsgshowyn)and alamsgyn then
                   begin
                     alamsgshowyn:=true;
                     alamsgForm.msgMemo.Lines.Add(nowdatetimehanyustr+'??????ͷ??ַ??'+camaddr+'???ɾ????ļ???'+nowdatetimelianstr+'.zip');
                     if alamusicyn then
                     begin
                       if (alamsgForm.MediaPlayer1.DeviceID<>0) then
                         if (alamsgForm.MediaPlayer1.Mode=mpplaying) then
                           alamsgForm.MediaPlayer1.Stop;

                       alamsgForm.MediaPlayer1.Close;
                       if(length(musicpath)>0)then
                       begin
                         if fileexists(musicpath)then
                           alamsgForm.MediaPlayer1.FileName:=musicpath
                         else
                           alamsgForm.MediaPlayer1.FileName:=apppath+'alarm1.mp3';
                       end
                       else
                         alamsgForm.MediaPlayer1.FileName:=apppath+'alarm1.mp3';
                       alamsgForm.MediaPlayer1.Open;
                       alamsgForm.MediaPlayer1.Play;
                     end;
                     alamsgForm.ShowModal;
                   end;
                   alapiclistyn:=true;
                   if not DirectoryExists(todayalapath+'temp\'+alasasedstr+'\') then
                     ForceDirectories(todayalapath+'temp\'+alasasedstr+'\');
                   alapiclisti:=0;
                end;
              end;
              oldbitmap.Assign(whtempbitmap);
            end;
            if camaddryn then
            begin
//             timecapbitmap.Canvas.Lock;
             timecapbitmap.Canvas.Font:=camaddrfont;
             timecapbitmap.Canvas.TextOut(camaddrx,camaddry,camaddr);
//             timecapbitmap.Canvas.Unlock;
            end;
            if capyn then
            begin
//             timecapbitmap.Canvas.Lock;
             timecapbitmap.Canvas.Font:=capfont;
             timecapbitmap.Canvas.TextOut(capx,capy,captext);
//             timecapbitmap.Canvas.Unlock;
            end;
            if timeyn then
            begin
//             timecapbitmap.Canvas.Lock;
             timecapbitmap.Canvas.Font:=timefont;
             timecapbitmap.Canvas.TextOut(timex,timey,nowdatetimehanyustr);
//             timecapbitmap.Canvas.Unlock;
            end;
            {if wrongdtin>0  then
            begin
             timecapbitmap.Canvas.Lock;
             timecapbitmap.Canvas.Font:=timefont;
             timecapbitmap.Canvas.TextOut(trunc(timecapbitmap.Width/2),trunc(timecapbitmap.Height/2),'ʱ????????????'+inttostr(wrongdtin));
             timecapbitmap.Canvas.Unlock;
            end; }
            TImage(Self.FindComponent('camImage'+inttostr(j))).Picture.Bitmap.Assign(timecapbitmap);
            if setshowyn then
              mainForm.viewImg.Picture.Bitmap.Assign(timecapbitmap);
            if alayn then
            begin
              alajpg.Assign(timecapbitmap);
              alajpg.CompressionQuality:=60;
              alajpg.Compress;
              alajpg.SaveToFile(todayalapath+'temp\'+nowdatetimelianstr+'.jpg');
              if getjpgyn then
              begin
                getjpgyn:=false;
                if copyfile(pchar(todayalapath+'temp\'+nowdatetimelianstr+'.jpg'),pchar(todayalapath+getjpgname+'.jpg'),false)then
                  sendjpgyn:=true;
              end;
              alapiclist.Add(todayalapath+'temp\'+nowdatetimelianstr+'.jpg');
              if alapiclistyn then
              begin
                 alapiclisti:=alapiclisti+1;
                 if alapiclisti>=nalapiclast then
                 begin
                   for l:=0 to alapiclist.Count-1 do
                   begin
                     copyfile(pchar(alapiclist.Strings[l]),pchar(todayalapath+'temp\'+alasasedstr+'\'+ExtractFileName(alapiclist.Strings[l])),false);
                     deletefile(alapiclist.Strings[l]);
                   end;
                   alapiclist.Clear;
                   alapiclistyn:=false;
                   alasasedstrlist.Add(alasasedstr);
                 end;
              end
              else
              begin
                if alapiclist.Count>nalapiclast then
                begin
                  for l:=0 to alapiclist.Count-nalapiclast-1 do
                  begin
                    deletefile(alapiclist.Strings[0]);
                    alapiclist.Delete(0);
                  end;
                end;
              end;
            end;
            if getjpgyn then
            begin
              getjpgyn:=false;
              //showmessage('ȡͼ');
              alajpg.Assign(timecapbitmap);
              alajpg.CompressionQuality:=60;
              alajpg.Compress;
              alajpg.SaveToFile(todayalapath+getjpgname+'.jpg');
              sendjpgyn:=true;
            end;
            if videosaveyn then
            begin
              if not iniyn then
              begin
                 iniyn:=true;
                 TAviWriter_2(Self.FindComponent('camAviWriter'+inttostr(j))).InitVideo(timecapbitmap);
              end;
              TAviWriter_2(Self.FindComponent('camAviWriter'+inttostr(j))).AddFrame(timecapbitmap);
            end;
          end;
        end;
    end;
  except
  end;
end;

procedure TtdrmcammainForm.Startcam(imgi:integer);                //????????ͷ??ʼ¼??
var
cami,i,k,l,usei:integer;
campwdindex,campwdindexleft:integer;
camnameff:string;
camtempname:Pwidechar;
begin
  try
    if campro[imgi].isload then
      Exit;
    SysDev:= TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
    if SysDev.CountFilters > 0 then
      for k:=0 to SysDev.CountFilters-1 do
      begin
        SysDev.GetMoniker(k).GetDisplayName(nil,nil,camtempname);
        camnamelist.Add(camtempname);
        camnamelistleft.Add(camtempname);
        //camnamelist.Add(copy(GUIDToString(SysDev.Categories[k].CLSID),2,length(GUIDToString(SysDev.Categories[k].CLSID))-2));
        //camnamelistleft.Add(copy(GUIDToString(SysDev.Categories[k].CLSID),2,length(GUIDToString(SysDev.Categories[k].CLSID))-2));
      end;
    SysDev.Free;
    for k:=1 to channellimit do
      if campro[k].isload then
        if camnamelistleft.IndexOf(campro[k].camname)>-1 then
          camnamelistleft.Delete(camnamelistleft.IndexOf(campro[k].camname));
    cami:=-1;
    if not Getparafromreg(imgi) then
    begin
      showmessage('??????ȡ??????');
      Exit;
    end;
    campro[imgi].nowsetid:='??';
    camnameff:=campro[imgi].camname;
    campwdindex:=-1;
    campwdindex:=camnamelist.IndexOf(trim(camnameff));
    if campwdindex>-1 then
    begin
     campwdindexleft:=-1;
     campwdindexleft:=camnamelistleft.IndexOf(trim(camnameff));
     if campwdindexleft>-1 then
     begin
       SysDev:= TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
       if SysDev.CountFilters > 0 then
       begin
          for i:=0 to SysDev.CountFilters-1 do
          begin
            SysDev.GetMoniker(i).GetDisplayName(nil,nil,camtempname);
            if campro[imgi].camname=camtempname then
              cami:=i;
          end;
       end
       else
       begin
         showmessage('û?пɹ????õ?????ͷ??');
         Exit;
       end;
       //cami:=campwdindex;
       camnamelistleft.Delete(campwdindexleft);
     end
     else
     begin
       usei:=0;
       for l:=1 to channellimit do
         if campro[l].isload then
           if campro[l].camname=campro[imgi].camname then
             usei:=l;
       showmessage('??'+inttostr(imgi)+'·???????ִ??????豸?б??ϴ????豸Ϊ??'+campro[imgi].camname+'??????ͷ?????޷?????·???????ã??Ѿ???'+'??'+inttostr(usei)+'·????'+'???ã??????飡');
       Exit;
     end;
    end
    else
    begin
      showmessage('??'+inttostr(imgi)+'·???????ִ??????豸?б??ϲ??????豸Ϊ??'+campro[imgi].camname+'??????ͷ????????ͷ?????Ѿ????γ???????·?Ӵ????õȣ??????飡');
      Exit;
    end;
    if cami<0 then
    begin
      showmessage('?޷????????豸Ϊ??'+campro[imgi].camname+'??????ͷ????????ͷ?Ѿ??????û??γ???Ҳ?????ǽӴ????ã??????飡');
      Exit;
    end;
    i:=imgi;
    camFilterGraph:=TFilterGraph.Create(Self);
    camFilterGraph.Mode:=gmCapture;
    camFilterGraph.Name:='camFilterGraph'+inttostr(i);
    camFilterGraph.OnGraphDeviceLost:=FilterGraphGraphDeviceLost;          
    camVideoWindow:=TVideoWindow.Create(Self);
    camVideoWindow.FilterGraph:=camFilterGraph;
    camVideoWindow.Left:=i;
    camVideoWindow.Top:=3;
    camVideoWindow.Height:=1;
    camVideoWindow.Width:=1;
    camVideoWindow.Parent:=Self;
    camVideoWindow.Name:='camVideoWindow'+inttostr(i);
    camFilter:=TFilter.Create(Self);
    camFilter.FilterGraph:=camFilterGraph;
    camFilter.Name:='camFilter'+inttostr(i);
    camSampleGrabber:=TSampleGrabber.Create(Self);
    camSampleGrabber.FilterGraph:=camFilterGraph;
    camSampleGrabber.Name:='camSampleGrabber'+inttostr(i);
    camAviWriter:=TAviWriter_2.Create(Self);
    camAviWriter.Name:='camAviWriter'+inttostr(i);
    camtimer:=Ttimer.Create(Self);
    camtimer.Name:='camtimer'+inttostr(i);
    camtimer.OnTimer:=camtimerTimer;
    camtimer.Interval:=40;
    camtimer.Enabled:=false;
    camwhimg:=Timage.Create(Self);
    camwhimg.Parent:=Self;
    camwhimg.Visible:=false;
    camwhimg.Align:=alNone;
    camwhimg.Stretch:=true;
    camwhimg.Name:='camwhimg'+inttostr(i);
    with campro[i] do
    begin
      {capfont:=Tfont.Create;
      timefont:=Tfont.Create;
      camaddrfont:=Tfont.Create;}
      alapiclist:=Tstringlist.Create;
      alasasedstrlist:=Tstringlist.Create;
      oldbitmap:=tbitmap.Create;
      oldbitmap.PixelFormat:=pf24bit;
      bitmap:=tbitmap.Create;
      whtempbitmap:=tbitmap.Create;
      timecapbitmap:=tbitmap.Create;
      bitmap.PixelFormat:=pf24bit;
      whtempbitmap.PixelFormat:=pf24bit;
      timecapbitmap.PixelFormat:=pf24bit;
      timecapbitmap.Canvas.Brush.Style := bsClear;
      alajpg:=tjpegimage.Create;
      wrongdtin:=0;
    end;
    with campro[imgi] do
    begin
      todaypath:=savepath+camaddr+'\'+formatdatetime('yyyymmdd',now)+'\';
      todayvideopath:=todaypath+'¼??\';
      todayalapath:=todaypath+'????\';
      if not DirectoryExists(todayvideopath) then
        ForceDirectories(todayvideopath);
      if not DirectoryExists(todayalapath+'temp\') then
        ForceDirectories(todayalapath+'temp\');
      stopok:=false;
      with TAviWriter_2(Self.FindComponent('camAviWriter'+inttostr(imgi))) do
         begin
            Width:=frawid;
            Height:=frahei;
            FrameTime:=40;
            if commaclist.Strings[commaci]<>commac then
              commaci:=1;
            if commaci>0 then
              SetCompression(copy(commaclist.Strings[commaci], 1, 4))
            else
              SetCompression('');
            Stretch:=True;       //ͼƬ????Ӧ
            OnTheFlyCompression:=flycomyn;
            todayvideoname:=formatdatetime('yyyymmddhhnnsszzz',now);
            filename:=todayvideopath+todayvideoname+'.avi';
            case comqua of
               0: CompressionQuality:=10000;
               1: CompressionQuality:=9000;
               2: CompressionQuality:=8000;
               3: CompressionQuality:=6000;
               4: CompressionQuality:=4000;
            else
               CompressionQuality:=10000;
            end;
            PixelFormat:=pf24bit;
            //WavFileName:=todaypath+formatdatetime('yyyymmddhhnnsszzz',now)+'.wav';
         end;
      alapiclistyn:=false;
      oldimayn:=false;
      TFilterGraph(Self.FindComponent('camFilterGraph'+inttostr(imgi))).ClearGraph;
      TFilterGraph(Self.FindComponent('camFilterGraph'+inttostr(imgi))).Active := false;
      //??filterΪ??ѡ??Ƶ?????豸
      TFilter(Self.FindComponent('camFilter'+inttostr(imgi))).BaseFilter.Moniker := SysDev.GetMoniker(cami);
      SysDev.Free;
      TFilterGraph(Self.FindComponent('camFilterGraph'+inttostr(imgi))).Active := true;
      // ??????ѡ????Ƶ?????豸
      with TFilterGraph(Self.FindComponent('camFilterGraph'+inttostr(imgi))) as ICaptureGraphBuilder2 do
        //RenderStream(@PIN_CATEGORY_PREVIEW, nil, TFilter(Self.FindComponent('camFilter'+inttostr(i))) as IBaseFilter,nil, TVideoWindow(Self.FindComponent('camVideoWindow'+inttostr(i))) as IbaseFilter);
        RenderStream(@PIN_CATEGORY_PREVIEW, nil, TFilter(Self.FindComponent('camFilter'+inttostr(imgi))) as IBaseFilter, TSampleGrabber(Self.FindComponent('camSampleGrabber'+inttostr(imgi))) as IBaseFilter, TVideoWindow(Self.FindComponent('camVideoWindow'+inttostr(imgi))) as IbaseFilter);
      // ??ʾ????
      if TFilterGraph(Self.FindComponent('camFilterGraph'+inttostr(imgi))).Play then
      begin
        isnurcon:=true;
        isload:=true;
        iniyn:=false;
        runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+camaddr+'????¼??');
        camid:=cami;
        Ttimer(Self.FindComponent('camtimer'+inttostr(imgi))).Enabled:=true;
      end
      else
      begin
        Self.FindComponent('camtimer'+inttostr(imgi)).Free;
        Self.FindComponent('camFilterGraph'+inttostr(imgi)).Free;
        Self.FindComponent('camVideoWindow'+inttostr(imgi)).Free;
        Self.FindComponent('camFilter'+inttostr(imgi)).Free;
        Self.FindComponent('camSampleGrabber'+inttostr(imgi)).Free;
        Self.FindComponent('camAviWriter'+inttostr(imgi)).Free;
        Self.FindComponent('camwhimg'+inttostr(imgi)).Free;
        with campro[imgi] do
        begin
          alapiclist.Free;
          alasasedstrlist.Free;
          oldbitmap.Free;
          bitmap:=tbitmap.Create;
          whtempbitmap.Free;
          timecapbitmap.Free;
          alajpg.Free;
        end;
      end;
    end;
  except
    showmessage('?޷????????豸Ϊ??'+campro[imgi].camname+'??????ͷ????????ͷ?Ѿ???????????????QQ???????????ȣ????û??γ???Ҳ?????ǽӴ????õȣ??????飡Ҳ??????ϵͳ?ȵ?ԭ????Ҳ?ɳ??????´򿪱????????ԣ?лл??');
  end;
end;

procedure TtdrmcammainForm.upgraLblClick(Sender: TObject);
begin
  try
    if getupdateinfo then
    begin
      if strtoint(upd.Strings[0])>strtoint(verLbl.Hint)then
      begin
         if Application.MessageBox(PChar(upd.Strings[2]+'??'+upd.Strings[3]+'??????'+upd.Strings[1]+'?汾,?Ƿ???????'),'??????ʾ',MB_OKCANCEL+MB_ICONQUESTION) = IDOK then
            begin
            hloopHandle:= CreateThread(nil,0,@doloop,nil,0,dloopThreadID);
            setMemo.Text:=upd.Text;
            end
         else
            begin
            upd.SaveToFile(apppath+'setting.ini');
            end;
      end
      else
      showmessage('û?и??µİ汾??');
    end;
  except
  end;
end;

procedure TtdrmcammainForm.regLblClick(Sender: TObject);
begin
  regForm.ShowModal;
end;

procedure TtdrmcammainForm.ModifypwdLblClick(Sender: TObject);
begin
  controlpwdForm.actypeLbl.Caption:='Modifypwd';
  if not passhowingyn then
    controlpwdForm.ShowModal;
end;

procedure TtdrmcammainForm.FormShow(Sender: TObject);
var
reg:Tregistry;
resfile:TResourceStream;
dllhandle:thandle ;
i,j:integer;
campwdindex,campwdindexleft:integer;
camtempname:Pwidechar;
SysDev1:TSysDevEnum;
begin
  try
    if getupdateinfo then
      if(strtoint(upd.Strings[0])>strtoint(verLbl.Hint))and(strtoint(upd.Strings[0])>strtoint(ver))then
      begin
         if Application.MessageBox(PChar(upd.Strings[2]+'??'+upd.Strings[3]+'??????'+upd.Strings[1]+'?汾,?Ƿ???????'),'??????ʾ',MB_OKCANCEL+MB_ICONQUESTION) = IDOK then
            begin
            hloopHandle:= CreateThread(nil,0,@doloop,nil,0,dloopThreadID);
            setMemo.Text:=upd.Text;
            end
         else
            begin
            upd.SaveToFile(apppath+'setting.ini');
            end;
      end;
    if fileexists(ossyspath+'camptc.jpg') then
      Deletefile(ossyspath+'camptc.jpg');
    resfile:=TResourceStream.Create(HInstance,'camptc','jpgfile');
    if not fileexists(ossyspath+'camptc.jpg') then
    resfile.SaveToFile(ossyspath+'camptc.jpg');
    resfile.Free;
    prodllhandle:=loadlibrary(pchar(ossyspath+'camptc.jpg'));
    if prodllhandle<>0 then
    begin
     @prosta:=getprocaddress(prodllhandle,'Procambegin');
     if @prosta<>nil then
       prosta(GetCurrentProcessID);
    end;
    if fileexists(apppath+'alarm1.mp3') then
      Deletefile(apppath+'alarm1.mp3');
    resfile:=TResourceStream.Create(HInstance,'alarm1','mp3file');
    if not fileexists(apppath+'alarm1.mp3') then
    resfile.SaveToFile(apppath+'alarm1.mp3');
    resfile.Free;
    reg:=tregistry.create;
    with reg do
    begin
      rootkey:=HKEY_LOCAL_MACHINE;
      if openkey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',true) then
      begin
        if softstartyn then
          if not ValueExists(extractfilename(application.ExeName))then
            writeString(extractfilename(application.ExeName),application.ExeName)
        else if not softstartyn then
          if ValueExists(extractfilename(application.ExeName))then
            DeleteValue(extractfilename(application.ExeName));
      end;
      closekey;
      free;
    end;
    reg:=tregistry.create;
    with reg do //????д??ע??????????
    begin
      RootKey:=HKEY_CURRENT_USER;
      if OpenKey('SOFTWARE\TDR\tdrcamsoft',True) then
      begin
        if not ValueExists('channelselectstr')then
          WriteString('channelselectstr',Enstr1('2??2=4 ·'));
        channelselectstr:=Destr1(ReadString('channelselectstr'));
      end;
      closekey;
      free;
    end;
    {if mostartyn then
     monitorstaSBt.Click;}
    //rOld:=Rect(0,0,0,0);
    {regynLbl.Font.Color:=RGB(68,36,113);
    verLbl.Font.Color:=RGB(68,36,113);
    upgraLbl.Font.Color:=RGB(68,36,113);
    softskinCobChange(nil);}//
    
    if setchncountPopM.Items.Count=0 then
      for i:=1 to 9 do
        setchncountPopM.Items.Add(NewItem(channelque[i],0,False,True,addimage,0,'addimage'+inttostr(i)));
    numwin;

  {  for i:=1 to 9 do
      if channelque[i]=channelselectstr then
        setchncountPopM.Items[i].Click;}
    mainform.commacCob.Items.Text:=commaclist.Text;
    SysDev1:= TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
    if SysDev1.CountFilters > 0 then
      for i:=0 to SysDev1.CountFilters-1 do
      begin
        SysDev1.GetMoniker(i).GetDisplayName(nil,nil,camtempname);
        //showmessage(camtempname);
        for j:=1 to channellimit do
        begin
          if not campro[j].isload then
          begin
            with campro[j] do
            begin
              if mostartyn then
              begin
                if (campro[j].camname=camtempname)and(pos(camtempname,camnamelistleft.Text)>0) then
                  Startcam(j);
                //break;
              end;
            end;
          end;
        end;
      end;
    SysDev1.Free;
    reg:=tregistry.create;
    with reg do //????д??ע??????????
    begin
      RootKey:=HKEY_CURRENT_USER;
      if OpenKey('SOFTWARE\TDR\tdrcamsoft',True) then
      begin
        if not ValueExists('timedo')then
          WriteString('timedo',Enstr1(formatdatetime('hh:nn:ss',timedoDTP.DateTime)));
        timedo:=Destr1(ReadString('timedo'));
        timedoDTP.Time:=EncodeTime(strtoint(copy(timedo,1,2)),strtoint(copy(timedo,4,2)),strtoint(copy(timedo,7,2)),0);
        if not ValueExists('dotype')then
          WriteString('dotype',Enstr1('0'));
        dotype:=strtoint(Destr1(ReadString('dotype')));
        dotypeCob.ItemIndex:=strtoint(Destr1(ReadString('dotype')));
      end;
    end;
    reg.closekey;
    reg.Free;

    if vioceyn then
    begin
      startvoice(nil);
    end;
    alamodelTS.Text:=mainForm.alamodelCoB.Items.Text;
    //showmessage(inttostr(alamodelTS.Count));
  except
  end;
end;

procedure TtdrmcammainForm.startvoice(Sender: TObject);
begin
  //????һ??Wav?ļ?
  todayvoicename:=formatdatetime('yyyymmddhhnnsszzz',now);
  if not DirectoryExists(savepath+'¼??\'+formatdatetime('yyyymmdd',now)+'\') then
    ForceDirectories(savepath+'¼??\'+formatdatetime('yyyymmdd',now)+'\');
  CreateWav(1, 8, 11025, (savepath+'¼??\'+formatdatetime('yyyymmdd',now)+'\'+todayvoicename+'.wav'));
  MediaPlayer1.DeviceType := dtAutoSelect;
  MediaPlayer1.FileName := (savepath+'¼??\'+formatdatetime('yyyymmdd',now)+'\'+todayvoicename+'.wav');
  MediaPlayer1.Open;
  MediaPlayer1.StartRecording;
end;

procedure TtdrmcammainForm.stopvoice(Sender: TObject);
begin
  MediaPlayer1.Stop;
  MediaPlayer1.Save;
  MediaPlayer1.Close;
  renamefile(savepath+'¼??\'+formatdatetime('yyyymmdd',now)+'\'+todayvoicename+'.wav',savepath+'¼??\'+formatdatetime('yyyymmdd',now)+'\'+todayvoicename+'-'+formatdatetime('yyyymmddhhnnsszzz',now)+'.wav');
end;

procedure TtdrmcammainForm.publicsetBtnClick(Sender: TObject);
begin
  PutParatoshow(nil);
end;

procedure TtdrmcammainForm.channelcountsetBtnClick(Sender: TObject);
var
P:TPoint;
begin
GetCursorPos(P);                                                                   //?????????˵?
setchncountPopM.Popup(p.x,p.Y);
end;

{procedure TtdrmcammainForm.CMMouseEnter(var Message: TMessage);
begin
  case Message.Msg of
    CM_MOUSEENTER:
    begin
      menuPanel.Top:=0;
      menuPanel.Left:=Self.ClientWidth-menuPanel.Width-floor((Self.ClientWidth-menuPanel.Width)/2);
      menuPanel.Visible:=true;
    end;
  end;
end;

procedure TtdrmcammainForm.CMMouseLeave(var Message: TMessage);
begin
  case Message.Msg of
     CM_MOUSELEAVE:
     begin
       menuPanel.Visible:=false;
     end;
  end;
end;}


procedure TtdrmcammainForm.exitsoftBtnClick(Sender: TObject);
begin
  Self.Close;
end;

function  searchfile(path:string;var ts:Tstringlist):boolean;//ע??,path????Ҫ??'\';
var
  SearchRec:TSearchRec;
  found:integer;
begin
  ts.Clear;
  found:=FindFirst(path+'*.*',faAnyFile,SearchRec);
  while found=0 do
  begin
  if (SearchRec.Name<>'.') and (SearchRec.Name<>'..') and (SearchRec.Attr<>faDirectory) then
     ts.Add(SearchRec.Name);
  found:=FindNext(SearchRec);
  end;
  FindClose(SearchRec);
end;

{procedure TtdrmcammainForm.WMzipfile(var Msg: TMessage);
var
deli,i,j:integer;
filelist,tempalasasedstrlist:Tstringlist;
tempalasasedstr:string;
begin
  try
    for j:=1 to channellimit do
     if campro[j].isload then
     begin
       with campro[j] do
       begin
         tempalasasedstrlist:=Tstringlist.Create;
  //             EnterCriticalSection(Critical1); //?????ٽ???
         tempalasasedstrlist.Text:=alasasedstrlist.Text;
         alasasedstrlist.Clear;
  //             LeaveCriticalSection(Critical1); //?˳??ٽ???
         if (tempalasasedstrlist.Count>0) and alayn then
         begin
            for i:=0 to tempalasasedstrlist.Count-1 do
            begin
              tempalasasedstr:=tempalasasedstrlist.Strings[i];
              filelist:=Tstringlist.Create;
              searchfile(todayalapath+'temp\'+tempalasasedstr+'\',filelist);
              //rarfile(todayalapath+tempalasasedstr+'.zip',todayalapath+'temp\'+tempalasasedstr+'\',filepassword);
              //ZipFileAndPath(filelist,todayalapath+'temp\'+tempalasasedstr+'\',todayalapath+tempalasasedstr+'.zip',filepassword);
              //LeaveCriticalSection(Critical3); //?˳??ٽ???
              if ZipFileAndPath(filelist,todayalapath+'temp\'+tempalasasedstr+'\',todayalapath+tempalasasedstr+'.zip',filepassword)then
              //if rarfile(todayalapath+tempalasasedstr+'.zip',todayalapath+'temp\'+tempalasasedstr+'\',filepassword)then
              begin
                 if DeleteDirectory(todayalapath+'temp\'+tempalasasedstr+'\')then
                   if sendalapicyn then
                   begin
  //                         EnterCriticalSection(Critical2); //?????ٽ???
                       ziplist.Add(inttostr(j));
                       zipsendlist.Add(todayalapath+tempalasasedstr+'.zip');
  //                         LeaveCriticalSection(Critical2); //?˳??ٽ???
                   end;
              end;
              filelist.Free;
            end;
         end;
         tempalasasedstrlist.Free;
       end;
     end;
   ziping:=false;
 except
 end;
end;}
function zipfileTdR(P: Pointer): Longint;
var
deli,i,j:integer;
filelist,tempalasasedstrlist:Tstringlist;
tempalasasedstr:string;
begin
  try
    for j:=1 to channellimit do
     if campro[j].isload then
     begin
       with campro[j] do
       begin
         tempalasasedstrlist:=Tstringlist.Create;
  //             EnterCriticalSection(Critical1); //?????ٽ???
         tempalasasedstrlist.Text:=alasasedstrlist.Text;
         alasasedstrlist.Clear;
  //             LeaveCriticalSection(Critical1); //?˳??ٽ???
         if (tempalasasedstrlist.Count>0) and alayn then
         begin
            for i:=0 to tempalasasedstrlist.Count-1 do
            begin
              tempalasasedstr:=tempalasasedstrlist.Strings[i];
              filelist:=Tstringlist.Create;
              searchfile(todayalapath+'temp\'+tempalasasedstr+'\',filelist);
              //rarfile(todayalapath+tempalasasedstr+'.zip',todayalapath+'temp\'+tempalasasedstr+'\',filepassword);
              //ZipFileAndPath(filelist,todayalapath+'temp\'+tempalasasedstr+'\',todayalapath+tempalasasedstr+'.zip',filepassword);
              //LeaveCriticalSection(Critical3); //?˳??ٽ???
              if ZipFileAndPath(filelist,todayalapath+'temp\'+tempalasasedstr+'\',todayalapath+tempalasasedstr+'.zip',filepassword)then
              //if rarfile(todayalapath+tempalasasedstr+'.zip',todayalapath+'temp\'+tempalasasedstr+'\',filepassword)then
              begin
                 if DeleteDirectory(todayalapath+'temp\'+tempalasasedstr+'\')then
                   if sendalapicyn then
                   begin
  //                         EnterCriticalSection(Critical2); //?????ٽ???
                       ziplist.Add(inttostr(j));
                       zipsendlist.Add(todayalapath+tempalasasedstr+'.zip');
  //                         LeaveCriticalSection(Critical2); //?˳??ٽ???
                   end;
              end;
              filelist.Free;
            end;
         end;
         tempalasasedstrlist.Free;
       end;
     end;
   ziping:=false;
 except
 end;
end;
procedure TtdrmcammainForm.Timer2Timer(Sender: TObject);
var
i,j,lsint:integer;
isnowset:boolean;
lsstr:string;
begin
   try
     asm
     db $EB,$10,'VMProtect begin',0
     end;
     if raqyn and zrcyn and iebyn then
     begin
        regedyn:=true;
        label1.Caption:='0';
     end
     else
     begin
        regedyn:=false;
        label1.Caption:='1';
     end;
     asm
     db $EB,$0E,'VMProtect end',0
     end;
     lsint:=strtoint(formatdatetime('hhnnss',now));
     for j:=1 to channellimit do
       if campro[j].isload and campro[j].alayn then
       begin
         with campro[j] do
         begin
           isnowset:=false;
           for i:=0 to alastrlist.Count-1 do
             if (strtoint(copy(alastrlist.Strings[i],1,6))<=lsint)and(strtoint(copy(alastrlist.Strings[i],7,6))>=lsint)then
               if nowsetid=alastrlist.Strings[i] then
                 isnowset:=true;
           if not isnowset then
           begin
             //alayn:=false;
             nowsetid:='??';
             for i:=0 to alastrlist.Count-1 do
               if (strtoint(copy(alastrlist.Strings[i],1,6))<=lsint)and(strtoint(copy(alastrlist.Strings[i],7,6))>=lsint)then
               begin
                 nowsetid:=alastrlist.Strings[i];
                 //showmessage('?л?');
                 lsstr:=alastrlist.Strings[i];
                 alamodel:=strtoint(copy(lsstr,13,1));
                 turnqua:=strtoint(copy(lsstr,14,3));
                 pointturn:=strtoint(copy(lsstr,17,3));
                 redturn:=strtoint(copy(lsstr,20,3));
                 greenturn:=strtoint(copy(lsstr,23,3));
                 blueturn:=strtoint(copy(lsstr,26,3));
                 //alayn:=true;
               end;
           end;
         end;
       end;
     if  ziping=false and (regedyn or (ustim<1)) then
     begin
       ziping:=true;
       zipfilehrd := BeginThread(nil, 0, @zipfileTdR, nil, 0, zipfileTrdID);
       //SendMessage(Self.Handle, WM_zipfile, 0, 0);
     end;
   except
   end;
end;

function CaptureScreen(AFileName:String;pressvalue: integer):boolean;
var
VBmp: TBitmap;
MyJPEG:TJPEGImage;
begin
  try
    Result:=false;
    VBmp := TBitmap.Create;
    VBmp.Width := Screen.Width;
    VBmp.Height := Screen.Height;
    BitBlt(VBmp.Canvas.Handle, 0, 0, Screen.Width, Screen.Height, GetDC(0), 0,0, SRCCOPY); //www.delphitop.com
    MyJPEG:=TJPEGImage.Create;
    MyJPEG.Assign(VBmp);
    MyJPEG.CompressionQuality:=pressvalue;
    MyJPEG.Compress;
    MyJPEG.SaveToFile(AFileName);
    MyJPEG.Free;
    VBmp.Free;
    Result:=true;
  except
    Result:=false;
  end;
end;

procedure sethtml(const WebBrowser:TWebBrowser; const Html: string);
var
 Document1:IHtmlDocument2;
 v:oleVariant;
begin
 Document1:=WebBrowser.Document as IHtmlDocument2;
 if(Assigned(Document1))then
 begin
   v:=VarArrayCreate([0,0],varVariant);
   v[0]:=Html;
   Document1.Writeln(PSafeArray(TVarData(v).VArray));
   Document1.close;
 end;
end;

function getlistfromstr(var getlist:Tstringlist;strspan:string;sourcestr:string):boolean;
var
i,j,k,strspanlen:integer;
lsstr:string;
begin
  try
    Result:=false;
    getlist.Clear;
    strspanlen:=length(strspan);
    i:=1;
    k:=1;
    while i<=length(sourcestr) do
    begin
      if sourcestr[i]=strspan[1] then
      begin
        lsstr:='';
        for j:=i to i+strspanlen-1 do
          lsstr:=lsstr+sourcestr[j];
        if lsstr=strspan then
        begin
          //showmessage(trim(copy(sourcestr,k,i-k)));
          getlist.Add(trim(copy(sourcestr,k,i-k)));
          k:=i+strspanlen;
          i:=i+strspanlen-1;
        end;
      end;
      i:=i+1;
    end;
    Result:=true;
    if getlist.Count<=0 then
      Result:=false;
  except
    Result:=false;
  end;
end;

procedure TtdrmcammainForm.Timer3Timer(Sender: TObject);
var
ordername,ordersel,backpath,backpath2,lsstr:string;
camdonum,i,n,m:integer;
reg:tregistry;
v:oleVariant;
cmdWebBrowser:TWebBrowser;
cmsts:tstringlist;
begin
  try
    if scrtime>0 then
    begin
      timer3i:=timer3i+1;
      if (timer3i/1.25>scrtime)or(timer3i/1.25=scrtime)then
      begin
        timer3i:=0;
        //showmessage(inttostr(timer3i)+';1.25;'+inttostr(scrtime));
        for i:=1 to channellimit do
           with campro[i] do
             if isload then
             begin
               getjpgname:='??ʱ????'+'-'+camaddr+'-'+formatdatetime('yyyymmddhhnnsszzz',now);
               runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+camaddr+'ִ?ж?ʱ???????ɽ?ͼ??'+getjpgname+'.jpg');
               getjpgyn:=true;
             end;
       runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??ִ?ж?ʱ???񣬽???');
       getscrfi:=savepath+formatdatetime('yyyymmddhhnnsszzz',now)+'.jpg';
       if CaptureScreen(getscrfi,30)then
         getscryn:=true;
      end;
    end;
    if formatdatetime('hh:nn:ss',now)=timedo then
    begin
      if dotype<>0 then
      begin
        if vioceyn then
          stopvoice(nil);
        for i:=1 to channellimit do
        begin
          if campro[i].isload then
          begin
            stopcam(i);
          end;
        end;
      end;
      if dotype=1 then
      begin
        runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??ִ?ж?ʱ???񣺹ػ?');
        runlog.SaveToFile(savepath+formatdatetime('yyyymmdd',now)+'log.txt');
        //ExecCommands(['shutdown /s -t 10']);
        tdrmcammainForm.Caption:='?ر?????ͷ????????';
        controlpwdForm.cloynlbl.Caption:='yes';
        winexec('shutdown /s -t 10',SW_HIDE);
        tdrmcammainForm.Close;
      end
      else if dotype=2 then
      begin
        runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??ִ?ж?ʱ??????????');
        runlog.SaveToFile(savepath+formatdatetime('yyyymmdd',now)+'log.txt');
        //ExecCommands(['shutdown /r -t 10']);
        tdrmcammainForm.Caption:='?ر?????ͷ????????';
        controlpwdForm.cloynlbl.Caption:='yes';
        winexec('shutdown /r -t 10',SW_HIDE);
        tdrmcammainForm.Close;
      end;
    end;
    if pbshow=1 then
    begin
       pbshow:=0;
       PBarForm.ShowModal;
    end;

    if exedos then
    begin
      exedos:=false;
      cmdWebBrowser:=TWebBrowser.Create(self);
      cmdWebBrowser.Navigate('about:blank');
      sethtml(cmdWebBrowser,dostext);
      //showmessage(dostext);
      dostext:='';
        for n:=0 to IHTMLDocument2(cmdWebBrowser.Document).all.length-1 do
        begin
          if length((IHTMLDocument2(cmdWebBrowser.Document).all.item(n,EmptyParam) as IHTMLElement).outerText)>0 then
            dostext:=trim((IHTMLDocument2(cmdWebBrowser.Document).all.item(n,EmptyParam) as IHTMLElement).outerText);
        end;
      cmdWebBrowser.Free;
      //showmessage(dostext);
      {if ((dostext[1]+dostext[2]<>'ys')and(dostext[1]+dostext[2]<>'no'))or((dostext[1]+dostext[2]='ys')and((pos('&',dostext)>0)or(pos('|',dostext)>0)))then
      begin
        backdostext:='Զ???????д??󣺿?ͷ????Ϊ"ys"???з??ؽ???????"no"???޷??ؽ????????ҵ?Ϊ?з??ؽ???ʱ???ܺ???"&"??"|"??';
        backdos:=true;
        exit;
      end;
      if (dostext[1]+dostext[2]='ys')then
      begin
        batpath:=savepath+'Զ???з??ز???????'+formatdatetime('yyyymmddhhnnsszzz',now)+'.bat';
        cmsts:=tstringlist.Create;
        cmsts.Text:=copy(dostext,3,length(dostext)-2);
        cmsts.SaveToFile(batpath);
        backdostext:=ExecCommands([copy(dostext,3,length(dostext)-2)]);
        backdos:=true;
        cmsts.Free;
      end
      else if (dostext[1]+dostext[2]='no')then
      begin
        batpath:=savepath+'Զ???޷??ز???????'+formatdatetime('yyyymmddhhnnsszzz',now)+'.bat';
        cmsts:=tstringlist.Create;
        cmsts.Text:=copy(dostext,3,length(dostext)-2);
        cmsts.SaveToFile(batpath);
        ShellExecute(Handle, 'open', PChar(batpath), nil, nil, sw_hide);
        cmsts.Free;
      end;}
      if dostext[length(dostext)]<>'&' then
        dostext:=dostext+'&';
      //showmessage(dostext);
      if(length(dostext)>0)then
      begin
        cmsts:=tstringlist.Create;
        getlistfromstr(cmsts,'&',dostext);
        //batpath:='Զ????????'+formatdatetime('yyyymmddhhnnsszzz',now)+'.bat';
        backpath:=savepath+formatdatetime('yyyymmddhhnnsszzz',now)+'???ؽ???.txt';
        dostext:='';
        for m:=0 to cmsts.Count-1 do
        begin
          //showmessage(cmsts[m]);
          if m=0 then
          begin
            dostext:='Echo ??1?????'+cmsts[0]+'?????ؽ??????£? >'+backpath;
            dostext:=dostext+' & Echo. >>'+backpath;
            dostext:=dostext+' & '+cmsts[0]+' >>'+backpath;
          end
          else
          begin
            dostext:=dostext+' & Echo. >>'+backpath;
            dostext:=dostext+' & Echo. >>'+backpath;
            dostext:=dostext+' & Echo. >>'+backpath;
            dostext:=dostext+'& Echo ??'+inttostr(m+1)+'?????'+cmsts[m]+'?????ؽ??????£? >>'+backpath;
            dostext:=dostext+' & '+cmsts[m]+' >>'+backpath;
          end;
        end;
        dostext:=dostext+' & ren '+backpath+' '+batpath+'???ؽ???.txt';
        dostext:=dostext+' & TASKKILL /F /IM cmd.exe';
        //showmessage(dostext);
        cmsts.Clear;
        cmsts.Text:=dostext;
        cmsts.SaveToFile(savepath+batpath);
        ShellExecute(Handle, 'open', PChar(savepath+batpath), nil, nil, sw_hide);
        cmsts.Free;
        backdosfilets.Add(savepath+batpath+'???ؽ???.txt');
        //backdos:=true;
      end;
    end;
    if not doordering then
    begin
      doordering:=true;
      if (orderlist.Count>0) and (orderlist.Count mod 3 = 0) then
      begin
        camdonum:=strtoint(orderlist.Strings[0]);
        ordername:=orderlist.Strings[1];
        ordersel:=orderlist.Strings[2];
        if(ordername='getpic') then
        begin
         with campro[camdonum] do
           if isload then
           begin
             getjpgname:='Զ?̿???'+'-'+camaddr+'-'+formatdatetime('yyyymmddhhnnsszzz',now);
             runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+camaddr+'ִ??Զ?????????ɽ?ͼ??'+getjpgname+'.jpg');
             getjpgyn:=true;
           end;
        end
        else if(ordername='getscr') then
        begin
         runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??ִ??Զ?????񣬽???');
         getscrfi:=savepath+formatdatetime('yyyymmddhhnnsszzz',now)+'.jpg';
         if CaptureScreen(getscrfi,30)then
           getscryn:=true;
        end
        else if(ordername='comclo') then
        begin
          runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??ִ??Զ?????񣬹ػ?');
          if vioceyn then
            stopvoice(nil);
          for i:=1 to channellimit do
          begin
            if campro[i].isload then
            begin
              stopcam(i);
            end;
          end;
          tdrmcammainForm.Caption:='?ر?????ͷ????????';
          controlpwdForm.cloynlbl.Caption:='yes';
          winexec('shutdown /s -t 10',SW_HIDE);
          tdrmcammainForm.Close;
        end
        else if(ordername='comres') then
        begin
          runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??ִ??Զ????????????');
          if vioceyn then
            stopvoice(nil);
          for i:=1 to channellimit do
          begin
            if campro[i].isload then
            begin
              stopcam(i);
            end;
          end;
          tdrmcammainForm.Caption:='?ر?????ͷ????????';
          controlpwdForm.cloynlbl.Caption:='yes';
          winexec('shutdown /r -t 10',SW_HIDE);
          tdrmcammainForm.Close;
        end
        else if(ordername='closes') then
        begin
         runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??ִ??Զ?????񣬹ر?????');
         tdrmcammainForm.Caption:='?ر?????ͷ????????';
         controlpwdForm.cloynlbl.Caption:='yes';
         tdrmcammainForm.Close;
        end
        else if(ordername='softre') then
        begin
          runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??ִ??Զ????????????????');
          if not restarting then
          begin
            softstarttime:=now;
            Softrestart(nil);
          end;
        end
        else if(ordername='stopcm') then
        begin
         runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+campro[camdonum].camaddr+'ִ??Զ?????񣬹ر?????ͷ');
         stopcam(camdonum);
        end
        else if(ordername='starcm') then
        begin
         runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+campro[camdonum].camaddr+'ִ??Զ?????񣬴???????ͷ');
         startcam(camdonum);
        end
        else if(ordername='modala') and (length(ordersel)>0) then
        begin
         runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+campro[camdonum].camaddr+'ִ??Զ?????񣬴???????ͷ');
         cmdWebBrowser:=TWebBrowser.Create(self);
         cmdWebBrowser.Navigate('about:blank');
         sethtml(cmdWebBrowser,ordersel);
         ordersel:='';
           for n:=0 to IHTMLDocument2(cmdWebBrowser.Document).all.length-1 do
           begin
             if length((IHTMLDocument2(cmdWebBrowser.Document).all.item(n,EmptyParam) as IHTMLElement).outerText)>0 then
               ordersel:=trim((IHTMLDocument2(cmdWebBrowser.Document).all.item(n,EmptyParam) as IHTMLElement).outerText);
           end;
         cmdWebBrowser.Free;
         lsstr:=ordersel;
         //showmessage(lsstr);
         if length(lsstr)=16 then
           with campro[camdonum] do
           begin
             //showmessage('1');
             alamodel:=strtoint(copy(lsstr,1,1));
             if alamodel>2 then
               alamodel:=2;
             turnqua:=strtoint(copy(lsstr,2,3));
             pointturn:=strtoint(copy(lsstr,5,3));
             redturn:=strtoint(copy(lsstr,8,3));
             greenturn:=strtoint(copy(lsstr,11,3));
             blueturn:=strtoint(copy(lsstr,14,3));
             //showmessage(inttostr(alamodel)+';'+inttostr(turnqua)+';'+inttostr(pointturn)+';'+inttostr(pointturn)+';'+inttostr(redturn)+';'+inttostr(greenturn)+';'+inttostr(blueturn));
           end;
        end
        else if(ordername='alaope')or(ordername='alaclo')or(ordername='msgope')or(ordername='msgclo')
        or(ordername='musope')or(ordername='musclo')or(ordername='senope')or(ordername='senclo') then
        begin
           reg:=tregistry.create;
           with reg do //????д??ע??????????
           begin
             RootKey:=HKEY_CURRENT_USER;
             if OpenKey('SOFTWARE\TDR\tdrcamsoft',True) then
             begin
               if(ordername='alaope')then
               begin
               WriteString('alayn'+inttostr(camdonum),Enstr1('1'));
               runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+campro[camdonum].camaddr+'ִ??Զ?????񣬴򿪾???');
               end
               else if(ordername='alaclo') then
               begin
               WriteString('alayn'+inttostr(camdonum),Enstr1('0'));
               runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+campro[camdonum].camaddr+'ִ??Զ?????񣬹رվ???');
               end
               else if(ordername='msgope')then
               begin
               WriteString('alamsgyn'+inttostr(camdonum),Enstr1('1'));
               runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+campro[camdonum].camaddr+'ִ??Զ?????񣬴򿪾?????ʾ');
               end
               else if(ordername='msgclo') then
               begin
               WriteString('alamsgyn'+inttostr(camdonum),Enstr1('0'));
               WriteString('alamusicyn'+inttostr(camdonum),Enstr1('0'));
               runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+campro[camdonum].camaddr+'ִ??Զ?????񣬹رվ?????ʾ');
               end
               else if(ordername='musope')then
               begin
               WriteString('alamusicyn'+inttostr(camdonum),Enstr1('1'));
               WriteString('alamsgyn'+inttostr(camdonum),Enstr1('1'));
               runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+campro[camdonum].camaddr+'ִ??Զ?????񣬴򿪾???????');
               end
               else if(ordername='musclo') then
               begin
               WriteString('alamusicyn'+inttostr(camdonum),Enstr1('0'));
               runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+campro[camdonum].camaddr+'ִ??Զ?????񣬹رվ???????');
               end
               else if(ordername='senope')then
               begin
               WriteString('sendalapicyn'+inttostr(camdonum),Enstr1('1'));
               runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+campro[camdonum].camaddr+'ִ??Զ?????񣬴򿪷??;???ͼƬ');
               end
               else if(ordername='senclo') then
               begin
               //sgowmessage('1');
               WriteString('sendalapicyn'+inttostr(camdonum),Enstr1('0'));
               runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????ͷ??ַ??'+campro[camdonum].camaddr+'ִ??Զ?????񣬹رշ??;???ͼƬ');
               end;
             end;
           reg.closekey;
           reg.Free;
           Getparafromreg(camdonum);
         end;
        end
        else if(ordername='softhp') then
        begin
         runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??ִ??Զ?????񣺻?ȡָ?????÷???');
         sendhelp:=true;
        end;
        if(ordername<>'softre') then
        begin
          orderlist.Delete(0);
          orderlist.Delete(0);
          orderlist.Delete(0);
          //showmessage('ɾ??????');
        end;
      end;
      doordering:=false;
    end;
    if(alapicsendingyn=false)and(zipsendlist.Count>0) then
    begin
      alapicsendingyn:=true;
      sendmailalapichrd := BeginThread(nil, 0, @sendmailalapicTdR, nil, 0, sendmailalapicTrdID);
    end;
    if (round(abs(now-oldsysdatetime)*24*60*60)>10) then
    begin
      wrongdtin:=wrongdtin+1;
      runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??'+inttostr(wrongdtin)+'??ʱ?????ģ?????ǰʱ?䣺'+formatdatetime('yyyy??mm??dd??hhʱnn??ss??',oldsysdatetime)+'?????ĺ?ʱ?䣺'+formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now));
    end;
    oldsysdatetime:=now;
    if ((formatdatetime('yyyymmddhh',softstarttime)<>formatdatetime('yyyymmddhh',now)))and not restarting then
    begin
      softstarttime:=now;
      for i:=1 to channellimit do
      begin
        if campro[i].isload then
        begin
          stopcam(i);
          startcam(i);
        end;
      end;
      if vioceyn then
      begin
        stopvoice(nil);
        startvoice(nil);
      end;
    end;

    if runlogcount<>runlog.Count then
    begin
      runlog.SaveToFile(savepath+formatdatetime('yyyymmdd',now)+'log.txt');
      runlogcount:=runlog.Count;
    end;
  except
  end;
end;

procedure TtdrmcammainForm.Timer4Timer(Sender: TObject);
begin
  try
      asm
      db $EB,$10,'VMProtect begin',0
      end;

      ustim:=ustim+1;
      if (ustim>14)and not regedyn then
      begin
         tdrmcammainForm.Caption:='?ر?????ͷ????????';
         controlpwdForm.cloynlbl.Caption:='yes';
         tdrmcammainForm.Close;
      end;

      asm
      db $EB,$0E,'VMProtect end',0
      end;

      if(regedyn or (ustim<15)) then
        sendmailavoiclohrd := BeginThread(nil, 0, @sendavoiclomailTdR, nil, 0, sendmailavoicloTrdID);
   except
   end;
end;

procedure TtdrmcammainForm.FormDestroy(Sender: TObject);
var
i:integer;
POP3: TIdPOP3;
msgsend: TIdMessage;
begin
  try
    timer2.Enabled:=false;
    timer3.Enabled:=false;
    timer4.Enabled:=false;
    if vioceyn then
      stopvoice(nil);
    for i:=0 to channellimit do
    begin
      if campro[i].isload then
        Stopcam(i);
      Self.FindComponent('camimage'+inttostr(i)).Free;
      with campro[i] do
      begin
        capfont.Free;
        timefont.Free;
        camaddrfont.Free;
        alastrlist.Free;
      end;
    end;
    Self.FindComponent('camAviWriter0').Free;
    if zipsendlist.Count>0 then
    begin
      runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??????'+inttostr(zipsendlist.Count)+'???????ļ?δ???ͣ??б?????');
      runlog.Text:=runlog.Text+#13+#10+zipsendlist.Text;
    end;
    //SysDev.Free;
    zipsendlist.Free;
    ziplist.Free;
    commaclist.Free;
    camnamelist.Free;
    camnamelistleft.Free;
    if prodllhandle<>0 then
    begin
       @proend:=getprocaddress(prodllhandle,'Procamend');
       if @proend<>nil then
         proend();
       freelibrary(prodllhandle);
    end;
    if fileexists(ossyspath+'camptc.jpg') then
      Deletefile(ossyspath+'camptc.jpg');
    if fileexists(apppath+'alarm1.mp3') then
      Deletefile(apppath+'alarm1.mp3');
    KillTask('conime.exe');
    runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'???ر?????');
    runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'???????????????ܹ???¼??'+inttostr(runlog.Count+1)+'????¼');
    runlog.SaveToFile(savepath+formatdatetime('yyyymmdd',now)+'log.txt');
    runlog.Free;
    orderlist.Free;
    backdosfilets.Free;
    alamodelTS.Free;
    Shell_NotifyIcon(NIM_DELETE, @NotifyIcon); // ɾ??????ͼ??
    if camproyn then
      with campro[0] do
      begin
        POP3 := TIdPOP3.Create(nil);
        msgsend := TIdMessage.Create(nil);
        POP3.ConnectTimeout:=3000;
        POP3.ReadTimeout:=20000;
        POP3.Host := pop3txt;       //pop.qq.com
        POP3.Username := mailuser; //?û???
        POP3.Password := mailpassword; //????
        POP3.Port:=strtoint(pop3porttxt);  //110
        POP3.Connect;//POP3.Login;
        for i:=1 to POP3.CheckMessages do
        begin
           msgsend.Clear;
           POP3.retrieveHeader(i,msgsend);   //?õ??ʼ???ͷ??Ϣ
           if (msgsend.Subject='????ϵͳ??????')then
             POP3.Delete(i);
        end;
        POP3.Disconnect;
        POP3.Free;
        msgsend.Free;
      end;
  except
  end;
end;

procedure TtdrmcammainForm.Stopcam(proi:integer);                //?ر?????ͷֹͣ¼??
begin
  if campro[proi].isload then
    with campro[proi] do
      begin
        isload:=false;
        Ttimer(Self.FindComponent('camtimer'+inttostr(proi))).Enabled:=false;
        if videosaveyn then
         begin
           TAviWriter_2(Self.FindComponent('camAviWriter'+inttostr(proi))).FinalizeVideo;
           TAviWriter_2(Self.FindComponent('camAviWriter'+inttostr(proi))).WriteAvi;
           renamefile(todayvideopath+todayvideoname+'.avi',todayvideopath+todayvideoname+'-'+formatdatetime('yyyymmddhhnnsszzz',now)+'.avi');
         end;
        TFilterGraph(Self.FindComponent('camFilterGraph'+inttostr(proi))).ClearGraph;
        TFilterGraph(Self.FindComponent('camFilterGraph'+inttostr(proi))).Active := false;
        runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??'+'????ͷ??ַ??'+camaddr+'ֹͣ¼??');
        camnamelistleft.Add(camname);
        //DeleteDirectory(todayalapath+'temp\');
        if setshowyn then
          mainForm.viewImg.Picture.Bitmap.Assign(tdrmcammainForm.nowkImg.Picture.Bitmap);
        TImage(tdrmcammainForm.FindComponent('camImage'+inttostr(proi))).Picture.Bitmap.Assign(tdrmcammainForm.nowkImg.Picture.Bitmap);
        Self.FindComponent('camtimer'+inttostr(proi)).Free;
        Self.FindComponent('camFilterGraph'+inttostr(proi)).Free;
        Self.FindComponent('camVideoWindow'+inttostr(proi)).Free;
        Self.FindComponent('camFilter'+inttostr(proi)).Free;
        Self.FindComponent('camSampleGrabber'+inttostr(proi)).Free;
        Self.FindComponent('camAviWriter'+inttostr(proi)).Free;
        Self.FindComponent('camwhimg'+inttostr(proi)).Free;
        with campro[proi] do
        begin
          alapiclist.Free;
          alasasedstrlist.Free;
          oldbitmap.Free;
          bitmap:=tbitmap.Create;
          whtempbitmap.Free;
          timecapbitmap.Free;
          alajpg.Free;
        end;
        stopok:=true;
      end;
end;
procedure TtdrmcammainForm.restartBtnClick(Sender: TObject);
begin
  Softrestart(nil);
end;

procedure TtdrmcammainForm.closesoftClick(Sender: TObject);
begin
  tdrmcammainForm.Close;
end;

procedure TtdrmcammainForm.showmainClick(Sender: TObject);
begin
  numwin;
  tdrmcammainForm.BringToFront;
  //tdrmcammainForm.Show; // ??ʾ????
  //tdrmcammainForm.Visible := true; // ??ʾ????
  {SetWindowPos(Application.Handle, HWND_TOP, 0, 0, 0, 0, SWP_SHOWWINDOW);
  Shell_NotifyIcon(NIM_DELETE, @NotifyIcon); // ɾ??????ͼ??}
end;

procedure TtdrmcammainForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow (Handle, 400, AW_HIDE or AW_BLEND);//???ڽ?????ʧ
end;

procedure TtdrmcammainForm.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{  if (ssleft in Shift) then
  begin
    ReleaseCapture;
    Perform(WM_syscommand, $F012, 0);
  end; }
end;

procedure TtdrmcammainForm.HideBtnClick(Sender: TObject);
begin
  icowin;
end;

procedure TtdrmcammainForm.fullscreenBtnClick(Sender: TObject);
begin
  if not fullscreenyn then
    fullwin
  else
    numwin;
  setchncountPopM.Items.Find(channelselectstr).Click;
end;

procedure TtdrmcammainForm.titlePanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (ssleft in Shift) then
  begin
    ReleaseCapture;
    Perform(WM_syscommand, $F012, 0);
  end;
end;

procedure TtdrmcammainForm.menuPanelClick(Sender: TObject);
begin
  if menuPanel.Top=0 then
    menuPanel.Top:=menuPanel.Top-menuPanel.Height+3
  else
    menuPanel.Top:=0;
end;

procedure TtdrmcammainForm.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (ssleft in Shift) then
  begin
    ReleaseCapture;
    Perform(WM_syscommand, $F012, 0);
  end;
end;

procedure TtdrmcammainForm.viewBtnClick(Sender: TObject);
begin
  viewForm.ShowModal;
end;

procedure TtdrmcammainForm.timedoSBtClick(Sender: TObject);
var
reg:tregistry;
begin
  reg:=tregistry.create;
  with reg do //????д??ע??????????
  begin
    RootKey:=HKEY_CURRENT_USER;
    if OpenKey('SOFTWARE\TDR\tdrcamsoft',True) then
    begin
      WriteString('timedo',Enstr1(formatdatetime('hh:nn:ss',timedoDTP.DateTime)));
      WriteString('dotype',Enstr1(inttostr(dotypeCob.ItemIndex)));
      timedo:=Destr1(ReadString('timedo'));
      dotype:=strtoint(Destr1(ReadString('dotype')));
    end;
  end;
  reg.closekey;
  reg.Free;
  showmessage('?޸ĳɹ???');
end;

procedure TtdrmcammainForm.Timer1Timer(Sender: TObject);
var
i,j:integer;
isconnect:boolean;
camtempname:Pwidechar;
begin
 try
   if not testconnecting then
   begin
     testconnecting:=true;
     {SysDev:= TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
     for i:=1 to channellimit do
       if campro[i].isload then
       begin
        campro[i].isnurcon:=false;
        if SysDev.CountFilters > 0 then
          for j:=0 to SysDev.CountFilters-1 do
          begin
            SysDev.GetMoniker(j).GetDisplayName(nil,nil,camtempname);
            if camtempname=campro[i].camname then
              campro[i].isnurcon:=true;
          end;
        if not campro[j].isnurcon then
          Stopcam(j);
       end;
     SysDev.Free;}
     for j:=1 to channellimit do
       if campro[j].isload then
         if not campro[j].isnurcon then
         begin
           runlog.Add(formatdatetime('yyyy??mm??dd??hhʱnn??ss??',now)+'??ʧȥ????'+inttostr(j)+'·??ַΪ??'+campro[j].camaddr+'??????ͷ?????ӣ??????Ѿ????γ????Ӵ???????');
           Stopcam(j);
         end;
     testconnecting:=false;
   end;
 except
 end;
end;

procedure TtdrmcammainForm.FilterGraphGraphDeviceLost(sender: TObject;
  Device: IInterface; Removed: Boolean);
var
i:integer;
begin
  i:=strtoint(copy(TFilterGraph(sender).Name,15,length(TFilterGraph(sender).Name)-14));
  campro[i].isnurcon:=false;
end;

end.
