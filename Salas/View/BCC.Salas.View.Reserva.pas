unit BCC.Salas.View.Reserva;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, Math,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, BCC.Sala.Model.Reserva, BCC.Sala.DAO.Reserva,
  BCC.DAO.Cliente, BCC.Model.Cliente, BCC.Model.Sala, BCC.Clientes.View.Consulta,
  BCC.Salas.View.Consulta, BCC.DAO.Sala, BCC.Salas.View.ConsultaReserva, DateUtils,
  Vcl.WinXCalendars, System.Generics.Collections, BCC.Manual.View.AgendarReserva,
  Vcl.Imaging.pngimage;

type
  TFrmReservaSala = class(TFraBase)
    PnlCentro: TPanel;
    PnlBotoes: TPanel;
    BtnNovo: TButton;
    BtnEditar: TButton;
    BtnConsultar: TButton;
    ClvAgenda: TCalendarView;
    DbgAgenda: TDBGrid;
    MtbAgenda: TFDMemTable;
    DsAgenda: TDataSource;
    MtbAgendaSala: TStringField;
    MtbAgendaHora: TTimeField;
    PnlConteudo: TPanel;
    BtnCancelar: TButton;
    BtnSalvar: TButton;
    LblData: TLabel;
    LblHora: TLabel;
    LedCliente: TLabeledEdit;
    LedSala: TLabeledEdit;
    DtpHora: TDateTimePicker;
    DtpReserva: TDateTimePicker;
    LblTitulo: TLabel;
    DtpSaida: TDateTimePicker;
    LblTempo: TLabel;
    BimHelp: TImage;
    procedure FrameResize(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure LedClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LedSalaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnConsultarClick(Sender: TObject);
    procedure ClvAgendaClick(Sender: TObject);
    procedure BimHelpClick(Sender: TObject);
  private
    { Private declarations }
    ReservaAtual : TReserva;
    SalaSelecionada : TSala;
    ClienteSelecionado : TCliente;

    Help : TFrmManualAgendarReserva;

    procedure LimparTela();
    procedure PreencherTela(AReserva : TReserva);

    procedure TratarTela(AEmEdicao : Boolean);
    function  GetReserva() : TReserva;

    procedure PreencherAgenda();
  public
    { Public declarations }
  end;

var
  FrmReservaSala: TFrmReservaSala;

implementation

{$R *.dfm}

procedure TFrmReservaSala.BimHelpClick(Sender: TObject);
begin
  inherited;
  if Self.Help <> nil then
  begin
    FreeAndNil(Self.Help);
  end;

  Self.Help := TFrmManualAgendarReserva.Create(Self);
  Self.Help.Show();
end;

procedure TFrmReservaSala.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  try
    if Self.ReservaAtual.Codigo > 0 then
    begin
      Self.PreencherTela(Self.ReservaAtual);
    end
    else
    begin
      Self.LimparTela();
    end;
  except
    Self.LimparTela();
  end;

  Self.TratarTela(False);
end;

procedure TFrmReservaSala.BtnConsultarClick(Sender: TObject);
var
  ConsultaReserva : TFrmConsultaReserva;
begin
  inherited;
  ConsultaReserva := TFrmConsultaReserva.Create(Self);
  try
    ConsultaReserva.ShowModal();
  finally
    if ConsultaReserva.Consultou then
    begin
      Self.ReservaAtual := ConsultaReserva.ObjetoConsultado;
      Self.PreencherTela(ConsultaReserva.ObjetoConsultado);
    end;
    FreeAndNil(ConsultaReserva);
  end;
  Self.TratarTela(False);
end;

procedure TFrmReservaSala.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Self.TratarTela(True);
end;

procedure TFrmReservaSala.BtnNovoClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.ReservaAtual);
  Self.LimparTela();
  Self.TratarTela(True);
end;

procedure TFrmReservaSala.BtnSalvarClick(Sender: TObject);
var
  DmReserva : TDmReserva;
  Reserva : TReserva;
begin
  inherited;
  DmReserva := TDmReserva.Create(Self);
  Reserva := Self.GetReserva();

  if DmReserva.ValidarData(Reserva) then
  begin
    try
      if Self.ReservaAtual.Codigo > 0 then
      begin
        DmReserva.Editar(Reserva);
        Self.ReservaAtual := Reserva;
        Self.PreencherTela(Self.ReservaAtual);
        Self.TratarTela(False);
      end
      else
      begin
        Self.ReservaAtual := TDmReserva.Create(Self).Inserir(Self.GetReserva());
        Self.PreencherTela(Self.ReservaAtual);
        Self.TratarTela(False);
      end;
    except
      Self.ReservaAtual := TDmReserva.Create(Self).Inserir(Self.GetReserva());
      Self.PreencherTela(Self.ReservaAtual);
      Self.TratarTela(False);
    end;
  end
  else
  begin
    Application.MessageBox('Essa sala já esta reservada nesse horário. Tente outro horario ou sala.', 'Conflito de horários.');
  end;

