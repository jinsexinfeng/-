VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   0  'None
   Caption         =   "RASZ1901ʱ����ʾ"
   ClientHeight    =   2010
   ClientLeft      =   14850
   ClientTop       =   7350
   ClientWidth     =   3810
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2010
   ScaleWidth      =   3810
   ShowInTaskbar   =   0   'False
   Begin VB.Timer Timer3 
      Enabled         =   0   'False
      Interval        =   350
      Left            =   2160
      Top             =   960
   End
   Begin VB.Timer Timer2 
      Interval        =   1000
      Left            =   2760
      Top             =   960
   End
   Begin VB.Timer Timer1 
      Interval        =   100
      Left            =   3360
      Top             =   960
   End
   Begin VB.Shape Shape1 
      BorderColor     =   &H00808080&
      DrawMode        =   7  'Invert
      Height          =   100
      Left            =   1680
      Top             =   120
      Width           =   495
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Caption         =   "���ڿλ�ʣ:88:88"
      BeginProperty Font 
         Name            =   "΢���ź�"
         Size            =   21.75
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   495
      Left            =   120
      TabIndex        =   3
      Top             =   1320
      Width           =   3495
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "88"
      BeginProperty Font 
         Name            =   "΢���ź�"
         Size            =   21.75
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      TabIndex        =   2
      Top             =   720
      Width           =   495
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "88"
      BeginProperty Font 
         Name            =   "΢���ź�"
         Size            =   21.75
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   495
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "88:88:88"
      BeginProperty Font 
         Name            =   "΢���ź�"
         Size            =   42
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   3495
   End
   Begin VB.Shape Shape2 
      BorderColor     =   &H00FFFFFF&
      BorderStyle     =   0  'Transparent
      FillColor       =   &H0080C0FF&
      FillStyle       =   0  'Solid
      Height          =   10000
      Left            =   0
      Top             =   1000
      Width           =   3855
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim RemainTime As Integer
Dim FromStyle As Integer
Dim Time_Dict(1440) As Integer
Dim sx As Integer
Dim sy As Integer

Dim Input_text As String
Dim BColorTime As Single

Dim auto As Integer
Dim Disable_time As Integer
Dim soundplay As Integer
Dim Warn_Off As Integer
Dim PrintMode As String
Dim Breath As String

Dim PrintWord_long As String
Dim PrintCount_long As String
Dim PrintCount_Short As String


'����Ϊ��������
Private Declare Function waveOutGetNumDevs Lib "winmm.dll" () As Long
Private Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Long, ByVal hwndCallback As Long) As Long
Private Declare Function sndPlaySound& Lib "winmm.dll" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long)
Const SND_SYNC = &H0
Const SND_ASYNC = &H1
Const SND_NODEFAULT = &H2
Const soundname = "\ring.wav"
'��������

Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Dim BolIsMove As Boolean, MousX As Long, MousY As Long

'͸������SetLayeredWindowAttributes
'ʹ��bai����������������ɵ�ʵ�ְ�͸�����塣����΢���Ҫ��͸�����崰���ڴ���ʱӦʹ��WS_EX_LAYERED��������CreateWindowEx���������ڴ��������øò�������SetWindowLong������ѡ�ú��ߡ�ȫ�������������������£�
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function SetLayeredWindowAttributes Lib "user32" (ByVal hwnd As Long, ByVal crKey As Long, ByVal bAlpha As Byte, ByVal dwFlags As Long) As Long
'����hwnd��͸������ľ����crKeyΪ��ɫֵ��bAlpha��͸���ȣ�ȡֵ��Χ��[0,255]��dwFlags��͸����ʽ������ȡ����ֵ����ȡֵΪLWA_ALPHAʱ��crKey������Ч��bAlpha������Ч����ȡֵΪLWA_COLORKEYʱ��bAlpha������Ч�������е�������ɫΪcrKey�ĵط�����Ϊ͸������������ܺ����ã����ǲ�����Ϊ������������״�Ĵ��������һ�������������������ϲ������ˣ�ֻ��ָ��͸��������ɫֵ���ɣ������������뿴������롣
Private Const WS_EX_LAYERED = &H80000
Private Const GWL_EXSTYLE = (-20)
Private Const LWA_ALPHA = &H2
Private Const LWA_COLORKEY = &H1
'��͸���������

Private Declare Function SetWindowRgn Lib "user32" (ByVal hwnd As Long, ByVal hRgn As Long, ByVal bRedraw As Boolean) As Long
'���ڽ�CreateRoundRectRgn������Բ�����򸳸�����
Private Declare Function CreateRoundRectRgn Lib "gdi32" (ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long, ByVal X3 As Long, ByVal Y3 As Long) As Long
'���ڴ���һ��Բ�Ǿ��Σ��þ�����X1��Y1-X2��Y2ȷ��������X3��Y3ȷ������Բ����Բ�ǻ��ȡ�
'���� ���ͼ�˵����
'X1,Y1 Long���������Ͻǵ�X��Y����
'X2,Y2 Long���������½ǵ�X��Y����
'X3 Long��Բ����Բ�Ŀ��䷶Χ��0��û��Բ�ǣ������ο�ȫԲ��
'Y3 Long��Բ����Բ�ĸߡ��䷶Χ��0��û��Բ�ǣ������θߣ�ȫԲ��
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
'��CreateRoundRectRgn����������ɾ�������Ǳ�Ҫ�ģ����򲻱�Ҫ��ռ�õ����ڴ�
Dim outrgn As Long
'����������һ��ȫ�ֱ���,�������������

Private Sub Form_Activate() '����Activate()�¼�
Call rgnform(Me, 30, 30) '�����ӹ���
End Sub

Private Sub Form_Unload(Cancel As Integer) '����Unload�¼�
DeleteObject outrgn '��Բ������ʹ�õ�����ϵͳ��Դ�ͷ�
End Sub

Private Sub rgnform(ByVal frmbox As Form, ByVal fw As Long, ByVal fh As Long) '�ӹ��̣��ı����fw��fh��ֵ��ʵ��Բ��
Dim w As Long, h As Long
w = frmbox.ScaleX(frmbox.Width, vbTwips, vbPixels)
h = frmbox.ScaleY(frmbox.Height, vbTwips, vbPixels)
outrgn = CreateRoundRectRgn(0, 0, w, h, fw, fh)
Call SetWindowRgn(frmbox.hwnd, outrgn, True)
End Sub
'Բ�ǽ���

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
If Button = 1 Then BolIsMove = True
MousX = X
MousY = Y
End Sub
 
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Dim CurrX As Long, CurrY As Long
If BolIsMove Then
 CurrX = Me.Left - MousX + X
 CurrY = Me.Top - MousY + Y
 Me.Move CurrX, CurrY
End If
End Sub
 
Private Sub Form_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
BolIsMove = False
Call Set_Style  'jinsexinfeng
End Sub
'����ƶ�����

'Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
'If Input_text <> "e" Then Cancel = True
'ȡ���ر�
'End Sub

'���� WAV �ļ�
'PlayWav (App.Path + soundname)
Private Sub PlayWav(soundname As String)
    Dim tmpSoundName As String
    Dim wFlags%, X%
    tmpSoundName = pathWavFiles & soundname
    wFlags% = SND_ASYNC Or SND_NODEFAULT
    X% = sndPlaySound(tmpSoundName, wFlags%)
End Sub


Private Sub Form_Load()
'�����ö�����
SetWindowPos Me.hwnd, -1, 0, 0, 0, 0, 2 Or 1
sx = Screen.Width
sy = Screen.Height

Randomize
Call BColor
Call settime
Call Set_Style
Call User_Setting

PrintCount_Short = DateDiff("d", Now(), CDate("2022/6/7"))
PrintCount_long = "����߿�:" & PrintCount_Short & "��"
Form1.BackColor = RGB(228, 228, 229)

'��͸��
Dim rtn As Long
rtn = GetWindowLong(hwnd, GWL_EXSTYLE)
rtn = rtn Or WS_EX_LAYERED
SetWindowLong hwnd, GWL_EXSTYLE, rtn
SetLayeredWindowAttributes hwnd, 0, 230, LWA_ALPHA
End Sub

Sub User_Setting()
Breath = 0  '������
Disable_time = 1
auto = 1
PrintMode = 1
soundplay = 1
Warn_Off = 1 '��������ȡ��

'auto = GetSetting("JinSeXinFeng", "Time", "auto", 1)
'Disable_time = GetSetting("JinSeXinFeng", "Time", "Disable_time", 1)
'soundplay = GetSetting("JinSeXinFeng", "Time", "soundplay", 1)

End Sub

Private Sub Label1_Click()
Call Change_Style
End Sub

Private Sub Label2_Click()
Call Change_Style
End Sub

Private Sub Label3_Click()
Call Change_Style
End Sub

Sub Change_Style()
If FromStyle = 1 Then
    Form1.Left = 14500 / 19200 * sx
    '����Ŵ�
ElseIf FromStyle = 0 Then
    Form1.Left = 18400 / 19200 * sx
    '�����С
End If
Call Set_Style
End Sub

Private Sub Label4_DblClick()
If auto = 1 Then
    Input_text = InputBox("RASZ1901JZB����" & Chr(13) & "cmd�鿴�����ȫ", "ʱ���趨", "cmd")
