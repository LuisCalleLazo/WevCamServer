�
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
})) �
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
} �
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
} �
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
}		 �
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
} �
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
} �4
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
}UU �b
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
None	| �
)
� �
;
� �
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
;	aa �
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
�� 
(
�� 
	webSocket
�� 
.
�� 
State
�� !
!=
��" $
WebSocketState
��% 3
.
��3 4
Open
��4 8
)
��8 9
break
�� 
;
�� 
byte
�� 
[
�� 
]
�� 

imageBytes
�� 
=
��  !
await
��" '
File
��( ,
.
��, -
ReadAllBytesAsync
��- >
(
��> ?
	imagePath
��? H
)
��H I
;
��I J
await
�� 
	webSocket
�� 
.
�� 
	SendAsync
�� '
(
��' (
new
��( +
ArraySegment
��, 8
<
��8 9
byte
��9 =
>
��= >
(
��> ?

imageBytes
��? I
)
��I J
,
��J K"
WebSocketMessageType
��L `
.
��` a
Binary
��a g
,
��g h
true
��i m
,
��m n 
CancellationToken��o �
.��� �
None��� �
)��� �
;��� �
await
�� 
Task
�� 
.
�� 
Delay
�� 
(
�� 
$num
�� #
)
��# $
;
��$ %
}
��
 
}
�� 
}
�� 
public
�� 

