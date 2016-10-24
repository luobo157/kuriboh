<%
Response.Buffer=true

Const num=25 '链接 
Const tNum=25 '推荐
Const xNum=25 '相关
Const nNum=25 '最新
Const mNum=4 '导航
Const aLong =350  '文章长度的字数
Const keyfile="k.txt"  '关键词文件名，根据k.txt里的关键词来生成$ekey$，每个关键词一行
Const txtfile="t.txt" '内容文件名，存放文章，不需要插入{title}标签
Const templetefile="m.html" '模板文件，导入生成$ekey$，$tkey1$，$tkey1$，$xkey1$，$content$，字符编码为gbk（暂时未清楚是那个国标）
Const minpathlen=5  '文件夹最小长度
Const maxpathlen=10  '文件夹最大长度
Const isopenext=true  '是否默认显示后缀，也即有.html
Class apiClass
Public vs


Public Function getKey(digits)  '定义并初始化数组，全局（公共）数组，digits为随机数
Dim char_array(36)  '定义数组下标为36，也即数组有36个数据，0-9、a-z
Dim output, num
char_array(0) = "0"
char_array(1) = "1"
char_array(2) = "2"
char_array(3) = "3"
char_array(4) = "4"
char_array(5) = "5"
char_array(6) = "6"
char_array(7) = "7"
char_array(8) = "8"
char_array(9) = "9"
char_array(10) = "a"
char_array(11) = "s"
char_array(12) = "d"
char_array(13) = "f"
char_array(14) = "e"
char_array(15) = "f"
char_array(16) = "g"
char_array(17) = "h"
char_array(18) = "i"
char_array(19) = "j"
char_array(20) = "k"
char_array(21) = "l"
char_array(22) = "m"
char_array(23) = "n"
char_array(24) = "o"
char_array(25) = "p"
char_array(26) = "q"
char_array(27) = "r"
char_array(28) = "s"
char_array(29) = "t"
char_array(30) = "u"
char_array(31) = "v"
char_array(32) = "w"
char_array(33) = "x"
char_array(34) = "y"
char_array(35) = "z"
Randomize
Do While Len(output) < digits
num = char_array(Int((35) * Rnd + 0))
output = output + num
Loop
getKey = output
End Function

Public Function GetRanNum(Min, max)
Randomize
GetRanNum = Int((max - Min + 1) * Rnd) + Min
End Function
Public Sub echo(str)
Response.Write str
End Sub

Public Sub main(allnum,getAppSplit,HostPath,HostKey,ext,txtfile,templetefile,num, tNum, xNum, nNum, mNum, aLong)
vs = "2.0"
skinext=""
if isopenext Then skinext=ext
ran = 0
'templetePath = Application("templetePath_" & ran)
If templetePath <> "" Then
Else
templetePath = readFile(Server.MapPath(templetefile))
Application("templetePath_" & ran) = templetePath
End If
myKey = HostKey
myArt = eArt(aLong,txtfile)


rTemplete = r(templetePath, "$ekey$", myKey)
rTemplete = r(rTemplete, "$title$", myKey)



m_keyword = ""
For i = 0 To 4
    m_keyword = m_keyword & "," & readApp(getAppSplit,GetRanNum(0, allnum-1))(1)
Next
rTemplete = r(rTemplete, "$keyword$", myKey & "," & m_keyword)
rTemplete = r(rTemplete, "$description$", myKey & myKey1 & Left(myArt, 100))
aHOST = readApp(getAppSplit,GetRanNum(0, allnum-1))
cHOST = aHOST(0)
rTemplete = r(rTemplete, "$author$", "<a href='../" & cHOST & "/"&skinext&"' target='_bank'>" & aHOST(1) & "</a>")
rTemplete = r(rTemplete, "$mainword$", myKey)
rTemplete = r(rTemplete, "$now$", Date)

tmyArt = CInt(Len(myArt) / 2)

sContent = Left(myArt, tmyArt) & "<b>" & myKey & "</b>" & Right(myArt, tmyArt)