Else
    Input_text = Val(RemainTime \ 60 + 1)
    If Input_text > 10 Then
    Input_text = InputBox("�������趨ʱ�䣨�֣�" & Chr(13) & "RASZ1901JZB����" & Chr(13) & "cmd�鿴�����ȫ", "ʱ���趨", Input_text)
    Else
    Input_text = InputBox("�������趨ʱ�䣨�֣�" & Chr(13) & "RASZ1901JZB����" & Chr(13) & "cmd�鿴�����ȫ", "ʱ���趨", "40")
    End If
End If
SettingIndex = CheckSettingIndex(Input_text)
If SettingIndex = -2 Then
    MsgBox "s �����¿�����" & Chr(13) & "e �˳����" & Chr(13) & "au �Զ�ʱ������" & Chr(13) & "d ѧ������ʱ�����" & Chr(13) & "w ��������" & Chr(13) & "m ��������"
ElseIf SettingIndex = -1 Then
    MsgBox "�������"
ElseIf SettingIndex = 0 Then
    RemainTime = Val(Input_text) * 60
    Disable_time = 1
    auto = 0
ElseIf SettingIndex > 0 Then
    Call SetSetting(Input_text)
End If
End Sub

Sub SetSetting(Input_text)
If Input_text = "m" Then
If soundplay = 0 Then
soundplay = 1
MsgBox ("�ѿ�����������")
Else
soundplay = 0
MsgBox ("�ѹر���������")
End If
Exit Sub
End If
If Input_text = "s" Then
If Disable_time = 1 Then
Disable_time = 0
RemainTime = 0
Else
Disable_time = 1
End If
Exit Sub
End If
If Input_text = "e" Then
Unload Form1
Exit Sub
End If
If Input_text = "au" Then
If auto = 1 Then
auto = 0
MsgBox ("�ѹر��Զ�ʱ������")
Else
auto = 1
MsgBox ("�ѿ����Զ�ʱ������")
End If
Exit Sub
End If
If Input_text = "PrintMode" Then
If PrintMode = 1 Then
PrintMode = 0
MsgBox ("����ģʽ")
Else
PrintMode = 1
MsgBox ("������ģʽ")
End If
Exit Sub
End If
If Input_text = "w" Then
If Warn_Off = 1 Then
Warn_Off = 0
MsgBox ("��ʱ��������")
Else
Warn_Off = 1
MsgBox ("�رյ�������")
End If
Exit Sub
End If
End Sub

Function CheckSettingIndex(Input_text As String) As Integer
Dim Temp As String
CheckSettingIndex = -1
If Input_text = "cmd" Then
    CheckSettingIndex = -2
ElseIf Input_text = "s" Then 's �����¿�����
    CheckSettingIndex = 1
ElseIf Input_text = "e" Then 'e �˳����
    CheckSettingIndex = 2
ElseIf Input_text = "au" Then 'au �Զ�ʱ������
    CheckSettingIndex = 3
ElseIf Input_text = "d" Then 'd ѧ������ʱ�����
    CheckSettingIndex = 4
ElseIf Input_text = "w" Then 'w ��������
    CheckSettingIndex = 5
ElseIf Input_text = "m" Then 'm ��������
    CheckSettingIndex = 6
End If
If CheckSettingIndex = -1 Then
For z = 1 To Len(Input_text)
    Temp = Mid(Input_text, z, 1)
    If Asc(Temp) > 57 Or Asc(Temp) < 46 Or Asc(Temp) = 47 Then
        Exit Function
    End If
Next z
CheckSettingIndex = 0
End If
End Function

Private Sub Timer1_Timer()
t = Time()
Label1.Caption = t
If Len(t) = 7 Then t = 0 & t
Label2.Caption = Mid(t, 1, 2)
Label3.Caption = Mid(t, 4, 2)
'ʱ����ʾ
End Sub

Sub Set_Style()
'��С�Ŵ��������
If y0 <> Form1.Top Or x0 <> Form1.Left Then
    If Form1.Top > 8400 / 10800 * sy Then
        Form1.Top = 8400 / 10800 * sy
    End If
    If Form1.Top < 100 / 10800 * sy Then
        Form1.Top = 100 / 10800 * sy
    End If
    If Form1.Left < 200 / 19200 * sx Then
        Form1.Left = 200 / 19200 * sx
    End If
    If Form1.Left > 17000 / 19200 * sx Then
        Label1.Visible = False
        Form1.Width = 850
        Form1.Left = sx - 950
        Label2.Visible = True
        Label3.Visible = True
        Label4.Alignment = 0
        FromStyle = 1
    End If
    If Form1.Left < 16990 / 19200 * sx Then
        Label1.Visible = True
        Form1.Width = 3900
        Label2.Visible = False
        Label3.Visible = False
        Label4.Alignment = 2
        FromStyle = 0
    End If
    y0 = Form1.Top
    x0 = Form1.Left
End If
Call Print_word
End Sub

