PROGRAM Babati;
uses crt,dos,graph;
const
 day:array[0..6] of string=
('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
 month:array[1..12] of string=('January','February','March','April','May','June',
 'July','August','September','October','November','December');

Type
date=record   {record containing details for the date}
     day:integer;
     month:integer;
   year:integer;
end;
Regis=record {record containing resident details}
fname,hsetype:string;
resID:real;
tel:real;
dtreg:date;
end;
Bus=record {record containing business details}
name,bstype:string;
busID:real;
tel:real;
dtereg:date;
end;
Sewer=record  {record containing residents registered to sewer line}
name,subtype:string;
ID:real;
datreg:date;
end;
Garbage=record  {record containing residents registered to garbage collection}
name:string;
id:real;
dtgreg:date;
end;
payment=record {record of payments}
rent,gregfee,gfee,bsn,mkt,pfee,cfee,park,resID,busID:real;
m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12:string;
mg1,mg2,mg3,mg4,mg5,mg6,mg7,mg8,mg9,mg10,mg11,mg12:string;
ms1,ms2,ms3,ms4,ms5,ms6,ms7,ms8,ms9,ms10,ms11,ms12:string;
annual:string;
annualb:string;
dtpayr:date;
dtpayg:date;
dtpays:date;
dtpayb:date;
dtpaym:date;
dtpayp:date;
monthpaid:string;
end;
Market=record {record containing market details}
vnd,total:real;
end;
Parking=record {record containing parking details}
vhctype:string;
vcamount:real;
dtpark:date;
end;
lic=record{record of licensed businesses}
name,bstype:string;
end;
VAR
regisfile:file of regis;
payfile:file of payment;
busfile:file of bus;
mktfile:file of market;
prkfile:file of parking;
sewfile:file of sewer;
gabfile:file of garbage;
tsk:integer;
register:regis;
business:bus;
pay:payment;
mkt:market;
park:parking;
sewage:sewer;
garb:garbage;
c:char;
dd,mm,yyyy,dow:word;

Procedure entry;       {procedure for starting of program}
var
  Gd, Gm, I, Width: Integer;
begin
  Gd := Detect; InitGraph(Gd, Gm, '');
  if GraphResult <> grOk then Halt(1);
    setbkcolor(blue);
    setfillstyle(10,blue);
    Bar(0, 0, 650, 600);
    setcolor(14);
    settextstyle(4,0,4);
    outtextxy(115,25,'BABATI URBAN COUNCIL');
    outtextxy(60,70,'REVENUE COLLECTION SYSTEM');
    setcolor(13);
    outtextxy(200,200,'WELCOME');
    settextstyle(5,0,3);
    setcolor(white);
    outtextxy(180,300,'Program coded by:');
    outtextxy(170,330,'Birir Lee Kipngetich');
    outtextxy(200,370,'401099114');
    settextstyle(7,0,1);
    setcolor(11);
    outtextxy(100,410,'Press <enter> key to continue');
  ReadLn;
  CloseGraph;
end;

procedure dt;     {procedure for getting date}
begin
getdate(yyyy,mm,dd,dow);
end;

Procedure menu;   {procedure for main menu}
begin;
dt;
textbackground(blue);
clrscr;
textcolor(lightred);
gotoxy(5,2);writeln('B A B A T I  R E V E N U E  C O L L E C T I O N  S Y S T E M');
gotoxy(5,3);writeln('-------------------------------------------------------------');
textcolor(yellow);
gotoxy(24,5);writeln(' MAIN MENU ');
textcolor(lightgreen);
gotoxy(48,7);writeln('The current date is  ',dd,'/',mm,'/',yyyy);
textcolor(white);
gotoxy(7,9);writeln('Please select a task that you want to do:');
writeln;
writeln('       1.Registration');
writeln('       2.Collect revenue');
writeln('       3.Display  records');
writeln('       4.View reports');
writeln('       5.Edit records');
writeln('       6.Delete records');
writeln('       7.Exit program');
readln(tsk);
 if tsk>7 then
       repeat
       writeln('ERROR! PLEASE ENTER THE CORRECT TASK');
       readln(tsk);
       until tsk<=7
       end;


Procedure input_res;    {procedure for registering tenants}
label 1,2;
VAR
hs,ndai:integer;
id,v:real;
n,s:string;
begin

        {$I-}   reset(regisfile);{$I+}
     if ioresult <>0 then 1:rewrite(regisfile);
    while not eof(regisfile)  do
    begin
     {$I-} read(regisfile,register);{$I+}
       if ioresult <> 0 then goto 1;
       end;

      {$I-}   reset(payfile);{$I+}
     if ioresult <>0 then 2:rewrite(payfile);
    while not eof(payfile)  do
    begin
     {$I-} read(payfile,pay);{$I+}
       if ioresult <> 0 then goto 2;
    end;

    repeat
    clrscr;
    textcolor(11);
     writeln('Enter the name of the resident');readln(n);
     readln(n);
     writeln('Enter the ID number of the resident');
    repeat
    reset(regisfile);
    readln(ID);V:=1;
    while not eof(regisfile) do
    begin
    read(regisfile,register);
    if register.resID=ID then
    begin
    writeln('The ID Number already exists.Enter another valid one');
    V:=0;
    end;
    end;
    until v=1;
    register.resID:=ID;
    register.fname:=n;
    pay.resID:=register.resID;
    writeln('Enter the telephone number of the resident');
    readln(register.tel);
    writeln('Enter the type of house');
    writeln('           HOUSES:                      ');
    writeln('ษออออออออออออออออออออออออออออออออออออออป');
    writeln('บ    House Type            Rent        บ');
    writeln('บ 1ฏฏฏฏSingle room      Ksh.500.00     บ');
    writeln('บ 2ฏฏฏฏOne bedroomed    Ksh.1,500.00   บ');
    writeln('บ 3ฏฏฏฏTwo bedroomed    Ksh.2,500.00   บ');
    writeln('บ 4ฏฏฏฏThree bedroomed  Ksh.3,500.00   บ');
    writeln('ศออออออออออออออออออออออออออออออออออออออผ');
    write('House type:');read(hs);
    if hs>4 then
       repeat
       writeln('ERROR! PLEASE ENTER THE CORRECT HOUSE TYPE');
       readln(hs);
       until hs<=4;
    case hs of
          1:register.hsetype:='Single room';
          2:register.hsetype:='One bedroomed';
          3:register.hsetype:='Two bedroomed';
          4:register.hsetype:='Three bedroomed';
          end;

    dt;
    writeln('The date of registration is:',dd,'/',mm,'/',yyyy);readln;
    register.dtreg.day:=dd;
    register.dtreg.month:=mm;
    register.dtreg.year:=yyyy;
    s:='';
    pay.m1:=s;
    pay.m2:=s;
    pay.m3:=s;
    pay.m4:=s;
    pay.m5:=s;
    pay.m6:=s;
    pay.m7:=s;
    pay.m8:=s;
    pay.m9:=s;
    pay.m10:=s;
    pay.m11:=s;
    pay.m12:=S;

    seek(regisfile,filesize(regisfile));
    seek(payfile,filesize(payfile));
    write (regisfile,register);
    write(payfile,pay);


    write('DO YOU WANT TO INPUT ANOTHER TENANT (Y/N) ?');
    repeat
        c:=upcase(readkey);
    until c in ['Y','N'];
     writeln(c);
    until c='N';
   close(regisfile);
   close(payfile);

             end;

Procedure input_bus;    {procedure for registering businesses}
label 3,4;
Var
  bs,gari:integer;
  id,v:real;
  n,s:string;
begin
clrscr;
 dt;
         {$I-}   reset(busfile);{$I+}
     if ioresult <>0 then 3:rewrite(busfile);
      {$I-}   reset(payfile);{$I+}
     if ioresult <>0 then 4:rewrite(payfile);
    while not eof(payfile)  do
    begin
     {$I-} read(payfile,pay);{$I+}
       if ioresult <> 0 then goto 4;
    end;
    repeat
    clrscr;
    textcolor(11);
    writeln('Enter the name of the business');
    readln(n);  readln(n);
    writeln('Enter the license number of the business');
     repeat
     reset(busfile);
    readln(ID);V:=1;
     while not eof(busfile)  do
    begin
     {$I-} read(busfile,business);{$I+}
       if ioresult <> 0 then goto 3;
       end;
    if business.busID=ID then
    begin
    writeln('The ID Number already exists.Enter another valid one');
    V:=0;
    end;
    until v=1;
    business.busID:=ID;
    business.name:=n;
    pay.busID:=business.busID;

    writeln('Enter the type of business preffered');
     writeln('       BUSINESSES:                     ');
    writeln('ษออออออออออออออออออออออออออออออออออออออป');
    writeln('บ  Business type         License fee   บ');
    writeln('บ 1:General shop         Ksh.3000.00   บ');
    writeln('บ 2:Hardware shop        Ksh.4500.00   บ');
    writeln('บ 3:Private institution  Ksh.10000.00  บ');
    writeln('บ 4:Miscellaneous        Ksh.2500.00   บ');
    writeln('ศออออออออออออออออออออออออออออออออออออออผ');
    write('Business type:');read(bs);
    if bs>4 then
       repeat
       writeln('ERROR! PLEASE ENTER THE CORRECT BUSINESS TYPE');
       readln(bs);
       until bs<=4;
     case bs of
          1:business.bstype:='General shop';
          2:business.bstype:='Hardware shop';
          3:business.bstype:='Private institution';
          4:business.bstype:='Miscellaneous';

          end;

    writeln('Enter the telephone no. of the business');
    readln(business.tel);
    writeln('The date of registration is:',dd,'/',mm,'/',yyyy);
    business.dtereg.day:=dd;
    business.dtereg.month:=mm;
    business.dtereg.year:=yyyy;
    s:='';
    pay.annualb:=s;

     seek(busfile,filesize(busfile));
     seek(payfile,filesize(payfile));
     write (busfile,business);
     write(payfile,pay);
    write('DO YOU WANT TO INPUT ANOTHER BUSINESS (Y/N) ?');
    repeat
        c:=upcase(readkey);
    until c in ['Y','N'];
     writeln(c);
    until c='N';
    close(busfile);
    close(payfile);
      end;

Procedure input_sewer;  {procedure for registering sewer connection}
label 5;
var
sb:integer;
id,v:real;
begin
dt;
clrscr;
      {$I-}   reset(sewfile);{$I+}
     if ioresult <>0 then 5:rewrite(sewfile);
    while not eof(sewfile)  do
    begin
     {$I-} read(sewfile,sewage);{$I+}
       if ioresult <> 0 then goto 5;
       end;

    repeat
    clrscr;
writeln('Residents pay the following to be connected:');
writeln('ษออออออออออออออออออออออออออออออออออออออป ');
writeln('บ 1.Initial connection fee  - Ksh 3500 บ ');
writeln('บ 2.Annual Subcription fee  - Ksh 3000 บ ');
writeln('บ 3.Monthly Subcription fee - Ksh 300  บ ');
writeln('ศออออออออออออออออออออออออออออออออออออออผ ');
writeln;textcolor(white);
Writeln('Press any key to continue......');readkey;

clrscr;
textcolor(11);
writeln('Enter the ID number of the tenant who');
write('wants to be connected:');
repeat
readln(id);
reset(regisfile);
v:=0;
repeat
read(regisfile,register);
if register.resid=id then v:=1;
until eof(regisfile);
if v=0 then
begin
writeln('Resident does not exist');
writeln('Enter a valid ID number of a tenant that exists');
end
else
until v=1;
if v=1 then
begin
reset(regisfile);
repeat
read(regisfile,register);
until register.resid=id;
     writeln('Which subscription does the resident want to connect to?');
     writeln('1.Annual subscription');
     writeln('2.Monthly subscription');
     write('Subscription:');readln(sb);
     if sb>2 then
       repeat
       writeln('ERROR! PLEASE ENTER THE CORRECT SUBSCRIPTION TYPE');
       readln(sb);
       until sb<=2;
     case sb of
      1:sewage.subtype:='Annual subscription';
      2:sewage.subtype:='Monthly subscription';
      end;
      writeln('The date of registration is:',dd,'/',mm,'/',yyyy);
      sewage.datreg.day:=dd;
     sewage.datreg.month:=mm;
     sewage.datreg.year:=yyyy;
     sewage.name:=register.fname;
     sewage.id:=register.resID;

      seek(sewfile,filesize(sewfile));
      write(sewfile,sewage);
      end;
    writeln('DO YOU WANT TO REGISTER ANOTHER RESIDENT?(Y/N)');
      repeat
        c:=upcase(readkey);
    until c in ['Y','N'];
     writeln(c);
    until c='N';
    close(sewfile);
      end;

Procedure input_garbage;    {procedure for registering garbage collection}
label 6;
var id,v:real;
begin
dt;
clrscr;

      {$I-}   reset(gabfile);{$I+}
     if ioresult <>0 then 6:rewrite(gabfile);
    while not eof(gabfile)  do
    begin
     {$I-} read(gabfile,garb); {$I+}
       if ioresult <> 0 then goto 6;
    end;
    repeat
    clrscr;
writeln('Residents have to pay the following to be registered:');
writeln('ษออออออออออออออออออออออออออออออออออออออป ');
writeln('บ Initial connection fee - Ksh.500.00  บ ');
writeln('บ Monthly subscription   - Ksh.100.00  บ ');
writeln('ศออออออออออออออออออออออออออออออออออออออผ ');
clrscr;
textcolor(11);
writeln('Enter the ID number of the tenant who');
writeln('wants to be connected:');
repeat
readln(id);
reset(regisfile);
v:=0;
repeat
read(regisfile,register);
if register.resid=id then v:=1;
until eof(regisfile);
if v=0 then
begin
writeln('Resident does not exist');
writeln('Enter a valid ID number of a tenant that exists');
end
else
until v=1;
if v=1 then
begin
reset(regisfile);
repeat
read(regisfile,register);
until register.resid=id;
 writeln('The date of registration is:',dd,'/',mm,'/',yyyy);
     garb.dtgreg.day:=dd;
     garb.dtgreg.month:=mm;
     garb.dtgreg.year:=yyyy;
     garb.name:=register.fname;
     garb.id:=register.resID;

     seek(gabfile,filesize(gabfile));
     write(gabfile,garb);
     end;
    writeln('DO YOU WANT TO REGISTER ANOTHER RESIDENT?(Y/N)');
      repeat
        c:=upcase(readkey);
    until c in ['Y','N'];
     writeln(c);
    until c='N';
    close(gabfile);
      end;

Procedure registration;
var
ch:integer;
begin
clrscr;
   textcolor(yellow);
   gotoxy(25,3);writeln('REGISTRATION MENU');
   gotoxy(5,4);writeln('--------------------------------------------------------');
   textcolor(white);
  gotoxy(4,7);writeln('What do you want to register?');
   writeln('     1ฏฏฏTenant              ');
   writeln('     2ฏฏฏBusiness            ');
   writeln('     3ฏฏฏSewer Services      ');
   writeln('     4ฏฏฏGarbage collection  ');
   writeln('     5ฏฏฏGo back to main menu');
   read(ch);
   if ch>5 then
       repeat
       writeln('ERROR! PLEASE ENTER THE CORRECT TASK');
       readln(ch);
       until ch<=5;
   case ch of
       1:input_res;
       2:input_bus;
       3:input_sewer;
       4:input_garbage;
       5:menu;
    end;
    end;

procedure view_res; label 7;    {procedure for viewing tenant details}
var x,y:integer;
begin
  dt;
  clrscr;textcolor(lightmagenta);
        gotoxy(25,1);writeln('REGISTERED TENANTS');
        textcolor(10);
        gotoxy(1,2);writeln('ษอออออออออออออหอออออออออออหอออออออออออออออหออออออออออออออออหอออออออออออออออออป ');
        gotoxy(1,3);write('บ NAME                                                                        ');
        gotoxy(15,3);write('บ ID NO.                                                                     ');
        gotoxy(27,3);write('บ TEL NO.                                                                   ');
        gotoxy(43,3);write('บ HSE TYPE ');
        gotoxy(60,3);write('บ DATE REGISTERED บ');
        gotoxy(1,4);writeln('ฬอออออออออออออฮอออออออออออฮอออออออออออออออฮออออออออออออออออฮอออออออออออออออออบ' );
     {$I-}   reset(regisfile);{$I+}
     if ioresult <>0 then 7:rewrite(regisfile);
         x:=0;
        while not eof(regisfile) do
        begin
       {$I-} read(regisfile,register);{$I+}
       if ioresult <> 0 then goto 7;
        x:=x+1;
        textcolor(14);
        gotoxy(2,wherey);write(register.fname);
        gotoxy(16,wherey);write(register.resID:0:0);
        gotoxy(28,wherey);write(register.tel:0:0);
        gotoxy(44,wherey);write(register.hsetype);
        gotoxy(61,wherey);writeln(register.dtreg.day,'/',register.dtreg.month,'/',register.dtreg.year);
        end;
        textcolor(10);
        y:=3;
        repeat
        y:=y+1;
        gotoxy(1,y);writeln('บ');
        gotoxy(15,y);writeln('บ');
        gotoxy(27,y);writeln('บ');
        gotoxy(43,y);writeln('บ');
        gotoxy(60,y);writeln('บ');
        gotoxy(78,y);writeln('บ');
        until y=x+4;
        gotoxy(1,wherey);writeln('ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
        writeln('');writeln('');writeln('');  textcolor(white);
        Writeln('      Press any key to continue......');
        readkey;

end;

procedure view_regbus;    {procedure for viewing business details}
label 8;
var x,y:integer;
begin
  dt;
  clrscr;textcolor(lightmagenta);
        gotoxy(25,1);writeln('REGISTERED BUSINESSES');
        textcolor(10);
        gotoxy(1,2);writeln('ษอออออออออออออหอออออออออออหอออออออออออออออออออหออออออออออออหอออออออออออออออป ');
        gotoxy(1,3);write('บ NAME');
        gotoxy(15,3);write('บLIC NO.');
        gotoxy(27,3);write('บBSN TYPE');
        gotoxy(47,3);write('บTEL NO.');
        gotoxy(60,3);write('บDATE REGISTEREDบ');
         gotoxy(1,4);writeln('ฬอออออออออออออฮอออออออออออฮอออออออออออออออออออฮออออออออออออฮอออออออออออออออบ' );
          {$I-}   reset(busfile);{$I+}
     if ioresult <>0 then 8:rewrite(busfile);
         x:=0;
        while not eof(busfile) do
        begin
       {$I-} read(busfile,business);{$I+}
       if ioresult <> 0 then goto 8;
        x:=x+1;
        textcolor(14);
        gotoxy(2,wherey);write(business.name);
        gotoxy(16,wherey);write(business.busID:0:0);
        gotoxy(28,wherey);write(business.bstype);
        gotoxy(48,wherey);write(business.tel:0:0);
        gotoxy(61,wherey);writeln(business.dtereg.day,'/',business.dtereg.month,'/',business.dtereg.year);
        end;
        textcolor(10);
        y:=3;
        repeat
        y:=y+1;
        gotoxy(1,y);writeln('บ');
        gotoxy(15,y);writeln('บ');
        gotoxy(27,y);writeln('บ');
        gotoxy(47,y);writeln('บ');
        gotoxy(60,y);writeln('บ');
        gotoxy(76,y);writeln('บ');
        until y=x+4;
        gotoxy(1,wherey);writeln('ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
        writeln('');writeln('');writeln('');  textcolor(white);
        Writeln('      Press any key to continue......');
        readkey;
        end;

procedure view_regsew;    {procedure for viewing tenants registered to sewage connection}
  label 9;
  begin
  clrscr;textcolor(lightmagenta);
        gotoxy(19,1);writeln('REGISTERED TO SEWER SERVICE');
        textcolor(10);
        gotoxy(3,3);write('NAME');
        gotoxy(20,3);write('ID NO.');
        gotoxy(29,3);write('SUBSCRIPTION');
        gotoxy(52,3);writeln('DATE REGISTERED');
        {$I-}   reset(sewfile);{$I+}
     if ioresult <>0 then 9:rewrite(sewfile);
        while not eof(sewfile) do
        begin
       {$I-} read(sewfile,sewage);{$I+}
       if ioresult <> 0 then goto 9;
        begin
        textcolor(14);
        gotoxy(3,wherey);write(sewage.name);
        gotoxy(20,wherey);write(sewage.ID:0:0);
        gotoxy(29,wherey);write(sewage.subtype);
        gotoxy(52,wherey);writeln(sewage.datreg.day,'/',sewage.datreg.month,'/',sewage.datreg.year);
        end;
        end;
        writeln('');writeln('');writeln('');  textcolor(white);
        Writeln('      Press any key to continue......');
        readkey;
        end;

procedure view_regarb;   {procedure for viewing tenants registered to garbage collection}
label 10;
  begin
  clrscr;textcolor(lightmagenta);
        gotoxy(19,1);writeln('REGISTERED TO GARBAGE COLLECTION');
        textcolor(10);
        gotoxy(3,3);write('NAME');
        gotoxy(20,3);write('ID NO.');
        gotoxy(29,3);writeln('DATE REGISTERED');
        {$I-}   reset(gabfile);{$I+}
     if ioresult <>0 then 10:rewrite(gabfile);
        while not eof(gabfile) do
        begin
       {$I-} read(gabfile,garb);{$I+}
       if ioresult <> 0 then goto 10;
        begin
        textcolor(14);
        gotoxy(3,wherey);write(garb.name);
        gotoxy(20,wherey);write(garb.ID:0:0);
        gotoxy(29,wherey);writeln(garb.dtgreg.day,'/',garb.dtgreg.month,'/',garb.dtgreg.year);
        end;
        end;
        writeln('');writeln('');writeln('');  textcolor(white);
        Writeln('      Press any key to continue......');
        readkey;
        end;

  Procedure display;
  var
    view:integer;
      begin
      clrscr;
        textcolor(yellow);
     gotoxy(25,3);writeln('DISPLAY RECORDS MENU');
     gotoxy(5,4);writeln('-----------------------------------------------------------');
     textcolor(white);
        gotoxy(3,7);writeln('On which basis do you want to view the records?');
        Writeln('  1.Registered tenants');
        writeln('  2.Registered businesses');
        writeln('  3.Residents registered to sewer service');
        writeln('  4.Residents registered to gabage collection'); writeln;
        writeln('  5.Go back to main menu');
        writeln;
        write('Choose from above:');readln(view);
        if view>5 then repeat
        writeln('ERROR!Enter valid choice');
        readln(view);until view<5;
    case view of
          1:view_res;
          2:view_regbus;
          3:view_regsew;
          4:view_regarb;
          5:menu;
          end;
          end;


Procedure col_rent;   {procedure for collecting house rent payments}
   VAR
   rnt,m,s,k:integer;
   id:real;
   begin


       reset(payfile);
       reset(regisfile);

    clrscr;
   view_res;
   textcolor(11);
   writeln('Enter the ID number of the tenant');
   readln(ID);
   repeat
      k:=0; reset(regisfile);
      repeat
      read(regisfile,register);
      if register.resID=ID then
      k:=1;
      until eof(regisfile);
      if k=0 then
      Begin
      writeln('ERROR! INVALID ENTRY');
      writeln('Enter an ID number that exists');readln(ID);end;
      until k=1;
      clrscr;
    writeln('Enter the month for which payment is being made');
    writeln('      1.January                  7.July');
    writeln('      2.February                 8.August');
    writeln('      3.March                    9.September');
    writeln('      4.April                   10.October');
    writeln('      5.May                     11.November');
    writeln('      6.June                    12.December');

    readln(m);
    writeln('The tenant is ',register.fname);
    writeln('payment for ',month[m]);
    repeat
    read(payfile,pay);
    until pay.resID=id; s:=0;
    case m of
     1:If pay.m1='paid' then s:=1;
     2:If pay.m2='paid' then s:=1;
     3:If pay.m3='paid' then s:=1;
     4:If pay.m4='paid' then s:=1;
     5:If pay.m5='paid' then s:=1;
     6:If pay.m6='paid' then s:=1;
     7:If pay.m7='paid' then s:=1;
     8:If pay.m8='paid' then s:=1;
     9:If pay.m9='paid' then s:=1;
    10:If pay.m10='paid' then s:=1;
    11:If pay.m11='paid' then s:=1;
    12:If pay.m12='paid' then s:=1;
    end;
   If s=1 then
   writeln('The tenant has already paid for ',month[m])  else
   If s=0 then
  Begin
    seek(payfile,filepos(payfile)-1);
    If register.hsetype='Single room' then pay.rent:=500 else
    if register.hsetype='One bedroomed' then pay.rent:=1500 else
    if register.hsetype='Two bedroomed' then pay.rent:=2500 else
    if register.hsetype='Three bedroomed' then pay.rent:=3500;
    case m of
    1:pay.m1:='paid';
    2:pay.m2:='paid';
    3:pay.m3:='paid';
    4:pay.m4:='paid';
    5:pay.m5:='paid';
    6:pay.m6:='paid';
    7:pay.m7:='paid';
    8:pay.m8:='paid';
    9:pay.m9:='paid';
    10:pay.m10:='paid';
    11:pay.m11:='paid';
    12:pay.m12:='paid';
    end;
    dt;
    pay.dtpayr.day:=dd;
    pay.dtpayr.month:=mm;
    pay.dtpayr.year:=yyyy;
    pay.monthpaid:=month[m];
    write(payfile,pay);
          close(payfile);
          close(regisfile);
   writeln('The amount paid is Ksh.',pay.rent:0:2);
   writeln('Date of payment: ',dd,'/',mm,'/',yyyy);
   end;
   readln;
end;


Procedure col_sewer;     {procedure for collecting sewer payments}
var
m,s,k:integer;
id:real;
begin
dt;
    reset(payfile);
    reset(sewfile);
    clrscr;
    view_regsew;
textcolor(11);
write('Enter the ID number of the tenant:');
readln(id);
repeat
      k:=0; reset(sewfile);
      repeat
      read(sewfile,sewage);
      if sewage.ID=id then
      k:=1;
      until eof(sewfile);
      if k=0 then
      Begin
      writeln('ERROR! INVALID ENTRY');
      writeln('Enter an ID number that exists');readln(id);end;
      until k=1;
clrscr;
writeln('The tenant is: ',sewage.name);
If sewage.subtype='Annual subscription' then
begin
reset(payfile);
repeat
read(payfile,pay);
until pay.resID=id;
s:=0;
If pay.annual='paid' then s:=1;
If s=1 then
writeln('The tenant has already paid for ',yyyy)  else
If s=0 then
Begin
  pay.pfee:=3000;
  pay.annual:='paid';
    writeln('The amount paid is Ksh.',pay.pfee:0:2);
writeln('Date of payment: ',dd,'/',mm,'/',yyyy);
   end;
readkey;
end
else
if sewage.subtype='Monthly subscription' then
begin
writeln('Enter the month for which payment is being made');
writeln('      1.January                  7.July');
writeln('      2.February                 8.August');
writeln('      3.March                    9.September');
writeln('      4.April                   10.October');
writeln('      5.May                     11.November');
writeln('      6.June                    12.December');
readln(m);
reset(payfile);
repeat
read(payfile,pay);
until pay.resID=id; s:=0;
case m of
1:If pay.ms1='paid' then s:=1;
2:If pay.ms2='paid' then s:=1;
3:If pay.ms3='paid' then s:=1;
4:If pay.ms4='paid' then s:=1;
5:If pay.ms5='paid' then s:=1;
6:If pay.ms6='paid' then s:=1;
7:If pay.ms7='paid' then s:=1;
8:If pay.ms8='paid' then s:=1;
9:If pay.ms9='paid' then s:=1;
10:If pay.ms10='paid' then s:=1;
11:If pay.ms11='paid' then s:=1;
12:If pay.ms12='paid' then s:=1;
end;
If s=1 then
writeln('The tenant has already paid for ',month[m])  else
If s=0 then
Begin
  pay.pfee:=300;
 case m of
    1:pay.ms1:='paid';
    2:pay.ms2:='paid';
    3:pay.ms3:='paid';
    4:pay.ms4:='paid';
    5:pay.ms5:='paid';
    6:pay.ms6:='paid';
    7:pay.ms7:='paid';
    8:pay.ms8:='paid';
    9:pay.ms9:='paid';
    10:pay.ms10:='paid';
    11:pay.ms11:='paid';
    12:pay.ms12:='paid';
    end;
    writeln('The amount paid is Ksh.',pay.pfee:0:2);
writeln('Date of payment: ',dd,'/',mm,'/',yyyy);
   end;
     end;
        pay.cfee:=3500;
          dt;
          pay.dtpays.day:=dd;
          pay.dtpays.month:=mm;
          pay.dtpays.year:=yyyy;
          pay.monthpaid:=month[m];
          seek(payfile,filepos(payfile)-1);
          write(payfile,pay);
readln;
close(sewfile);
close(payfile);
end;

Procedure col_license;      {procedure for collecting business license payments}
var
s,m,k:integer;
lic:real;
begin
dt;


       reset(payfile);
       reset(busfile);
clrscr;
view_regbus;
textcolor(11);
writeln('Enter the license number of the business');
readln(lic);
repeat
      k:=0; reset(busfile);
      repeat
      read(busfile,business);
      if business.busID=lic then
      k:=1;
      until eof(busfile);
      if k=0 then
      Begin
      writeln('ERROR! INVALID ENTRY');
      writeln('Enter an ID number that exists');readln(lic);end;
      until k=1;
clrscr;
writeln('The business is: ',business.name);
repeat
read(payfile,pay);
until pay.busID=lic;
s:=0;
If pay.annualb='paid' then s:=1;
If s=1 then
writeln('The business has already paid for ',yyyy)  else
If s=0 then
Begin
  pay.pfee:=3000;
  pay.annualb:='paid';


    seek(payfile,filepos(payfile)-1);
If business.bstype='General shop' then pay.bsn:=3000 else
if business.bstype='Hardware shop' then pay.bsn:=4500 else
if business.bstype='Private institution' then pay.bsn:=10000 else
if business.bstype='Miscellaneous' then pay.bsn:=2500;
writeln('The amount paid is Ksh.',pay.bsn:0:2);
writeln('Date of payment: ',dd,'/',mm,'/',yyyy);
end;

          dt;
          pay.dtpayb.day:=dd;
          pay.dtpayb.month:=mm;
          pay.dtpayb.year:=yyyy;
          write(payfile,pay);
          close(payfile);
          close(busfile);

readln;
end;

Procedure col_markt;    {procedure for collecting market payments}
begin
  reset(mktfile);
  reset(payfile);
  while not eof(payfile)  do
    read(payfile,pay);
    clrscr;
    seek(payfile,filesize(payfile));
  writeln('How many vendors came to the market today?');
  readln(mkt.vnd);
  mkt.total:=50*mkt.vnd;
  pay.mkt:=mkt.total;
  writeln('The amount collected is Ksh.',mkt.total:4:2);
  readln;
  dt;
  pay.dtpaym.day:=dd;
  pay.dtpaym.month:=mm;
  pay.dtpaym.month:=yyyy;
  write(mktfile,mkt);
  write(payfile,pay);
  close(mktfile);
  close(payfile);
end;

Procedure col_garb;    {procedure for collecting garbage payments}
VAR
m,s,k:integer;
id:real;
begin

       reset(gabfile);
       reset(payfile);
clrscr;
view_regarb;
writeln('Enter the ID number of the tenant');
readln(id);
repeat
      k:=0; reset(gabfile);
      repeat
      read(gabfile,garb);
      if garb.ID=id then
      k:=1;
      until eof(gabfile);
      if k=0 then
      Begin
      writeln('ERROR! INVALID ENTRY');
      writeln('Enter an ID number that exists');readln(id);end;
      until k=1;
writeln('Enter the month for which payment is being made');
writeln('      1.January                  7.July');
writeln('      2.February                 8.August');
writeln('      3.March                    9.September');
writeln('      4.April                   10.October');
writeln('      5.May                     11.November');
writeln('      6.June                    12.December');

 readln(m);

writeln('The tenant is ',garb.name);
writeln('payment for ',month[m]);
repeat
read(payfile,pay);
until pay.resID=id; s:=0;
case m of
1:If pay.mg1='paid' then s:=1;
2:If pay.mg2='paid' then s:=1;
3:If pay.mg3='paid' then s:=1;
4:If pay.mg4='paid' then s:=1;
5:If pay.mg5='paid' then s:=1;
6:If pay.mg6='paid' then s:=1;
7:If pay.mg7='paid' then s:=1;
8:If pay.mg8='paid' then s:=1;
9:If pay.mg9='paid' then s:=1;
10:If pay.mg10='paid' then s:=1;
11:If pay.mg11='paid' then s:=1;
12:If pay.mg12='paid' then s:=1;
end;
If s=1 then
writeln('The tenant has already paid for ',month[m])  else
If s=0 then
Begin
    seek(payfile,filepos(payfile)-1);
    pay.gfee:=100;
 case m of
    1:pay.mg1:='paid';
    2:pay.mg2:='paid';
    3:pay.mg3:='paid';
    4:pay.mg4:='paid';
    5:pay.mg5:='paid';
    6:pay.mg6:='paid';
    7:pay.mg7:='paid';
    8:pay.mg8:='paid';
    9:pay.mg9:='paid';
    10:pay.mg10:='paid';
    11:pay.mg11:='paid';
    12:pay.mg12:='paid';
    end;
          pay.gregfee:=500;
          dt;
          pay.dtpayg.day:=dd;
          pay.dtpayg.month:=mm;
          pay.dtpayg.year:=yyyy;
          pay.monthpaid:=month[m];
          write(payfile,pay);
writeln('The amount paid is Ksh.',pay.gfee:4:2);
writeln('Date of payment: ',dd,'/',mm,'/',yyyy);
end;
readln;
close(payfile);
close(gabfile);
end;

Procedure col_park;    {procedure for collecting parking payments}
VAR
pak:integer;
begin
clrscr;
       reset(prkfile);
       reset(payfile);
    while not eof(payfile)  do
    read(payfile,pay);

    clrscr;
    seek(payfile,filesize(payfile));
writeln('Which type of vehicle is being parked ?');
writeln('       1:Car');
writeln('       2:Pickup');
writeln('       3:Lorry');
writeln('       4:Cart');
read(pak);
case pak of
          1:pay.park:=100;
          2:pay.park:=200;
          3:pay.park:=500;
          4:pay.park:=30;
          end;
writeln('The amount collected is Ksh.',pay.park:3:0);
readln;
readln;
              dt;
          pay.dtpayp.day:=dd;
          pay.dtpayp.month:=mm;
          pay.dtpayp.year:=yyyy;
          write(payfile,pay);
          close(prkfile);
          close(payfile);
end;

Procedure collection;
VAR
serv:integer;
begin
clrscr;
textcolor(yellow);
gotoxy(25,3);writeln('REVENUE COLLECTION MENU');
gotoxy(5,4);writeln('-----------------------------------------------------------');
textcolor(white);
writeln('For which services do you want to collect revenue ?');
    writeln('ษออออออออออออออออออออออป');
    writeln('บ 1ฏฏฏRent             บ');
    writeln('บ 2ฏฏฏSewer            บ');
    writeln('บ 3ฏฏฏGarbage          บ');
    writeln('บ 4ฏฏฏLicense          บ');
    writeln('บ 5ฏฏฏMarket           บ');
    writeln('บ 6ฏฏฏParking          บ');
    writeln('ศออออออออออออออออออออออผ'); writeln;
    writeln('7ฏฏฏGo back to main menu');
    read(serv);
    if serv>7 then
       repeat
       writeln('ERROR! PLEASE ENTER THE CORRECT TASK');
       readln(serv);
       until serv<=7;
   case serv of
          1:col_rent;
          2:col_sewer;
          3:col_garb;
          4:col_license;
          5:col_markt;
          6:col_park;
          7:menu;
          end;
end;

Procedure rep_daily;     {procedure for viewing daily reports}
label 11;
Var
rtsum,bussum,gbsum,mktsum,sewsum,paksum,total:real;
gregfee,cfee:real;
d,m,y:integer;
month,s:string;
begin
dt;
rtsum:=0; bussum:=0; gbsum:=0; mktsum:=0; sewsum:=0; paksum:=0;
total:=0;
clrscr;
  gotoxy(2,4);textcolor(white);
  write('Enter the day: ');
  readln(d);
  writeln('Enter the month : ');
      gotoxy(2,6);write('1.January ');            gotoxy(30,6);write('7. July ');
      gotoxy(2,8);write('2. February ');          gotoxy(30,8);write('8. August ');
      gotoxy(2,10);write('3. March ');             gotoxy(30,10);write('9. September ');
      gotoxy(2,12);write('4. April ');             gotoxy(30,12);write('10. October ');
      gotoxy(2,14);write('5. May');                gotoxy(30,14);write('11. November ');
      gotoxy(2,16);writeln('6. June ');           gotoxy(30,16);writeln('12. December ');
     writeln;
     writeln;
     writeln('Choice>>> ');
     readln(m);
 case m of
      1:month:='January';2:month:='February';3:month:='March';4:month:='April';5:month:='May';
      6:month:='June';7:month:='July';8:month:='August';9:month:='September';10:month:='October';
      11:month:='November';12:month:='December';
end;{end case}
     write('Enter the year: ');
     readln(y);


clrscr;
       textcolor(lightmagenta);
       gotoxy(30,1);write('DAILY REPORT');  textcolor(10);
       gotoxy(2,3);write('Payment made on:' ,d,'/',m,'/',y);
       textcolor(yellow);
       gotoxy(10,7);write('Rent ');
       gotoxy(22,7);write('Business ');
       gotoxy(34,7);write('Garbage ');
       gotoxy(46,7);write('Sewer');
       gotoxy(57,7);write('Market');
       gotoxy(68,7);writeln('Parking ');
       s:='paid';
       {$I-}   reset(payfile);{$I+}
     if ioresult <>0 then 11:rewrite(payfile);
    while not eof(payfile)  do
    begin
    {$I-} read(payfile,pay);{$I+}
       if ioresult <> 0 then goto 11;

   if (pay.dtpayr.month=m) and (pay.dtpayr.year=y)  and(pay.dtpayr.day=d) then
   begin
   if pay.m1=s then rtsum:=rtsum+pay.rent;
   if pay.m2=s then rtsum:=rtsum+pay.rent;
   if pay.m3=s then rtsum:=rtsum+pay.rent;
   if pay.m4=s then rtsum:=rtsum+pay.rent;
   if pay.m5=s then rtsum:=rtsum+pay.rent;
   if pay.m6=s then rtsum:=rtsum+pay.rent;
   if pay.m7=s then rtsum:=rtsum+pay.rent;
   if pay.m8=s then rtsum:=rtsum+pay.rent;
   if pay.m9=s then rtsum:=rtsum+pay.rent;
   if pay.m10=s then rtsum:=rtsum+pay.rent;
   if pay.m11=s then rtsum:=rtsum+pay.rent;
   if pay.m12=s then rtsum:=rtsum+pay.rent;
   end;
   if (pay.dtpayb.month=m) and (pay.dtpayb.year=y)  and(pay.dtpayb.day=d) then
   begin
   bussum:=bussum+pay.bsn;
   end;
   if (pay.dtpayg.month=m) and (pay.dtpayg.year=y)  and(pay.dtpayg.day=d) then
   begin
   if pay.mg1=s then gbsum:=gbsum+pay.gfee;
   if pay.mg2=s then gbsum:=gbsum+pay.gfee;
   if pay.mg3=s then gbsum:=gbsum+pay.gfee;
   if pay.mg4=s then gbsum:=gbsum+pay.gfee;
   if pay.mg5=s then gbsum:=gbsum+pay.gfee;
   if pay.mg6=s then gbsum:=gbsum+pay.gfee;
   if pay.mg7=s then gbsum:=gbsum+pay.gfee;
   if pay.mg8=s then gbsum:=gbsum+pay.gfee;
   if pay.mg9=s then gbsum:=gbsum+pay.gfee;
   if pay.mg10=s then gbsum:=gbsum+pay.gfee;
   if pay.mg11=s then gbsum:=gbsum+pay.gfee;
   if pay.mg12=s then gbsum:=gbsum+pay.gfee;
   gbsum:=gbsum+pay.gregfee;
   end;
    if (pay.dtpays.month=m) and (pay.dtpays.year=y)  and(pay.dtpays.day=d) then
   begin
   if pay.ms1=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   if pay.ms2=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   if pay.ms3=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   if pay.ms4=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   if pay.ms5=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   if pay.ms6=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   if pay.ms7=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   if pay.ms8=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   if pay.ms9=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   if pay.ms10=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   if pay.ms11=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   if pay.ms12=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   sewsum:=sewsum+pay.cfee;
   end;
   if (pay.dtpaym.month=m) and (pay.dtpaym.year=y)  and(pay.dtpaym.day=d) then
   begin
       mktsum:=mktsum+pay.mkt;
    end;
    if (pay.dtpayp.month=m) and (pay.dtpayp.year=y)  and(pay.dtpayp.day=d) then
   begin
       paksum:=paksum+pay.park;
     end;
end;
        total:=rtsum+bussum+sewsum+gbsum+mktsum+paksum ;
        textcolor(lightgreen);
        gotoxy(10,8);write('Ksh.',rtsum:2:0);
        gotoxy(22,8);write('Ksh.',bussum:2:0);
        gotoxy(34,8);write('Ksh.',gbsum:2:0);
        gotoxy(46,8);write('Ksh.',sewsum:2:0);
        gotoxy(57,8);write('Ksh.',mktsum:2:0);
        gotoxy(68,8);writeln('Ksh.',paksum:2:0);
     writeln;
     textcolor(white);
     gotoxy(25,15);writeln('TOTAL REVENUE COLLECTED. Ksh.',total:2:0);
     readln;
close(payfile);
 end;

Procedure rep_monthly; {procedure for viewing monthly reports}
label 12;
  var
   rtsum,gbsum,sewsum,total:real;
   greg,cfee:real;
   m,y:integer;
   s:string;
 begin
 rtsum:=0; gbsum:=0;
 sewsum:=0;total:=0;
  clrscr;
  gotoxy(2,3);textcolor(white);writeln('Enter the Month : ');

      gotoxy(2,5);write('1.January ');            gotoxy(30,5);write('7. July ');
      gotoxy(2,7);write('2. February ');          gotoxy(30,7);write('8. August ');
      gotoxy(2,9);write('3. March ');             gotoxy(30,9);write('9. September ');
      gotoxy(2,11);write('4. April ');             gotoxy(30,11);write('10. October ');
      gotoxy(2,13);write('5. May');                gotoxy(30,13);writeln('11. November ');
      gotoxy(2,15);writeln('6. June ');           gotoxy(30,15);write('12. December ');
     writeln; writeln;
     write('Choice>>> : ');
     readln(m);

  write('Enter the year:' );
     readln(y);
begin
clrscr;
textcolor(lightmagenta);
 gotoxy(30,1);write('MONTHLY REPORTS'); textcolor(10);
 gotoxy(2,3);write('Payments made in the Month of: ', month[m], '   Year:', y);
 textcolor(yellow);
  gotoxy(10,7);write('Rent');
  gotoxy(22,7);write('Garbage');
  gotoxy(34,7);write('Sewer');
  s:='paid';
  {$I-}   reset(payfile);{$I+}
     if ioresult <>0 then 12:rewrite(payfile);
    while not eof(payfile)  do
    begin
    {$I-} read(payfile,pay);{$I+}
       if ioresult <> 0 then goto 12;

    if (pay.monthpaid=month[m]) and (pay.dtpayr.year=y) then
     begin
     case m of
   1:if pay.m1=s then rtsum:=rtsum+pay.rent;
   2: if pay.m2=s then rtsum:=rtsum+pay.rent;
   3: if pay.m3=s then rtsum:=rtsum+pay.rent;
   4: if pay.m4=s then rtsum:=rtsum+pay.rent;
   5: if pay.m5=s then rtsum:=rtsum+pay.rent;
   6: if pay.m6=s then rtsum:=rtsum+pay.rent;
   7: if pay.m7=s then rtsum:=rtsum+pay.rent;
   8: if pay.m8=s then rtsum:=rtsum+pay.rent;
   9: if pay.m9=s then rtsum:=rtsum+pay.rent;
   10:if pay.m10=s then rtsum:=rtsum+pay.rent;
   11:if pay.m11=s then rtsum:=rtsum+pay.rent;
   12:if pay.m12=s then rtsum:=rtsum+pay.rent;
   end; end;
    if (pay.monthpaid=month[m]) and (pay.dtpayg.year=y) then
     begin
    case m of
   1:if pay.mg1=s then gbsum:=gbsum+pay.gfee;
   2:if pay.mg2=s then gbsum:=gbsum+pay.gfee;
   3:if pay.mg3=s then gbsum:=gbsum+pay.gfee;
   4:if pay.mg4=s then gbsum:=gbsum+pay.gfee;
   5:if pay.mg5=s then gbsum:=gbsum+pay.gfee;
   6:if pay.mg6=s then gbsum:=gbsum+pay.gfee;
   7:if pay.mg7=s then gbsum:=gbsum+pay.gfee;
   8:if pay.mg8=s then gbsum:=gbsum+pay.gfee;
   9:if pay.mg9=s then gbsum:=gbsum+pay.gfee;
   10:if pay.mg10=s then gbsum:=gbsum+pay.gfee;
   11:if pay.mg11=s then gbsum:=gbsum+pay.gfee;
   12:if pay.mg12=s then gbsum:=gbsum+pay.gfee;
   end;
   end;
   if (pay.monthpaid=month[m]) and (pay.dtpays.year=y) then
     begin
   case m of
   1:if pay.ms1=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   2:if pay.ms2=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   3:if pay.ms3=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   4:if pay.ms4=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   5:if pay.ms5=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   6:if pay.ms6=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   7:if pay.ms7=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   8:if pay.ms8=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   9:if pay.ms9=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   10:if pay.ms10=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   11:if pay.ms11=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   12:if pay.ms12=s then sewsum:=sewsum+pay.pfee+pay.cfee;
   end;

   end;end;


        total:=rtsum+sewsum+gbsum;
        textcolor(lightgreen);
        gotoxy(10,8);write('Ksh.',rtsum:2:0);
        gotoxy(22,8);write('Ksh.',gbsum:2:0);
        gotoxy(34,8);write('Ksh.',sewsum:2:0);
     writeln;
     textcolor(white);
     gotoxy(20,15);writeln('TOTAL REVENUE COLLECTED: Ksh.',total:0:0);
     readln;
 close(payfile);
 end;
 end;

Procedure rep_annual; {procedure for viewing annual reports}
label 13;
  var
   rtsum,bussum,mktsum,paksum,gbsum,sewsum,total:real;
   greg,cfee:real;
   m,y:integer;
   s:string;
 begin
 rtsum:=0; bussum:=0;mktsum:=0; paksum:=0; gbsum:=0;
 sewsum:=0;total:=0;
  clrscr;
  writeln('Enter the year:' );
     textcolor(white);readln(y);
begin
clrscr;
textcolor(lightmagenta);
  gotoxy(30,1);write('ANNUAL REPORT');   textcolor(10);
  gotoxy(2,3);write('Payments made in the Year:', y);  textcolor(white);
  gotoxy(2,5);write('SERVICES');
  gotoxy(25,5);write('AMOUNT COLLECTED');
  gotoxy(2,6);write('Rent');
  gotoxy(2,7);write('Business');
  gotoxy(2,8);write('Garbage');
  gotoxy(2,9);write('Sewer');
  gotoxy(2,10);write('Market');
  gotoxy(2,11);write('Parking');
textcolor(yellow);
{$I-}   reset(payfile);{$I+}
        begin
        s:='paid';
     if ioresult <>0 then 13:rewrite(payfile);
    while not eof(payfile)  do
    begin
    {$I-} read(payfile,pay);{$I+}
       if ioresult <> 0 then goto 13;

   if pay.m1=s then rtsum:=rtsum+pay.rent;
   if pay.m2=s then rtsum:=rtsum+pay.rent;
   if pay.m3=s then rtsum:=rtsum+pay.rent;
   if pay.m4=s then rtsum:=rtsum+pay.rent;
   if pay.m5=s then rtsum:=rtsum+pay.rent;
   if pay.m6=s then rtsum:=rtsum+pay.rent;
   if pay.m7=s then rtsum:=rtsum+pay.rent;
   if pay.m8=s then rtsum:=rtsum+pay.rent;
   if pay.m9=s then rtsum:=rtsum+pay.rent;
   if pay.m10=s then rtsum:=rtsum+pay.rent;
   if pay.m11=s then rtsum:=rtsum+pay.rent;
   if pay.m12=s then rtsum:=rtsum+pay.rent;
     bussum:=bussum+pay.bsn;
   if pay.mg1=s then gbsum:=gbsum+pay.gfee;
   if pay.mg2=s then gbsum:=gbsum+pay.gfee;
   if pay.mg3=s then gbsum:=gbsum+pay.gfee;
   if pay.mg4=s then gbsum:=gbsum+pay.gfee;
   if pay.mg5=s then gbsum:=gbsum+pay.gfee;
   if pay.mg6=s then gbsum:=gbsum+pay.gfee;
   if pay.mg7=s then gbsum:=gbsum+pay.gfee;
   if pay.mg8=s then gbsum:=gbsum+pay.gfee;
   if pay.mg9=s then gbsum:=gbsum+pay.gfee;
   if pay.mg10=s then gbsum:=gbsum+pay.gfee;
   if pay.mg11=s then gbsum:=gbsum+pay.gfee;
   if pay.mg12=s then gbsum:=gbsum+pay.gfee;
   gbsum:=gbsum+pay.gregfee;
   if pay.ms1=s then sewsum:=sewsum+pay.pfee;
   if pay.ms2=s then sewsum:=sewsum+pay.pfee;
   if pay.ms3=s then sewsum:=sewsum+pay.pfee;
   if pay.ms4=s then sewsum:=sewsum+pay.pfee;
   if pay.ms5=s then sewsum:=sewsum+pay.pfee;
   if pay.ms6=s then sewsum:=sewsum+pay.pfee;
   if pay.ms7=s then sewsum:=sewsum+pay.pfee;
   if pay.ms8=s then sewsum:=sewsum+pay.pfee;
   if pay.ms9=s then sewsum:=sewsum+pay.pfee;
   if pay.ms10=s then sewsum:=sewsum+pay.pfee;
   if pay.ms11=s then sewsum:=sewsum+pay.pfee;
   if pay.ms12=s then sewsum:=sewsum+pay.pfee;
   sewsum:=sewsum+pay.cfee;
       mktsum:=mktsum+pay.mkt;
       paksum:=paksum+pay.park;
   end;
end;

        total:=rtsum+bussum+sewsum+gbsum+mktsum+paksum;
        gotoxy(25,6);write('Ksh.',rtsum:2:0);
        gotoxy(25,7);write('Ksh.',bussum:2:0);
        gotoxy(25,8);write('Ksh.',gbsum:2:0);
        gotoxy(25,9);write('Ksh.',sewsum:2:0);
        gotoxy(25,10);write('Ksh.',mktsum:2:0);
        gotoxy(25,11);writeln('Ksh.',paksum:2:0);
        writeln;
  gotoxy(25,15);writeln('TOTAL REVENUE COLLECTED. Ksh.',total:0:0);
  readln;
  close(payfile);
 end;
 end;

Procedure reports;
var
r:integer;
begin
  clrscr;
  textcolor(yellow);
 gotoxy(29,3);writeln('REPORTS MENU');
 gotoxy(5,4);writeln('------------------------------------------------------------------');
  writeln;
  writeln;
  textcolor(white);
 gotoxy(5,7);writeln('  Which reports do you want to view? ');
  writeln('      1.Daily reports     ');
  writeln('      2.Monthly reports   ');
  writeln('      3.Annual reports     ');    writeln;
  writeln('      4.Go back to main menu');
  readln (r);
  if r>4 then
       repeat
       writeln('ERROR! PLEASE ENTER THE CORRECT TASK');
       readln(r);
       until r<=4;
    case r of
    1:rep_daily;
    2:rep_monthly;
    3:rep_annual;
    4:menu;
    end;
end;

Procedure edit_ten;  {procedure for editing tenant details}
 var
 hs,ndai,counter:integer;
 ind:real;
 begin
       reset(regisfile);
      clrscr;
      view_res;
      Writeln('Enter the ID no. of the business you want to edit');
      write('ID NO.:');readln(ind);
      repeat
      counter:=0; reset(regisfile);
      repeat
      read(regisfile,register);
      if register.resID=ind then
      counter:=1;
      until eof(regisfile);
      if counter=0 then
      Begin
      writeln('ERROR! INVALID ENTRY');
      writeln('Enter an ID number that exists');readln(ind);end;
      until counter=1;
      reset(regisfile);
      repeat
      read(regisfile,register);
      counter:=counter+1;
      until register.resID=ind;


      begin

      seek(regisfile,filepos(regisfile)-1);
      writeln('       ****Re-enter the following tenant details to edit****');
      clrscr;
         writeln('Enter the name of the resident');
    readln(register.fname);
    writeln('Enter the telephone number of the resident');
    readln(register.tel);
    writeln('Enter the type of house');
    writeln('           HOUSES:                      ');
    writeln('ษออออออออออออออออออออออออออออออออออออออป');
    writeln('บ    House Type            Rent        บ');
    writeln('บ 1ฏฏฏฏSingle room      Ksh.500.00     บ');
    writeln('บ 2ฏฏฏฏOne bedroomed    Ksh.1,500.00   บ');
    writeln('บ 3ฏฏฏฏTwo bedroomed    Ksh.2,500.00   บ');
    writeln('บ 4ฏฏฏฏThree bedroomed  Ksh.3,500.00   บ');
    writeln('ศออออออออออออออออออออออออออออออออออออออผ');
    write('House type:');read(hs);
    case hs of
          1:register.hsetype:='Single room';
          2:register.hsetype:='One bedroomed';
          3:register.hsetype:='Two bedroomed';
          4:register.hsetype:='Three bedroomed';
          end;

      write(regisfile,register);
      close(regisfile);
      end
      end;

Procedure edit_bus;    {procedure for editing business details}
var
 bs,gari,counter:integer;
 lic:real;
 begin


      reset(busfile);
      clrscr;
      view_regbus;

      Writeln('Enter the license no. of the business you want to edit');
      write('LIC NO.:');readln(lic);
      repeat
      counter:=0; reset(busfile);
      repeat
      read(busfile,business);
      if business.busID=lic then
      counter:=1;
      until eof(busfile);
      if counter=0 then
      Begin
      writeln('ERROR! INVALID ENTRY');
      writeln('Enter a license number that exists');readln(lic);end;
      until counter=1;
      reset(busfile);
      repeat
      read(busfile,business);
      counter:=counter+1;
      until business.busID=lic;


      begin
      seek(busfile,filepos(busfile)-1);
      writeln('       ****Re-enter the following tenant details to edit****');
      clrscr;
       writeln('Enter the name of the business');
    readln(business.name);
    writeln('Enter the license number of the business');
    readln(business.busID);
    writeln('Enter the type of business preffered');
     writeln('       BUSINESSES:                     ');
    writeln('ษออออออออออออออออออออออออออออออออออออออป');
    writeln('บ  Business type       License fee     บ');
    writeln('บ 1:General shops         Ksh.500.00   บ');
    writeln('บ 2:Hardware shops        Ksh.1,500.00 บ');
    writeln('บ 3:Private institutions  Ksh.2,500.00 บ');
    writeln('บ 4:Miscellaneous         Ksh.3,500.00 บ');
    writeln('ศออออออออออออออออออออออออออออออออออออออผ');
    write('Business type:');read(bs);
     case bs of
          1:business.bstype:='General shops';
          2:business.bstype:='Hardware shops';
          3:business.bstype:='Private institutions';
          4:business.bstype:='Miscellaneous';
          end;

    writeln('Enter the telephone no. of the business');
    readln(business.tel);
      write(busfile,business);
      close(busfile);
      end;
      end;

Procedure edit;
var
red:integer;
begin
     clrscr;
     textcolor(yellow);
     gotoxy(29,3);writeln('EDITING MENU');
     gotoxy(5,4);writeln('------------------------------------------------------------------');
     writeln;
     writeln;
     textcolor(white);
     gotoxy(4,7);writeln('Choose the criteria you want to edit');
     writeln('        1.Tenant records');
     writeln('        2.Business records'); writeln;
     writeln('        3.Go back to main menu');
     read(red);
     if red>3 then
       repeat
       writeln('ERROR! PLEASE ENTER THE CORRECT TASK');
       readln(red);
       until red<=3;
     case red of
     1:edit_ten;
     2:edit_bus;
     3:menu;
     end;
 end;

Procedure del_ten;    {procedure for deleting tenant records}
 var
  n,r:integer;
  id:real;
begin

      clrscr;
     view_res;
      Writeln('Enter the ID number of the tenant you want to delete ');
      write('ID NO.:');readln(id);
      repeat
      n:=0; reset(regisfile);
      repeat
      read(regisfile,register);
      if register.resID=id then
      n:=1;
      until eof(regisfile);
      if n=0 then
      Begin
      writeln('ERROR! INVALID ENTRY');
      writeln('Enter an ID number that exists');readln(id);end;
      until n=1;
      reset(regisfile);
      repeat
      read(regisfile,register);
      n:=n+1;
      until register.resID=id;

      for r:=n to filesize(regisfile)-1 do
      begin
      seek(regisfile,r);
      read(regisfile,register);
      seek(regisfile,n-1);
      write(regisfile,register);
      end;
      seek(regisfile,filesize(regisfile)-1);
      truncate(regisfile);
      writeln('The resident records have been deleted');
      readln;
      end;


Procedure del_bus;     {procedure for deleting tenant records}
var
  n,r:integer;
  id:real;
begin


     clrscr;
     view_regbus;

      Writeln('Enter the license number of the business you want to delete ');
      write('LICENSE NO.:');readln(id);
       repeat
      n:=0; reset(busfile);
      repeat
      read(busfile,business);
      if business.busID=id then
      n:=1;
      until eof(busfile);
      if n=0 then
      Begin
      writeln('ERROR! INVALID ENTRY');
      writeln('Enter a license number that exists');readln(id);end;
      until n=1;
      reset(busfile);
      repeat
      read(busfile,business);
      n:=n+1;
      until business.busID=id;

      for r:=n to filesize(busfile)-1 do
      begin
      seek(busfile,r);
      read(busfile,business);
      seek(busfile,n-1);
      write(busfile,business);
      end;
      seek(busfile,filesize(busfile)-1);
      truncate(busfile);
      writeln('The business records have been deleted');
      end;
Procedure delete;
VAR
rec:integer;
begin
clrscr;
     textcolor(yellow);
     gotoxy(29,3);writeln('DELETE RECORDS MENU');
     gotoxy(5,4);writeln('------------------------------------------------------------------');
     writeln;
     writeln;
     textcolor(white);
     gotoxy(4,7);writeln('Which records do you want to delete ?');
     writeln('        1.Tenant records');
     writeln('        2.Business records');  writeln;
     writeln('        3.Go back to main menu');
     read(rec);
     if rec>3 then
       repeat
       writeln('ERROR! PLEASE ENTER THE CORRECT TASK');
       readln(rec);
       until rec<=3;
     case rec of
     1:del_ten;
     2:del_bus;
     3:menu;
     end;
 end;
Procedure exit;     {procedure for exiting program}
var
  Gd, Gm, I, Width: Integer;
begin
  Gd := Detect; InitGraph(Gd, Gm, '');
  if GraphResult <> grOk then Halt(1);
    setbkcolor(blue);
    setfillstyle(10,blue);
    Bar(0, 0, 650, 600);
    setcolor(yellow);
    settextstyle(7,0,4);
    outtextxy(150,200,'HAVE A NICE DAY');
  ReadLn;
  CloseGraph;
end;


Procedure assigning;       {procedure for assigning files}
begin
assign(busfile,'bus.dat');
assign(regisfile,'regis.dat');
assign(payfile,'pay.dat');
assign(sewfile,'sew.dat');
assign(gabfile,'gab.dat');
assign(mktfile,'mkt.dat');
assign(prkfile,'prk.dat');
end;
BEGIN
begin
entry
end;

clrscr;
assigning;
menu;
repeat
case tsk of
1:Begin
  registration;
  menu;
  end;
2:Begin
  collection;
  menu;
  end;
3:Begin
  display;
  menu;
  end;
4:Begin
  reports;
  menu;
  end;
5:Begin
  edit;
  menu;
  end;
6:Begin
  delete;
  menu;
  end;
7:Begin
  exit;
  end;
  end;
until tsk=7;

END.