rTemplete = r(rTemplete, "$content$", sContent)
rTemplete = r(rTemplete, "$host$", "../"&HostPath&"/"&skinext)
For i = 0 To num
bHOST = readApp(getAppSplit,GetRanNum(0, allnum-1))
cHOST = bHOST(0)
bKey = bHOST(1)
rTemplete = r(rTemplete, "$key" & i & "$", bKey)
rTemplete = r(rTemplete, "$url" & i & "$", "../" & cHOST & "/"&skinext)
Next
For i = 0 To tNum
bHOST = readApp(getAppSplit,GetRanNum(0, allnum-1))
cHOST = bHOST(0)
bKey = bHOST(1)
rTemplete = r(rTemplete, "$tkey" & i & "$", bKey)
rTemplete = r(rTemplete, "$turl" & i & "$", "../" & cHOST & "/"&skinext)
Next
For i = 0 To xNum
bHOST = readApp(getAppSplit,GetRanNum(0, allnum-1))
cHOST = bHOST(0)
bKey = bHOST(1)
rTemplete = r(rTemplete, "$xkey" & i & "$", bKey)
rTemplete = r(rTemplete, "$xurl" & i & "$", "../" & cHOST & "/"&skinext)
Next
For i = 0 To nNum
bHOST = readApp(getAppSplit,GetRanNum(0, allnum-1))
cHOST = bHOST(0)
bKey = bHOST(1)
rTemplete = r(rTemplete, "$nkey" & i & "$", bKey)
rTemplete = r(rTemplete, "$nurl" & i & "$", "../" & cHOST & "/"&skinext)
Next
For i = 0 To mNum
bHOST = readApp(getAppSplit,GetRanNum(0, allnum-1))
cHOST = bHOST(0)
bKey = bHOST(1)
rTemplete = r(rTemplete, "$mkey" & i & "$", bKey)
rTemplete = r(rTemplete, "$murl" & i & "$", "../" & cHOST & "/"&skinext)
Next
rTemplete = r(rTemplete, "$ads$", loadAds)


CreatePath HostPath
wFile server.MapPath(HostPath & "/"&ext), rTemplete

echo HostKey & "-" &HostPath & "/"&ext  & "　success<br>"


End Sub
'建立文件夹
Public Sub CreatePath(Path)
Pathx=Server.MapPath(Path)
set fso=server.CreateObject("scripting.filesystemobject")
		If fso.FolderExists(Pathx) = false Then
			fso.CreateFolder(Pathx) 
		end if	
set fso=nothing 
End Sub
'判断文件存在
Public function Dir(filepath)
set fso=Server.CreateObject ("Scripting.FileSystemObject") 
if fso.FileExists(filepath) then 
Dir=1
else
Dir=0
end if
Set fso=Nothing
end function
'随机域名配关键词
Public Function HOST_Key(cn,HS,keyfile)
Set rhk=server.createObject("ADODB.Recordset")
rhk.Open "select * from [k] where [Host] like '"&HS&"'",cn,3,3
if rhk.Eof And rhk.Bof Then
rhk.addnew
HOST_HtmlKey=eKey(keyfile)
rhk("HOST")=HS
rhk("key")=HOST_HtmlKey
rhk.update
HOST_Key=HOST_HtmlKey
Else
HOST_Key=rhk("key")
End If
rhk.close
set rhk=nothing


End Function
Public Function rHost(HHs)
HHs = r(HHs, ":", "_")
HHs = r(HHs, "/", "_")
rHost = HHs
End Function

'写入文件
Public Sub wFile(fPath, content)
Dim filename, MDBpath, fso, fout
On Error Resume Next
Set fso = CreateObject("scripting.FileSystemObject")
Set fout = fso.CreateTextFile(fPath)

fout.Write content
fout.Close
Set fout = Nothing
Set fso = Nothing
If Err Then
Err.Clear
On Error GoTo 0
End If
End Sub
'随机抽取域名
Public Function get_HOST()
get_HOST=uCase(getKey(GetRanNum(minpathlen, maxpathlen)))
End Function
'随机抽取域名
Public Function get_HOST2(xStr)
get_HOST2=uCase(getKey(GetRanNum(minpathlen, maxpathlen)))
if Instr("$"&xStr,"$"&get_HOST2&"#")>0 Then
	get_HOST2=get_HOST2(xStr)
