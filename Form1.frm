VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   0  'None
   Caption         =   "RASZ1901ʱ����ʾ"
   ClientHeight    =   2010
   ClientLeft      =   14850
   ClientTop       =   7350
   ClientWidth     =   3810
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2010
   ScaleWidth      =   3810
   ShowInTaskbar   =   0   'False
   Begin VB.Timer Timer3 
      Enabled         =   0   'False
      Interval        =   500
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
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim i As Integer
Dim a As Integer
Dim b As Integer
Dim auto As Integer
Dim sx As Integer
Dim sy As Integer
Dim t2 As String
Dim t3 As String
Dim st As String
Dim p1 As String

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
End Sub
'����ƶ�����

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
If t2 <> "e" Then Cancel = True
'ȡ���ر�
End Sub

Private Sub Form_Load()
'�����ö�����
SetWindowPos Me.hwnd, -1, 0, 0, 0, 0, 2 Or 1
sx = Screen.Width
sy = Screen.Height
b = 0
st = 1
auto = 1
Form1.BackColor = RGB(228, 228, 229)
'��͸��
Dim rtn As Long
rtn = GetWindowLong(hwnd, GWL_EXSTYLE)
rtn = rtn Or WS_EX_LAYERED
SetWindowLong hwnd, GWL_EXSTYLE, rtn
SetLayeredWindowAttributes hwnd, 0, 230, LWA_ALPHA
End Sub

Private Sub Label1_Click()
Form1.Left = 18400 / 19200 * sx
'�����С
End Sub

Private Sub Label2_Click()
Form1.Left = 14500 / 19200 * sx
'����Ŵ�
End Sub

Private Sub Label3_Click()
Form1.Left = 14500 / 19200 * sx
'����Ŵ�
End Sub

Private Sub Label4_DblClick()
t2 = Val(i \ 60 + 1)
If t2 > 10 Then
t2 = InputBox("�������趨ʱ�䣨�֣�" & Chr(13) & "RASZ1901JZB����", "ʱ���趨", t2)
Else
t2 = InputBox("�������趨ʱ�䣨�֣�" & Chr(13) & "RASZ1901JZB����", "ʱ���趨", "40")
End If
If t2 = "s" Then
st = 0
Exit Sub
End If
If t2 = "e" Then
Unload Form1
Exit Sub
End If
If t2 = "a" Then
If auto = 1 Then
auto = 0
MsgBox ("�ѹر��Զ�ʱ������")
Else
auto = 1
MsgBox ("�ѿ����Զ�ʱ������")
End If
Exit Sub
End If
For z = 1 To Len(t2)
t3 = Mid(t2, z, 1)
If Asc(t3) > 57 Or Asc(t3) < 48 Then
MsgBox ("�������")
Exit Sub
End If
Next z
If t2 <> "" Then
i = Val(t2) * 60
st = 1
End If
'�Զ��嶨ʱ
End Sub

Private Sub Timer1_Timer()
t = Time()
Label1.Caption = t
If Len(t) = 7 Then t = 0 & t
Label2.Caption = Mid(t, 1, 2)
Label3.Caption = Mid(t, 4, 2)
'ʱ����ʾ
If y0 <> Form1.Top Or x0 <> Form1.Left Then
If Form1.Top > 8400 / 10800 * sy Then
Form1.Top = 8400 / 10800 * sy
End If
If Form1.Left > 17000 / 19200 * sx Then
Label1.Visible = False
Form1.Width = 850
Form1.Left = sx - 950
Label2.Visible = True
Label3.Visible = True
Label4.Alignment = 0
a = 1
End If
If Form1.Left < 16990 / 19200 * sx Then
Label1.Visible = True
Form1.Width = 3900
Label2.Visible = False
Label3.Visible = False
Label4.Alignment = 2
a = 0
End If
y0 = Form1.Top
x0 = Form1.Left
End If
'��С�Ŵ��������
If st = 0 Then
Timer2.Enabled = False
Timer3.Enabled = False
If a = 0 Then Label4.Caption = "�ѽ����¿�����"
If a = 1 Then Label4.Caption = "��"
Else
Timer2.Enabled = True
End If
End Sub

Private Sub Timer2_Timer()
If auto <> 0 Then
If Time() = "7:25:00" Or Time() = "8:15:00" Or Time() = "9:20:00" Or Time() = "10:10:00" Or Time() = "11:05:00" Or Time() = "13:45:00" Or Time() = "14:40:00" Or Time() = "15:30:00" Or Time() = "16:20:00" Then
i = 2400
End If
If Time() = "18:00:00" Then
i = 6300
End If
If Time() = "20:00:00" Then
i = 5400
End If
End If
'��ʼ�Ͽ�ʱ��ʱ
i = i - 1
If i >= 0 Then
Else
If a = 0 Then Label4.Caption = "��ʾ:�ǿ���ʱ��"
If a = 1 Then Label4.Caption = "ͣ"
Exit Sub
End If
If i > 600 Or i <= 0 Then
If a = 0 Then
p1 = "���ڿλ�ʣ:" & i \ 60 & ":" & i Mod 60
Label4.Caption = p1
End If
If a = 1 Then
Label4.Caption = i \ 60
End If
Timer3.Enabled = False
Else
Timer3.Enabled = True
End If
If i = 60 And a = 1 Then
Form1.Left = 14500 / 19200 * sx
End If
'���õ���ʱ
End Sub

Private Sub Timer3_Timer()
If b = 0 Then
If a = 0 Then
p1 = "���ڿλ�ʣ:" & i \ 60 & ":" & i Mod 60
Label4.Caption = p1
End If
If a = 1 Then
Label4.Caption = i \ 60
End If
b = 1
Else
Label4.Caption = ""
b = 0
End If
'���ʱ����˸
End Sub
