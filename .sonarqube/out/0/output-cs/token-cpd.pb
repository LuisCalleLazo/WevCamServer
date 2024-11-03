–
YC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Services\UserService.cs
	namespace 	
WebCamServer
 
. 
Services 
{ 
public		 
class			 
UserService		 
:		 
IUserService		 )
{

 
}(( 
})) ﬂ
eC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Services\Interfaces\IUserService.cs
	namespace 	
WebCamServer
 
. 
Services 
.  

Interfaces  *
{ 
public 
	interface	 
IUserService 
{ 
} 
} Ô
iC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Services\Interfaces\IDetectIAService.cs
	namespace 	
WebCamServer
 
. 
Services 
.  

Interfaces  *
{ 
public 
	interface	 
IDetectIAService #
{ 
bool 
IsAuthorized	 
( 
string 
capture $
)$ %
;% &
bool 
HasHumanoidShape	 
( 
string  
capture! (
)( )
;) *
} 
} Ú
iC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Services\Interfaces\IControlsService.cs
	namespace 	
WebCamServer
 
. 
Services 
.  

Interfaces  *
{ 
public 
	interface	 
IControlsService #
{ 
Task 
ControlsOfCamera	 
( 
	WebSocket #
	webSocket$ -
)- .
;. /
} 
}		 ÷
gC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Services\Interfaces\ICameraService.cs
	namespace 	
WebCamServer
 
. 
Services 
.  

Interfaces  *
{ 
public 
	interface	 
ICameraService !
{ 
Task 
Esp32CamConnection	 
( 
	WebSocket %
	webSocket& /
)/ 0
;0 1
Task 
WatchCamera	 
( 
	WebSocket 
	webSocket (
)( )
;) *
Task		 
CloseAllConnections			 
(		 
)		 
;		 
}

 
} ﬂ
eC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Services\Interfaces\IAuthService.cs
	namespace 	
WebCamServer
 
. 
Services 
.  

Interfaces  *
{ 
public 
	interface	 
IAuthService 
{ 
} 
} ß4
]C:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Services\DetectIAService.cs
	namespace 	
WebCamServer
 
. 
Services 
{ 
public 
class	 
DetectIAService 
:  
IDetectIAService! 1
{		 
private

 
readonly

 
IUserRepository

 $
	_userRepo

% .
;

. /
public 

DetectIAService 
( 
IUserRepository *
userRepo+ 3
)3 4
{ 
	_userRepo 
= 
userRepo 
; 
} 
public 

bool 
IsAuthorized 
( 
string #
capture$ +
)+ ,
{ 

Dictionary 
< 
string 
, 
Mat 
> 
authorizedPeople .
=/ 0 
LoadAuthorizedPeople1 E
(E F
)F G
;G H
Mat 	
imagen
 
= 
new 
Mat 
( 
capture "
)" #
;# $
Mat 	
gris
 
= 
new 
Mat 
( 
) 
; 
Cv2 	
.	 

CvtColor
 
( 
imagen 
, 
gris 
,   
ColorConversionCodes! 5
.5 6
BGR2GRAY6 >
)> ?
;? @
CascadeClassifier 
clasificador $
=% &
new' *
CascadeClassifier+ <
(< =
$str= j
)j k
;k l
Rect 

[
 
] 
rostros 
= 
clasificador #
.# $
DetectMultiScale$ 4
(4 5
gris5 9
)9 :
;: ;
foreach 
( 
Rect 
rostro 
in 
rostros %
)% &
{ 
Mat   
rostroImagen   
=   
new   
Mat   "
(  " #
gris  # '
,  ' (
rostro  ) /
)  / 0
;  0 1
foreach!! 
(!! 
KeyValuePair!! 
<!! 
string!! $
,!!$ %
Mat!!& )
>!!) *
authorizedPerson!!+ ;
in!!< >
authorizedPeople!!? O
)!!O P
{"" 	
Mat##
 
authorizedFace## 
=## 
authorizedPerson## /
.##/ 0
Value##0 5
;##5 6
double$$
 

similarity$$ 
=$$ #
CalculateFaceSimilarity$$ 5
($$5 6
rostroImagen$$6 B
,$$B C
authorizedFace$$D R
)$$R S
;$$S T
if%%
 
(%% 

similarity%% 
>%% 
$num%% 
)%% 
{&&
 
return'' 
true'' 
;'' 
}((
 
})) 	
}** 
return,, 
false,, 
;,, 
}-- 
private// 

Dictionary// 
<// 
string// 
,// 
Mat// "
>//" # 
LoadAuthorizedPeople//$ 8
(//8 9
)//9 :
{00 
return11 
new11 

Dictionary11 
<11 
string11 "
,11" #
Mat11$ '
>11' (
(11( )
)11) *
;11* +
}22 
private44 
double44 #
CalculateFaceSimilarity44 *
(44* +
Mat44+ .
face144/ 4
,444 5
Mat446 9
face244: ?
)44? @
{55 
return66 
$num66 
;66 
}77 
public99 

bool99 
HasHumanoidShape99  
(99  !
string99! '
capture99( /
)99/ 0
{:: 
Mat<< 	
imagen<<
 
=<< 
new<< 
Mat<< 
(<< 
capture<< "
)<<" #
;<<# $
Net?? 	
net??
 
=?? 
CvDnn?? 
.?? 
ReadNetFromDarknet?? (
(??( )
$str??) =
,??= >
$str??? W
)??W X
;??X Y
Mat@@ 	
blob@@
 
=@@ 
CvDnn@@ 
.@@ 
BlobFromImage@@ $
(@@$ %
imagen@@% +
,@@+ ,
$num@@- .
/@@/ 0
$num@@1 6
,@@6 7
new@@8 ;
Size@@< @
(@@@ A
$num@@A D
,@@D E
$num@@F I
)@@I J
,@@J K
new@@L O
Scalar@@P V
(@@V W
$num@@W X
,@@X Y
$num@@Z [
,@@[ \
$num@@] ^
)@@^ _
,@@_ `
true@@a e
,@@e f
false@@g l
)@@l m
;@@m n
netAA 	
.AA	 

SetInputAA
 
(AA 
blobAA 
)AA 
;AA 
MatBB 	
	detectionBB
 
=BB 
netBB 
.BB 
ForwardBB !
(BB! "
)BB" #
;BB# $
forEE 	
(EE
 
intEE 
iEE 
=EE 
$numEE 
;EE 
iEE 
<EE 
	detectionEE #
.EE# $
SizeEE$ (
(EE( )
$numEE) *
)EE* +
;EE+ ,
iEE- .
++EE. 0
)EE0 1
{FF 
floatGG 

confidenceGG 
=GG 
	detectionGG $
.GG$ %
GetGG% (
<GG( )
floatGG) .
>GG. /
(GG/ 0
$numGG0 1
,GG1 2
$numGG3 4
,GG4 5
iGG6 7
,GG7 8
$numGG9 :
)GG: ;
;GG; <
ifHH 

(HH 

confidenceHH 
>HH 
$numHH 
)HH 
{II 	
intJJ
 
classIdJJ 
=JJ 
(JJ 
intJJ 
)JJ 
	detectionJJ &
.JJ& '
GetJJ' *
<JJ* +
floatJJ+ 0
>JJ0 1
(JJ1 2
$numJJ2 3
,JJ3 4
$numJJ5 6
,JJ6 7
iJJ8 9
,JJ9 :
$numJJ; <
)JJ< =
;JJ= >
ifKK
 
(KK 
classIdKK 
==KK 
$numKK 
)KK 
{LL
 
returnMM 
trueMM 
;MM 
}NN
 
}OO 	
}PP 
returnRR 
falseRR 
;RR 
}SS 
}TT 
}UU Éb
[C:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Services\CameraService.cs
	namespace 	
WebCamServer
 
. 
Services 
{ 
public 
class	 
CameraService 
: 
ICameraService -
{		 
private 
ConcurrentBag 
< 
	WebSocket #
># $
_viewers% -
=. /
new0 3
ConcurrentBag4 A
<A B
	WebSocketB K
>K L
(L M
)M N
;N O
public 

CameraService 
( 
) 
{ 
} 
private 
async 
Task 
SendImageToViewers )
() *
byte* .
[. /
]/ 0

imageBytes1 ;
); <
{ 
Console 
. 
	WriteLine 
( 
$str (
+) *
_viewers+ 3
.3 4
Count4 9
)9 :
;: ;
List 

<
 
	WebSocket 
> 
closedSockets #
=$ %
new& )
List* .
<. /
	WebSocket/ 8
>8 9
(9 :
): ;
;; <
foreach 
( 
var 
viewer 
in 
_viewers %
)% &
{ 
if 

( 
viewer 
. 
State 
== 
WebSocketState *
.* +
Open+ /
)/ 0
{ 	
try
 
{
 
await 
viewer 
. 
	SendAsync "
(" #
new# &
ArraySegment' 3
<3 4
byte4 8
>8 9
(9 :

imageBytes: D
)D E
,E F 
WebSocketMessageTypeG [
.[ \
Binary\ b
,b c
trued h
,h i
CancellationTokenj {
.{ |
None	| Ä
)
Ä Å
;
Å Ç
Console 
. 
	WriteLine 
( 
$str 5
)5 6
;6 7
}
 
catch  
 
(   
	Exception   
ex   
)   
{!!
 
Console"" 
."" 
	WriteLine"" 
("" 
$"""  
$str""  9
{""9 :
ex"": <
.""< =
Message""= D
}""D E
"""E F
)""F G
;""G H
closedSockets## 
.## 
Add## 
(## 
viewer## $
)##$ %
;##% &
}$$
 
}%% 	
else&& 
{'' 	
closedSockets((
 
.(( 
Add(( 
((( 
viewer(( "
)((" #
;((# $
})) 	
}** 
foreach,, 
(,, 
var,, 
socket,, 
in,, 
closedSockets,, *
),,* +
{-- 
_viewers.. 
=.. 
new.. 
ConcurrentBag.. $
<..$ %
	WebSocket..% .
>... /
(../ 0
_viewers..0 8
...8 9
Except..9 ?
(..? @
new..@ C
[..C D
]..D E
{..F G
socket..H N
}..O P
)..P Q
)..Q R
;..R S
Console// 
.// 
	WriteLine// 
(// 
$str// <
)//< =
;//= >
}00 
Console22 
.22 
	WriteLine22 
(22 
$str22 6
+227 8
_viewers229 A
.22A B
Count22B G
(22G H
)22H I
)22I J
;22J K
}33 
private55 
bool55 
IsValidImage55 
(55 
byte55 "
[55" #
]55# $

imageBytes55% /
)55/ 0
{66 
try77 	
{88 
using99 
(99 
MemoryStream99 
ms99 
=99  
new99! $
MemoryStream99% 1
(991 2

imageBytes992 <
)99< =
)99= >
{:: 	
using;;
 
(;; 
Image;; 
image;; 
=;; 
Image;; $
.;;$ %
Load;;% )
(;;) *
ms;;* ,
);;, -
);;- .
{<<
 
return== 
true== 
;== 
}>>
 
}?? 	
}@@ 
catchAA 
(AA 
	ExceptionAA 
)AA 
{BB 
returnCC 
falseCC 
;CC 
}DD 
}EE 
publicGG 

asyncGG 
TaskGG 
Esp32CamConnectionGG (
(GG( )
	WebSocketGG) 2
	webSocketGG3 <
)GG< =
{HH 
varII 	
bufferII
 
=II 
newII 
byteII 
[II 
$numII  
*II! "
$numII# $
]II$ %
;II% &
usingJJ 
(JJ 
varJJ 
msJJ 
=JJ 
newJJ 
MemoryStreamJJ &
(JJ& '
)JJ' (
)JJ( )
{KK 
whileLL 
(LL 
	webSocketLL 
.LL 
StateLL 
==LL !
WebSocketStateLL" 0
.LL0 1
OpenLL1 5
)LL5 6
{MM 	"
WebSocketReceiveResultNN
  
resultNN! '
=NN( )
awaitNN* /
	webSocketNN0 9
.NN9 :
ReceiveAsyncNN: F
(NNF G
newNNG J
ArraySegmentNNK W
<NNW X
byteNNX \
>NN\ ]
(NN] ^
bufferNN^ d
)NNd e
,NNe f
CancellationTokenNNg x
.NNx y
NoneNNy }
)NN} ~
;NN~ 
ifPP
 
(PP 
resultPP 
.PP 
MessageTypePP  
==PP! # 
WebSocketMessageTypePP$ 8
.PP8 9
ClosePP9 >
)PP> ?
{QQ
 
breakRR 
;RR 
}SS
 
elseTT
 
ifTT 
(TT 
resultTT 
.TT 
MessageTypeTT %
==TT& ( 
WebSocketMessageTypeTT) =
.TT= >
BinaryTT> D
)TTD E
{UU
 
msVV 
.VV 
WriteVV 
(VV 
bufferVV 
,VV 
$numVV 
,VV 
resultVV  &
.VV& '
CountVV' ,
)VV, -
;VV- .
ifWW 
(WW 
resultWW 
.WW 
EndOfMessageWW #
)WW# $
{XX 
byteYY 
[YY 
]YY 

imageBytesYY 
=YY  !
msYY" $
.YY$ %
ToArrayYY% ,
(YY, -
)YY- .
;YY. /
msZZ 
.ZZ 
	SetLengthZZ 
(ZZ 
$numZZ 
)ZZ 
;ZZ 
if\\ 
(\\ 
IsValidImage\\ 
(\\ 

imageBytes\\ )
)\\) *
)\\* +
{]] 
Console^^ 
.^^ 
	WriteLine^^ !
(^^! "
$str^^" /
)^^/ 0
;^^0 1
stringaa 
directoryPathaa $
=aa% &
	Directoryaa' 0
.aa0 1
GetCurrentDirectoryaa1 D
(aaD E
)aaE F
+aaG H
$straaI Y
+aaZ [
DateTimeaa\ d
.aad e
Nowaae h
.aah i
ToStringaai q
(aaq r
$straar ~
)aa~ 
;	aa Ä
ifbb 
(bb 
!bb 
	Directorybb 
.bb 
Existsbb %
(bb% &
directoryPathbb& 3
)bb3 4
)bb4 5
	Directorybb6 ?
.bb? @
CreateDirectorybb@ O
(bbO P
directoryPathbbP ]
)bb] ^
;bb^ _
stringdd 
dateNamedd 
=dd  !
DateTimedd" *
.dd* +
Nowdd+ .
.dd. /
ToStringdd/ 7
(dd7 8
$strdd8 M
)ddM N
;ddN O
stringee 
fileNameee 
=ee  !
directoryPathee" /
+ee0 1
$"ee2 4
$stree4 ;
{ee; <
dateNameee< D
}eeD E
$streeE I
"eeI J
;eeJ K
usinggg 
(gg 
Imagegg 
imagegg "
=gg# $
Imagegg% *
.gg* +
Loadgg+ /
(gg/ 0
newgg0 3
MemoryStreamgg4 @
(gg@ A

imageBytesggA K
)ggK L
)ggL M
)ggM N
{hh 
imageii 
.ii 

SaveAsJpegii "
(ii" #
fileNameii# +
)ii+ ,
;ii, -
Consolejj 
.jj 
	WriteLinejj #
(jj# $
$strjj$ 1
)jj1 2
;jj2 3
}kk 
}ll 
}mm 
}nn
 
}oo 	
}pp 
}qq 
publicuu 

asyncuu 
Taskuu 
WatchCamerauu !
(uu! "
	WebSocketuu" +
	webSocketuu, 5
)uu5 6
{vv 
stringxx 
videoFolderPathxx 
=xx 
	Directoryxx (
.xx( )
GetCurrentDirectoryxx) <
(xx< =
)xx= >
+xx? @
$strxxA J
;xxJ K
varyy 	
videoFoldersyy
 
=yy 
	Directoryyy "
.yy" #
GetDirectoriesyy# 1
(yy1 2
videoFolderPathyy2 A
)yyA B
;yyB C
foreach{{ 
({{ 
var{{ 
folder{{ 
in{{ 
videoFolders{{ )
){{) *
{|| 
var}}
 
images}} 
=}} 
	Directory}}  
.}}  !
GetFiles}}! )
(}}) *
folder}}* 0
,}}0 1
$str}}2 9
)}}9 :
.}}: ;
OrderBy}}; B
(}}B C
f}}C D
=>}}E G
f}}H I
)}}I J
.}}J K
ToList}}K Q
(}}Q R
)}}R S
;}}S T
foreach~~
 
(~~ 
var~~ 
	imagePath~~  
in~~! #
images~~$ *
)~~* +
{
 
if
ÅÅ 
(
ÅÅ 
	webSocket
ÅÅ 
.
ÅÅ 
State
ÅÅ !
!=
ÅÅ" $
WebSocketState
ÅÅ% 3
.
ÅÅ3 4
Open
ÅÅ4 8
)
ÅÅ8 9
break
ÇÇ 
;
ÇÇ 
byte
ÖÖ 
[
ÖÖ 
]
ÖÖ 

imageBytes
ÖÖ 
=
ÖÖ  !
await
ÖÖ" '
File
ÖÖ( ,
.
ÖÖ, -
ReadAllBytesAsync
ÖÖ- >
(
ÖÖ> ?
	imagePath
ÖÖ? H
)
ÖÖH I
;
ÖÖI J
await
àà 
	webSocket
àà 
.
àà 
	SendAsync
àà '
(
àà' (
new
àà( +
ArraySegment
àà, 8
<
àà8 9
byte
àà9 =
>
àà= >
(
àà> ?

imageBytes
àà? I
)
ààI J
,
ààJ K"
WebSocketMessageType
ààL `
.
àà` a
Binary
ààa g
,
ààg h
true
àài m
,
ààm n 
CancellationTokenàào Ä
.ààÄ Å
NoneààÅ Ö
)ààÖ Ü
;ààÜ á
await
ãã 
Task
ãã 
.
ãã 
Delay
ãã 
(
ãã 
$num
ãã #
)
ãã# $
;
ãã$ %
}
åå
 
}
çç 
}
éé 
public
êê 

async
êê 
Task
êê !
CloseAllConnections
êê )
(
êê) *
)
êê* +
{
ëë 
foreach
íí 
(
íí 
var
íí 
viewer
íí 
in
íí 
_viewers
íí %
)
íí% &
{
ìì 
if
îî 

(
îî 
viewer
îî 
.
îî 
State
îî 
==
îî 
WebSocketState
îî *
.
îî* +
Open
îî+ /
)
îî/ 0
{
ïï 	
await
ññ
 
viewer
ññ 
.
ññ 

CloseAsync
ññ !
(
ññ! ""
WebSocketCloseStatus
ññ" 6
.
ññ6 7
NormalClosure
ññ7 D
,
ññD E
$str
ññF _
,
ññ_ `
CancellationToken
ñña r
.
ññr s
None
ññs w
)
ññw x
;
ññx y
}
óó 	
}
òò 
}
ôô 
}
öö 
}õõ É
]C:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Services\ControlsService.cs
	namespace 	