Private Sub Timer2_Timer()
If auto <> 0 Then   '��ʼ�Ͽ�ʱ��ʱ
    Call Down_Time
End If

If RemainTime >= 0 Then
    RemainTime = RemainTime - 1
    Shape2.Top = (2400 - RemainTime) / 2400 * 2010
End If
Call Print_word
End Sub

Sub Print_word()
PrintWord_long = "���ڿλ�ʣ:" & RemainTime \ 60 & ":" & RemainTime Mod 60
PrintWord_Short = RemainTime \ 60
If Disable_time = 0 Then
    Timer3.Enabled = False
    If FromStyle = 0 Then Label4.Caption = "�ѽ����¿�����"
    If FromStyle = 1 Then Label4.Caption = "��"
    Label4.ForeColor = RGB(255, 0, 255)
    Exit Sub
End If
If RemainTime >= 600 Then
    If PrintMode = 0 Then
        If FromStyle = 0 Then
           Label4.Caption = PrintWord_long
        End If
        If FromStyle = 1 Then
           Label4.Caption = PrintWord_Short
        End If
        Label4.ForeColor = RGB(82, 64, 192)
    End If
    If PrintMode = 1 Then
        If FromStyle = 0 Then
          Label4.Caption = PrintCount_long
        End If
        If FromStyle = 1 Then
          Label4.Caption = PrintCount_Short
        End If
        Label4.ForeColor = RGB(221, 8, 8)
    End If
ElseIf RemainTime > 0 Then
    If FromStyle = 0 Then
        Label4.Caption = PrintWord_long
    End If
    If FromStyle = 1 Then
        Label4.Caption = PrintWord_Short
    End If
    Timer3.Enabled = True
    If RemainTime = 60 And Form1.Left > 14500 / 19200 * sx And Warn_Off = 0 Then
        Form1.Left = 14500 / 19200 * sx
    End If
    If RemainTime = 1 And soundplay = 1 Then
        PlayWav (App.Path + soundname)
    End If
    If RemainTime = 1 Then
        Call BColor
    End If
ElseIf RemainTime >= -1 Then
    If PrintMode = 0 Then
        If FromStyle = 0 Then Label4.Caption = "��ʾ:�ǿ���ʱ��"
        If FromStyle = 1 Then Label4.Caption = "ͣ"
        Label4.ForeColor = RGB(82, 64, 192)
    Else
        If FromStyle = 0 Then Label4.Caption = PrintCount_long
        If FromStyle = 1 Then Label4.Caption = PrintCount_Short
        Label4.ForeColor = RGB(221, 8, 8)
    End If
    Timer3.Enabled = False
End If
'���õ���ʱ
End Sub

Private Sub Timer3_Timer()
Breath = Breath + 0.2
Label4.ForeColor = RGB(27 + (180 * Abs(Breath)), (166 * Abs(Breath)), 192)
If Breath = 1 Then Breath = -1
'���ʱ�������˸
End Sub

Sub BColor()
Dim RGBColor As Single
BColorTime = (BColorTime + 1)mod 3
RGBColor = Rnd() * 10000 Mod 30
If BColorTime = 0 Then Shape2.FillColor = RGB(180 + RGBColor, 210 - RGBColor, 180)
If BColorTime = 1 Then Shape2.FillColor = RGB(180 + RGBColor, 180, 210 - RGBColor)
If BColorTime = 2 Then Shape2.FillColor = RGB(180, 180 + RGBColor, 210 - RGBColor)
End Sub

Sub settime()
Dim tempStr As String '�������tempStrΪ�ַ���
Dim temp_a, temp_b As String
Dim temp_c As Integer
Dim place_file As String
place_file = App.Path & "\timedict.txt"
Open place_file For Input As #1 '���ļ�
While Not EOF(1)  '��ȡ������
    Line Input #1, temp_a '��ȡһ�е�����tempStr
    If Len(temp_a) = 16 Then
    If Mid(temp_a, Weekday(Now()) + 9, 1) = "1" Then
    temp_b = ChangetoNum(Mid(temp_a, 1, 5))
    temp_c = Val(Mid(temp_a, 7, 2))
    For m = 0 To temp_c - 1
    Time_Dict(temp_b + m) = (temp_c - m) * 60
    Next m
    End If
    End If
Wend 'δ��������
Close #1 '�ر�
End Sub

Sub Down_Time()
If Right(Time(), 2) = "00" Then
    If Time_Dict(ChangetoNum(Time())) <> 0 Then RemainTime = Time_Dict(ChangetoNum(Time()))
End If
End Sub

Function ChangetoNum(k As String) As Integer
If Len(k) = 7 Then k = "0" & k
ChangetoNum = Mid(k, 1, 2) * 60 + Mid(k, 4, 2)
End Function