end;

procedure TFrmReservaSala.ClvAgendaClick(Sender: TObject);
begin
  inherited;
  Self.PreencherAgenda();
end;

procedure TFrmReservaSala.FrameResize(Sender: TObject);
begin
  inherited;
  Self.PnlCentro.Top  := Self.PnlBotoes.Height;
  Self.PnlCentro.Left := Floor((Self.Width - Self.PnlCentro.Width) / 2);

  Self.ClvAgenda.Date := Date();
  Self.PreencherAgenda();
end;

function TFrmReservaSala.GetReserva: TReserva;
begin
  Result := TReserva.Create();
  Result.CodSala       := Self.SalaSelecionada.Codigo;
  Result.CodCliente    := Self.ClienteSelecionado.Codigo;
  Result.DataHora      := StrToDateTime(DateToStr(Self.DtpReserva.Date) + TimeToStr(Self.DtpHora.Time));
  Result.DataHoraFinal := StrToDateTime(DateToStr(Self.DtpReserva.Date) + TimeToStr(Self.DtpSaida.Time));

  try
    if Self.ReservaAtual.Codigo > 0 then
    begin
      Result.Codigo := Self.ReservaAtual.Codigo;
    end;
  except

  end;
end;

procedure TFrmReservaSala.LedClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Consulta : TFrmConsultaCliente;
begin
  inherited;
  if Key = VK_Return then
  begin
    if Self.LedCliente.Text = '' then
    begin
      Consulta := TFrmConsultaCliente.Create(Self);
      try
        Consulta.ShowModal();
        if Consulta.Consultou then
        begin
          Self.ClienteSelecionado := Consulta.ObjetoConsultado;
          Self.LedCliente.Text := Self.ClienteSelecionado.Nome;
        end;
      finally
        FreeAndNil(Consulta);
      end;
    end;
  end;
end;

procedure TFrmReservaSala.LedSalaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Consulta : TFrmConsultaSala;
begin
  inherited;
  if Key = VK_Return then
  begin
    if Self.LedSala.Text = '' then
    begin
      Consulta := TFrmConsultaSala.Create(Self);
      try
        Consulta.ShowModal();
        if Consulta.Consultou then
        begin
          Self.SalaSelecionada := Consulta.ObjetoConsultado;
          Self.LedSala.Text := Self.SalaSelecionada.Descricao;
        end;
      finally
        FreeAndNil(Consulta);
      end;
    end;
  end;
end;

procedure TFrmReservaSala.LimparTela;
begin
  FreeAndNil(Self.SalaSelecionada);
  FreeAndNil(Self.ClienteSelecionado);
  Self.LedCliente.Text := '';
  Self.LedSala.Text := '';
  Self.DtpReserva.Date := Date();
  Self.DtpHora.Time    := Time();
end;

procedure TFrmReservaSala.PreencherAgenda;
var
  Reservas : TObjectList<TReserva>;
  DmSala   : TDmSala;
begin
  Self.MtbAgenda.Close();
  Self.MtbAgenda.Open();
  Self.MtbAgenda.EmptyDataSet();

  Reservas := TDmReserva.Create(Self).SelecionarData(Self.ClvAgenda.Date);
  DmSala := TDmSala.Create(Self);
  
  for var Reserva in Reservas do
  begin
    Self.MtbAgenda.Append();
    Self.MtbAgendaSala.Value := DmSala.Selecionar(Reserva.CodSala).Descricao; 
    Self.MtbAgendaHora.Value := Reserva.DataHora;
    Self.MtbAgenda.Post();
  end;
end;

procedure TFrmReservaSala.PreencherTela(AReserva: TReserva);
begin
  Self.SalaSelecionada := TDmSala.Create(Self).Selecionar(AReserva.CodSala);
  Self.LedSala.Text    := Self.SalaSelecionada.Descricao;

  Self.ClienteSelecionado := TDmCliente.Create(Self).SelecionarCliente(AReserva.CodCliente);
  Self.LedCliente.Text    := Self.ClienteSelecionado.Nome;

  Self.DtpReserva.Date := DateOf(AReserva.DataHora);
  Self.DtpHora.Time    := TimeOf(AReserva.DataHora);
  Self.DtpSaida.Time   := TimeOf(AReserva.DataHoraFinal);
end;

procedure TFrmReservaSala.TratarTela(AEmEdicao: Boolean);
begin
  Self.BtnNovo.Enabled := not AEmEdicao;

  try
    Self.BtnEditar.Enabled := (not AEmEdicao) and (Self.ReservaAtual.Codigo > 0);
  except
    Self.BtnEditar.Enabled := False;
  end;

  Self.BtnConsultar.Enabled := not AEmEdicao;
  Self.PnlConteudo.Enabled := AEmEdicao;

  Self.PreencherAgenda();
end;

end.