End If
End Function
'随机抽取文章，文章段落
Public Function eArt(slong,txtfile)
Dim ArtCount, Art

ranArt = 0
    Art = Application("Art_" & ranArt)
    If Art <> "" Then
    Else
    Art = readFile(Server.MapPath(txtfile))
    Application("Art_" & ranArt) = Art
    End If
    If Len(Art) <= slong Then
    eArt = Art: Exit Function
    End If
    ransArt = GetRanNum(100, Len(Art) - slong)
    eArt = Mid(Art, ransArt, slong)
    'Art = r(Art, Chr(13) & Chr(10), vbCrLf)
    'sArt = Split(Art, vbCrLf)
    'eArt = get_Art(sArt)
    'eKey = keyCount
End Function
Public Function get_Art(vKey)
ransArt = GetRanNum(0, UBound(vKey))
get_Art = vKey(ransArt)
If Len(get_Art) > 100 Then Exit Function
get_Art = get_Art(vKey)
End Function
'随机抽取关键词
Public Function eKey(keyfile)
Dim keyCount, key

rankey = 0
    key = Application("key_" & rankey)
    If key <> "" Then
    Else
    key = readFile(Server.MapPath(keyfile))
    Application("key_" & rankey) = key
    End If
    key = r(key, Chr(13) & Chr(10), vbCrLf)
    sKey = Split(key, vbCrLf)
    eKey = get_Key(sKey)

    'eKey = keyCount
End Function


Public Function get_Key(vKey)
ransKey = GetRanNum(0, UBound(vKey))
get_Key = vKey(ransKey)
If get_Key <> "" Then Exit Function
get_Key = get_Key(vKey)
End Function

'替换
Public Function r(str, r1, r2)
r = str

If str <> "" And r1 <> "" Then
r = Replace(str, r1, r2)
End If
End Function
'判断是否为数字
Public Function CNum(num)
    If num <> "" Then
        CNum = IsNumeric(num)
    Else
        CNum = False
    End If
End Function
'清除缓存
Public Sub clearApp()
Call echo("<b>开始执行清理当前站点缓存</b>：")
cachelist = Split(GetallCache(), ",")
If UBound(cachelist) > 1 Then
For i = 0 To UBound(cachelist) - 1
   DelCahe cachelist(i)
   Call echo("更新 <b>" & cachelist(i) & "</b> 完成")
Next
Call echo("更新了" & UBound(cachelist) & "个缓存对象<br>")
Else
Call echo("<b>当前站点全部缓存清理完成。</b>")
End If
End Sub
Function GetallCache()
Dim Cacheobj
For Each Cacheobj In Application.Contents
GetallCache = GetallCache & Cacheobj & ","
Next
End Function

Sub DelCahe(MyCaheName)
Application.Lock
Application.Contents.Remove (MyCaheName)
Application.UnLock
End Sub

Public Sub DelFile(filepath)
On Error Resume Next
Set fso = CreateObject("Scripting.FileSystemObject")
fso.DeleteFile(Server.mappath(filepath))
Set fso = nothing
If Err Then
Err.Clear

ENd If
On Error GoTo 0
End Sub
'读取文件内容
Public Function readFile(fPath)

On Error Resume Next
   Const ForReading = 1
   Set fso = CreateObject("Scripting.FileSystemObject")
   Set ts = fso.OpenTextFile(fPath, ForReading)
   readFile = ts.ReadAll
   ts.Close
If Err Then
Err.Clear
readFile = ""
On Error GoTo 0
End If

End Function
'计算文件夹中文件数量
Public Function pathCount(fldPath)
On Error Resume Next
Dim fso, fld
Set fso = CreateObject("Scripting.FileSystemObject")
Set fld = fso.GetFolder(Server.MapPath(fldPath))
 pathCount = fld.Files.Count
