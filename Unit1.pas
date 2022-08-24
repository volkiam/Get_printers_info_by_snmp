unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, IdSNMP,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    IdSNMP1: TIdSNMP;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button2: TButton;
    Edit3: TEdit;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ Функция SNMP опроса принтера }
Function SNMPQuery (Host, Mib: string) : string;
var
s: String;
i, j: Integer;
SNMP: TIdSNMP;
temps:string;
begin
SNMP := TIdSNMP.Create(nil);
SNMP.Query.Host := Host;
SNMP.Query.Port := 161;
SNMP.Query.Community := Form1.Edit3.Text;
SNMP.Query.PDUType := PDUGetRequest;
SNMP.Query.MIBAdd(Mib,'');
try
if SNMP.SendQuery then
for i := 0 to SNMP.Reply.ValueCount - 1 do
 begin
  SNMPQuery:= SNMP.Reply.Value[i];
  temps:=SNMP.Reply.Value[0]
 end;
finally
Application.ProcessMessages;
SNMP.Free;
end;
end;

function HexToInt(s: string): integer;
label
  gte;
var
  tempt: string;
  i: integer;
begin
  tempt := '';
  if s = '' then
  begin
    HexToInt := 0;
    goto gte;
  end;
  for i := 1 to Length(s) do
  begin
    tempt := tempt + IntToHex(Ord(s[i]), 2);
  end;
  HexToInt := StrToInt(tempt);
  gte:
end;

procedure TForm1.Button1Click(Sender: TObject);
  var
   Host, t: string;
   mib:array [1..15] of string[80];
   k:integer;
Begin
Memo1.Clear;
host:= Form1.Edit1.Text;
mib[1]:= '1.3.6.1.2.1.43.11.1.1.8.1.1';
mib[2]:= '1.3.6.1.2.1.43.5.1.1.17.1';
mib[3]:= '1.3.6.1.2.1.25.3.5.1.1.1';  //other(1), unknown(2), idle(3), printing(4), warmup(5)
mib[4]:= '1.3.6.1.2.1.43.17.6.1.5.1.2';
mib[5]:= '1.3.6.1.2.1.1.5.0';
mib[6]:= '1.3.6.1.2.1.2.2.1.6.2';
mib[7]:= '1.3.6.1.2.1.43.10.2.1.4.1.1';
mib[8]:= '1.3.6.1.2.1.25.3.2.1.3.1';
mib[9]:= '1.3.6.1.2.1.43.11.1.1.9.1.1';
mib[10]:= '1.3.6.1.2.1.43.11.1.1.6.1.1';
mib[11]:= '1.3.6.1.2.1.43.17.6.1.5.1.1';
mib[12]:= '1.3.6.1.2.1.25.3.2.1.5.1'; //unknown(1), running(2), warning(3), testing(4), down(5)
mib[13]:= '1.3.6.1.4.1.641.2.1.5.3';   //
{ hrprinterdetectederrorstate OBJECT-TYPE SYNTAX OCTET STRING ACCESS read-only
STATUS mandatory DESCRIPTION "This object represents any error conditions detected
by the printer. The error conditions are encoded as bits in an octet string,
with the following definitions: Condition Bit # hrDeviceStatus
lowPaper 0 warning(3)
noPaper 1 down(5)
lowToner 2 warning(3)
noToner 3 down(5)
doorOpen 4 down(5)
jammed 5 down(5)
offline 6 down(5)
serviceRequested 7 warning(3)


Condition         Value
lowPaper
noPaper              @
lowToner
noToner
nocartridge          0x10
doorOpen            0x08
jammed                do not have time to do )))}

Memo1.Lines.Add('Объем картриджа' + ': ' + SNMPQuery(host, mib[1]));
Memo1.Lines.Add('Серийный номер' + ': ' + SNMPQuery(host, mib[2]));
Memo1.Lines.Add('Состояние принтера' + ': ' + SNMPQuery(host, mib[3]));
Memo1.Lines.Add('Состояние устройства' + ': ' + SNMPQuery(host, mib[4]));
Memo1.Lines.Add('Host name' + ': ' + SNMPQuery(host, mib[5]));
Memo1.Lines.Add('Mac adress' + ': ' + SNMPQuery(host, mib[6]));
Memo1.Lines.Add('Page' + ': ' + SNMPQuery(host, mib[7]));
Memo1.Lines.Add('Model' + ': ' + SNMPQuery(host, mib[8]));
Memo1.Lines.Add('Текущий уровень тонера' + ': ' + SNMPQuery(host, mib[9]));
Memo1.Lines.Add('Тип картриджа' + ': ' + SNMPQuery(host, mib[10]));
Memo1.Lines.Add('Статус печати' + ': ' + SNMPQuery(host, mib[11]));
Memo1.Lines.Add('Расположение' + ': ' + SNMPQuery(host, mib[12]));
Memo1.Lines.Add('картридж' + ': ' + SNMPQuery(host, mib[13]));

end;                   

procedure TForm1.Button2Click(Sender: TObject);
begin
Memo1.Lines.Add('Check OID' + ': ' + SNMPQuery(Form1.Edit1.Text, Form1.Edit2.Text));
end;



end.