async
�� 
Task
�� !
CloseAllConnections
�� )
(
��) *
)
��* +
{
�� 
foreach
�� 
(
�� 
var
�� 
viewer
�� 
in
�� 
_viewers
�� %
)
��% &
{
�� 
if
�� 

(
�� 
viewer
�� 
.
�� 
State
�� 
==
�� 
WebSocketState
�� *
.
��* +
Open
��+ /
)
��/ 0
{
�� 	
await
��
 
viewer
�� 
.
�� 

CloseAsync
�� !
(
��! ""
WebSocketCloseStatus
��" 6
.
��6 7
NormalClosure
��7 D
,
��D E
$str
��F _
,
��_ `
CancellationToken
��a r
.
��r s
None
��s w
)
��w x
;
��x y
}
�� 	
}
�� 
}
�� 
}
�� 
}�� �
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
}++ �
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
}SS �
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
} �&
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
}== �
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
},, �
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
}AA �
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
}BB �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
},, �
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
}-- �
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
}-- �
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
}-- �
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
�
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
} �
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
} �
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
} �

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
} �	
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
} �
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
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
,
��V W
UpdateUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
,
��V W
DeleteUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
}
�� 
,
�� 
constraints
�� 
:
�� 
table
�� "
=>
��# %
{
�� 
table
�� 
.
�� 

PrimaryKey
�� $
(
��$ %
$str
��% 7
,
��7 8
x
��9 :
=>
��; =
x
��> ?
.
��? @
Id
��@ B
)
��B C
;
��C D
table
�� 
.
�� 

ForeignKey
�� $
(
��$ %
name
�� 
:
�� 
$str
�� =
,
��= >
column
�� 
:
�� 
x
��  !
=>
��" $
x
��% &
.
��& '
UserId
��' -
,
��- .
principalTable
�� &
:
��& '
$str
��( /
,
��/ 0
principalColumn
�� '
:
��' (
$str
��) -
,
��- .
onDelete
��  
:
��  !
ReferentialAction
��" 3
.
��3 4
Cascade
��4 ;
)
��; <
;
��< =
}
�� 
)
�� 
;
�� 
migrationBuilder
�� 
.
�� 
CreateTable
�� (
(
��( )
name
�� 
:
�� 
$str
�� 
,
��  
columns
�� 
:
�� 
table
�� 
=>
�� !
new
��" %
{
�� 
Id
�� 
=
�� 
table
�� 
.
�� 
Column
�� %
<
��% &
int
��& )
>
��) *
(
��* +
type
��+ /
:
��/ 0
$str
��1 :
,
��: ;
nullable
��< D
:
��D E
false
��F K
)
��K L
.
�� 

Annotation
�� #
(
��# $
$str
��$ D
,
��D E+
NpgsqlValueGenerationStrategy
��F c
.
��c d%
IdentityByDefaultColumn
��d {
)
��{ |
,
��| }
UserId
�� 
=
�� 
table
�� "
.
��" #
Column
��# )
<
��) *
int
��* -
>
��- .
(
��. /
type
��/ 3
:
��3 4
$str
��5 >
,
��> ?
nullable
��@ H
:
��H I
false
��J O
)
��O P
,
��P Q
CreateAt
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
DateTime
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< V
,
��V W
nullable
��X `
:
��` a
false
��b g
)
��g h
,
��h i
UpdateAt
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
DateTime
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< V
,
��V W
nullable
��X `
:
��` a
false
��b g
)
��g h
,
��h i
DeleteAt
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
DateTime
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< V
,
��V W
nullable
��X `
:
��` a
false
��b g
)
��g h
,
��h i
CreateUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
,
��V W
UpdateUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
,
��V W
DeleteUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
}
�� 
,
�� 
constraints
�� 
:
�� 
table
�� "
=>
��# %
{
�� 
table
�� 
.
�� 

PrimaryKey
�� $
(
��$ %
$str
��% 1
,
��1 2
x
��3 4
=>
��5 7
x
��8 9
.
��9 :
Id
��: <
)
��< =
;
��= >
table
�� 
.
�� 

ForeignKey
�� $
(
��$ %
name
�� 
:
�� 
$str
�� 7
,
��7 8
column
�� 
:
�� 
x
��  !
=>
��" $
x
��% &
.
��& '
UserId
��' -
,
��- .
principalTable
�� &
:
��& '
$str
��( /
,
��/ 0
principalColumn
�� '
:
��' (
$str
��) -
,
��- .
onDelete
��  
:
��  !
ReferentialAction
��" 3
.
��3 4
Cascade
��4 ;
)
��; <
;
��< =
}
�� 
)
�� 
;
�� 
migrationBuilder
�� 
.
�� 
CreateTable
�� (
(
��( )
name
�� 
:
�� 
$str
�� 
,
�� 
columns
�� 
:
�� 
table
�� 
=>
�� !
new
��" %
{
�� 
Id
�� 
=
�� 
table
�� 
.
�� 
Column
�� %
<
��% &
string
��& ,
>
��, -
(
��- .
type
��. 2
:
��2 3
$str
��4 :
,
��: ;
nullable
��< D
:
��D E
false
��F K
)
��K L
,
��L M
CurrentToken
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
string
��0 6
>
��6 7
(
��7 8
type
��8 <
:
��< =
$str
��> D
,
��D E
nullable
��F N
:
��N O
true
��P T
)
��T U
,
��U V
RefreshToken
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
string
��0 6
>
��6 7
(
��7 8
type
��8 <
:
��< =
$str
��> D
,
��D E
nullable
��F N
:
��N O
true
��P T
)
��T U
,
��U V

CreateDate
�� 
=
��  
table
��! &
.
��& '
Column
��' -
<
��- .
DateTime
��. 6
>
��6 7
(
��7 8
type
��8 <
:
��< =
$str
��> X
,
��X Y
nullable
��Z b
:
��b c
false
��d i
)
��i j
,
��j k
ExpiredDate
�� 
=
��  !
table
��" '
.
��' (
Column
��( .
<
��. /
DateTime
��/ 7
>
��7 8
(
��8 9
type
��9 =
:
��= >
$str
��? Y
,
��Y Z
nullable
��[ c
:
��c d
false
��e j
)
��j k
,
��k l
Active
�� 
=
�� 
table
�� "
.
��" #
Column
��# )
<
��) *
bool
��* .
>
��. /
(
��/ 0
type
��0 4
:
��4 5
$str
��6 ?
,
��? @
nullable
��A I
:
��I J
false
��K P
)
��P Q
,
��Q R
UserId
�� 
=
�� 
table
�� "
.
��" #
Column
��# )
<
��) *
int
��* -
>
��- .
(
��. /
type
��/ 3
:
��3 4
$str
��5 >
,
��> ?
nullable
��@ H
:
��H I
false
��J O
)
��O P
}
�� 
,
�� 
constraints
�� 
:
�� 
table
�� "
=>
��# %
{
�� 
table
�� 
.
�� 

PrimaryKey
�� $
(
��$ %
$str
��% 0
,
��0 1
x
��2 3
=>
��4 6
x
��7 8
.
��8 9
Id
��9 ;
)
��; <
;
��< =
table
�� 
.
�� 

ForeignKey
�� $
(
��$ %
name
�� 
:
�� 
$str
�� 6
,
��6 7
column
�� 
:
�� 
x
��  !
=>
��" $
x
��% &
.
��& '
UserId
��' -
,
��- .
principalTable
�� &
:
��& '
$str
��( /
,
��/ 0
principalColumn
�� '
:
��' (
$str
��) -
,
��- .
onDelete
��  
:
��  !
ReferentialAction
��" 3
.
��3 4
Cascade
��4 ;
)
��; <
;
��< =
}
�� 
)
�� 
;
�� 
migrationBuilder
�� 
.
�� 
CreateTable
�� (
(
��( )
name
�� 
:
�� 
$str
��  
,
��  !
columns
�� 
:
�� 
table
�� 
=>
�� !
new
��" %
{
�� 
Id
�� 
=
�� 
table
�� 
.
�� 
Column
�� %
<
��% &
int
��& )
>
��) *
(
��* +
type
��+ /
:
��/ 0
$str
��1 :
,
��: ;
nullable
��< D
:
��D E
false
��F K
)
��K L
.
�� 

Annotation
�� #
(
��# $
$str
��$ D
,
��D E+
NpgsqlValueGenerationStrategy
��F c
.
��c d%
IdentityByDefaultColumn
��d {
)
��{ |
,
��| }
Description
�� 
=
��  !
table
��" '
.
��' (
Column
��( .
<
��. /
string
��/ 5
>
��5 6
(
��6 7
type
��7 ;
:
��; <
$str
��= C
,
��C D
nullable
��E M
:
��M N
true
��O S
)
��S T
,
��T U
Value
�� 
=
�� 
table
�� !
.
��! "
Column
��" (
<
��( )
string
��) /
>
��/ 0
(
��0 1
type
��1 5
:
��5 6
$str
��7 =
,
��= >
nullable
��? G
:
��G H
true
��I M
)
��M N
,
��N O
Type
�� 
=
�� 
table
��  
.
��  !
Column
��! '
<
��' (
int
��( +
>
��+ ,
(
��, -
type
��- 1
:
��1 2
$str
��3 <
,
��< =
nullable
��> F
:
��F G
false
��H M
)
��M N
,
��N O
SeekerId
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
int
��, /
>
��/ 0
(
��0 1
type
��1 5
:
��5 6
$str
��7 @
,
��@ A
nullable
��B J
:
��J K
false
��L Q
)
��Q R
,
��R S
CreateAt
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
DateTime
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< V
,
��V W
nullable
��X `
:
��` a
false
��b g
)
��g h
,
��h i
UpdateAt
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
DateTime
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< V
,
��V W
nullable
��X `
:
��` a
false
��b g
)
��g h
,
��h i
DeleteAt
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
DateTime
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< V
,
��V W
nullable
��X `
:
��` a
false
��b g
)
��g h
,
��h i
CreateUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
,
��V W
UpdateUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
,
��V W
DeleteUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
}
�� 
,
�� 
constraints
�� 
:
�� 
table
�� "
=>
��# %
{
�� 
table
�� 
.
�� 

PrimaryKey
�� $
(
��$ %
$str
��% 2
,
��2 3
x
��4 5
=>
��6 8
x
��9 :
.
��: ;
Id
��; =
)
��= >
;
��> ?
table
�� 
.
�� 

ForeignKey
�� $
(
��$ %
name
�� 
:
�� 
$str
�� <
,
��< =
column
�� 
:
�� 
x
��  !
=>
��" $
x
��% &
.
��& '
SeekerId
��' /
,
��/ 0
principalTable
�� &
:
��& '
$str
��( 1
,
��1 2
principalColumn
�� '
:
��' (
$str
��) -
,
��- .
onDelete
��  
:
��  !
ReferentialAction
��" 3
.
��3 4
Cascade
��4 ;
)
��; <
;
��< =
}
�� 
)
�� 
;
�� 
migrationBuilder
�� 
.
�� 
CreateTable
�� (
(
��( )
name
�� 
:
�� 
$str
��  
,
��  !
columns
�� 
:
�� 
table
�� 
=>
�� !
new
��" %
{
�� 
Id
�� 
=
�� 
table
�� 
.
�� 
Column
�� %
<
��% &
int
��& )
>
��) *
(
��* +
type
��+ /
:
��/ 0
$str
��1 :
,
��: ;
nullable
��< D
:
��D E
false
��F K
)
��K L
.
�� 

Annotation
�� #
(
��# $
$str
��$ D
,
��D E+
NpgsqlValueGenerationStrategy
��F c
.
��c d%
IdentityByDefaultColumn
��d {
)
��{ |
,
��| }
	DirPhotos
�� 
=
�� 
table
��  %
.
��% &
Column
��& ,
<
��, -
string
��- 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; A
,
��A B
nullable
��C K
:
��K L
true
��M Q
)
��Q R
,
��R S
	BirthDate
�� 
=
�� 
table
��  %
.
��% &
Column
��& ,
<
��, -
DateTime
��- 5
>
��5 6
(
��6 7
type
��7 ;
:
��; <
$str
��= W
,
��W X
nullable
��Y a
:
��a b
false
��c h
)
��h i
,
��i j
FullName
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
string
��, 2
>
��2 3
(
��3 4
type
��4 8
:
��8 9
$str
��: @
,
��@ A
nullable
��B J
:
��J K
true
��L P
)
��P Q
,
��Q R
Size
�� 
=
�� 
table
��  
.
��  !
Column
��! '
<
��' (
double
��( .
>
��. /
(
��/ 0
type
��0 4
:
��4 5
$str
��6 H
,
��H I
nullable
��J R
:
��R S
false
��T Y
)
��Y Z
,
��Z [
Description
�� 
=
��  !
table
��" '
.
��' (
Column
��( .
<
��. /
string
��/ 5
>
��5 6
(
��6 7
type
��7 ;
:
��; <
$str
��= C
,
��C D
nullable
��E M
:
��M N
true
��O S
)
��S T
,
��T U
LastSeenMap
�� 
=
��  !
table
��" '
.
��' (
Column
��( .
<
��. /
string
��/ 5
>
��5 6
(
��6 7
type
��7 ;
:
��; <
$str
��= C
,
��C D
nullable
��E M
:
��M N
true
��O S
)
��S T
,
��T U
Found
�� 
=
�� 
table
�� !
.
��! "
Column
��" (
<
��( )
bool
��) -
>
��- .
(
��. /
type
��/ 3
:
��3 4
$str
��5 >
,
��> ?
nullable
��@ H
:
��H I
false
��J O
)
��O P
,
��P Q
SeekerId
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
int
��, /
>
��/ 0
(
��0 1
type
��1 5
:
��5 6
$str
��7 @
,
��@ A
nullable
��B J
:
��J K
false
��L Q
)
��Q R
,
��R S
CreateAt
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
DateTime
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< V
,
��V W
nullable
��X `
:
��` a
false
��b g
)
��g h
,
��h i
UpdateAt
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
DateTime
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< V
,
��V W
nullable
��X `
:
��` a
false
��b g
)
��g h
,
��h i
DeleteAt
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
DateTime
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< V
,
��V W
nullable
��X `
:
��` a
false
��b g
)
��g h
,
��h i
CreateUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
,
��V W
UpdateUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
,
��V W
DeleteUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
}
�� 
,
�� 
constraints
�� 
:
�� 
table
�� "
=>
��# %
{
�� 
table
�� 
.
�� 

PrimaryKey
�� $
(
��$ %
$str
��% 2
,
��2 3
x
��4 5
=>
��6 8
x
��9 :
.
��: ;
Id
��; =
)
��= >
;
��> ?
table
�� 
.
�� 

ForeignKey
�� $
(
��$ %
name
�� 
:
�� 
$str
�� <
,
��< =
column
�� 
:
�� 
x
��  !
=>
��" $
x
��% &
.
��& '
SeekerId
��' /
,
��/ 0
principalTable
�� &
:
��& '
$str
��( 1
,
��1 2
principalColumn
�� '
:
��' (
$str
��) -
,
��- .
onDelete
��  
:
��  !
ReferentialAction
��" 3
.
��3 4
Cascade
��4 ;
)
��; <
;
��< =
}
�� 
)
�� 
;
�� 
migrationBuilder
�� 
.
�� 
CreateTable
�� (
(
��( )
name
�� 
:
�� 
$str
�� #
,
��# $
columns
�� 
:
�� 
table
�� 
=>
�� !
new
��" %
{
�� 
Id
�� 
=
�� 
table
�� 
.
�� 
Column
�� %
<
��% &
int
��& )
>
��) *
(
��* +
type
��+ /
:
��/ 0
$str
��1 :
,
��: ;
nullable
��< D
:
��D E
false
��F K
)
��K L
.
�� 

Annotation
�� #
(
��# $
$str
��$ D
,
��D E+
NpgsqlValueGenerationStrategy
��F c
.
��c d%
IdentityByDefaultColumn
��d {
)
��{ |
,
��| }
	InitVideo
�� 
=
�� 
table
��  %
.
��% &
Column
��& ,
<
��, -
TimeOnly
��- 5
>
��5 6
(
��6 7
type
��7 ;
:
��; <
$str
��= U
,
��U V
nullable
��W _
:
��_ `
false
��a f
)
��f g
,
��g h
EndVideo
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
TimeOnly
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< T
,
��T U
nullable
��V ^
:
��^ _
false
��` e
)
��e f
,
��f g
Date
�� 
=
�� 
table
��  
.
��  !
Column
��! '
<
��' (
DateOnly
��( 0
>
��0 1
(
��1 2
type
��2 6
:
��6 7
$str
��8 >
,
��> ?
nullable
��@ H
:
��H I
false
��J O
)
��O P
,
��P Q
CameraId
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
int
��, /
>
��/ 0
(
��0 1
type
��1 5
:
��5 6
$str
��7 @
,
��@ A
nullable
��B J
:
��J K
false
��L Q
)
��Q R
,
��R S
	MissingId
�� 
=
�� 
table
��  %
.
��% &
Column
��& ,
<
��, -
int
��- 0
>
��0 1
(
��1 2
type
��2 6
:
��6 7
$str
��8 A
,
��A B
nullable
��C K
:
��K L
false
��M R
)
��R S
,
��S T
CreateAt
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
DateTime
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< V
,
��V W
nullable
��X `
:
��` a
false
��b g
)
��g h
,
��h i
UpdateAt
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
DateTime
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< V
,
��V W
nullable
��X `
:
��` a
false
��b g
)
��g h
,
��h i
DeleteAt
�� 
=
�� 
table
�� $
.
��$ %
Column
��% +
<
��+ ,
DateTime
��, 4
>
��4 5
(
��5 6
type
��6 :
:
��: ;
$str
��< V
,
��V W
nullable
��X `
:
��` a
false
��b g
)
��g h
,
��h i
CreateUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
,
��V W
UpdateUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
,
��V W
DeleteUserId
��  
=
��! "
table
��# (
.
��( )
Column
��) /
<
��/ 0
int
��0 3
>
��3 4
(
��4 5
type
��5 9
:
��9 :
$str
��; D
,
��D E
nullable
��F N
:
��N O
false
��P U
)
��U V
}
�� 
,
�� 
constraints
�� 
:
�� 
table
�� "
=>
��# %
{
�� 
table
�� 
.
�� 

PrimaryKey
�� $
(
��$ %
$str
��% 5
,
��5 6
x
��7 8
=>
��9 ;
x
��< =
.
��= >
Id
��> @
)
��@ A
;
��A B
table
�� 
.
�� 

ForeignKey
�� $
(
��$ %
name
�� 
:
�� 
$str
�� ?
,
��? @
column
�� 
:
�� 
x
��  !
=>
��" $
x
��% &
.
��& '
CameraId
��' /
,
��/ 0
principalTable
�� &
:
��& '
$str
��( 1
,
��1 2
principalColumn
�� '
:
��' (
$str
��) -
,
��- .
onDelete
��  
:
��  !
ReferentialAction
��" 3
.
��3 4
Cascade
��4 ;
)
��; <
;
��< =
table
�� 
.
�� 

ForeignKey
�� $
(
��$ %
name
�� 
:
�� 
$str
�� A
,
��A B
column
�� 
:
�� 
x
��  !
=>
��" $
x
��% &
.
��& '
	MissingId
��' 0
,
��0 1
principalTable
�� &
:
��& '
$str
��( 2
,
��2 3
principalColumn
�� '
:
��' (
$str
��) -
,
��- .
onDelete
��  
:
��  !
ReferentialAction
��" 3
.
��3 4
Cascade
��4 ;
)
��; <
;
��< =
}
�� 
)
�� 
;
�� 
migrationBuilder
�� 
.
�� 
CreateIndex
�� (
(
��( )
name
�� 
:
�� 
$str
�� (
,
��( )
table
�� 
:
�� 
$str
�� 
,
��  
column
�� 
:
�� 
$str
��  
,
��  !
unique
�� 
:
�� 
true
�� 
)
�� 
;
�� 
migrationBuilder
�� 
.
�� 
CreateIndex
�� (
(
��( )
name
�� 
:
�� 
$str
�� ,
,
��, -
table
�� 
:
�� 
$str
�� !
,
��! "
column
�� 
:
�� 
$str
�� "
)
��" #
;
��# $
migrationBuilder
�� 
.
�� 
CreateIndex
�� (
(
��( )
name
�� 
:
�� 
$str
�� /
,
��/ 0
table
�� 
:
�� 
$str
�� $
,
��$ %
column
�� 
:
�� 
$str
�� "
)
��" #
;
��# $
migrationBuilder
�� 
.
�� 
CreateIndex
�� (
(
��( )
name
�� 
:
�� 
$str
�� 0
,
��0 1
table
�� 
:
�� 
$str
�� $
,
��$ %
column
�� 
:
�� 
$str
�� #
)
��# $
;
��$ %
migrationBuilder
�� 
.
�� 
CreateIndex
�� (
(
��( )
name
�� 
:
�� 
$str
�� ,
,
��, -
table
�� 
:
�� 
$str
�� !
,
��! "
column
�� 
:
�� 
$str
�� "
)
��" #
;
��# $
migrationBuilder
�� 
.
�� 
CreateIndex
�� (
(
��( )
name
�� 
:
�� 
$str
�� /
,
��/ 0
table
�� 
:
�� 
$str
�� &
,
��& '
column
�� 
:
�� 
$str
��  
)
��  !
;
��! "
migrationBuilder
�� 
.
�� 
CreateIndex
�� (
(
��( )
name
�� 
:
�� 
$str
�� )
,
��) *
table
�� 
:
�� 
$str
��  
,
��  !
column
�� 
:
�� 
$str
��  
,
��  !
unique
�� 
:
�� 
true
�� 
)
�� 
;
�� 
migrationBuilder
�� 
.
�� 
CreateIndex
�� (
(
��( )
name
�� 
:
�� 
$str
�� (
,
��( )
table
�� 
:
�� 
$str
�� 
,
��  
column
�� 
:
�� 
$str
��  
)
��  !
;
��! "
migrationBuilder
�� 
.
�� 
CreateIndex
�� (
(
��( )
name
�� 
:
�� 
$str
�� &
,
��& '
table
�� 
:
�� 
$str
�� 
,
�� 
column
�� 
:
�� 
$str
�� 
,
��  
unique
�� 
:
�� 
true
�� 
)
�� 
;
�� 
migrationBuilder
�� 
.
�� 
CreateIndex
�� (
(
��( )
name
�� 
:
�� 
$str
�� %
,
��% &
table
�� 
:
�� 
$str
�� 
,
�� 
column
�� 
:
�� 
$str
�� 
,
�� 
unique
�� 
:
�� 
true
�� 
)
�� 
;
�� 
migrationBuilder
�� 
.
�� 
CreateIndex
�� (
(
��( )
name
�� 
:
�� 
$str
�� +
,
��+ ,
table
�� 
:
�� 
$str
�� 
,
�� 
column
�� 
:
�� 
$str
�� $
,
��$ %
unique
�� 
:
�� 
true
�� 
)
�� 
;
�� 
}
�� 	
	protected
�� 
override
�� 
void
�� 
Down
��  $
(
��$ %
MigrationBuilder
��% 5
migrationBuilder
��6 F
)
��F G
{
�� 	
migrationBuilder
�� 
.
�� 
	DropTable
�� &
(
��& '
name
�� 
:
�� 
$str
�� 
)
�� 
;
��  
migrationBuilder
�� 
.
�� 
	DropTable
�� &
(
��& '
name
�� 
:
�� 
$str
��  
)
��  !
;
��! "
migrationBuilder
�� 
.
�� 
	DropTable
�� &
(
��& '
name
�� 
:
�� 
$str
�� #
)
��# $
;
��$ %
migrationBuilder
�� 
.
�� 
	DropTable
�� &
(
��& '
name
�� 
:
�� 
$str
�� %
)
��% &
;
��& '
migrationBuilder
�� 
.
�� 
	DropTable
�� &
(
��& '
name
�� 
:
�� 
$str
�� 
)
�� 
;
��  
migrationBuilder
�� 
.
�� 
	DropTable
�� &
(
��& '
name
�� 
:
�� 
$str
�� 
)
��  
;
��  !
migrationBuilder
�� 
.
�� 
	DropTable
�� &
(
��& '
name
�� 
:
�� 
$str
��  
)
��  !
;
��! "
migrationBuilder
�� 
.
�� 
	DropTable
�� &
(
��& '
name
�� 
:
�� 
$str
�� 
)
��  
;
��  !
migrationBuilder
�� 
.
�� 
	DropTable
�� &
(
��& '
name
�� 
:
�� 
$str
�� 
)
�� 
;
�� 
migrationBuilder
�� 
.
�� 
	DropTable
�� &
(
��& '
name
�� 
:
�� 
$str
�� !
)
��! "
;
��" #
}
�� 	
}
�� 
}�� �
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
}		 �
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
} �

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
} �3
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
}DD �e
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
��
 
HasForeignKey
�� 
(
�� 
p
�� 
=>
�� 
p
��  
.
��  !
SeekerId
��! )
)
��) *
.
��
 

IsRequired
�� 
(
�� 
)
�� 
;
�� 
}
�� 
)
�� 
;
�� 	
}
�� 
}
�� 
}�� �
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
}dd �
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
};; �
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
} �
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
}-- �
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
} �	
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
} �
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