Exit Function
if err Then
pathCount = 0
err.clear
end if
End Function

Public Function getApp(allnum)


str=""
for i=1 to allnum
HOST=H.get_HOST2(str)
HOST_HtmlKey=H.eKey(keyfile)
str=str & HOST  & "#" & HOST_HtmlKey & "$"

next
getApp=str


End Function
Public Function readApp(apps_split,ic)
appsHtml=apps_split(ic)
appArray=split(appsHtml,"#")
readApp=appArray
End Function
Public Function splitReadApp(allnum)
	apps=readFile(server.MapPath("app.txt"))
	apps_split=split(apps,"$")
	splitReadApp=apps_split
End Function
End Class

page=Request("page")
allnum=Request("allnum")
pagenum=Request("pagenum")
ext=Request("ext")

if Request("ing")="update" Then
xpageNum=500
Set H=new apiClass  '非dll组件开关
ipage=Request("ipage")
if not H.cNum(ipage) Then
ipage=0
Call H.DelFile("app.txt")
End If
startNum=ipage*xpagenum
EndNum=(ipage+1)*xpagenum
if startNum-allnum>0 Then
H.echo "关键词处理完毕，转向生成文件<script>setTimeout(function(){window.location.href='?ing=run&allnum="&allnum&"&pagenum="&pagenum&"&ext="&ext&"&page="&page&"';},2000)</script>"
Response.End()
End If
if EndNum>allnum Then EndNum=allnum
Files=H.readFile(server.MapPath("app.txt"))
Files=Files & H.getApp((EndNum-startNum))
H.wFile server.MapPath("app.txt"),Files
H.echo ipage & "页处理完毕<script>setTimeout(function(){window.location.href='?ing=update&allnum="&allnum&"&pagenum="&pagenum&"&ext="&ext&"&page="&page&"&ipage="&(ipage+1)&"';},2000)</script>"
Set H=Nothing

Response.End()
End If
if Request("ing")="run" Then

Set H=new apiClass  '非dll组件开关


if ext="" Then
H.echo "请输入正确的文件名"
Response.End()
ENd If
if not H.cNum(allnum) Then
H.echo "请输入正确的总数量"
Response.End()
End If
if not H.cNum(pagenum) Then
H.echo "请输入正确的每页数量"
Response.End()
End If
if not H.cNum(page) Then
page=1
End If
xpage=page-1
if page=1 Then Application("HOSTKEY")=""
startNum=xpage*pagenum
EndNum=page*pagenum
getAppSplit=H.splitReadApp(allnum)
if startNum>=allnum-1 Then H.echo "处理完毕，<a href='"&H.readApp(getAppSplit,allnum-1)(0)&"/'>点此查看</a>":Response.End()
if EndNum>=allnum-1 Then EndNum=allnum
H.echo "正在处理数据：" & startNum & "-" & EndNum & "/进度：" & (startNum/allnum)*100 & "%<br>"


for jj=startNum to EndNum-1
host_Html=H.readApp(getAppSplit,jj)
HostPath=host_Html(0)
HostKey=host_Html(1)
H.echo HostPath & "："

response.flush()
	'if HostPath<>"" Then
		call H.main(allnum,getAppSplit,HostPath,HostKey,ext,txtfile,templetefile,num,tNum,xNum,nNum,mNum,aLong)
	'End If

next
H.echo "<script>setTimeout(function(){window.location.href='?ing=run&allnum="&allnum&"&pagenum="&pagenum&"&ext="&ext&"&page="&(page+1)&"';},3000)</script>"
Set H=nothing

Response.End()
ENd If
%>
<form id="form1" name="form1" method="get" action="">
  生成数量：<input name="ing" type="hidden" id="ing" value="update" size="10" />
    <input name="allnum" type="text" id="allnum" value="1000" size="10" />
  每页生成数量
  <input name="pagenum" type="text" id="pagenum" value="300" size="10" />
  生成文件名
  <input name="ext" type="text" id="ext" value="index.html" />
  <input type="submit" name="button" id="button" value="提交" />
</form>