WebCamServer
 
. 
Services 
{ 
public 
class	 
ControlsService 
:  
IControlsService! 1
{ 
public		 

ControlsService		 
(		 
)		 
{

 
} 
public 

async 
Task 
ControlsOfCamera &
(& '
	WebSocket' 0
	webSocket1 :
): ;
{ 
var 	
buffer
 
= 
new 
byte 
[ 
$num  
*! "
$num# $
]$ %
;% &
while 
( 
	webSocket 
. 
State 
== 
WebSocketState  .
.. /
Open/ 3
)3 4
{ 
var 
result 
= 
await 
	webSocket $
.$ %
ReceiveAsync% 1
(1 2
new2 5
ArraySegment6 B
<B C
byteC G
>G H
(H I
bufferI O
)O P
,P Q
CancellationTokenR c
.c d
Noned h
)h i
;i j
if 

( 
result 
. 
MessageType 
== ! 
WebSocketMessageType" 6
.6 7
Close7 <
)< =
{ 	
await
 
	webSocket 
. 

CloseAsync $
($ % 
WebSocketCloseStatus% 9
.9 :
NormalClosure: G
,G H
$strI R
,R S
CancellationTokenT e
.e f
Nonef j
)j k
;k l
} 	
else 
{ 	
var
 
	clientMsg 
= 
Encoding "
." #
UTF8# '
.' (
	GetString( 1
(1 2
buffer2 8
,8 9
$num: ;
,; <
result= C
.C D
CountD I
)I J
;J K
var
 
serverResponse 
= 
$" !
$str! 9
{9 :
	clientMsg: C
}C D
"D E
;E F
var
 
	bufferRes 
= 
Encoding "
." #
UTF8# '
.' (
GetBytes( 0
(0 1
serverResponse1 ?
)? @
;@ A
await!!
 
	webSocket!! 
.!! 
	SendAsync!! #
(!!# $
new"" 
ArraySegment"" 
<"" 
byte"" !
>""! "
(""" #
	bufferRes""# ,
)"", -
,""- . 
WebSocketMessageType##  
.##  !
Text##! %
,##% &
true$$ 
,$$ 
CancellationToken%% 
.%% 
None%% "
)&& 
;&& 
}'' 	
}(( 
})) 
}** 
}++ –
YC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Services\AuthService.cs
	namespace		 	
WebCamServer		
 
.		 
Services		 
{

 
public 
class	 
AuthService 
: 
IAuthService )
{ 
}RR 
}SS µ
ZC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Security\PasswordHash.cs
	namespace 	
WebCamServer
 
. 
Security 
{ 
public 
static	 
class 
PasswordHash "
{ 
public		 

static		 
string		 
HashPassword		 %
(		% &
string		& ,
password		- 5
,		5 6
Guid		7 ;
saltGuid		< D
)		D E
{

 
using 
( 
var 
sha256 
= 
SHA256  
.  !
Create! '
(' (
)( )
)) *
{ 
var 
	saltBytes 
= 
saltGuid  
.  !
ToByteArray! ,
(, -
)- .
;. /
var 
combinedBytes 
= 
new 
byte  $
[$ %
	saltBytes% .
.. /
Length/ 5
+6 7
password8 @
.@ A
LengthA G
]G H
;H I
Array 
. 
Copy 
( 
	saltBytes 
, 
combinedBytes +
,+ ,
	saltBytes- 6
.6 7
Length7 =
)= >
;> ?
Array 
. 
Copy 
( 
Encoding 
. 
UTF8  
.  !
GetBytes! )
() *
password* 2
)2 3
,3 4
$num5 6
,6 7
combinedBytes8 E
,E F
	saltBytesG P
.P Q
LengthQ W
,W X
passwordY a
.a b
Lengthb h
)h i
;i j
var 
hashedBytes 
= 
sha256  
.  !
ComputeHash! ,
(, -
combinedBytes- :
): ;
;; <
return 
Convert 
. 
ToBase64String %
(% &
hashedBytes& 1
)1 2
;2 3
} 
} 
public 

static 
bool 
VerifyPassword %
(% &
string& ,
storedPassword- ;
,; <
string= C
inputPasswordD Q
,Q R
GuidS W
saltGuidX `
)` a
{ 
var 	
hashedInputPassword
 
= 
HashPassword  ,
(, -
inputPassword- :
,: ;
saltGuid< D
)D E
;E F
return 
hashedInputPassword  
==! #
storedPassword$ 2
;2 3
} 
} 
} É&
QC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Security\Jwt.cs
	namespace

 	
WebCamServer


 
.

 
Security

 
{ 
public 
class	 
Jwt 
{ 
public 

static 
string 
GenerateToken &
(& '

AuthJwtDto 
jwt 
, 
User 
user 
)  
{ 
var 	
tokenHandler
 
= 
new #
JwtSecurityTokenHandler 4
(4 5
)5 6
;6 7
var 	
claimbs
 
= 
new 
List 
< 
Claim "
>" #
{ 
new 
Claim 
( #
JwtRegisteredClaimNames )
.) *
Sub* -
,- .
jwt/ 2
.2 3
Subject3 :
): ;
,; <
new 
Claim 
( #
JwtRegisteredClaimNames )
.) *
Jti* -
,- .
Guid/ 3
.3 4
NewGuid4 ;
(; <
)< =
.= >
ToString> F
(F G
)G H
)H I
,I J
new 
Claim 
( #
JwtRegisteredClaimNames )
.) *
Iat* -
,- .
DateTime/ 7
.7 8
UtcNow8 >
.> ?
ToString? G
(G H
)H I
)I J
,J K
new 
Claim 
( 
$str 
, 
user 
. 
Id 
.  
ToString  (
(( )
)) *
)* +
,+ ,
new 
Claim 
( 
$str 
, 
user 
. 
Name #
)# $
,$ %
} 
; 
var 	
key
 
= 
new  
SymmetricSecurityKey (
(( )
Encoding) 1
.1 2
UTF82 6
.6 7
GetBytes7 ?
(? @
jwt@ C
.C D
KeyD G
)G H
)H I
;I J
var 	
Sigin
 
= 
new 
SigningCredentials (
(( )
key) ,
,, -
SecurityAlgorithms. @
.@ A
HmacSha256SignatureA T
)T U
;U V
var!! 	
	tokenDesc!!
 
=!! 
new!! #
SecurityTokenDescriptor!! 1
{"" 
Subject## 
=## 
new## 
ClaimsIdentity## $
(##$ %
claimbs##% ,
)##, -
,##- .
Expires$$ 
=$$ 
DateTime$$ 
.$$ 
UtcNow$$ !
.$$! "

AddMinutes$$" ,
($$, -
jwt$$- 0
.$$0 1
TimeValidMin$$1 =
)$$= >
,$$> ?
Issuer%% 
=%% 
jwt%% 
.%% 
Issuer%% 
,%% 
Audience&& 
=&& 
jwt&& 
.&& 
Audience&& 
,&&  
SigningCredentials'' 
='' 
Sigin'' "
}(( 
;(( 
var** 	
token**
 
=** 
tokenHandler** 
.** 
CreateToken** *
(*** +
	tokenDesc**+ 4
)**4 5
;**5 6
var++ 	
	jwt_token++
 
=++ 
tokenHandler++ "
.++" #

WriteToken++# -
(++- .
token++. 3
)++3 4
;++4 5
return-- 
	jwt_token-- 
;-- 
}.. 
public00 

static00 
string00  
GenerateRefreshToken00 -
(00- .
)00. /
{000 1
var22 	
	byteArray22
 
=22 
new22 
byte22 
[22 
$num22 !
]22! "
;22" #
var33 	
refreshToken33
 
=33 
$str33 
;33 
using55 
(55 
var55 
rng55 
=55 !
RandomNumberGenerator55 ,
.55, -
Create55- 3
(553 4
)554 5
)555 6
{557 8
rng66 
.66 
GetBytes66 
(66 
	byteArray66 
)66 
;66  
refreshToken77 
=77 
Convert77 
.77 
ToBase64String77 -
(77- .
	byteArray77. 7
)777 8
;778 9
}88 
return:: 
refreshToken:: 
;:: 
};; 
}<< 
}== ‰
lC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\VideoPublicationRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
{ 
public		 
class			 &
VideoPublicationRepository		 )
:		* +'
IVideoPublicationRepository		, G
{

 
private 
readonly 
IMongoCollection %
<% &
VideoPublication& 6
>6 7
_coll8 =
;= >
public 
&
VideoPublicationRepository %
(% &
IMongoClient& 2
mongoClient3 >
,> ?
IOptions@ H
<H I
MongoDbSettingsI X
>X Y
settingsZ b
)b c
{ 
var 	
database
 
= 
mongoClient  
.  !
GetDatabase! ,
(, -
settings- 5
.5 6
Value6 ;
.; <
DatabaseName< H
)H I
;I J
_coll 
= 
database 
. 
GetCollection $
<$ %
VideoPublication% 5
>5 6
(6 7
$str7 J
)J K
;K L
} 
public 

async 
Task 
< 
List 
< 
VideoPublication +
>+ ,
>, -
GetAll. 4
(4 5
)5 6
{ 
return 
await 
_coll 
. 
Find 
( 
_ 
=>  "
true# '
)' (
.( )
ToListAsync) 4
(4 5
)5 6
;6 7
} 
public 

async 
Task 
< 
VideoPublication &
>& '
GetById( /
(/ 0
string0 6
id7 9
)9 :
{ 
return 
await 
_coll 
. 
Find 
( 
entity $
=>% '
entity( .
.. /
Id/ 1
==2 4
id5 7
)7 8
.8 9
FirstOrDefaultAsync9 L
(L M
)M N
;N O
} 
public 

async 
Task 
Create 
( 
VideoPublication -
	newEntity. 7
)7 8
{ 
await 
_coll 
. 
InsertOneAsync  
(  !
	newEntity! *
)* +
;+ ,
}   
public"" 

async"" 
Task"" 
Update"" 
("" 
string"" #
id""$ &
,""& '
VideoPublication""( 8
updatedEntity""9 F
)""F G
{## 
await$$ 
_coll$$ 
.$$ 
ReplaceOneAsync$$ !
($$! "
entity$$" (
=>$$) +
entity$$, 2
.$$2 3
Id$$3 5
==$$6 8
id$$9 ;
,$$; <
updatedEntity$$= J
)$$J K
;$$K L
}%% 
public'' 

async'' 
Task'' 
Delete'' 
('' 
string'' #
id''$ &
)''& '
{(( 
await)) 
_coll)) 
.)) 
DeleteOneAsync))  
())  !
entity))! '
=>))( *
entity))+ 1
.))1 2
Id))2 4
==))5 7
id))8 :
))): ;
;)); <
}** 
}++ 
},, ·
`C:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\UserRepository.cs
	namespace		 	
WebCamServer		
 
.		 
Repositories		 #
{

 
public 
class	 
UserRepository 
: 
IUserRepository  /
{ 
}@@ 
}AA ‰
aC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\TokenRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
{		 
public

 
class

	 
TokenRepository

 
:

  
ITokenRepository

! 1
{ 
}AA 
}BB Ö
xC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\Interfaces\IVideoPublicationRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
.# $

Interfaces$ .
{ 
public 
	interface	 '
IVideoPublicationRepository .
{ 
} 
} Ì
lC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\Interfaces\IUserRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
.# $

Interfaces$ .
{ 
public 
	interface	 
IUserRepository "
{ 
} 
} Ô
mC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\Interfaces\ITokenRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
.# $

Interfaces$ .
{ 
public 
	interface	 
ITokenRepository #
{ 
} 
} Û
oC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\Interfaces\ICommentRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
.# $

Interfaces$ .
{ 
public 
	interface	 
ICommentRepository %
{ 
} 
} Ò
nC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\Interfaces\ICameraRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
.# $

Interfaces$ .
{ 
public 
	interface	 
ICameraRepository $
{ 
} 
} ˘
rC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\Interfaces\ICameraHomeRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
.# $

Interfaces$ .
{ 
public 
	interface	 !
ICameraHomeRepository (
{ 
} 
} Å
vC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\Interfaces\ICameraActivityRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
.# $

Interfaces$ .
{ 
public 
	interface	 %
ICameraActivityRepository ,
{ 
} 
} ä
cC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\CommentRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
{ 
public		 
class			 
CommentRepository		  
:		! "
ICommentRepository		# 5
{

 
private 
readonly 
IMongoCollection %
<% &
Comment& -
>- .
_coll/ 4
;4 5
public 

CommentRepository 
( 
IMongoClient )
mongoClient* 5
,5 6
IOptions7 ?
<? @
MongoDbSettings@ O
>O P
settingsQ Y
)Y Z
{ 
var 	
database
 
= 
mongoClient  
.  !
GetDatabase! ,
(, -
settings- 5
.5 6
Value6 ;
.; <
DatabaseName< H
)H I
;I J
_coll 
= 
database 
. 
GetCollection $
<$ %
Comment% ,
>, -
(- .
$str. 8
)8 9
;9 :
} 
public 

async 
Task 
< 
List 
< 
Comment "
>" #
># $
GetAll% +
(+ ,
), -
{ 
return 
await 
_coll 
. 
Find 
( 
_ 
=>  "
true# '
)' (
.( )
ToListAsync) 4
(4 5
)5 6
;6 7
} 
public 

async 
Task 
< 
Comment 
> 
GetById &
(& '
string' -
id. 0
)0 1
{ 
return 
await 
_coll 
. 
Find 
( 
entity $
=>% '
entity( .
.. /
Id/ 1
==2 4
id5 7
)7 8
.8 9
FirstOrDefaultAsync9 L
(L M
)M N
;N O
} 
public 

async 
Task 
Create 
( 
Comment $
	newEntity% .
). /
{ 
await 
_coll 
. 
InsertOneAsync  
(  !
	newEntity! *
)* +
;+ ,
}   
public"" 

async"" 
Task"" 
Update"" 
("" 
string"" #
id""$ &
,""& '
Comment""( /
updatedEntity""0 =
)""= >
{## 
await$$ 
_coll$$ 
.$$ 
ReplaceOneAsync$$ !
($$! "
entity$$" (
=>$$) +
entity$$, 2
.$$2 3
Id$$3 5
==$$6 8
id$$9 ;
,$$; <
updatedEntity$$= J
)$$J K
;$$K L
}%% 
public'' 

async'' 
Task'' 
Delete'' 
('' 
string'' #
id''$ &
)''& '
{(( 
await)) 
_coll)) 
.)) 
DeleteOneAsync))  
())  !
entity))! '
=>))( *
entity))+ 1
.))1 2
Id))2 4
==))5 7
id))8 :
))): ;
;)); <
}** 
}++ 
},, Á
bC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\CameraRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
{ 
public		 
class			 
CameraRepository		 
:		  !
ICameraRepository		" 3
{

 
},, 
}-- Û
fC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\CameraHomeRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
{ 
public		 
class			  
CameraHomeRepository		 #
:		$ %!
ICameraHomeRepository		& ;
{

 
},, 
}-- ˇ
jC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Repositories\CameraActivityRepository.cs
	namespace 	
WebCamServer
 
. 
Repositories #
{ 
public		 
class			 $
CameraActivityRepository		 '
:		( )%
ICameraActivityRepository		* C
{

 
},, 
}-- Ò
LC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Program.cs
var 
builder 
= 
WebApplication 
. 
CreateBuilder *
(* +
args+ /
)/ 0
;0 1
builder 
. 
Services 
. 
	Configure 
< 
CloudinarySettings -
>- .
( 
builder 

.
 
Configuration 
. 

GetSection #
(# $
$str$ 8
)8 9
)9 :
;: ;
builder 
. 
Services 
. 
AddControllers 
(  
)  !
;! "
builder 
. 
Services 
. 
AddAutoMapper 
( 
typeof %
(% &
AuthService& 1
)1 2
.2 3
Assembly3 ;
); <
;< =
string "
MyAllowSpecificOrigins 
= 
$str  0
;0 1
builder 
. 
Services 
. 
ConfigureCors 
( "
MyAllowSpecificOrigins 5
)5 6
;6 7
LoadService 
. 
LoadServices 
( 
builder  
.  !
Services! )
)) *
;* +
LoadService 
. 
LoadRepositories 
( 
builder $
.$ %
Services% -
)- .
;. /
builder   
.   
Services   
.   
ConfigureContext   !
(  ! "
builder  " )
)  ) *
;  * +
builder## 
.## 
Services## 
.## #
AddEndpointsApiExplorer## (
(##( )
)##) *
;##* +
builder$$ 
.$$ 
Services$$ 
.$$ 
AddSwaggerGen$$ 
($$ 
)$$  
;$$  !
builder'' 
.'' 
Services'' 
.'' 
ConfigureSwagger'' !
(''! "
)''" #
;''# $
var)) 
app)) 
=)) 	
builder))
 
.)) 
Build)) 
()) 
))) 
;)) 
if-- 
(-- 
app-- 
.-- 
Environment-- 
.-- 
IsDevelopment-- !
(--! "
)--" #
)--# $
{.. 
app// 
.// 

UseSwagger// 
(// 
)// 
;// 
app00 
.00 
UseSwaggerUI00 
(00 
)00 
;00 
}11 
app33 
.33 
UseHttpsRedirection33 
(33 
)33 
;33 
app55 
.55 
UseWebSockets55 
(55 
)55 
;55 
;55 
app77 
.77 

UseRouting77 
(77 
)77 
;77 
app88 
.88 
UseCors88 
(88 "
MyAllowSpecificOrigins88 "
)88" #
;88# $
app<< 
.<< 
MapControllers<< 
(<< 
)<< 
;<< 
app>> 
.>> 
Run>> 
(>> 
)>> 	
;>>	 
«
TC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\UserInfo.cs
	namespace 	
WebCamServer
 
. 
Models 
{ 
public 
class	 
UserInfo 
: 
HistoryModel &
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
public		 

string		 
	FirstName		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
public

 

string

 
DadLastName

 
{

 
get

  #
;

# $
set

% (
;

( )
}

* +
public 

string 
MomLastName 
{ 
get  #
;# $
set% (
;( )
}* +
public 

DateTime 
	BirthDate 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
City 
{ 
get 
; 
set !
;! "
}# $
public 

virtual 
User 
User 
{ 
get "
;" #
set$ '
;' (
}) *
} 
} æ
PC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\User.cs
	namespace 	
WebCamServer
 
. 
Models 
{ 
public 
class	 
User 
: 
HistoryModel "
{ 
public		 

int		 
Id		 
{		 
get		 
;		 
set		 
;		 
}		 
public

 

string

 
Name

 
{

 
get

 
;

 
set

 !
;

! "
}

# $
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
public 

Guid 
PasswordSalt 
{ 
get "
;" #
set$ '
;' (
}) *
public 

int 

UserInfoId 
{ 
get 
;  
set! $
;$ %
}& '
public 

virtual 
UserInfo 
UserInfo $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 

virtual 
ICollection 
< 
Notification +
>+ ,
Notifications- :
{; <
get= @
;@ A
setB E
;E F
}G H
public 

virtual 
Seeker 
Seeker  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

virtual 
Admin 
Admin 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

virtual 
ICollection 
< 
Token $
>$ %
Tokens& ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
} 
} Û
QC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\Token.cs
	namespace 	
WebCamServer
 
. 
Models 
{ 
public 
class	 
Token 
{ 
public 

string 
Id 
{ 
get 
; 
set 
;  
}! "
public		 

string		 
CurrentToken		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		* +
public

 

string

 
RefreshToken

 
{

  
get

! $
;

$ %
set

& )
;

) *
}

* +
public 

DateTime 

CreateDate 
{  
get! $
;$ %
set& )
;) *
}* +
public 

DateTime 
ExpiredDate 
{  !
get" %
;% &
set' *
;* +
}+ ,
public 

bool 
Active 
{ 
get 
; 
set !
;! "
}" #
public 

int 
UserId 
{ 
get 
; 
set  
;  !
}" #
public 

User 
User 
{ 
get 
; 
set 
; 
}  
} 
} Ü

bC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\Templates\HistoryModel.cs
	namespace 	
WebCamServer
 
. 
Models 
. 
	Templates '
{ 
public 
class	 
HistoryModel 
{ 
public 

DateTime 
CreateAt 
{ 
get "
;" #
set$ '
;' (
}) *
public 

DateTime 
UpdateAt 
{ 
get "
;" #
set$ '
;' (
}) *
public 

DateTime 
DeleteAt 
{ 
get "
;" #
set$ '
;' (
}) *
public		 

int		 
CreateUserId		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
public

 

int

 
UpdateUserId

 
{

 
get

 !
;

! "
set

# &
;

& '
}

( )
public 

int 
DeleteUserId 
{ 
get !
;! "
set# &
;& '
}( )
} 
} Í	
RC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\Seeker.cs
	namespace 	
WebCamServer
 
. 
Models 
{ 
public 
class	 
Seeker 
: 
HistoryModel $
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public

 

int

 
UserId

 
{

 
get

 
;

 
set

  
;

  !
}

" #
public 

virtual 
User 
User 
{ 
get "
;" #
set$ '
;' (
}) *
public 

virtual 
ICollection 
< 
Contacts '
>' (
Contacts) 1
{2 3
get4 7
;7 8
set9 <
;< =
}> ?
public 

virtual 
ICollection 
< 
Missing &
>& '
Missings( 0
{1 2
get3 6
;6 7
set8 ;
;; <
}= >
} 
} ü
fC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\RedSocial\VideoPublication.cs
	namespace 	
WebCamServer
 
. 
Models 
. 
	RedSocial '
{ 
public 
class	 
VideoPublication 
{ 
public 

string 
Id 
{ 
get 
; 
set 
;  
}! "
public 

string 
Title 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
Description 
{ 
get  #
;# $
set% (
;( )
}* +
public 

TimeOnly 
	InitVideo 
{ 
get  #
;# $
set% (
;( )
}* +
public		 

TimeOnly		 
EndVideo		 
{		 
get		 "
;		" #
set		$ '
;		' (
}		) *
public

 

DateOnly

 
Date

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
public 

int 
FoundVideoId 
{ 
get !
;! "
set# &
;& '
}( )
} 
} Å
]C:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\RedSocial\Comment.cs
	namespace 	
WebCamServer
 
. 
Models 
. 
	RedSocial '
{ 
public 
class	 
Comment 
{ 
public 

string 
Id 
{ 
get 
; 
set 
;  
}! "
public 

string 
Comments 
{ 
get  
;  !
set" %
;% &
}' (
public 

string 
Image 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
Video 
{ 
get 
; 
set "
;" #
}$ %
public		 

DateTime		 
Date		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
public 

int 
PublicationId 
{ 
get "
;" #
set$ '
;' (
}) *
public 

int 
	CommentId 
{ 
get 
; 
set  #
;# $
}% &
} 
} ›
XC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\Notification.cs
	namespace 	
WebCamServer
 
. 
Models 
{ 
public 
class	 
Notification 
: 
HistoryModel *
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Title 
{ 
get 
; 
set "
;" #
}$ %
public		 

string		 
Description		 
{		 
get		  #
;		# $
set		% (
;		( )
}		* +
public

 

string

 

LinkAction

 
{

 
get

 "
;

" #
set

$ '
;

' (
}

) *
public 

NotificationType 
Type  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

int 
UserId 
{ 
get 
; 
set  
;  !
}" #
public 

virtual 
User 
User 
{ 
get "
;" #
set$ '
;' (
}) *
} 
public 
enum	 
NotificationType 
{ 
Message 
, 
Alert 
, 
VideoMissing  
} 
} ”
SC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\Missing.cs
	namespace 	
WebCamServer
 
. 
Models 
{ 
public 
class	 
Missing 
: 
HistoryModel %
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
	DirPhotos 
{ 
get !
;! "
set# &
;& '
}( )
public		 

DateTime		 
	BirthDate		 
{		 
get		  #
;		# $
set		% (
;		( )
}		* +
public

 

string

 
FullName

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
public 

double 
Size 
{ 
get 
; 
set !
;! "
}# $
public 

string 
Description 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
LastSeenMap 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

bool 
Found 
{ 
get 
; 
set  
;  !
}" #
public 

int 
SeekerId 
{ 
get 
; 
set "
;" #
}$ %
public 

virtual 
Seeker 
Seeker  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

virtual 
ICollection 
< 

FoundVideo )
>) *
FoundVideos+ 6
{7 8
get9 <
;< =
set> A
;A B
}C D
} 
} «
VC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\FoundVideo.cs
	namespace 	
WebCamServer
 
. 
Models 
{ 
public 
class	 

FoundVideo 
: 
HistoryModel (
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

TimeOnly 
	InitVideo 
{ 
get  #
;# $
set% (
;( )
}* +
public		 

TimeOnly		 
EndVideo		 
{		 
get		 "
;		" #
set		$ '
;		' (
}		) *
public

 

DateOnly

 
Date

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
public 

int 
CameraId 
{ 
get 
; 
set "
;" #
}$ %
public 

int 
	MissingId 
{ 
get 
; 
set  #
;# $
}% &
public 

virtual 
Camera 
Camera  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

virtual 
Missing 
Missing "
{# $
get% (
;( )
set* -
;- .
}/ 0
} 
} ≠
TC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\Contacts.cs
	namespace 	
WebCamServer
 
. 
Models 
{ 
public 
class	 
Contacts 
: 
HistoryModel &
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Description 
{ 
get  #
;# $
set% (
;( )
}* +
public		 

string		 
Value		 
{		 
get		 
;		 
set		 "
;		" #
}		$ %
public

 

ContactsType

 
Type

 
{

 
get

 "
;

" #
set

$ '
;

' (
}

) *
public 

int 
SeekerId 
{ 
get 
; 
set !
;! "
}" #
public 

virtual 
Seeker 
Seeker  
{! "
get# &
;& '
set( +
;+ ,
}- .
} 
public 
enum	 
ContactsType 
{ 
Number 

,
 
Phone 
, 
Email 
} 
} ¸
RC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\Camera.cs
	namespace 	
WebCamServer
 
. 
Models 
{ 
public 
class	 
Camera 
: 
HistoryModel $
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Code 
{ 
get 
; 
set !
;! "
}# $
public		 

string		 
UbicationMap		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		+ ,
public 

virtual 
ICollection 
< 

FoundVideo )
>) *
FoundVideos+ 6
{7 8
get9 <
;< =
set> A
;A B
}C D
} 
} ï
QC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Models\Admin.cs
	namespace 	
WebCamServer
 
. 
Models 
{ 
public 
class	 
Admin 
: 
HistoryModel #
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public

 

int

 
UserId

 
{

 
get

 
;

 
set

  
;

  !
}

" #
public 

virtual 
User 
User 
{ 
get "
;" #
set$ '
;' (
}) *
} 
} Ò
\C:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Helpers\MongoDbSettings.cs
	namespace 	
WebCamServer
 
. 
Helpers 
{ 
public 
class	 
MongoDbSettings 
{ 
public 

string 
ConnectionString "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 

string 
DatabaseName 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
} Ó≥
nC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Migrations\20241101185129_First migration.cs
	namespace 	
WebCamServer
 
. 

Migrations !
{ 
public

 

partial

 
class

 
Firstmigration

 '
:

( )
	Migration

* 3
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str 
,  
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 :
,: ;
nullable< D
:D E
falseF K
)K L
. 

Annotation #
(# $
$str$ D
,D E)
NpgsqlValueGenerationStrategyF c
.c d#
IdentityByDefaultColumnd {
){ |
,| }
Code 
= 
table  
.  !
Column! '
<' (
string( .
>. /
(/ 0
type0 4
:4 5
$str6 <
,< =
nullable> F
:F G
trueH L
)L M
,M N
UbicationMap  
=! "
table# (
.( )
Column) /
</ 0
string0 6
>6 7
(7 8
type8 <
:< =
$str> D
,D E
nullableF N
:N O
trueP T
)T U
,U V
CreateAt 
= 
table $
.$ %
Column% +
<+ ,
DateTime, 4
>4 5
(5 6
type6 :
:: ;
$str< V
,V W
nullableX `
:` a
falseb g
)g h
,h i
UpdateAt 
= 
table $
.$ %
Column% +
<+ ,
DateTime, 4
>4 5
(5 6
type6 :
:: ;
$str< V
,V W
nullableX `
:` a
falseb g
)g h
,h i
DeleteAt 
= 
table $
.$ %
Column% +
<+ ,
DateTime, 4
>4 5
(5 6
type6 :
:: ;
$str< V
,V W
nullableX `
:` a
falseb g
)g h
,h i
CreateUserId  
=! "
table# (
.( )
Column) /
</ 0
int0 3
>3 4
(4 5
type5 9
:9 :
$str; D
,D E
nullableF N
:N O
falseP U
)U V
,V W
UpdateUserId  
=! "
table# (
.( )
Column) /
</ 0
int0 3
>3 4
(4 5
type5 9
:9 :
$str; D
,D E
nullableF N
:N O
falseP U
)U V
,V W
DeleteUserId  
=! "
table# (
.( )
Column) /
</ 0
int0 3
>3 4
(4 5
type5 9
:9 :
$str; D
,D E
nullableF N
:N O
falseP U
)U V
} 
, 
constraints 
: 
table "
=># %
{ 
table   
.   

PrimaryKey   $
(  $ %
$str  % 1
,  1 2
x  3 4
=>  5 7
x  8 9
.  9 :
Id  : <
)  < =
;  = >
}!! 
)!! 
;!! 
migrationBuilder## 
.## 
CreateTable## (
(##( )
name$$ 
:$$ 
$str$$ !
,$$! "
columns%% 
:%% 
table%% 
=>%% !
new%%" %
{&& 
Id'' 
='' 
table'' 
.'' 
Column'' %
<''% &
int''& )
>'') *
(''* +
type''+ /
:''/ 0
$str''1 :
,'': ;
nullable''< D
:''D E
false''F K
)''K L
.(( 

Annotation(( #
(((# $
$str(($ D
,((D E)
NpgsqlValueGenerationStrategy((F c
.((c d#
IdentityByDefaultColumn((d {
)(({ |
,((| }
Name)) 
=)) 
table))  
.))  !
Column))! '
<))' (
string))( .
>)). /
())/ 0
type))0 4
:))4 5
$str))6 <
,))< =
nullable))> F
:))F G
true))H L
)))L M
,))M N
	FirstName** 
=** 
table**  %
.**% &
Column**& ,
<**, -
string**- 3
>**3 4
(**4 5
type**5 9
:**9 :
$str**; A
,**A B
nullable**C K
:**K L
true**M Q
)**Q R
,**R S
DadLastName++ 
=++  !
table++" '
.++' (
Column++( .
<++. /
string++/ 5
>++5 6
(++6 7
type++7 ;
:++; <
$str++= C
,++C D
nullable++E M
:++M N
true++O S
)++S T
,++T U
MomLastName,, 
=,,  !
table,," '
.,,' (
Column,,( .
<,,. /
string,,/ 5
>,,5 6
(,,6 7
type,,7 ;
:,,; <
$str,,= C
,,,C D
nullable,,E M
:,,M N
true,,O S
),,S T
,,,T U
	BirthDate-- 
=-- 
table--  %
.--% &
Column--& ,
<--, -
DateTime--- 5
>--5 6
(--6 7
type--7 ;
:--; <
$str--= W
,--W X
nullable--Y a
:--a b
false--c h
)--h i
,--i j
Email.. 
=.. 
table.. !
...! "
Column.." (
<..( )
string..) /
>../ 0
(..0 1
type..1 5
:..5 6
$str..7 =
,..= >
nullable..? G
:..G H
true..I M
)..M N
,..N O
City// 
=// 
table//  
.//  !
Column//! '
<//' (
string//( .
>//. /
(/// 0
type//0 4
://4 5
$str//6 <
,//< =
nullable//> F
://F G
true//H L
)//L M
,//M N
CreateAt00 
=00 
table00 $
.00$ %
Column00% +
<00+ ,
DateTime00, 4
>004 5
(005 6
type006 :
:00: ;
$str00< V
,00V W
nullable00X `
:00` a
false00b g
)00g h
,00h i
UpdateAt11 
=11 
table11 $
.11$ %
Column11% +
<11+ ,
DateTime11, 4
>114 5
(115 6
type116 :
:11: ;
$str11< V
,11V W
nullable11X `
:11` a
false11b g
)11g h
,11h i
DeleteAt22 
=22 
table22 $
.22$ %
Column22% +
<22+ ,
DateTime22, 4
>224 5
(225 6
type226 :
:22: ;
$str22< V
,22V W
nullable22X `
:22` a
false22b g
)22g h
,22h i
CreateUserId33  
=33! "
table33# (
.33( )
Column33) /
<33/ 0
int330 3
>333 4
(334 5
type335 9
:339 :
$str33; D
,33D E
nullable33F N
:33N O
false33P U
)33U V
,33V W
UpdateUserId44  
=44! "
table44# (
.44( )
Column44) /
<44/ 0
int440 3
>443 4
(444 5
type445 9
:449 :
$str44; D
,44D E
nullable44F N
:44N O
false44P U
)44U V
,44V W
DeleteUserId55  
=55! "
table55# (
.55( )
Column55) /
<55/ 0
int550 3
>553 4
(554 5
type555 9
:559 :
$str55; D
,55D E
nullable55F N
:55N O
false55P U
)55U V
}66 
,66 
constraints77 
:77 
table77 "
=>77# %
{88 
table99 
.99 

PrimaryKey99 $
(99$ %
$str99% 3
,993 4
x995 6
=>997 9
x99: ;
.99; <
Id99< >
)99> ?
;99? @
}:: 
):: 
;:: 
migrationBuilder<< 
.<< 
CreateTable<< (
(<<( )
name== 
:== 
$str== 
,== 
columns>> 
:>> 
table>> 
=>>> !
new>>" %
{?? 
Id@@ 
=@@ 
table@@ 
.@@ 
Column@@ %
<@@% &
int@@& )
>@@) *
(@@* +
type@@+ /
:@@/ 0
$str@@1 :
,@@: ;
nullable@@< D
:@@D E
false@@F K
)@@K L
.AA 

AnnotationAA #
(AA# $
$strAA$ D
,AAD E)
NpgsqlValueGenerationStrategyAAF c
.AAc d#
IdentityByDefaultColumnAAd {
)AA{ |
,AA| }
NameBB 
=BB 
tableBB  
.BB  !
ColumnBB! '
<BB' (
stringBB( .
>BB. /
(BB/ 0
typeBB0 4
:BB4 5
$strBB6 <
,BB< =
nullableBB> F
:BBF G
trueBBH L
)BBL M
,BBM N
EmailCC 
=CC 
tableCC !
.CC! "
ColumnCC" (
<CC( )
stringCC) /
>CC/ 0
(CC0 1
typeCC1 5
:CC5 6
$strCC7 =
,CC= >
nullableCC? G
:CCG H
trueCCI M
)CCM N
,CCN O
PasswordDD 
=DD 
tableDD $
.DD$ %
ColumnDD% +
<DD+ ,
stringDD, 2
>DD2 3
(DD3 4
typeDD4 8
:DD8 9
$strDD: @
,DD@ A
nullableDDB J
:DDJ K
trueDDL P
)DDP Q
,DDQ R
PasswordSaltEE  
=EE! "
tableEE# (
.EE( )
ColumnEE) /
<EE/ 0
GuidEE0 4
>EE4 5
(EE5 6
typeEE6 :
:EE: ;
$strEE< B
,EEB C
nullableEED L
:EEL M
falseEEN S
)EES T
,EET U

UserInfoIdFF 
=FF  
tableFF! &
.FF& '
ColumnFF' -
<FF- .
intFF. 1
>FF1 2
(FF2 3
typeFF3 7
:FF7 8
$strFF9 B
,FFB C
nullableFFD L
:FFL M
falseFFN S
)FFS T
,FFT U
CreateAtGG 
=GG 
tableGG $
.GG$ %
ColumnGG% +
<GG+ ,
DateTimeGG, 4
>GG4 5
(GG5 6
typeGG6 :
:GG: ;
$strGG< V
,GGV W
nullableGGX `
:GG` a
falseGGb g
)GGg h
,GGh i
UpdateAtHH 
=HH 
tableHH $
.HH$ %
ColumnHH% +
<HH+ ,
DateTimeHH, 4
>HH4 5
(HH5 6
typeHH6 :
:HH: ;
$strHH< V
,HHV W
nullableHHX `
:HH` a
falseHHb g
)HHg h
,HHh i
DeleteAtII 
=II 
tableII $
.II$ %
ColumnII% +
<II+ ,
DateTimeII, 4
>II4 5
(II5 6
typeII6 :
:II: ;
$strII< V
,IIV W
nullableIIX `
:II` a
falseIIb g
)IIg h
,IIh i
CreateUserIdJJ  
=JJ! "
tableJJ# (
.JJ( )
ColumnJJ) /
<JJ/ 0
intJJ0 3
>JJ3 4
(JJ4 5
typeJJ5 9
:JJ9 :
$strJJ; D
,JJD E
nullableJJF N
:JJN O
falseJJP U
)JJU V
,JJV W
UpdateUserIdKK  
=KK! "
tableKK# (
.KK( )
ColumnKK) /
<KK/ 0
intKK0 3
>KK3 4
(KK4 5
typeKK5 9
:KK9 :
$strKK; D
,KKD E
nullableKKF N
:KKN O
falseKKP U
)KKU V
,KKV W
DeleteUserIdLL  
=LL! "
tableLL# (
.LL( )
ColumnLL) /
<LL/ 0
intLL0 3
>LL3 4
(LL4 5
typeLL5 9
:LL9 :
$strLL; D
,LLD E
nullableLLF N
:LLN O
falseLLP U
)LLU V
}MM 
,MM 
constraintsNN 
:NN 
tableNN "
=>NN# %
{OO 
tablePP 
.PP 

PrimaryKeyPP $
(PP$ %
$strPP% /
,PP/ 0
xPP1 2
=>PP3 5
xPP6 7
.PP7 8
IdPP8 :
)PP: ;
;PP; <
tableQQ 
.QQ 

ForeignKeyQQ $
(QQ$ %
nameRR 
:RR 
$strRR =
,RR= >
columnSS 
:SS 
xSS  !
=>SS" $
xSS% &
.SS& '

UserInfoIdSS' 1
,SS1 2
principalTableTT &
:TT& '
$strTT( 3
,TT3 4
principalColumnUU '
:UU' (
$strUU) -
,UU- .
onDeleteVV  
:VV  !
ReferentialActionVV" 3
.VV3 4
CascadeVV4 ;
)VV; <
;VV< =
}WW 
)WW 
;WW 
migrationBuilderYY 
.YY 
CreateTableYY (
(YY( )
nameZZ 
:ZZ 
$strZZ 
,ZZ 
columns[[ 
:[[ 
table[[ 
=>[[ !
new[[" %
{\\ 
Id]] 
=]] 
table]] 
.]] 
Column]] %
<]]% &
int]]& )
>]]) *
(]]* +
type]]+ /
:]]/ 0
$str]]1 :
,]]: ;
nullable]]< D
:]]D E
false]]F K
)]]K L
.^^ 

Annotation^^ #
(^^# $
$str^^$ D
,^^D E)
NpgsqlValueGenerationStrategy^^F c
.^^c d#
IdentityByDefaultColumn^^d {
)^^{ |
,^^| }
UserId__ 
=__ 
table__ "
.__" #
Column__# )
<__) *
int__* -
>__- .
(__. /
type__/ 3
:__3 4
$str__5 >
,__> ?
nullable__@ H
:__H I
false__J O
)__O P
,__P Q
CreateAt`` 
=`` 
table`` $
.``$ %
Column``% +
<``+ ,
DateTime``, 4
>``4 5
(``5 6
type``6 :
:``: ;
$str``< V
,``V W
nullable``X `
:``` a
false``b g
)``g h
,``h i
UpdateAtaa 
=aa 
tableaa $
.aa$ %
Columnaa% +
<aa+ ,
DateTimeaa, 4
>aa4 5
(aa5 6
typeaa6 :
:aa: ;
$straa< V
,aaV W
nullableaaX `
:aa` a
falseaab g
)aag h
,aah i
DeleteAtbb 
=bb 
tablebb $
.bb$ %
Columnbb% +
<bb+ ,
DateTimebb, 4
>bb4 5
(bb5 6
typebb6 :
:bb: ;
$strbb< V
,bbV W
nullablebbX `
:bb` a
falsebbb g
)bbg h
,bbh i
CreateUserIdcc  
=cc! "
tablecc# (
.cc( )
Columncc) /
<cc/ 0
intcc0 3
>cc3 4
(cc4 5
typecc5 9
:cc9 :
$strcc; D
,ccD E
nullableccF N
:ccN O
falseccP U
)ccU V
,ccV W
UpdateUserIddd  
=dd! "
tabledd# (
.dd( )
Columndd) /
<dd/ 0
intdd0 3
>dd3 4
(dd4 5
typedd5 9
:dd9 :
$strdd; D
,ddD E
nullableddF N
:ddN O
falseddP U
)ddU V
,ddV W
DeleteUserIdee  
=ee! "
tableee# (
.ee( )
Columnee) /
<ee/ 0
intee0 3
>ee3 4
(ee4 5
typeee5 9
:ee9 :
$stree; D
,eeD E
nullableeeF N
:eeN O
falseeeP U
)eeU V
}ff 
,ff 
constraintsgg 
:gg 
tablegg "
=>gg# %
{hh 
tableii 
.ii 

PrimaryKeyii $
(ii$ %
$strii% 0
,ii0 1
xii2 3
=>ii4 6
xii7 8
.ii8 9
Idii9 ;
)ii; <
;ii< =
tablejj 
.jj 

ForeignKeyjj $
(jj$ %
namekk 
:kk 
$strkk 6
,kk6 7
columnll 
:ll 
xll  !
=>ll" $
xll% &
.ll& '
UserIdll' -
,ll- .
principalTablemm &
:mm& '
$strmm( /
,mm/ 0
principalColumnnn '
:nn' (
$strnn) -
,nn- .
onDeleteoo  
:oo  !
ReferentialActionoo" 3
.oo3 4
Cascadeoo4 ;
)oo; <
;oo< =
}pp 
)pp 
;pp 
migrationBuilderrr 
.rr 
CreateTablerr (
(rr( )
namess 
:ss 
$strss %
,ss% &
columnstt 
:tt 
tablett 
=>tt !
newtt" %
{uu 
Idvv 
=vv 
tablevv 
.vv 
Columnvv %
<vv% &
intvv& )
>vv) *
(vv* +
typevv+ /
:vv/ 0
$strvv1 :
,vv: ;
nullablevv< D
:vvD E
falsevvF K
)vvK L
.ww 

Annotationww #
(ww# $
$strww$ D
,wwD E)
NpgsqlValueGenerationStrategywwF c
.wwc d#
IdentityByDefaultColumnwwd {
)ww{ |
,ww| }
Titlexx 
=xx 
tablexx !
.xx! "
Columnxx" (
<xx( )
stringxx) /
>xx/ 0
(xx0 1
typexx1 5
:xx5 6
$strxx7 =
,xx= >
nullablexx? G
:xxG H
falsexxI N
)xxN O
,xxO P
Descriptionyy 
=yy  !
tableyy" '
.yy' (
Columnyy( .
<yy. /
stringyy/ 5
>yy5 6
(yy6 7
typeyy7 ;
:yy; <
$stryy= C
,yyC D
nullableyyE M
:yyM N
trueyyO S
)yyS T
,yyT U

LinkActionzz 
=zz  
tablezz! &
.zz& '
Columnzz' -
<zz- .
stringzz. 4
>zz4 5
(zz5 6
typezz6 :
:zz: ;
$strzz< B
,zzB C
nullablezzD L
:zzL M
truezzN R
)zzR S
,zzS T
Type{{ 
={{ 
table{{  
.{{  !
Column{{! '
<{{' (
int{{( +
>{{+ ,
({{, -
type{{- 1
:{{1 2
$str{{3 <
,{{< =
nullable{{> F
:{{F G
false{{H M
){{M N
,{{N O
UserId|| 
=|| 
table|| "
.||" #
Column||# )
<||) *
int||* -
>||- .
(||. /
type||/ 3
:||3 4
$str||5 >
,||> ?
nullable||@ H
:||H I
false||J O
)||O P
,||P Q
CreateAt}} 
=}} 
table}} $
.}}$ %
Column}}% +
<}}+ ,
DateTime}}, 4
>}}4 5
(}}5 6
type}}6 :
:}}: ;
$str}}< V
,}}V W
nullable}}X `
:}}` a
false}}b g
)}}g h
,}}h i
UpdateAt~~ 
=~~ 
table~~ $
.~~$ %
Column~~% +
<~~+ ,
DateTime~~, 4
>~~4 5
(~~5 6
type~~6 :
:~~: ;
$str~~< V
,~~V W
nullable~~X `
:~~` a
false~~b g
)~~g h
,~~h i
DeleteAt 
= 
table $
.$ %
Column% +
<+ ,
DateTime, 4
>4 5
(5 6
type6 :
:: ;
$str< V
,V W
nullableX `
:` a
falseb g
)g h
,h i
CreateUserId
ÄÄ  
=
ÄÄ! "
table
ÄÄ# (
.
ÄÄ( )
Column
ÄÄ) /
<
ÄÄ/ 0
int
ÄÄ0 3
>
ÄÄ3 4
(
ÄÄ4 5
type
ÄÄ5 9
:
ÄÄ9 :
$str
ÄÄ; D
,
ÄÄD E
nullable
ÄÄF N
:
ÄÄN O
false
ÄÄP U
)
ÄÄU V
,
ÄÄV W
UpdateUserId
ÅÅ  
=
ÅÅ! "
table
ÅÅ# (
.
ÅÅ( )
Column
ÅÅ) /
<
ÅÅ/ 0
int
ÅÅ0 3
>
ÅÅ3 4
(
ÅÅ4 5
type
ÅÅ5 9
:
ÅÅ9 :
$str
ÅÅ; D
,
ÅÅD E
nullable
ÅÅF N
:
ÅÅN O
false
ÅÅP U
)
ÅÅU V
,
ÅÅV W
DeleteUserId
ÇÇ  
=
ÇÇ! "
table
ÇÇ# (
.
ÇÇ( )
Column
ÇÇ) /
<
ÇÇ/ 0
int
ÇÇ0 3
>
ÇÇ3 4
(
ÇÇ4 5
type
ÇÇ5 9
:
ÇÇ9 :
$str
ÇÇ; D
,
ÇÇD E
nullable
ÇÇF N
:
ÇÇN O
false
ÇÇP U
)
ÇÇU V
}
ÉÉ 
,
ÉÉ 
constraints
ÑÑ 
:
ÑÑ 
table
ÑÑ "
=>
ÑÑ# %
{
ÖÖ 
table
ÜÜ 
.
ÜÜ 

PrimaryKey
ÜÜ $
(
ÜÜ$ %
$str
ÜÜ% 7
,
ÜÜ7 8
x
ÜÜ9 :
=>
ÜÜ; =
x
ÜÜ> ?
.
ÜÜ? @
Id
ÜÜ@ B
)
ÜÜB C
;
ÜÜC D
table
áá 
.
áá 

ForeignKey
áá $
(
áá$ %
name
àà 
:
àà 
$str
àà =
,
àà= >
column
ââ 
:
ââ 
x
ââ  !
=>
ââ" $
x
ââ% &
.
ââ& '
UserId
ââ' -
,
ââ- .
principalTable
ää &
:
ää& '
$str
ää( /
,
ää/ 0
principalColumn
ãã '
:
ãã' (
$str
ãã) -
,
ãã- .
onDelete
åå  
:
åå  !
ReferentialAction
åå" 3
.
åå3 4
Cascade
åå4 ;
)
åå; <
;
åå< =
}
çç 
)
çç 
;
çç 
migrationBuilder
èè 
.
èè 
CreateTable
èè (
(
èè( )
name
êê 
:
êê 
$str
êê 
,
êê  
columns
ëë 
:
ëë 
table
ëë 
=>
ëë !
new
ëë" %
{
íí 
Id
ìì 
=
ìì 
table
ìì 
.
ìì 
Column
ìì %
<
ìì% &
int
ìì& )
>
ìì) *
(
ìì* +
type
ìì+ /
:
ìì/ 0
$str
ìì1 :
,
ìì: ;
nullable
ìì< D
:
ììD E
false
ììF K
)
ììK L
.
îî 

Annotation
îî #
(
îî# $
$str
îî$ D
,
îîD E+
NpgsqlValueGenerationStrategy
îîF c
.
îîc d%
IdentityByDefaultColumn
îîd {
)
îî{ |
,
îî| }
UserId
ïï 
=
ïï 
table
ïï "
.
ïï" #
Column
ïï# )
<
ïï) *
int
ïï* -
>
ïï- .
(
ïï. /
type
ïï/ 3
:
ïï3 4
$str
ïï5 >
,
ïï> ?
nullable
ïï@ H
:
ïïH I
false
ïïJ O
)
ïïO P
,
ïïP Q
CreateAt
ññ 
=
ññ 
table
ññ $
.
ññ$ %
Column
ññ% +
<
ññ+ ,
DateTime
ññ, 4
>
ññ4 5
(
ññ5 6
type
ññ6 :
:
ññ: ;
$str
ññ< V
,
ññV W
nullable
ññX `
:
ññ` a
false
ññb g
)
ññg h
,
ññh i
UpdateAt
óó 
=
óó 
table
óó $
.
óó$ %
Column
óó% +
<
óó+ ,
DateTime
óó, 4
>
óó4 5
(
óó5 6
type
óó6 :
:
óó: ;
$str
óó< V
,
óóV W
nullable
óóX `
:
óó` a
false
óób g
)
óóg h
,
óóh i
DeleteAt
òò 
=
òò 
table
òò $
.
òò$ %
Column
òò% +
<
òò+ ,
DateTime
òò, 4
>
òò4 5
(
òò5 6
type
òò6 :
:
òò: ;
$str
òò< V
,
òòV W
nullable
òòX `
:
òò` a
false
òòb g
)
òòg h
,
òòh i
CreateUserId
ôô  
=
ôô! "
table
ôô# (
.
ôô( )
Column
ôô) /
<
ôô/ 0
int
ôô0 3
>
ôô3 4
(
ôô4 5
type
ôô5 9
:
ôô9 :
$str
ôô; D
,
ôôD E
nullable
ôôF N
:
ôôN O
false
ôôP U
)
ôôU V
,
ôôV W
UpdateUserId
öö  
=
öö! "
table
öö# (
.
öö( )
Column
öö) /
<
öö/ 0
int
öö0 3
>
öö3 4
(
öö4 5
type
öö5 9
:
öö9 :
$str
öö; D
,
ööD E
nullable
ööF N
:
ööN O
false
ööP U
)
ööU V
,
ööV W
DeleteUserId
õõ  
=
õõ! "
table
õõ# (
.
õõ( )
Column
õõ) /
<
õõ/ 0
int
õõ0 3
>
õõ3 4
(
õõ4 5
type
õõ5 9
:
õõ9 :
$str
õõ; D
,
õõD E
nullable
õõF N
:
õõN O
false
õõP U
)
õõU V
}
úú 
,
úú 
constraints
ùù 
:
ùù 
table
ùù "
=>
ùù# %
{
ûû 
table
üü 
.
üü 

PrimaryKey
üü $
(
üü$ %
$str
üü% 1
,
üü1 2
x
üü3 4
=>
üü5 7
x
üü8 9
.
üü9 :
Id
üü: <
)
üü< =
;
üü= >
table
†† 
.
†† 

ForeignKey
†† $
(
††$ %
name
°° 
:
°° 
$str
°° 7
,
°°7 8
column
¢¢ 
:
¢¢ 
x
¢¢  !
=>
¢¢" $
x
¢¢% &
.
¢¢& '
UserId
¢¢' -
,
¢¢- .
principalTable
££ &
:
££& '
$str
££( /
,
££/ 0
principalColumn
§§ '
:
§§' (
$str
§§) -
,
§§- .
onDelete
••  
:
••  !
ReferentialAction
••" 3
.
••3 4
Cascade
••4 ;
)
••; <
;
••< =
}
¶¶ 
)
¶¶ 
;
¶¶ 
migrationBuilder
®® 
.
®® 
CreateTable
®® (
(
®®( )
name
©© 
:
©© 
$str
©© 
,
©© 
columns
™™ 
:
™™ 
table
™™ 
=>
™™ !
new
™™" %
{
´´ 
Id
¨¨ 
=
¨¨ 
table
¨¨ 
.
¨¨ 
Column
¨¨ %
<
¨¨% &
string
¨¨& ,
>
¨¨, -
(
¨¨- .
type
¨¨. 2
:
¨¨2 3
$str
¨¨4 :
,
¨¨: ;
nullable
¨¨< D
:
¨¨D E
false
¨¨F K
)
¨¨K L
,
¨¨L M
CurrentToken
≠≠  
=
≠≠! "
table
≠≠# (
.
≠≠( )
Column
≠≠) /
<
≠≠/ 0
string
≠≠0 6
>
≠≠6 7
(
≠≠7 8
type
≠≠8 <
:
≠≠< =
$str
≠≠> D
,
≠≠D E
nullable
≠≠F N
:
≠≠N O
true
≠≠P T
)
≠≠T U
,
≠≠U V
RefreshToken
ÆÆ  
=
ÆÆ! "
table
ÆÆ# (
.
ÆÆ( )
Column
ÆÆ) /
<
ÆÆ/ 0
string
ÆÆ0 6
>
ÆÆ6 7
(
ÆÆ7 8
type
ÆÆ8 <
:
ÆÆ< =
$str
ÆÆ> D
,
ÆÆD E
nullable
ÆÆF N
:
ÆÆN O
true
ÆÆP T
)
ÆÆT U
,
ÆÆU V

CreateDate
ØØ 
=
ØØ  
table
ØØ! &
.
ØØ& '
Column
ØØ' -
<
ØØ- .
DateTime
ØØ. 6
>
ØØ6 7
(
ØØ7 8
type
ØØ8 <
:
ØØ< =
$str
ØØ> X
,
ØØX Y
nullable
ØØZ b
:
ØØb c
false
ØØd i
)
ØØi j
,
ØØj k
ExpiredDate
∞∞ 
=
∞∞  !
table
∞∞" '
.
∞∞' (
Column
∞∞( .
<
∞∞. /
DateTime
∞∞/ 7
>
∞∞7 8
(
∞∞8 9
type
∞∞9 =
:
∞∞= >
$str
∞∞? Y
,
∞∞Y Z
nullable
∞∞[ c
:
∞∞c d
false
∞∞e j
)
∞∞j k
,
∞∞k l
Active
±± 
=
±± 
table
±± "
.
±±" #
Column
±±# )
<
±±) *
bool
±±* .
>
±±. /
(
±±/ 0
type
±±0 4
:
±±4 5
$str
±±6 ?
,
±±? @
nullable
±±A I
:
±±I J
false
±±K P
)
±±P Q
,
±±Q R
UserId
≤≤ 
=
≤≤ 
table
≤≤ "
.
≤≤" #
Column
≤≤# )
<
≤≤) *
int
≤≤* -
>
≤≤- .
(
≤≤. /
type
≤≤/ 3
:
≤≤3 4
$str
≤≤5 >
,
≤≤> ?
nullable
≤≤@ H
:
≤≤H I
false
≤≤J O
)
≤≤O P
}
≥≥ 
,
≥≥ 
constraints
¥¥ 
:
¥¥ 
table
¥¥ "
=>
¥¥# %
{
µµ 
table
∂∂ 
.
∂∂ 

PrimaryKey
∂∂ $
(
∂∂$ %
$str
∂∂% 0
,
∂∂0 1
x
∂∂2 3
=>
∂∂4 6
x
∂∂7 8
.
∂∂8 9
Id
∂∂9 ;
)
∂∂; <
;
∂∂< =
table
∑∑ 
.
∑∑ 

ForeignKey
∑∑ $
(
∑∑$ %
name
∏∏ 
:
∏∏ 
$str
∏∏ 6
,
∏∏6 7
column
ππ 
:
ππ 
x
ππ  !
=>
ππ" $
x
ππ% &
.
ππ& '
UserId
ππ' -
,
ππ- .
principalTable
∫∫ &
:
∫∫& '
$str
∫∫( /
,
∫∫/ 0
principalColumn
ªª '
:
ªª' (
$str
ªª) -
,
ªª- .
onDelete
ºº  
:
ºº  !
ReferentialAction
ºº" 3
.
ºº3 4
Cascade
ºº4 ;
)
ºº; <
;
ºº< =
}
ΩΩ 
)
ΩΩ 
;
ΩΩ 
migrationBuilder
øø 
.
øø 
CreateTable
øø (
(
øø( )
name
¿¿ 
:
¿¿ 
$str
¿¿  
,
¿¿  !
columns
¡¡ 
:
¡¡ 
table
¡¡ 
=>
¡¡ !
new
¡¡" %
{
¬¬ 
Id
√√ 
=
√√ 
table
√√ 
.
√√ 
Column
√√ %
<
√√% &
int
√√& )
>
√√) *
(
√√* +
type
√√+ /
:
√√/ 0
$str
√√1 :
,
√√: ;
nullable
√√< D
:
√√D E
false
√√F K
)
√√K L
.
ƒƒ 

Annotation
ƒƒ #
(
ƒƒ# $
$str
ƒƒ$ D
,
ƒƒD E+
NpgsqlValueGenerationStrategy
ƒƒF c
.
ƒƒc d%
IdentityByDefaultColumn
ƒƒd {
)
ƒƒ{ |
,
ƒƒ| }
Description
≈≈ 
=
≈≈  !
table
≈≈" '
.
≈≈' (
Column
≈≈( .
<
≈≈. /
string
≈≈/ 5
>
≈≈5 6
(
≈≈6 7
type
≈≈7 ;
:
≈≈; <
$str
≈≈= C
,
≈≈C D
nullable
≈≈E M
:
≈≈M N
true
≈≈O S
)
≈≈S T
,
≈≈T U
Value
∆∆ 
=
∆∆ 
table
∆∆ !
.
∆∆! "
Column
∆∆" (
<
∆∆( )
string
∆∆) /
>
∆∆/ 0
(
∆∆0 1
type
∆∆1 5
:
∆∆5 6
$str
∆∆7 =
,
∆∆= >
nullable
∆∆? G
:
∆∆G H
true
∆∆I M
)
∆∆M N
,
∆∆N O
Type
«« 
=
«« 
table
««  
.
««  !
Column
««! '
<
««' (
int
««( +
>
««+ ,
(
««, -
type
««- 1
:
««1 2
$str
««3 <
,
««< =
nullable
««> F
:
««F G
false
««H M
)
««M N
,
««N O
SeekerId
»» 
=
»» 
table
»» $
.
»»$ %
Column
»»% +
<
»»+ ,
int
»», /
>
»»/ 0
(
»»0 1
type
»»1 5
:
»»5 6
$str
»»7 @
,
»»@ A
nullable
»»B J
:
»»J K
false
»»L Q
)
»»Q R
,
»»R S
CreateAt
…… 
=
…… 
table
…… $
.
……$ %
Column
……% +
<
……+ ,
DateTime
……, 4
>
……4 5
(
……5 6
type
……6 :
:
……: ;
$str
……< V
,
……V W
nullable
……X `
:
……` a
false
……b g
)
……g h
,
……h i
UpdateAt
   
=
   
table
   $
.
  $ %
Column
  % +
<
  + ,
DateTime
  , 4
>
  4 5
(
  5 6
type
  6 :
:
  : ;
$str
  < V
,
  V W
nullable
  X `
:
  ` a
false
  b g
)
  g h
,
  h i
DeleteAt
ÀÀ 
=
ÀÀ 
table
ÀÀ $
.
ÀÀ$ %
Column
ÀÀ% +
<
ÀÀ+ ,
DateTime
ÀÀ, 4
>
ÀÀ4 5
(
ÀÀ5 6
type
ÀÀ6 :
:
ÀÀ: ;
$str
ÀÀ< V
,
ÀÀV W
nullable
ÀÀX `
:
ÀÀ` a
false
ÀÀb g
)
ÀÀg h
,
ÀÀh i
CreateUserId
ÃÃ  
=
ÃÃ! "
table
ÃÃ# (
.
ÃÃ( )
Column
ÃÃ) /
<
ÃÃ/ 0
int
ÃÃ0 3
>
ÃÃ3 4
(
ÃÃ4 5
type
ÃÃ5 9
:
ÃÃ9 :
$str
ÃÃ; D
,
ÃÃD E
nullable
ÃÃF N
:
ÃÃN O
false
ÃÃP U
)
ÃÃU V
,
ÃÃV W
UpdateUserId
ÕÕ  
=
ÕÕ! "
table
ÕÕ# (
.
ÕÕ( )
Column
ÕÕ) /
<
ÕÕ/ 0
int
ÕÕ0 3
>
ÕÕ3 4
(
ÕÕ4 5
type
ÕÕ5 9
:
ÕÕ9 :
$str
ÕÕ; D
,
ÕÕD E
nullable
ÕÕF N
:
ÕÕN O
false
ÕÕP U
)
ÕÕU V
,
ÕÕV W
DeleteUserId
ŒŒ  
=
ŒŒ! "
table
ŒŒ# (
.
ŒŒ( )
Column
ŒŒ) /
<
ŒŒ/ 0
int
ŒŒ0 3
>
ŒŒ3 4
(
ŒŒ4 5
type
ŒŒ5 9
:
ŒŒ9 :
$str
ŒŒ; D
,
ŒŒD E
nullable
ŒŒF N
:
ŒŒN O
false
ŒŒP U
)
ŒŒU V
}
œœ 
,
œœ 
constraints
–– 
:
–– 
table
–– "
=>
––# %
{
—— 
table
““ 
.
““ 

PrimaryKey
““ $
(
““$ %
$str
““% 2
,
““2 3
x
““4 5
=>
““6 8
x
““9 :
.
““: ;
Id
““; =
)
““= >
;
““> ?
table
”” 
.
”” 

ForeignKey
”” $
(
””$ %
name
‘‘ 
:
‘‘ 
$str
‘‘ <
,
‘‘< =
column
’’ 
:
’’ 
x
’’  !
=>
’’" $
x
’’% &
.
’’& '
SeekerId
’’' /
,
’’/ 0
principalTable
÷÷ &
:
÷÷& '
$str
÷÷( 1
,
÷÷1 2
principalColumn
◊◊ '
:
◊◊' (
$str
◊◊) -
,
◊◊- .
onDelete
ÿÿ  
:
ÿÿ  !
ReferentialAction
ÿÿ" 3
.
ÿÿ3 4
Cascade
ÿÿ4 ;
)
ÿÿ; <
;
ÿÿ< =
}
ŸŸ 
)
ŸŸ 
;
ŸŸ 
migrationBuilder
€€ 
.
€€ 
CreateTable
€€ (
(
€€( )
name
‹‹ 
:
‹‹ 
$str
‹‹  
,
‹‹  !
columns
›› 
:
›› 
table
›› 
=>
›› !
new
››" %
{
ﬁﬁ 
Id
ﬂﬂ 
=
ﬂﬂ 
table
ﬂﬂ 
.
ﬂﬂ 
Column
ﬂﬂ %
<
ﬂﬂ% &
int
ﬂﬂ& )
>
ﬂﬂ) *
(
ﬂﬂ* +
type
ﬂﬂ+ /
:
ﬂﬂ/ 0
$str
ﬂﬂ1 :
,
ﬂﬂ: ;
nullable
ﬂﬂ< D
:
ﬂﬂD E
false
ﬂﬂF K
)
ﬂﬂK L
.
‡‡ 

Annotation
‡‡ #
(
‡‡# $
$str
‡‡$ D
,
‡‡D E+
NpgsqlValueGenerationStrategy
‡‡F c
.
‡‡c d%
IdentityByDefaultColumn
‡‡d {
)
‡‡{ |
,
‡‡| }
	DirPhotos
·· 
=
·· 
table
··  %
.
··% &
Column
··& ,
<
··, -
string
··- 3
>
··3 4
(
··4 5
type
··5 9
:
··9 :
$str
··; A
,
··A B
nullable
··C K
:
··K L
true
··M Q
)
··Q R
,
··R S
	BirthDate
‚‚ 
=
‚‚ 
table
‚‚  %
.
‚‚% &
Column
‚‚& ,
<
‚‚, -
DateTime
‚‚- 5
>
‚‚5 6
(
‚‚6 7
type
‚‚7 ;
:
‚‚; <
$str
‚‚= W
,
‚‚W X
nullable
‚‚Y a
:
‚‚a b
false
‚‚c h
)
‚‚h i
,
‚‚i j
FullName
„„ 
=
„„ 
table
„„ $
.
„„$ %
Column
„„% +
<
„„+ ,
string
„„, 2
>
„„2 3
(
„„3 4
type
„„4 8
:
„„8 9
$str
„„: @
,
„„@ A
nullable
„„B J
:
„„J K
true
„„L P
)
„„P Q
,
„„Q R
Size
‰‰ 
=
‰‰ 
table
‰‰  
.
‰‰  !
Column
‰‰! '
<
‰‰' (
double
‰‰( .
>
‰‰. /
(
‰‰/ 0
type
‰‰0 4
:
‰‰4 5
$str
‰‰6 H
,
‰‰H I
nullable
‰‰J R
:
‰‰R S
false
‰‰T Y
)
‰‰Y Z
,
‰‰Z [
Description
ÂÂ 
=
ÂÂ  !
table
ÂÂ" '
.
ÂÂ' (
Column
ÂÂ( .
<
ÂÂ. /
string
ÂÂ/ 5
>
ÂÂ5 6
(
ÂÂ6 7
type
ÂÂ7 ;
:
ÂÂ; <
$str
ÂÂ= C
,
ÂÂC D
nullable
ÂÂE M
:
ÂÂM N
true
ÂÂO S
)
ÂÂS T
,
ÂÂT U
LastSeenMap
ÊÊ 
=
ÊÊ  !
table
ÊÊ" '
.
ÊÊ' (
Column
ÊÊ( .
<
ÊÊ. /
string
ÊÊ/ 5
>
ÊÊ5 6
(
ÊÊ6 7
type
ÊÊ7 ;
:
ÊÊ; <
$str
ÊÊ= C
,
ÊÊC D
nullable
ÊÊE M
:
ÊÊM N
true
ÊÊO S
)
ÊÊS T
,
ÊÊT U
Found
ÁÁ 
=
ÁÁ 
table
ÁÁ !
.
ÁÁ! "
Column
ÁÁ" (
<
ÁÁ( )
bool
ÁÁ) -
>
ÁÁ- .
(
ÁÁ. /
type
ÁÁ/ 3
:
ÁÁ3 4
$str
ÁÁ5 >
,
ÁÁ> ?
nullable
ÁÁ@ H
:
ÁÁH I
false
ÁÁJ O
)
ÁÁO P
,
ÁÁP Q
SeekerId
ËË 
=
ËË 
table
ËË $
.
ËË$ %
Column
ËË% +
<
ËË+ ,
int
ËË, /
>
ËË/ 0
(
ËË0 1
type
ËË1 5
:
ËË5 6
$str
ËË7 @
,
ËË@ A
nullable
ËËB J
:
ËËJ K
false
ËËL Q
)
ËËQ R
,
ËËR S
CreateAt
ÈÈ 
=
ÈÈ 
table
ÈÈ $
.
ÈÈ$ %
Column
ÈÈ% +
<
ÈÈ+ ,
DateTime
ÈÈ, 4
>
ÈÈ4 5
(
ÈÈ5 6
type
ÈÈ6 :
:
ÈÈ: ;
$str
ÈÈ< V
,
ÈÈV W
nullable
ÈÈX `
:
ÈÈ` a
false
ÈÈb g
)
ÈÈg h
,
ÈÈh i
UpdateAt
ÍÍ 
=
ÍÍ 
table
ÍÍ $
.
ÍÍ$ %
Column
ÍÍ% +
<
ÍÍ+ ,
DateTime
ÍÍ, 4
>
ÍÍ4 5
(
ÍÍ5 6
type
ÍÍ6 :
:
ÍÍ: ;
$str
ÍÍ< V
,
ÍÍV W
nullable
ÍÍX `
:
ÍÍ` a
false
ÍÍb g
)
ÍÍg h
,
ÍÍh i
DeleteAt
ÎÎ 
=
ÎÎ 
table
ÎÎ $
.
ÎÎ$ %
Column
ÎÎ% +
<
ÎÎ+ ,
DateTime
ÎÎ, 4
>
ÎÎ4 5
(
ÎÎ5 6
type
ÎÎ6 :
:
ÎÎ: ;
$str
ÎÎ< V
,
ÎÎV W
nullable
ÎÎX `
:
ÎÎ` a
false
ÎÎb g
)
ÎÎg h
,
ÎÎh i
CreateUserId
ÏÏ  
=
ÏÏ! "
table
ÏÏ# (
.
ÏÏ( )
Column
ÏÏ) /
<
ÏÏ/ 0
int
ÏÏ0 3
>
ÏÏ3 4
(
ÏÏ4 5
type
ÏÏ5 9
:
ÏÏ9 :
$str
ÏÏ; D
,
ÏÏD E
nullable
ÏÏF N
:
ÏÏN O
false
ÏÏP U
)
ÏÏU V
,
ÏÏV W
UpdateUserId
ÌÌ  
=
ÌÌ! "
table
ÌÌ# (
.
ÌÌ( )
Column
ÌÌ) /
<
ÌÌ/ 0
int
ÌÌ0 3
>
ÌÌ3 4
(
ÌÌ4 5
type
ÌÌ5 9
:
ÌÌ9 :
$str
ÌÌ; D
,
ÌÌD E
nullable
ÌÌF N
:
ÌÌN O
false
ÌÌP U
)
ÌÌU V
,
ÌÌV W
DeleteUserId
ÓÓ  
=
ÓÓ! "
table
ÓÓ# (
.
ÓÓ( )
Column
ÓÓ) /
<
ÓÓ/ 0
int
ÓÓ0 3
>
ÓÓ3 4
(
ÓÓ4 5
type
ÓÓ5 9
:
ÓÓ9 :
$str
ÓÓ; D
,
ÓÓD E
nullable
ÓÓF N
:
ÓÓN O
false
ÓÓP U
)
ÓÓU V
}
ÔÔ 
,
ÔÔ 
constraints
 
:
 
table
 "
=>
# %
{
ÒÒ 
table
ÚÚ 
.
ÚÚ 

PrimaryKey
ÚÚ $
(
ÚÚ$ %
$str
ÚÚ% 2
,
ÚÚ2 3
x
ÚÚ4 5
=>
ÚÚ6 8
x
ÚÚ9 :
.
ÚÚ: ;
Id
ÚÚ; =
)
ÚÚ= >
;
ÚÚ> ?
table
ÛÛ 
.
ÛÛ 

ForeignKey
ÛÛ $
(
ÛÛ$ %
name
ÙÙ 
:
ÙÙ 
$str
ÙÙ <
,
ÙÙ< =
column
ıı 
:
ıı 
x
ıı  !
=>
ıı" $
x
ıı% &
.
ıı& '
SeekerId
ıı' /
,
ıı/ 0
principalTable
ˆˆ &
:
ˆˆ& '
$str
ˆˆ( 1
,
ˆˆ1 2
principalColumn
˜˜ '
:
˜˜' (
$str
˜˜) -
,
˜˜- .
onDelete
¯¯  
:
¯¯  !
ReferentialAction
¯¯" 3
.
¯¯3 4
Cascade
¯¯4 ;
)
¯¯; <
;
¯¯< =
}
˘˘ 
)
˘˘ 
;
˘˘ 
migrationBuilder
˚˚ 
.
˚˚ 
CreateTable
˚˚ (
(
˚˚( )
name
¸¸ 
:
¸¸ 
$str
¸¸ #
,
¸¸# $
columns
˝˝ 
:
˝˝ 
table
˝˝ 
=>
˝˝ !
new
˝˝" %
{
˛˛ 
Id
ˇˇ 
=
ˇˇ 
table
ˇˇ 
.
ˇˇ 
Column
ˇˇ %
<
ˇˇ% &
int
ˇˇ& )
>
ˇˇ) *
(
ˇˇ* +
type
ˇˇ+ /
:
ˇˇ/ 0
$str
ˇˇ1 :
,
ˇˇ: ;
nullable
ˇˇ< D
:
ˇˇD E
false
ˇˇF K
)
ˇˇK L
.
ÄÄ 

Annotation
ÄÄ #
(
ÄÄ# $
$str
ÄÄ$ D
,
ÄÄD E+
NpgsqlValueGenerationStrategy
ÄÄF c
.
ÄÄc d%
IdentityByDefaultColumn
ÄÄd {
)
ÄÄ{ |
,
ÄÄ| }
	InitVideo
ÅÅ 
=
ÅÅ 
table
ÅÅ  %
.
ÅÅ% &
Column
ÅÅ& ,
<
ÅÅ, -
TimeOnly
ÅÅ- 5
>
ÅÅ5 6
(
ÅÅ6 7
type
ÅÅ7 ;
:
ÅÅ; <
$str
ÅÅ= U
,
ÅÅU V
nullable
ÅÅW _
:
ÅÅ_ `
false
ÅÅa f
)
ÅÅf g
,
ÅÅg h
EndVideo
ÇÇ 
=
ÇÇ 
table
ÇÇ $
.
ÇÇ$ %
Column
ÇÇ% +
<
ÇÇ+ ,
TimeOnly
ÇÇ, 4
>
ÇÇ4 5
(
ÇÇ5 6
type
ÇÇ6 :
:
ÇÇ: ;
$str
ÇÇ< T
,
ÇÇT U
nullable
ÇÇV ^
:
ÇÇ^ _
false
ÇÇ` e
)
ÇÇe f
,
ÇÇf g
Date
ÉÉ 
=
ÉÉ 
table
ÉÉ  
.
ÉÉ  !
Column
ÉÉ! '
<
ÉÉ' (
DateOnly
ÉÉ( 0
>
ÉÉ0 1
(
ÉÉ1 2
type
ÉÉ2 6
:
ÉÉ6 7
$str
ÉÉ8 >
,
ÉÉ> ?
nullable
ÉÉ@ H
:
ÉÉH I
false
ÉÉJ O
)
ÉÉO P
,
ÉÉP Q
CameraId
ÑÑ 
=
ÑÑ 
table
ÑÑ $
.
ÑÑ$ %
Column
ÑÑ% +
<
ÑÑ+ ,
int
ÑÑ, /
>
ÑÑ/ 0
(
ÑÑ0 1
type
ÑÑ1 5
:
ÑÑ5 6
$str
ÑÑ7 @
,
ÑÑ@ A
nullable
ÑÑB J
:
ÑÑJ K
false
ÑÑL Q
)
ÑÑQ R
,
ÑÑR S
	MissingId
ÖÖ 
=
ÖÖ 
table
ÖÖ  %
.
ÖÖ% &
Column
ÖÖ& ,
<
ÖÖ, -
int
ÖÖ- 0
>
ÖÖ0 1
(
ÖÖ1 2
type
ÖÖ2 6
:
ÖÖ6 7
$str
ÖÖ8 A
,
ÖÖA B
nullable
ÖÖC K
:
ÖÖK L
false
ÖÖM R
)
ÖÖR S
,
ÖÖS T
CreateAt
ÜÜ 
=
ÜÜ 
table
ÜÜ $
.
ÜÜ$ %
Column
ÜÜ% +
<
ÜÜ+ ,
DateTime
ÜÜ, 4
>
ÜÜ4 5
(
ÜÜ5 6
type
ÜÜ6 :
:
ÜÜ: ;
$str
ÜÜ< V
,
ÜÜV W
nullable
ÜÜX `
:
ÜÜ` a
false
ÜÜb g
)
ÜÜg h
,
ÜÜh i
UpdateAt
áá 
=
áá 
table
áá $
.
áá$ %
Column
áá% +
<
áá+ ,
DateTime
áá, 4
>
áá4 5
(
áá5 6
type
áá6 :
:
áá: ;
$str
áá< V
,
ááV W
nullable
ááX `
:
áá` a
false
ááb g
)
áág h
,
ááh i
DeleteAt
àà 
=
àà 
table
àà $
.
àà$ %
Column
àà% +
<
àà+ ,
DateTime
àà, 4
>
àà4 5
(
àà5 6
type
àà6 :
:
àà: ;
$str
àà< V
,
ààV W
nullable
ààX `
:
àà` a
false
ààb g
)
ààg h
,
ààh i
CreateUserId
ââ  
=
ââ! "
table
ââ# (
.
ââ( )
Column
ââ) /
<
ââ/ 0
int
ââ0 3
>
ââ3 4
(
ââ4 5
type
ââ5 9
:
ââ9 :
$str
ââ; D
,
ââD E
nullable
ââF N
:
ââN O
false
ââP U
)
ââU V
,
ââV W
UpdateUserId
ää  
=
ää! "
table
ää# (
.
ää( )
Column
ää) /
<
ää/ 0
int
ää0 3
>
ää3 4
(
ää4 5
type
ää5 9
:
ää9 :
$str
ää; D
,
ääD E
nullable
ääF N
:
ääN O
false
ääP U
)
ääU V
,
ääV W
DeleteUserId
ãã  
=
ãã! "
table
ãã# (
.
ãã( )
Column
ãã) /
<
ãã/ 0
int
ãã0 3
>
ãã3 4
(
ãã4 5
type
ãã5 9
:
ãã9 :
$str
ãã; D
,
ããD E
nullable
ããF N
:
ããN O
false
ããP U
)
ããU V
}
åå 
,
åå 
constraints
çç 
:
çç 
table
çç "
=>
çç# %
{
éé 
table
èè 
.
èè 

PrimaryKey
èè $
(
èè$ %
$str
èè% 5
,
èè5 6
x
èè7 8
=>
èè9 ;
x
èè< =
.
èè= >
Id
èè> @
)
èè@ A
;
èèA B
table
êê 
.
êê 

ForeignKey
êê $
(
êê$ %
name
ëë 
:
ëë 
$str
ëë ?
,
ëë? @
column
íí 
:
íí 
x
íí  !
=>
íí" $
x
íí% &
.
íí& '
CameraId
íí' /
,
íí/ 0
principalTable
ìì &
:
ìì& '
$str
ìì( 1
,
ìì1 2
principalColumn
îî '
:
îî' (
$str
îî) -
,
îî- .
onDelete
ïï  
:
ïï  !
ReferentialAction
ïï" 3
.
ïï3 4
Cascade
ïï4 ;
)
ïï; <
;
ïï< =
table
ññ 
.
ññ 

ForeignKey
ññ $
(
ññ$ %
name
óó 
:
óó 
$str
óó A
,
óóA B
column
òò 
:
òò 
x
òò  !
=>
òò" $
x
òò% &
.
òò& '
	MissingId
òò' 0
,
òò0 1
principalTable
ôô &
:
ôô& '
$str
ôô( 2
,
ôô2 3
principalColumn
öö '
:
öö' (
$str
öö) -
,
öö- .
onDelete
õõ  
:
õõ  !
ReferentialAction
õõ" 3
.
õõ3 4
Cascade
õõ4 ;
)
õõ; <
;
õõ< =
}
úú 
)
úú 
;
úú 
migrationBuilder
ûû 
.
ûû 
CreateIndex
ûû (
(
ûû( )
name
üü 
:
üü 
$str
üü (
,
üü( )
table
†† 
:
†† 
$str
†† 
,
††  
column
°° 
:
°° 
$str
°°  
,
°°  !
unique
¢¢ 
:
¢¢ 
true
¢¢ 
)
¢¢ 
;
¢¢ 
migrationBuilder
§§ 
.
§§ 
CreateIndex
§§ (
(
§§( )
name
•• 
:
•• 
$str
•• ,
,
••, -
table
¶¶ 
:
¶¶ 
$str
¶¶ !
,
¶¶! "
column
ßß 
:
ßß 
$str
ßß "
)
ßß" #
;
ßß# $
migrationBuilder
©© 
.
©© 
CreateIndex
©© (
(
©©( )
name
™™ 
:
™™ 
$str
™™ /
,
™™/ 0
table
´´ 
:
´´ 
$str
´´ $
,
´´$ %
column
¨¨ 
:
¨¨ 
$str
¨¨ "
)
¨¨" #
;
¨¨# $
migrationBuilder
ÆÆ 
.
ÆÆ 
CreateIndex
ÆÆ (
(
ÆÆ( )
name
ØØ 
:
ØØ 
$str
ØØ 0
,
ØØ0 1
table
∞∞ 
:
∞∞ 
$str
∞∞ $
,
∞∞$ %
column
±± 
:
±± 
$str
±± #
)
±±# $
;
±±$ %
migrationBuilder
≥≥ 
.
≥≥ 
CreateIndex
≥≥ (
(
≥≥( )
name
¥¥ 
:
¥¥ 
$str
¥¥ ,
,
¥¥, -
table
µµ 
:
µµ 
$str
µµ !
,
µµ! "
column
∂∂ 
:
∂∂ 
$str
∂∂ "
)
∂∂" #
;
∂∂# $
migrationBuilder
∏∏ 
.
∏∏ 
CreateIndex
∏∏ (
(
∏∏( )
name
ππ 
:
ππ 
$str
ππ /
,
ππ/ 0
table
∫∫ 
:
∫∫ 
$str
∫∫ &
,
∫∫& '
column
ªª 
:
ªª 
$str
ªª  
)
ªª  !
;
ªª! "
migrationBuilder
ΩΩ 
.
ΩΩ 
CreateIndex
ΩΩ (
(
ΩΩ( )
name
ææ 
:
ææ 
$str
ææ )
,
ææ) *
table
øø 
:
øø 
$str
øø  
,
øø  !
column
¿¿ 
:
¿¿ 
$str
¿¿  
,
¿¿  !
unique
¡¡ 
:
¡¡ 
true
¡¡ 
)
¡¡ 
;
¡¡ 
migrationBuilder
√√ 
.
√√ 
CreateIndex
√√ (
(
√√( )
name
ƒƒ 
:
ƒƒ 
$str
ƒƒ (
,
ƒƒ( )
table
≈≈ 
:
≈≈ 
$str
≈≈ 
,
≈≈  
column
∆∆ 
:
∆∆ 
$str
∆∆  
)
∆∆  !
;
∆∆! "
migrationBuilder
»» 
.
»» 
CreateIndex
»» (
(
»»( )
name
…… 
:
…… 
$str
…… &
,
……& '
table
   
:
   
$str
   
,
   
column
ÀÀ 
:
ÀÀ 
$str
ÀÀ 
,
ÀÀ  
unique
ÃÃ 
:
ÃÃ 
true
ÃÃ 
)
ÃÃ 
;
ÃÃ 
migrationBuilder
ŒŒ 
.
ŒŒ 
CreateIndex
ŒŒ (
(
ŒŒ( )
name
œœ 
:
œœ 
$str
œœ %
,
œœ% &
table
–– 
:
–– 
$str
–– 
,
–– 
column
—— 
:
—— 
$str
—— 
,
—— 
unique
““ 
:
““ 
true
““ 
)
““ 
;
““ 
migrationBuilder
‘‘ 
.
‘‘ 
CreateIndex
‘‘ (
(
‘‘( )
name
’’ 
:
’’ 
$str
’’ +
,
’’+ ,
table
÷÷ 
:
÷÷ 
$str
÷÷ 
,
÷÷ 
column
◊◊ 
:
◊◊ 
$str
◊◊ $
,
◊◊$ %
unique
ÿÿ 
:
ÿÿ 
true
ÿÿ 
)
ÿÿ 
;
ÿÿ 
}
ŸŸ 	
	protected
‹‹ 
override
‹‹ 
void
‹‹ 
Down
‹‹  $
(
‹‹$ %
MigrationBuilder
‹‹% 5
migrationBuilder
‹‹6 F
)
‹‹F G
{
›› 	
migrationBuilder
ﬁﬁ 
.
ﬁﬁ 
	DropTable
ﬁﬁ &
(
ﬁﬁ& '
name
ﬂﬂ 
:
ﬂﬂ 
$str
ﬂﬂ 
)
ﬂﬂ 
;
ﬂﬂ  
migrationBuilder
·· 
.
·· 
	DropTable
·· &
(
··& '
name
‚‚ 
:
‚‚ 
$str
‚‚  
)
‚‚  !
;
‚‚! "
migrationBuilder
‰‰ 
.
‰‰ 
	DropTable
‰‰ &
(
‰‰& '
name
ÂÂ 
:
ÂÂ 
$str
ÂÂ #
)
ÂÂ# $
;
ÂÂ$ %
migrationBuilder
ÁÁ 
.
ÁÁ 
	DropTable
ÁÁ &
(
ÁÁ& '
name
ËË 
:
ËË 
$str
ËË %
)
ËË% &
;
ËË& '
migrationBuilder
ÍÍ 
.
ÍÍ 
	DropTable
ÍÍ &
(
ÍÍ& '
name
ÎÎ 
:
ÎÎ 
$str
ÎÎ 
)
ÎÎ 
;
ÎÎ  
migrationBuilder
ÌÌ 
.
ÌÌ 
	DropTable
ÌÌ &
(
ÌÌ& '
name
ÓÓ 
:
ÓÓ 
$str
ÓÓ 
)
ÓÓ  
;
ÓÓ  !
migrationBuilder
 
.
 
	DropTable
 &
(
& '
name
ÒÒ 
:
ÒÒ 
$str
ÒÒ  
)
ÒÒ  !
;
ÒÒ! "
migrationBuilder
ÛÛ 
.
ÛÛ 
	DropTable
ÛÛ &
(
ÛÛ& '
name
ÙÙ 
:
ÙÙ 
$str
ÙÙ 
)
ÙÙ  
;
ÙÙ  !
migrationBuilder
ˆˆ 
.
ˆˆ 
	DropTable
ˆˆ &
(
ˆˆ& '
name
˜˜ 
:
˜˜ 
$str
˜˜ 
)
˜˜ 
;
˜˜ 
migrationBuilder
˘˘ 
.
˘˘ 
	DropTable
˘˘ &
(
˘˘& '
name
˙˙ 
:
˙˙ 
$str
˙˙ !
)
˙˙! "
;
˙˙" #
}
˚˚ 	
}
¸¸ 
}˝˝ á
_C:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Helpers\CloudinarySettings.cs
	namespace 	
WebCamServer
 
. 
Helpers 
{ 
public 
class	 
CloudinarySettings !
{ 
public 

string 
	CloudName 
{ 
get !
;! "
set# &
;& '
}( )
public 

string 
ApiKey 
{ 
get 
; 
set  #
;# $
}% &
public 

string 
	ApiSecret 
{ 
get !
;! "
set# &
;& '
}( )
} 
}		 ˇ
_C:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Helpers\AutoMapperProfiles.cs
	namespace 	
WebCamServer
 
. 
Helpers 
{ 
public 
class	 
AutoMapperProfiles !
:" #
Profile$ +
{		 
public

 

AutoMapperProfiles

 
(

 
)

 
{ 
	CreateMap 
< 
UserToCreateDto 
,  
User! %
>% &
(& '
)' (
;( )
	CreateMap 
< 
User 
, 
UserDto 
> 
( 
)  
;  !
} 
} 
} œ

QC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Dtos\UserDto.cs
	namespace 	
WebCamServer
 
. 
Dtos 
{ 
public 
class	 
UserDto 
{ 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
public 

string 
	FirstName 
{ 
get !
;! "
set# &
;& '
}( )
public 

string 
DadLastName 
{ 
get  #
;# $
set% (
;( )
}* +
public 

string 
MomLastName 
{ 
get  #
;# $
set% (
;( )
}* +
public		 

int		 
Age		 
{		 
get		 
;		 
set		 
;		 
}		  
public

 

string

 
Email

 
{

 
get

 
;

 
set

 "
;

" #
}

$ %
public 

string 
City 
{ 
get 
; 
set !
;! "
}# $
} 
} ö3
QC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Dtos\AuthDto.cs
	namespace 	
WebCamServer
 
. 
Dtos 
{ 
public 
class	 
UserToRegisterDto  
{ 
public 

string 
Name 
{ 
get 
; 
set  
;  !
}! "
public		 

string		 
Email		 
{		 
get		 
;		 
set		 "
;		" #
}		$ %
public

 

string

 
Password

 
{

 
get

  
;

  !
set

" %
;

% &
}

' (
public 

Guid 
PasswordSalt 
{ 
get "
;" #
set$ '
;' (
}) *
public 

string 
	FirstName 
{ 
get  
;  !
set" %
;% &
}& '
public 

string 
MomLastName 
{ 
get "
;" #
set$ '
;' (
}( )
public 

string 
DadLastName 
{ 
get "
;" #
set$ '
;' (
}( )
public 

int 
Age 
{ 
get 
; 
set 
; 
} 
public 

string 
City 
{ 
get 
; 
set  
;  !
}! "
public 

DateTime 

CreateDate 
{  
get  #
;# $
set% (
;( )
}* +
public 

UserToRegisterDto 
( 
) 
{ 

CreateDate 
= 
DateTime 
. 
UtcNow "
;" #
} 
} 
public 
class	 
UserToCreateDto 
{ 
public 

string 
Name 
{ 
get 
; 
set  
;  !
}! "
public 

string 
Email 
{ 
get 
; 
set "
;" #
}$ %
public 

string 
Password 
{ 
get  
;  !
set" %
;% &
}' (
public 

string 
	FirstName 
{ 
get  
;  !
set" %
;% &
}& '
public 

string 
MomLastName 
{ 
get "
;" #
set$ '
;' (
}( )
public   

string   
DadLastName   
{   
get   "
;  " #
set  $ '
;  ' (
}  ( )
public!! 

int!! 
Age!! 
{!! 
get!! 
;!! 
set!! 
;!! 
}!! 
public"" 

string"" 
City"" 
{"" 
get"" 
;"" 
set""  
;""  !
}""! "
public## 

string## 
Ci## 
{## 
get## 
;## 
set## 
;## 
}##  
public$$ 

string$$ 
GoogleId$$ 
{$$ 
get$$  
;$$  !
set$$" %
;$$% &
}$$' (
public%% 

string%% 

FacebookId%% 
{%% 
get%% "
;%%" #
set%%$ '
;%%' (
}%%) *
public&& 

string&& 
	TwitterId&& 
{&& 
get&& !
;&&! "
set&&# &
;&&& '
}&&( )
}'' 
public(( 
class((	 
AuthRequestDto(( 
{)) 
public** 

string** 
NameOrGmail** 
{** 
get** "
;**" #
set**$ '
;**' (
}**( )
public++ 

string++ 
Password++ 
{++ 
get++ 
;++  
set++! $
;++$ %
}++% &
},, 
public-- 
class--	  
AuthGoogleRequestDto-- #
{.. 
public// 

string// 
GoogleId// 
{// 
get// 
;//  
set//! $
;//$ %
}//% &
}00 
public11 
class11	 

AuthJwtDto11 
{22 
public33 

string33 
Key33 
{33 
get33 
;33 
set33  
;33  !
}33" #
public44 

string44 
Issuer44 
{44 
get44 
;44 
set44  #
;44# $
}44% &
public55 

string55 
Audience55 
{55 
get55  
;55  !
set55" %
;55% &
}55' (
public66 

string66 
Subject66 
{66 
get66 
;66  
set66! $
;66$ %
}66& '
public77 

int77 
TimeValidMin77 
{77 
get77  
;77  !
set77" %
;77% &
}77& '
}88 
public99 
class99	 &
AuthRefreshTokenRequestDto99 )
{:: 
public;; 

string;; 
TokenExpired;; 
{;;  
get;;  #
;;;# $
set;;% (
;;;( )
};;) *
public<< 

string<< 
RefreshToken<< 
{<<  
get<<  #
;<<# $
set<<% (
;<<( )
}<<) *
}== 
public>> 
class>>	 
AuthResponseDto>> 
{?? 
public@@ 

User@@ 
User@@ 
{@@ 
get@@ 
;@@ 
set@@ 
;@@ 
}@@  
publicAA 

stringAA 
CurrentTokenAA 
{AA  
getAA  #
;AA# $
setAA% (
;AA( )
}AA) *
publicBB 

stringBB 
RefreshTokenBB 
{BB  
getBB  #
;BB# $
setBB% (
;BB( )
}BB) *
}CC 
}DD Ωe
YC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Database\DataContext.cs
	namespace 	
usr_service
 
. 
Data 
{ 
public 
class	 
DataContext 
: 
	DbContext &
{		 
public

 

DataContext

 
(

 
DbContextOptions

 '
<

' (
DataContext

( 3
>

3 4
options

5 <
)

< =
:

> ?
base

@ D
(

D E
options

E L
)

L M
{

N O
}

P Q
public 

DbSet 
< 
User 
> 
Users 
{ 
get "
;" #
set$ '
;' (
}) *
public 

DbSet 
< 
UserInfo 
> 
	UserInfos $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 

DbSet 
< 
Admin 
> 
Admins 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

DbSet 
< 
Seeker 
> 
Seekers  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

DbSet 
< 
Token 
> 
Tokens 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

DbSet 
< 
Contacts 
> 
Contacts #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 

DbSet 
< 
Camera 
> 
Cameras  
{! "
get" %
;% &
set' *
;* +
}+ ,
public 

DbSet 
< 

FoundVideo 
> 
FoundVideos (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
public 

DbSet 
< 
Notification 
> 
Notifications ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
public 

DbSet 
< 
Missing 
> 
Missings "
{# $
get% (
;( )
set* -
;- .
}/ 0
	protected 
override 
void 
OnModelCreating +
(+ ,
ModelBuilder, 8
modelBuilder9 E
)E F
{ 
modelBuilder 
. 
Entity 
< 
User 
> 
(  
ur  "
=># %
{& '
ur 

.
 
HasKey 
( 
u 
=> 
u 
. 
Id 
) 
; 
ur 

.
 
HasIndex 
( 
u 
=> 
u 
. 
Name 
)  
.  
 
IsUnique   
(   
)   
;   
ur"" 

.""
 
HasIndex"" 
("" 
u"" 
=>"" 
u"" 
."" 
Email""  
)""  !
.##
 
IsUnique## 
(## 
)## 
;## 
ur%% 

.%%
 
HasOne%% 
(%% 
p%% 
=>%% 
p%% 
.%% 
UserInfo%% "
)%%" #
.&&
 
WithOne&& 
(&& 
p&& 
=>&& 
p&& 
.&& 
User&& 
)&&  
.''
 
HasForeignKey'' 
<'' 
User'' 
>'' 
('' 
p''  !
=>''" $
p''% &
.''& '

UserInfoId''' 1
)''1 2
;''2 3
})) 
))) 
;)) 	
modelBuilder++ 
.++ 
Entity++ 
<++ 
UserInfo++ "
>++" #
(++# $
tb++$ &
=>++' )
{++* +
tb,, 

.,,
 
HasKey,, 
(,, 
p,, 
=>,, 
p,, 
.,, 
Id,, 
),, 
;,, 
}// 
)// 
;// 	
modelBuilder11 
.11 
Entity11 
<11 
Admin11 
>11  
(11  !
tb11! #
=>11$ &
{11' (
tb22 

.22
 
HasKey22 
(22 
p22 
=>22 
p22 
.22 
Id22 
)22 
;22 
tb44 

.44
 
HasOne44 
(44 
p44 
=>44 
p44 
.44 
User44 
)44 
.55
 
WithOne55 
(55 
p55 
=>55 
p55 
.55 
Admin55  
)55  !
.66
 
HasForeignKey66 
<66 
Admin66 
>66 
(66  
p66! "
=>66# %
p66& '
.66' (
UserId66( .
)66. /
;66/ 0
}88 
)88 
;88 	
modelBuilder:: 
.:: 
Entity:: 
<:: 
Seeker::  
>::  !
(::! "
tb::" $
=>::% '
{::( )
tb;; 

.;;
 
HasKey;; 
(;; 
p;; 
=>;; 
p;; 
.;; 
Id;; 
);; 
;;; 
tb== 

.==
 
HasOne== 
(== 
p== 
=>== 
p== 
.== 
User== 
)== 
.>>
 
WithOne>> 
(>> 
p>> 
=>>> 
p>> 
.>> 
Seeker>> !
)>>! "
.??
 
HasForeignKey?? 
<?? 
Seeker?? 
>??  
(??  !
p??" #
=>??$ &
p??' (
.??( )
UserId??) /
)??/ 0
;??0 1
}AA 
)AA 
;AA 	
modelBuilderCC 
.CC 
EntityCC 
<CC 
TokenCC 
>CC  
(CC  !
tbCC! #
=>CC$ &
{CC' (
tbDD 

.DD
 
HasKeyDD 
(DD 
pDD 
=>DD 
pDD 
.DD 
IdDD 
)DD 
;DD 
tbFF 

.FF
 
HasOneFF 
(FF 
pFF 
=>FF 
pFF 
.FF 
UserFF 
)FF 
.GG
 
WithManyGG 
(GG 
pGG 
=>GG 
pGG 
.GG 
TokensGG "
)GG" #
.HH
 
HasForeignKeyHH 
(HH 
pHH 
=>HH 
pHH  
.HH  !
UserIdHH! '
)HH' (
.II
 

IsRequiredII 
(II 
)II 
;II 
}JJ 
)JJ 
;JJ 	
modelBuilderLL 
.LL 
EntityLL 
<LL 
ContactsLL "
>LL" #
(LL# $
tbLL$ &
=>LL' )
{LL* +
tbMM 

.MM
 
HasKeyMM 
(MM 
pMM 
=>MM 
pMM 
.MM 
IdMM 
)MM 
;MM 
tbOO 

.OO
 
HasOneOO 
(OO 
pOO 
=>OO 
pOO 
.OO 
SeekerOO  
)OO  !
.PP
 
WithManyPP 
(PP 
pPP 
=>PP 
pPP 
.PP 
ContactsPP $
)PP$ %
.QQ
 
HasForeignKeyQQ 
(QQ 
pQQ 
=>QQ 
pQQ  
.QQ  !
SeekerIdQQ! )
)QQ) *
.RR
 

IsRequiredRR 
(RR 
)RR 
;RR 
}SS 
)SS 
;SS 	
modelBuilderVV 
.VV 
EntityVV 
<VV 
CameraVV  
>VV  !
(VV! "
tbVV" $
=>VV% '
{VV( )
tbWW 

.WW
 
HasKeyWW 
(WW 
pWW 
=>WW 
pWW 
.WW 
IdWW 
)WW 
;WW 
}XX 
)XX 
;XX 	
modelBuilderZZ 
.ZZ 
EntityZZ 
<ZZ 

FoundVideoZZ $
>ZZ$ %
(ZZ% &
tbZZ& (
=>ZZ) +
{ZZ, -
tb[[ 

.[[
 
HasKey[[ 
([[ 
p[[ 
=>[[ 
p[[ 
.[[ 
Id[[ 
)[[ 
;[[ 
tb]] 

.]]
 
HasOne]] 
(]] 
p]] 
=>]] 
p]] 
.]] 
Camera]]  
)]]  !
.^^
 
WithMany^^ 
(^^ 
p^^ 
=>^^ 
p^^ 
.^^ 
FoundVideos^^ '
)^^' (
.__
 
HasForeignKey__ 
(__ 
p__ 
=>__ 
p__  
.__  !
CameraId__! )
)__) *
.``
 

IsRequired`` 
(`` 
)`` 
;`` 
tbbb 

.bb
 
HasOnebb 
(bb 
pbb 
=>bb 
pbb 
.bb 
Missingbb !
)bb! "
.cc
 
WithManycc 
(cc 
pcc 
=>cc 
pcc 
.cc 
FoundVideoscc '
)cc' (
.dd
 
HasForeignKeydd 
(dd 
pdd 
=>dd 
pdd  
.dd  !
	MissingIddd! *
)dd* +
.ee
 

IsRequiredee 
(ee 
)ee 
;ee 
}ff 
)ff 
;ff 	
modelBuilderhh 
.hh 
Entityhh 
<hh 
Notificationhh &
>hh& '
(hh' (
tbhh( *
=>hh+ -
{hh. /
tbii 

.ii
 
HasKeyii 
(ii 
pii 
=>ii 
pii 
.ii 
Idii 
)ii 
;ii 
tbkk 

.kk
 
HasOnekk 
(kk 
pkk 
=>kk 
pkk 
.kk 
Userkk 
)kk 
.ll
 
WithManyll 
(ll 
pll 
=>ll 
pll 
.ll 
Notificationsll )
)ll) *
.mm
 
HasForeignKeymm 
(mm 
pmm 
=>mm 
pmm  
.mm  !
UserIdmm! '
)mm' (
.nn
 

IsRequirednn 
(nn 
)nn 
;nn 
tbpp 

.pp
 
Propertypp 
(pp 
ppp 
=>pp 
ppp 
.pp 
Titlepp !
)pp! "
.qq
 

IsRequiredqq 
(qq 
)qq 
;qq 
tbss 

.ss
 
Propertyss 
(ss 
pss 
=>ss 
pss 
.ss 
Typess  
)ss  !
.tt
 

IsRequiredtt 
(tt 
)tt 
;tt 
tbvv 

.vv
 
Propertyvv 
(vv 
pvv 
=>vv 
pvv 
.vv 
Descriptionvv '
)vv' (
.ww
 

IsRequiredww 
(ww 
falseww 
)ww 
;ww 
}xx 
)xx 
;xx 	
modelBuilder{{ 
.{{ 
Entity{{ 
<{{ 
Missing{{ !
>{{! "
({{" #
tb{{# %
=>{{& (
{{{) *
tb|| 

.||
 
HasKey|| 
(|| 
p|| 
=>|| 
p|| 
.|| 
Id|| 
)|| 
;|| 
tb~~ 

.~~
 
HasOne~~ 
(~~ 
p~~ 
=>~~ 
p~~ 
.~~ 
Seeker~~  
)~~  !
.
 
WithMany 
( 
p 
=> 
p 
. 
Missings $
)$ %
.
ÄÄ
 
HasForeignKey
ÄÄ 
(
ÄÄ 
p
ÄÄ 
=>
ÄÄ 
p
ÄÄ  
.
ÄÄ  !
SeekerId
ÄÄ! )
)
ÄÄ) *
.
ÅÅ
 

IsRequired
ÅÅ 
(
ÅÅ 
)
ÅÅ 
;
ÅÅ 
}
ÇÇ 
)
ÇÇ 
;
ÇÇ 	
}
ÑÑ 
}
ÖÖ 
}ÜÜ û
_C:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Controllers\UserController.cs
	namespace 	
WebCamServer
 
. 
Controllers "
{ 
[ 
Route 
( 	
$str	 
) 
] 
[		 
ApiController		 
]		 
public

 
class

	 
UserController

 
:

 
ControllerBase

  .
{ 
private 
readonly 
IAuthService !
_authService" .
;. /
private 
readonly 
IUserService !
_service" *
;* +
private 
readonly 
ILogger 
< 
UserController +
>+ ,
_logger- 4
;4 5
public 

UserController 
( 
IAuthService &
authService' 2
,2 3
ILogger4 ;
<; <
UserController< J
>J K
loggerL R
,R S
IUserServiceT `
servicea h
)h i
{ 
_authService 
= 
authService  
;  !
_logger 
= 
logger 
; 
_service 
= 
service 
; 
} 
}cc 
}dd π
aC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Controllers\StreamController.cs
[ 
Route 
( 
$str 
) 
] 
[ 
ApiController 
] 
public 
class 
StreamController 
: 
ControllerBase  .
{ 
private		 	
readonly		
 
ICameraService		 !
_camServ		" *
;		* +
private

 	
readonly


 
IControlsService

 #
_conServ

$ ,
;

, -
public 
StreamController	 
( 
ICameraService (
camServ) 0
,0 1
IControlsService2 B
conServC J
)J K
{ 
_camServ 
= 
camServ 
; 
_conServ 
= 
conServ 
; 
} 
[ 
HttpGet 

(
 
$str 
) 
] 
public 
async	 
Task 
WsEsp32Camera !
(! "
)" #
{ 
if 
( 
HttpContext 
. 

WebSockets 
. 
IsWebSocketRequest 1
)1 2
{ 
	WebSocket 
	webSocket 
= 
await !
HttpContext" -
.- .

WebSockets. 8
.8 9 
AcceptWebSocketAsync9 M
(M N
)N O
;O P
await 
_camServ 
. 
Esp32CamConnection '
(' (
	webSocket( 1
)1 2
;2 3
} 
else 
{ 
HttpContext 
. 
Response 
. 

StatusCode %
=& '
$num( +
;+ ,
} 
} 
[   
HttpGet   

(  
 
$str   
)   
]   
public!! 
async!!	 
Task!! 
WsWatchCamera!! !
(!!! "
)!!" #
{"" 
if## 
(## 
HttpContext## 
.## 

WebSockets## 
.## 
IsWebSocketRequest## 1
)##1 2
{$$ 
	WebSocket%% 
	webSocket%% 
=%% 
await%% !
HttpContext%%" -
.%%- .

WebSockets%%. 8
.%%8 9 
AcceptWebSocketAsync%%9 M
(%%M N
)%%N O
;%%O P
await&& 
_camServ&& 
.&& 
WatchCamera&&  
(&&  !
	webSocket&&! *
)&&* +
;&&+ ,
}'' 
else(( 
{)) 
HttpContext** 
.** 
Response** 
.** 

StatusCode** %
=**& '
$num**( +
;**+ ,
}++ 
},, 
[.. 
HttpGet.. 

(..
 
$str.. 
).. 
].. 
public// 
async//	 
Task// 

WsControls// 
(// 
)//  
{00 
if11 
(11 
HttpContext11 
.11 

WebSockets11 
.11 
IsWebSocketRequest11 1
)111 2
{22 
	WebSocket33 
	webSocket33 
=33 
await33 !
HttpContext33" -
.33- .

WebSockets33. 8
.338 9 
AcceptWebSocketAsync339 M
(33M N
)33N O
;33O P
await44 
_conServ44 
.44 
ControlsOfCamera44 %
(44% &
	webSocket44& /
)44/ 0
;440 1
}55 
else66 
{77 
HttpContext88 
.88 
Response88 
.88 

StatusCode88 %
=88& '
$num88( +
;88+ ,
}99 
}:: 
};; ∆
_C:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Controllers\AuthController.cs
	namespace		 	
WebCamServer		
 
.		 
Controllers		 "
{

 
[ 
Route 
( 	
$str	 
) 
] 
[ 
ApiController 
] 
public 
class	 
AuthController 
: 
ControllerBase  .
{ 
private 
readonly 
IAuthService !
_service" *
;* +
public 

AuthController 
( 
IAuthService &
service' .
). /
{ 
_service 
= 
service 
; 
} 
} 
} ä
YC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Config\SwaggerConfig.cs
	namespace 	
WebCamServer
 
. 
Config 
{ 
public 
static	 
class $
ServiceExtenstionSwagger .
{ 
public 

static 
void 
ConfigureSwagger '
(' (
this( ,
IServiceCollection- ?
services@ H
)H I
{		 
services

 
.

 
AddSwaggerGen

 
(

 
c

 
=>

 !
{ 	
c
 
. 

SwaggerDoc 
( 
$str 
, 
new  
OpenApiInfo! ,
{- .
Title/ 4
=5 6
$str7 I
,I J
VersionK R
=S T
$strU Y
}Z [
)[ \
;\ ]
c
 
. !
AddSecurityDefinition !
(! "
$str" *
,* +
new, /!
OpenApiSecurityScheme0 E
{
 
Description 
= 
$str E
,E F
Name 
= 
$str "
," #
In 
= 
ParameterLocation "
." #
Header# )
,) *
Type 
= 
SecuritySchemeType %
.% &
ApiKey& ,
,, -
Scheme 
= 
$str 
}
 
) 
; 
c
 
. "
AddSecurityRequirement "
(" #
new# &&
OpenApiSecurityRequirement' A
(A B
)B C
{
 
{ 
new !
OpenApiSecurityScheme '
{ 
	Reference 
= 
new 
OpenApiReference  0
{ 
Type   
=   
ReferenceType   (
.  ( )
SecurityScheme  ) 7
,  7 8
Id!! 
=!! 
$str!! !
}"" 
,"" 
Scheme## 
=## 
$str## #
,### $
Name$$ 
=$$ 
$str$$ !
,$$! "
In%% 
=%% 
ParameterLocation%% (
.%%( )
Header%%) /
,%%/ 0
}&& 
,&& 
new'' 
List'' 
<'' 
string'' 
>''  
(''  !
)''! "
}(( 
})) 
))) 
;)) 
}** 
)** 
;** 	
}++ 
},, 
}-- Õ
]C:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Config\LoadServiceConfig.cs
	namespace 	
WebCamServer
 
. 
Config 
{		 
public

 
static

	 
class

 
LoadService

 !
{ 
public 

static 
void 
LoadRepositories '
(' (
IServiceCollection( :
services; C
)C D
{ 
} 
public 

static 
void 
LoadServices #
(# $
IServiceCollection$ 6
services7 ?
)? @
{ 
} 
} 
} Â	
VC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Config\CorsConfig.cs
	namespace 	
WebCamServer
 
. 
Config 
{ 
public 
static	 
class 

CorsConfig  
{ 
public 

static 
void 
ConfigureCors $
($ %
this% )
IServiceCollection* <
services= E
,E F
stringG M

policyNameN X
)X Y
{ 
services 
. 
AddCors 
( 
options 
=> !
{ 
options		 
.		 
	AddPolicy		 
(		 
name


 
:

 

policyName

 
,

 
builder
 
=> 
{
 
builder 
. 
AllowAnyOrigin "
(" #
)# $
. 
AllowAnyMethod #
(# $
)$ %
. 
AllowAnyHeader #
(# $
)$ %
;% &
}
 
) 
; 
} 
) 
; 	
} 
} 
} ƒ
YC:\Users\calle\Desktop\UNIFRANZ\SEMESTRE_6\Embebidos\WebCamServer\Config\ContextConfig.cs
	namespace 	
WebCamServer
 
. 
Config 
{		 
public

 
static

	 
class

 $
ServiceExtenstionContext

 .
{ 
public 

static 
void 
ConfigureContext '
(' (
this( ,
IServiceCollection- ?
services@ H
,H I!
WebApplicationBuilderJ _
builder` g
)g h
{ 
services 
. 
	Configure 
< 
MongoDbSettings (
>( )
() *
builder* 1
.1 2
Configuration2 ?
.? @

GetSection@ J
(J K
$strK \
)\ ]
)] ^
;^ _
services 
. 
AddSingleton 
< 
IMongoClient (
,( )
MongoClient* 5
>5 6
(6 7
sp7 9
=>: <
{ 
var 
settings 
= 
sp 
. 
GetRequiredService ,
<, -
IOptions- 5
<5 6
MongoDbSettings6 E
>E F
>F G
(G H
)H I
.I J
ValueJ O
;O P
return 
new 
MongoClient 
( 
settings '
.' (
ConnectionString( 8
)8 9
;9 :
} 
) 
; 	
string 
connectionDb 
= 
builder #
.# $
Configuration$ 1
.1 2
GetConnectionString2 E
(E F
$strF P
)P Q
;Q R
services 
. 
AddDbContext 
< 
DataContext '
>' (
(( )
options) 0
=>1 3
{ 
options 
. 
	UseNpgsql 
( 
connectionDb &
,& '

sqlOptions( 2
=>3 5
{ 	

sqlOptions
 
. 
CommandTimeout #
(# $
$num$ &
)& '
;' (
} 	
)	 

;
 
} 
) 
; 	
services"" 
."" %
AddDistributedMemoryCache"" (
(""( )
)"") *
;""* +
services$$ 
.$$ 

AddSession$$ 
($$ 
options$$ !
=>$$" $
{%% 
options&& 
.&& 
IdleTimeout&& 
=&& 
TimeSpan&& &
.&&& '
FromMinutes&&' 2
(&&2 3
$num&&3 5
)&&5 6
;&&6 7
options'' 
.'' 
Cookie'' 
.'' 
HttpOnly'' 
=''  !
true''" &
;''& '
options(( 
.(( 
Cookie(( 
.(( 
IsEssential(( "
=((# $
true((% )
;(() *
})) 
))) 
;)) 	
}** 
}++ 
},, 